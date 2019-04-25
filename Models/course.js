const con=require('../dbconfig.js');
const DbHelper=require('../shared/dbhelper.js');
const dbHelper=new DbHelper();
const moment=require('moment');
class Course{
    constructor(){

    }
    getSubjects(schoolId,courseId,params){
        const sql= 'SELECT'
                            +params.toString()+
                         'FROM \
                            subjects s \
                        JOIN \
                            course_subject cs \
                        ON \
                            s.id = cs.subject_id \
                        WHERE \
                            cs.course_id=?';
        return new Promise((resolve, reject) => {
            con.query(sql,[courseId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }
    getStudents(schoolId,courseId,params){
        let sql='SELECT'
                     +params.toString()+
                   ' FROM \
                        students s\
                    JOIN \
                        users u \
                    ON \
                        u.id = s.user_id \
                    WHERE \
                        s.course_id=? and u.school_id=?';
        return new Promise((resolve, reject) => {
            con.query(sql,[courseId,schoolId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }
    setAttendance(schoolId,courseId,params){
        const sql='insert into \
                        student_attendance \
                    set ? \
                    on \
                        duplicate key \
                    update \
                        status=? ';
        var promise=[];
        const absentees=params.data.filter(x=>{
            if(x.status===false){
                return x;
            }
        });

        return new Promise((resolve, reject) => {
            for(let i=0;i<absentees.length;i++){
                let object={
                    attendance_date:params.date,
                    record_updated_by:params.userId,
                    user_id:absentees[i].studentId,
                    status:false,
                    course_id:params.courseId,
                    created_at:moment().format(),
                    updated_at:moment().format()
                };
                promise.push(dbHelper.insertOnDuplicate(con,sql,object))
            }
            Promise.all(promise)
                .then(response=>{
                    resolve(response);
                })
                .catch(reason => {
                    reject(reason);
                })
        })
    }

    getAttendance(courseId,date){

    }



}
module.exports=Course;

