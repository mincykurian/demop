const express=require('express');
const router=express.Router({mergeParams:true});
const Config=require('../config.js');
const config=new Config();
const StaffController=require('../Controllers/staffcontroller.js');
const staffCtrl=new StaffController();

router.use(config.isValidSchool);

router.get('/:userId/exams',(req,res)=>{
    staffCtrl.getExamByStaff(req,res);
});

module.exports=router;