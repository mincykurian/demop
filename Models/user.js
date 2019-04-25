const con=require('../dbconfig.js');

class User {


    findAll(mobileNumber,params){
        let  sql='select ';
        let condition='FROM \
                            users u \
                        LEFT JOIN \
                            students s \
                        ON \
                            s.user_id = u.id \
                        LEFT JOIN \
                            staff st \
                        ON \
                            u.id = st.user_id \
                        LEFT JOIN \
                            courses c \
                        ON \
                            c.id = s.course_id OR st.course_id = c.id \
                        WHERE \
                            u.phone = ? ';
        sql+=params.toString()+' '+condition;

        return new Promise((resolve, reject) => {
            con.query(sql,[mobileNumber],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }

    getFCMToken(userId,params){
        const sql='SELECT'
                        +params.toString()+
                   ' FROM \
                        users u \
                    WHERE \
                        u.id = ?';
        return new Promise((resolve, reject) => {
            con.query(sql,[userId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })

    }
}
module.exports=User;