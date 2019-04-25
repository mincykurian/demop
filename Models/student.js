const con=require('../dbconfig.js');


const moment=require('moment');


class Student {
    constructor(){

    }

    getStudentProfile(userId,params){
        let sql='SELECT \
                    * \
                FROM \
                    students \
                WHERE \
                    user_id = ?';
        return new Promise((resolve, reject) => {
            con.query(sql,[userId],(err,rows,fields)=>{
                if(err) reject(err);
                else{
                    resolve(rows);
                }
            })
        })
    }
    update(userId,user){
        const sql='UPDATE \
                        students s \
                    join \
                        users u \
                    on \
                        s.user_id=u.id \
                    set ? \
                    where \
                        u.id=?';
        return new Promise((resolve, reject) => {
            con.query(sql,[user,userId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })

    }

//student Medical info

    setStudentMedicalDetails(params){
        params.created_at=moment().format();
        params.updated_at=moment().format();
        let sql='INSERT INTO \
                        student_medical_info \
                    set ? \
                    on \
                        duplicate key \
                    update \
                        user_id=?';
        return new Promise((resolve, reject) => {
            con.query(sql,[params,params.user_id],(err,rows,fields)=>{
                if(err) reject(err);
                resolve (rows);
            })
        })


    }

    updateStudentMedicalInfo(userId,params){
        delete params.user_id;
        let updateQuery='UPDATE \
                            student_medical_info \
                        set ? \
                        where \
                            user_id=?';
        return new Promise((resolve, reject) => {
            con.query(updateQuery,[params,userId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }

    deleteStudentMedicalInfo(userId){
        let sql='DELETE  FROM \
                    student_medical_info \
                WHERE \
                    user_id=?';
        return new Promise((resolve, reject) => {
            con.query(sql,[userId],(err,rows,fields)=>{
                if(err) reject (err);
                resolve(rows);
            });
        });
    }

    getStudentLiveStatus(userId,date){
        const sql='SELECT \
                    ( \
                        SELECT \
                        COUNT(user_id) \
                        FROM \
                        student_attendance \
                        WHERE \
                        user_id = ? \
                    ) AS isPresent,\
                    ( \
                    SELECT \
                        COUNT(sa.course_id) \
                    FROM \
                        student_attendance sa \
                    JOIN \
                        students s \
                    ON \
                        s.course_id = sa.course_id  \
                    WHERE \
                        s.user_id = ? \
                    ) AS isAttendanceMarked';
        return new Promise((resolve, reject) => {
            con.query(sql,[userId,userId],(err,rows,fields)=>{
                if(err) reject(err);
                console.log(rows)
                resolve(rows);
            })
        })
    }

    getAttendanceYearly(userId){
        return new Promise((resolve,reject)=>{
            const sql='SELECT \
                            sa.user_id, \
                            sa.attendance_date, \
                            u.name \
                        FROM \
                            `student_attendance` sa \
                        JOIN \
                            users u \
                        ON \
                            u.id = sa.record_updated_by \
                        WHERE \
                            attendance_date BETWEEN ? AND ? AND sa.user_id = ?';
            con.query(sql,['2018-06-01 00:00:00','2019-03-31 00:00:00',1],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }
}
module.exports=Student;