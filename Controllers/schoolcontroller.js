
const School=require('../Models/school.js');
const schoolModel=new School();


class Schoolcontroller {
    constructor(){

    }

    getMenuList(req,res){
        const schoolId=req.schoolId;
        const roleId=3;
        schoolModel.getMenu(schoolId,roleId,['id','name','component','icon','badge'])
            .then(menus=>{
                if(menus.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: 'Menu items are',
                            result: menus
                        });
                }else {
                    res.status(204).send({message:'no content'})
                }
            })
            .catch(err=>{
                res.status(500)
                    .send({
                        status:false,
                        message:'Internal server error',
                        details:err
                    });
            })
    }

    getStudentList(req,res){
        const schoolId=req.schoolId;
        schoolModel.getStudents(schoolId,[])
            .then(students=>{
                if(students.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: ' Active Students List',
                            result: students
                        })
                }else{
                    res.status(204).send({message:'No data'});
                }
            })
            .catch(err=>{
                res.status(500).send({details:err});
            })
    };

    getCourses(req,res){
        const schoolId=req.schoolId;
        schoolModel.getCourses(schoolId,['id','course_title'])
            .then(courses=>{
                if(courses.length>0){
                    res.status(200)
                        .send({
                            status: true,
                            code: 200,
                            message: 'Available courses',
                            result: courses
                        })
                }else{
                    res.status(204).send()
                }
            })
    }
}

module.exports=Schoolcontroller;