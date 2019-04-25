const express=require('express');
const router=express.Router({mergeParams:true});
const CourseController=require('../Controllers/coursecontroller.js');
const AttendanceController=require('../Controllers/attendancecontroller.js');
const attendanceCtrl=new AttendanceController();
const courseCtrl=new CourseController();
const ExamController=require('../Controllers/examcontroller.js');
const examCtrl=new ExamController();
const SchoolConfig=require('../config.js');
const config=new SchoolConfig();

router.use(config.isValidSchool);

router.get('/:id/students',(req,res)=>{
    courseCtrl.getStudentsByCourse(req,res);
});

router.post('/:id/attendance',(req,res)=>{
    attendanceCtrl.setAttendance(req,res);
});

router.get('/:id/attendance?date=?',(req,res)=>{

});

router.get('/:courseId/exams',(req,res)=>{
    courseCtrl.getExamByCourse(req,res);
});

router.post('/:courseId/exams',(req,res)=>{
    examCtrl.createExam(req,res);
});

module.exports=router;