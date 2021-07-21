const express = require("express");
const connection = require("../../module/connection");
const router = express.Router();

router.get('/',(req,res)=>{
    let sql = "select * from users";
    try {
        connection.query(sql,(error, results)=>{
            if(error){
                console.log(error);
                res.status(400).json({"error": error})
            }
            console.log(results);
            res.status(200).json({"data":results});
        });

    } catch (error) {
        console.log(`Error occured ${error}`);
        res.error(error);
    }
})

router.post('/saveUser', (req, res)=>{
    let {type, userName, phoneNumber,autoNumber, address} = req.body;
    let sql = "insert into users values(null, ?)";
    try {
        connection.query(sql,[type,userName,phoneNumber,autoNumber,address],(error,results)=>{
            if(error){
                console.log(error);
                res.status(400).json({"error": error})
            }
            console.log(results);
            res.status(200).json({"message":"saved successfully"});
        })
    } catch (error) {
        console.log(`Error occured ${error}`);
        res.error(error);
    }
})

module.exports = router;