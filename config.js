global.schools={};
schools['hfcghs']={
    schoolId:1,
    schoolName:'Holy Family Convent Girls School'
};
class Config {

    constructor(){
    }

    isValidSchool(req,res,next){
        if(schools[req.params.schoolCode.toString().toLowerCase()]){
            req.schoolId=schools[req.params.schoolCode.toString().toLowerCase()].schoolId;
            next();
        }else{
            res.status(400).send({error:'Bad request'})
        }
    }
    getSchool(schoolCode){
        if(schools[schoolCode.toString().toLowerCase()]){
            return schools[schoolCode.toString().toLowerCase()];
        }else{
            return false
        }
    }
}
module.exports=Config;