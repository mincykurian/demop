require('dotenv').config();
const admin = require("firebase-admin");
class Fcmcontroller {

    constructor(){
        if(!admin){
            let serviceAccount = require(process.env.FCM_CONFIG);
            admin.initializeApp({
                credential: admin.credential.cert(serviceAccount),
                databaseURL: "https://new-wesa.firebaseio.com"
            });
        }


        //console.log(fcm.instanceId());
    }

    async sendMessage(fcmToken,message){
        if(fcmToken!=null && fcmToken!==''){
            message.token=fcmToken;
            return await admin.messaging().send(message);

        }else console.log('fcm token null')


    }

    sendTopicMessage(topic,message){

        //console.log(fcmToken);
        if(topic!=null){

            message.topic=topic;
            admin.messaging().send(message)
                .then((response) => {
                    // Response is a message ID string.
                    console.log('Successfully sent message:', response);
                    return true;
                })
                .catch((error) => {
                    console.log('Error sending message:', error);
                    return false;
                });
        }

    }

}
module.exports=Fcmcontroller;