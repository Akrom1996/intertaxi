const cluster = require("cluster");
const cpu = require("os").cpus();
const numCPU = cpu.length;
if(cluster.isMaster){
    for(let i = 0; i <numCPU; i ++)
        cluster.fork();
    cluster.on('exit',(worker,code,signal)=>{
        console.log(`Worker ${process.pid} died`);
    })
}
else{
    const express = require("express");
    const app = express();
    require("dotenv").config();
    const userRouter = require('./routes/users/user');
    const PORT = process.env.PORT;
    app.use(express.json());
    app.use('/user', userRouter);
    app.listen(PORT||5000,()=>{
        console.log(`Server is listening on port ${PORT} `)
    });
    // console.log(`Worker ${process.pid} started`);
}

