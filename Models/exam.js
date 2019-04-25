const con=require('../dbconfig.js');
const moment=require('moment');

class Exam {
    constructor(){

    }

    getExamByStaff(userId,params){
        const sql='SELECT \
                        * \
                    FROM \
                        exams e \
                    JOIN \
                        exam_categories ec \
                    ON \
                        e.exam_category_id = ec.id \
                    WHERE \
                        e.conducted_by = ?';
        return new Promise((resolve, reject) => {
            con.query(sql,[userId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }
    getExamByCourse(schoolId,courseId,params){
        const sql='SELECT'
                        +params.toString()+
                   'FROM \
                        exams e \
                    JOIN \
                        exam_categories ec \
                    ON \
                        e.exam_category_id = ec.id \
                    JOIN \
                        subjects s \
                    ON \
                        s.id = e.subject_id \
                    JOIN \
                        users u \
                    ON \
                        u.id = e.conducted_by \
                    JOIN \
                        courses c \
                    ON \
                        c.id = e.course_id \
                    WHERE \
                            e.course_id = ? AND c.school_id = ?';
        return new Promise((resolve, reject) => {
            con.query(sql,[courseId,schoolId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }

    async addExam(exam){
       const sql='insert into \
                        exams \
                    set ?';
       return new Promise((resolve, reject) => {
           con.query(sql,[exam],(err,rows,fields)=>{
               if(err) reject(err);
               resolve(rows);
           })
       })
    }
    async isExamAlreadyExists(exam){
        const sql='SELECT \
                        e.id, \
                        e.name, \
                        e.created_at, \
                        u.name AS staff \
                    FROM \
                        exams e \
                    JOIN \
                        users u \
                    ON \
                        u.id = e.conducted_by \
                    WHERE \
                        e.exam_category_id = ? AND e.subject_id = ? AND e.course_id = ?';
        return new Promise((resolve, reject) => {
            con.query(sql,exam,(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }

    removeExam(id,type) {
       let sql = 'delete  \
                    from \
                        exams \
                    where \
                        id=?';
       if (type === 'hardDelete') {
           return new Promise((resolve, reject) => {
               con.query(sql, [id],(err,rows,fields)=>{
                   if(err) reject(err);
                   resolve(rows);
               })
           })

       }else if(type==='softDelete'){
           let sql='update \
                        exams \
                    set ? \
                    where \
                        id=?';
           const params={
               deleted:true,
               updated_at:moment().format('YYYY-MM-DD hh:mm:ss')
           };
           return new Promise((resolve, reject) => {
               con.query(sql,[params,id],(err,rows,fields)=>{
                   if(err) reject(err);
                   resolve(rows);
               })
           })
       }
   }

   getStudents(examId){
       const sql='SELECT \
                    u.id, \
                    u.name, \
                    u.fcmtoken \
                FROM \
                    students s \
                JOIN \
                    exams e \
                ON \
                    e.course_id = s.course_id \
                JOIN \
                    users u \
                ON \
                    u.id = s.user_id \
                WHERE \
                    e.id = ?';
       return new Promise((resolve,reject)=>{
            con.query(sql,[examId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
       })
    
   }

    addMarks(examId,marks){
        const sql='insert into \
                        exam_results \
                    set ? \
                    on \
                        duplicate key \
                    update ?';
        return new Promise((resolve, reject) => {
            con.query(sql,[marks,marks],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }
}

module.exports=Exam;