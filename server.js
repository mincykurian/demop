const express = require('express');
const  bodyParser = require('body-parser');
const app = express();
const  server = require('http').createServer(app);
const cors = require('cors');



const helmet=require('helmet');
require('dotenv').config();
const morgan=require('morgan');
const config=require('./Config/config.js');




//middleware
app.use(cors());
app.use(bodyParser.json());
app.use(helmet());
app.use(bodyParser.json());
app.use(morgan('dev'));



//routes
const userRoutes=require('./Routes/user');
const schoolRoutes=require('./Routes/school');
const studentRoutes=require('./Routes/student');
const courseRoutes=require('./Routes/course');
const staffRoutes=require('./Routes/staff');
const examRoutes=require('./Routes/exam');



app.use(`/wesa/api/${config.appVersion}/users`,userRoutes);
app.use(`/wesa/:schoolCode/api/${config.appVersion}/school`,schoolRoutes);
app.use(`/wesa/:schoolCode/api/${config.appVersion}/student|students`,studentRoutes);
app.use(`/wesa/:schoolCode/api/${config.appVersion}/course`,courseRoutes);
app.use(`/wesa/:schoolCode/api/${config.appVersion}/staff`,staffRoutes);
app.use(`/wesa/:schoolCode/api/${config.appVersion}/exams`,examRoutes);






server.listen(`${process.env.PORT}`, function () {
    console.log(`server running  ${process.env.PORT}`)
});
