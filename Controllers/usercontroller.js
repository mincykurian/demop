const User = require("../Models/user.js");
const SMS = require("../shared/smscontroller.js");
const JWT = require("../Middlewares/jwt.js");
const sms = new SMS();
const userObj = new User();
const jwt = new JWT();

class Usercontroller {
  constructor() {}

  findAllUser(req, res) {
    const mobileNumber = req.params.mobileNumber;
    userObj
      .findAll(mobileNumber, [
        "u.id",
        "u.name",
        "u.image",
        "c.id as course_id",
        "c.course_title",
        "role_id",
        "active"
      ])
      .then(data => {
        res.status(200).send({
          status: data.length > 0,
          code: 200,
          message:
            data.length > 0 ? "All users" : "No user found this mobile number",
          result: data.map(user => {
            return {
              name: user.name,
              user_id: user.id,
              roles: [{ id: user.role_id }],
              image: user.image,
              course_id: user.course_id,
              class: user.course_title,
              active: user.active,
              subscriptions: []
            };
          })
        });
      })
      .catch(err => {
        res.status(500).send(err);
      });
  }

  sendOTP(req, res) {
    userObj
      .findAll(req.params.mobileNumber, [
        "u.id",
        "u.name",
        "u.image",
        "u.role_id",
        "u.active"
      ])
      .then(users => {
        if (users.length > 0) {
          sms
            .sendOtp(req.params.mobileNumber)
            .then(data => {
              console.log(data);
              if (data.status) {
                res.status(200).send({
                  status: true,
                  code: 200,
                  message: "An otp sent to your number",
                  sessionId: data.sessionId
                });
              }
            })
            .catch(err => {});
        } else {
          res.status(200).send({
            status: false,
            code: 200,
            message: "Mobilenumber is not registerd.",
            result: users
          });
        }
      });
  }

  verifyOTP(req, res) {
    sms
      .verifyOtp(req.body.sessionId, req.body.otp)
      .then(data => {
        if (data.status) {
          userObj
            .findAll(data.phone, [
              "u.id",
              "u.name",
              "u.image",
              "u.role_id",
              "u.active"
            ])
            .then(users => {
              const userArray = users.map(user => {
                return {
                  userId: user.id,
                  roleId: user.roles[0].id
                };
              });
              const claims = {};
              claims.account = userArray;
              jwt
                .createToken(claims)
                .then(token => {
                  res.status(200).send({
                    status: true,
                    code: 200,
                    message: "JWT Token",
                    token: token
                  });
                })
                .catch(err => {
                  console.log(err);
                });
            })
            .catch(err => {
              console.log(err);
            });
        } else {
          res.status(200).send({
            status: true,
            code: 200,
            message: "Invalid OTP"
          });
        }
      })
      .catch(err => {
        console.log(err);
      });
  }

  getFCMToken(userId,params){
      userObj.getFCMToken(userId,params)
          .then(user=>{
              return(user)
          })
          .catch(err=>{
              return err;
          })
  }
}

module.exports = Usercontroller;
