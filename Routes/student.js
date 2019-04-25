const express=require('express');
const router=express.Router({mergeParams:true});
const Student=require('../Models/student.js');
const student=new Student();
const Config=require('../config.js');
const config=new Config();
const StudentController=require('../Controllers/studentcontroller.js');
const studentCtrl=new StudentController();
const AttendanceController=require('../Controllers/attendancecontroller.js');
const attendanceCtrl=new AttendanceController();

router.use(config.isValidSchool);


router.get('/:id([0-9]{1,8})',((req, res) => {
    studentCtrl.getStudentProfile(req,res);
}));

router.get('/:userId/attendance/live',(req,res)=>{
    attendanceCtrl.getStudentLiveStatus(req,res);
});

router.put('/:id',(req,res)=>{
   // console.log(req);
    studentCtrl.updateStudentProfile(req,res);
});

router.post('/medical',(req,res)=>{
    studentCtrl.AddStudentMedicalInfo(req,res);
});

router.put('/:userId/medical',(req,res)=>{
    studentCtrl.updateStudentMedicalInfo(req,res);
});

router.delete('/:userId/medical',(req,res)=>{
    studentCtrl.deleteStudentMedicalInfo(req,res);
});

router.get('/:userId/attendance',(req,res)=>{
    attendanceCtrl.getAttendance(req,res);

});

module.exports=router;