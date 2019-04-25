
class Dbhelper {
    constructor(){

    }

    insertOnDuplicate(con,sql,params){
        return new Promise((resolve, reject) => {
            con.query(sql,[params,params.status],(err,rows,fields)=>{
                if(err) reject(err);
                resolve(rows);
            })
        })
    }
}
module.exports=Dbhelper;