require('dotenv').config();
const mysql=require('mysql');


    const db=
        {
            test:{
                host: process.env.DB_HOST,
                user: process.env.DB_USER,
                password: process.env.DB_PASSWORD,
                database: process.env.DB_NAME,
                connectionLimit:10,
                connectTimeout:30000,
                multipleStatements:true,
                charset:"utf8mb4"
            }
        };


    const con=mysql.createPool(db.test);
    try {
        con.getConnection((err,connection)=>{
            if(connection){
                console.log('MySQL connected');
            }
            if(err){

                console.log(err);
                if(err.code==='PROTOCOL_CONNECTION_LOST'){
                    console.error('Database connection was closed');
                }
                if(err.code==='ER_CON_COUNT_ERROR'){
                    console.error('Database has too many connections');
                }
                if(err.code==='ECONNREFUESED'){
                    console.error('Database connection has refused');
                }
            }
        });
    }catch (e) {
        console.log(e)
    }
    module.exports=con;


