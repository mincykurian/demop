const con=require('../dbconfig.js');

class School {
    constructor(){

    }

    getMenu(schoolId,roleId,params){
        let condition='FROM \
                            school_roles_menu srm \
                        JOIN \
                            menus m \
                        ON \
                            m.id = srm.menu_id \
                        WHERE \
                            srm.school_id = ? AND srm.role_id = ? \
                        ORDER BY \
                            srm.order_no';
        let sql='SELECT '+params.toString()+condition;
        return new Promise((resolve, reject) => {
            con.query(sql,[schoolId,roleId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        });

    }

    getStudents(schoolId,params){
        let sql='SELECT \
                     * \
                FROM \
                    students s \
                JOIN \
                    users u \
                ON \
                    s.user_id = u.id \
                WHERE \
                    u.school_id = ?';
        return new Promise((resolve, reject) => {
            con.query(sql,[schoolId],(err,rows,fields)=>{
                if(err) reject(err);
                else{
                    resolve(rows);
                }
            })
        })
    }
    getCourses(schoolId,params){
        let sql='SELECT'
                    +params.toString()+
                'FROM \
                    courses c \
                WHERE \
                    school_id = ?';

        return new Promise((resolve, reject) => {
            con.query(sql,[schoolId],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }
}
module.exports=School;