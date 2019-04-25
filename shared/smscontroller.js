const http=require('http');
const con=require('../dbconfig.js');
const crypto=require('crypto');
require('dotenv').config();

class Smscontroller {

    constructor(){

    }

     static createHash(data) {
        const SECREAT='Manchester@13';
        return crypto.createHmac('sha256',SECREAT)
            .update(data.toString())
            .digest('hex');
    }

    sendOtp(mobileNumber) {
        const SECREAT='Manchester@13';
        const otp=createRandomNumber();
        return new Promise((resolve, reject) => {
            const options = {
                "method": "POST",
                "hostname": "api.msg91.com",
                "port": null,
                "path": "/api/v2/sendsms?campaign=&response=&afterminutes=&schtime=&unicode=&flash=&message=&encrypt=&authkey=&mobiles=&route=&sender=&country=91",
                "headers": {
                    "authkey": process.env.SMS_AUTH_KEY,
                    "content-type": "application/json"
                }
            };
            const req = http.request(options, function (res) {
                var chunks = [];
                res.on("data", function (chunk) {
                    chunks.push(chunk);
                });
                res.on("end", function (err) {
                    var body = Buffer.concat(chunks);
                    updateSessionAndOtp(mobileNumber)
                        .then(data=>{
                            resolve({status:true,mobileNumber:mobileNumber,sessionId:data.sessionId,otp:Smscontroller.createHash(otp),details:JSON.parse(body.toString())});
                        })
                        .catch(err=>{
                            resolve(err);
                        })
                });
            });

            req.write(JSON.stringify({ sender: 'ADWESA',
                route: '4',
                country: '91',
                sms:
                    [ { message: 'An 6 digit OTP sent to your number '+otp, to: [ mobileNumber ] }] }));
            req.end();
        });

        function createRandomNumber(){
            return Math.floor(100000+ Math.random()* 900000);
        }
         function updateSessionAndOtp(mobileNumber){
            const timestamp=new Date().getTime();
            console.log(timestamp)
            const sql='update \
                            users \
                        set ? \
                        where \
                            phone=?';
            return new Promise((resolve, reject) => {
               con.query(sql,[{otp:Smscontroller.createHash(otp),sessionId:timestamp},mobileNumber],(err, rows, fields)=>{
                   if(err) reject(err);
                   resolve({sessionId:timestamp});
               })
           })

        }
    }

    verifyOtp(sessionId,otp){
        const sql='select \
                        phone,otp \
                    from \
                        users \
                    where \
                        sessionId=? \
                    limit 1';
        return new Promise((resolve, reject) => {
            con.query(sql,[sessionId],(err,rows,fields)=>{
                if(err) reject(err);
                else if(rows.length>0){
                    if(rows[0].otp===Smscontroller.createHash(otp.toString())){
                        resolve({status:true,phone:rows[0].phone})
                    }else{
                        resolve({status:false})
                    }
                }else{
                    resolve({status:false})
                }
            })
        })
    }
}

module.exports=Smscontroller;
