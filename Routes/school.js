const express=require('express');
const router=express.Router({mergeParams:true});
const Config=require('../config.js');
const config=new Config();
const SchoolController=require('../Controllers/schoolcontroller.js');
const schoolCtrl=new SchoolController();
const CourseController=require('../Controllers/coursecontroller.js');
const courseCtrl=new CourseController();


router.get('/menus',config.isValidSchool,(req, res) => {
   schoolCtrl.getMenuList(req,res);
});

router.get('/students',config.isValidSchool,((req, res) => {
   schoolCtrl.getStudentList(req,res);
}));

router.get('/courses', config.isValidSchool,(req,res)=>{
    schoolCtrl.getCourses(req,res);
});

router.get('/course/:courseId/subjects', config.isValidSchool,(req,res)=>{
    courseCtrl.getSubjects(req,res);
});
module.exports=router;