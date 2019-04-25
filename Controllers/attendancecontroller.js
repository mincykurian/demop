/* eslint-disable no-console */
const SchoolConfig = require("../config.js");
const schoolConfig = new SchoolConfig();
const CourseModel = require("../Models/course.js");
const courseModel = new CourseModel();
let   FCMMessage = require("../shared/FCM.js");
const FCMController = require("./fcmcontroller.js");
const fcmCtrl = new FCMController();
const UserController = require("./usercontroller.js");
const userCtrl = new UserController();
const StudentModel=require('../Models/student.js');
const studentModel=new StudentModel();
const moment=require('moment');

class AttendanceController {
  constructor() {

  }

  setAttendance(req, res) {
    const school = schoolConfig.getSchool(req.params.schoolCode);
    const courseId = req.params.courseId;
    this.sendFCMNotificationToParents(school, req.body.data);
    courseModel
      .setAttendance(school.schoolId, courseId, req.body)
      .then(() => {
        res.status(201).send({
          status: true,
          code: 201,
          message: "Attendance submitted successfully"
        });
      })
      .catch(err => {
        console.log(err);
        res.sendStatus(500);
      });
  }

  getStudentLiveStatus(req,res){
    /*
     101:present
     201:absent
     302:not marked
     */
    const userId=req.params.userId;
    let response={};
    studentModel.getStudentLiveStatus(userId)
        .then(attendanceStatus=>{
          response.isPresent=(attendanceStatus[0].isPresent === 0);
          response.isAttendanceMarked=(attendanceStatus[0].isAttendanceMarked === 1);
          response.code=response.isPresent&&response.isAttendanceMarked?101:response.isPresent&&!response.isAttendanceMarked?302:201;
          response.updated_at=new Date();
          res.status(200)
              .send(response)
        })
        .catch(err=>{
          res.status(500)
              .send({
                status:false,
                message:'error',
                error:err
              })
        })
  }

  sendFCMNotificationToParents(school, students) {
    FCMMessage.android.data.title = school.schoolName;
    for (let student of students) {
      FCMMessage.android.data.body = student.status ? "Present" : "Absent";
      userCtrl.getFCMToken(student.studentId,['id','fcmtoken']).then(user => {
        if (user.length > 0) fcmCtrl.sendMessage(user[0].fcmtoken, FCMMessage);
      });
    }
  }

  getAttendance(req,res){

    const userId=req.params.userId;
    const type=req.query.type.toString();
    if(userId&&type){
        switch (type) {
            case 'yearly':
                getAttendanceYearly(userId);
                break;
        }
    }else{
        res.status(400)
            .send({
                code:400,
                status:false,
                message:'Invalid request',

            })
    }

    function getAttendanceYearly() {
        const userId=req.params.userId;
        studentModel.getAttendanceYearly(userId)
            .then(response=>{
                let output=response.map(data=>{
                    return {
                        absent_date:data.attendance_date,
                        record_updated_by:data.name,
            
                    }
                }).sort((a,b)=>{
                    return moment(a.attendance_date).month()-moment(b.attendance_date);
                });
                res.status(200)
                    .send({
                        status:true,
                        message:'Absent days list',
                        result:{total_working_days:15,total_absent_days:output.length,details:output}
                    })
            })
            .catch(err=>{
                res.status(500)
                    .send({
                        status:false,
                        message:'error',
                        error:err
                    })
            })
    }
  }

}
//test
/*a=new AttendanceController();
a.getAttendance({params:{userId:1,type:'yearly'},query:{type:'yearly'}},{});*/

module.exports = AttendanceController;
