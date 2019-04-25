
const ExamModel=require('../Models/exam.js');
const examModel=new ExamModel();

class Staffcontroller{
    constructor(){

    }

    getExamByStaff(req,res){
        const userId=req.params.userId;
        examModel.getExamByStaff(userId,[])
            .then(exams=>{
                if(exams.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: 'Exam List',
                            result:exams
                        })
                }
                else{
                    res.sendStatus(204);
                }
            })
            .catch(err=>{
                res.status(500).send(err);
            })
    }
}
module.exports=Staffcontroller;

