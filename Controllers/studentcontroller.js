const StudentModel=require('../Models/student.js');
const studentModel=new StudentModel();

class Studentcontroller {
    constructor(){

    }

    getStudentProfile(req,res){
        studentModel.getStudentProfile(req.params.id)
            .then(student=>{
                if(student.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: 'Student details',
                            result: student[0]
                        })
                }else{
                    res.status(204).send();
                }
            });
    }

    updateStudentProfile(req,res){
        studentModel.update(req.params.id,req.body)
            .then(data=>{
                if(data.affectedRows>0){
                    if(data.changedRows>0){
                        res.status(200)
                            .send({
                                status: true,
                                code: 200,
                                message: 'Student details updated',
                                result: data
                            })
                    }else{
                        res.status(200)
                            .send({
                                status: true,
                                code: 200,
                                message: 'Student details are upto date',
                                result: data
                            })
                    }
                }else {
                    res.status(200)
                        .send({
                            status: false,
                            code: 200,
                            message: 'No student found',
                        })
                }
            })
            .catch(err=>{
                res.status(500).send({message:err});
            })
    }

    AddStudentMedicalInfo(req,res){
        studentModel.setStudentMedicalDetails(req.body)
            .then(response=>{
                res.status(201)
                    .send({
                        status: true,
                        code: 201,
                        message: 'Student medical details inserted',
                        result: response
                    })
            })
            .catch(err=>{
                res.status(500)
                    .send({
                        status: true,
                        code: 500,
                        message: 'Internal Server error',
                        result: 'Student details is not present'
                    })
            })
    }

    updateStudentMedicalInfo(req,res){
        studentModel.updateStudentMedicalInfo(req.params.userId,req.body)
            .then(response=>{
                if(response.affectedRows>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: response.changedRows>0?'Updated':'Nothing to update',
                            result:response
                        })
                }else{
                    res.status(200)
                        .send({
                            status: false,
                            code: 200,
                            message: 'No student found',
                        })
                }

            })
            .catch(err=>{
                res.status(500).send({message:err});
            })
    }

    deleteStudentMedicalInfo(req,res){
        studentModel.deleteStudentMedicalInfo(req.params.userId)
            .then(response=>{
                res.status(200)
                    .send({
                        status: true,
                        code: 200,
                        message: response.affectedRows>0?'deleted':'No records exists..',
                    })
            })
            .catch(err=>{
                res.status(500).send({err:err});
            })
    }

    //Attendance


}

module.exports=Studentcontroller;