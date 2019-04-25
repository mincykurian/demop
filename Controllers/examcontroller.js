const moment=require('moment');
const ExamModel=require('../Models/exam.js');
const examModel=new ExamModel();
const FCM=require('../shared/FCM.js');
const FCMController=require('./fcmcontroller.js');
const fcmCtrl=new FCMController();
const SchoolConfig = require("../config.js");
const schoolConfig = new SchoolConfig();
class ExamController {
    constructor(){

    }

    createExam(req,res){
        let exam={
                name:req.body.name,
                course_id:req.body.course_id,
                subject_id:req.body.subject_id,
                starts_on:req.body.starts_on,
                ends_on:req.body.ends_on,
                exam_category_id:req.body.exam_category_id,
                conducted_by:req.body.conducted_by,
                maximum_marks:req.body.maximum_marks,
            created_at:moment().format('YYYY-MM-DD hh:mm:ss'),
            updated_at:moment().format('YYYY-MM-DD hh:mm:ss'),
            status:true
        };
        examModel.isExamAlreadyExists([exam.exam_category_id,exam.subject_id,exam.course_id])
            .then(response=>{
                if(response.length>0){
                    res.status(409)
                        .send({
                            status:false,
                            message:'Exam is already created',
                            result:response[0]
                        })
                }else{
                    examModel.addExam(exam)
                        .then(response=>{
                            res.status(201)
                                .send({
                                    status:true,
                                    code:201,
                                    message:'Exam created successfully'
                                })
                        })
                        .catch(err=>{
                            res.status(500)
                                .send({
                                    status:false,
                                    err:err
                                })
                        })
                }
            })
            .catch(err=>{

            })
    }

    removeExam(req,res){
        const type=req.query.type;
        const id=req.params.id;
        console.log(req.query);
        examModel.removeExam(id,type)
            .then(response=>{
                res.status(200)
                    .send({
                        status:true,
                        message:response.affectedRows>0?'deleted':'No records exists..'
                    })
            })
            .catch(err=>{
                console.log(err);
            })
    }

    addMarks(req,res){
        const examId=req.params.id;
        const marks={
            user_id:req.body.userId,
            exam_id:req.body.examId,
            marks_obtained:req.body.mark,
            created_at:moment().format('YYYY-MM-DD hh:mm:ss'),
            updated_at:moment().format('YYYY-MM-DD hh:mm:ss')
        };
        console.log(marks);
        examModel.addMarks(examId,marks)
            .then(response=>{
                console.log(response);
                res.status(201)
                    .send({
                        status:true,
                        code:201,
                        message:"Marks uploaded successfully"
                    })
            })
            .catch(err=>{
                console.log(err);
                res.status(500)
                    .send({
                        status:false,
                        code:500,
                        message:"error",
                        result:err
                    })
            })

    }

    sendExamNotification(req,res){
        const examId=req.params.id;
        const school = schoolConfig.getSchool(req.params.schoolCode);
        FCM.android.data.title=school.schoolName;
        examModel.getStudents(examId)
        .then(students=>{

            if(students.length>0){
                res.status(200)
                    .send({
                        status:true,
                        code:200,
                        message:'Notification sent to parents.'
                    })
            }else{
                res.status(204)
                    .send({
                        message:'Error'
                    })
            }
            students=students.filter(student=>{
                return student.fcmtoken!=null
            });

           for(let student of students){
             fcmCtrl.sendMessage(student.fcmtoken)
                 .then(response=>{
                     console.log(response)
                 })
                 .catch(err=>{
                     console.log(err);
                 })
           }

        })
        .catch(err=>{
            res.send(err);
        })
    }
}
module.exports=ExamController;