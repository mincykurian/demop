const Course=require('../Models/course.js');
const courseModel=new Course();
const moment=require('moment');
const SchoolConfig=require('../config.js');
const schoolConfig=new SchoolConfig();
const ExamModel=require('../Models/exam.js');
const examModel=new ExamModel();

class Coursecontroller {
    constructor(){

    }

    getSubjects(req,res){
        const schoolId=req.schoolId;
        const courseId=req.params.courseId;
        courseModel.getSubjects(schoolId,courseId,['s.id','s.subject_title','cs.course_id'])
            .then(subjects=>{
                if(subjects.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: ' Subjects',
                            result: subjects
                        })
                }else{
                    res.status(204).send({message:'No data'});
                }
            })
            .catch(err=>{
                res.status(500).send({message:'Internal server err'+ err})
            })
    }

    getStudentsByCourse(req,res){
        const schoolId=req.schoolId;
        const courseId=req.params.id;
        courseModel.getStudents(schoolId,courseId,['u.id','u.name','u.image'])
            .then(students=>{
                if(students.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: ' Students list',
                            result: students
                        })
                }else{
                    res.status(204).send({message:'No data'});
                }
            })
    }

    getExamByCourse(req,res){
        const school=schoolConfig.getSchool(req.params.schoolCode);
        examModel.getExamByCourse(school.schoolId,req.params.courseId,['e.id','e.name','ec.name','s.subject_title','e.starts_on','e.ends_on','e.maximum_marks','u.name as conducted_by','c.course_title'])
            .then(exams=>{
                if(exams.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: 'Exam List',
                            result:exams
                        })
                }
                else{
                    res.sendStatus(204);
                }
            })
            .catch(err=>{
                res.status(500).send(err);
            })
    }

}
module.exports=Coursecontroller;