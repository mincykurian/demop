
const express=require('express');
const router=express.Router();
const UserController=require('../Controllers/usercontroller.js');
const usrCtrl=new UserController();


router.get('/:mobileNumber([0-9]{10})/all',(req,res)=>{
    usrCtrl.findAllUser(req,res);
});

router.get('/phone/:mobileNumber/otp/send',(req,res)=>{
    usrCtrl.sendOTP(req,res);
});
router.post('/phone/verify',(req,res)=>{
    usrCtrl.verifyOTP(req,res);
});

module.exports=router;