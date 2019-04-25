const express=require('express');
const router=express.Router({mergeParams:true});


const ExamController=require('../Controllers/examcontroller.js');
const examCtrl=new ExamController();
const SchoolConfig=require('../config.js');
const config=new SchoolConfig();

router.use(config.isValidSchool);

router.delete('/:id',(req,res)=>{
    examCtrl.removeExam(req,res);
});

router.post('/:id/results',(req,res)=>{
    examCtrl.addMarks(req,res);
});

router.post('/:id/send-notification',((req, res) => {
    examCtrl.sendExamNotification(req,res);
}));
module.exports=router;