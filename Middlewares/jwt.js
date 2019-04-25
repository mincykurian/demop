const jwt=require('jsonwebtoken');
const fs=require('fs');
require('dotenv').config();
class JWT {


    constructor(){
        this.issuer='jpNme';
        this. subject='someuser@user.com';
        this. audience='http://hfcghs.jpnme.com';
        this. privateKEY=fs.readFileSync(process.env.PRIVATE_KEY,'utf8');
    }

    createToken(data){
        const signInOptions={
            issuer:this.issuer,
            subject:this.subject,
            audience:this.audience,
            expiresIn:'12h',
            algorithm:'RS256'
        };
       return new Promise((resolve, reject) => {
            jwt.sign(data,this.privateKEY,signInOptions,(err,token)=>{
                if(err) throw err;
                console.log(token);
                resolve(token);
            });
       })
    }
    verifyToken(req,res,next){
        const publicKEY=fs.readFileSync(process.env.PUBLIC_KEY,'utf8');
       // console.log(req);
        try{
            const signInOptions={
                issuer:'jpNme',
                subject:'someuser@user.com',
                audience:'http://hfcghs.jpnme.com',
                expiresIn:'12h',
                algorithm:['RS256']
            };
            const bearerHeader=req.header('authorization');
            if(bearerHeader){
                const token=bearerHeader.split(' ')[1];
                jwt.verify(token,publicKEY,signInOptions,(err,decode)=>{
                    if(err){
                        console.log(err);
                        return res.status(401).send({message:'Auth failed'});
                    }else{
                        req.decoded=decode;
                        //console.log(decode);
                        next();
                    }
                })

            }else{
                console.log('no token');
                next();
               /* res.send({
                    status:'no token'
                })
*/
            }
        }catch (e) {
            console.log(e);
        }
    }

}


module.exports=JWT;