const mysql = require('mysql');

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PW,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
    multipleStatements: true,
    waitForConnections: true,
    connectionLimit: 100, 
    queueLimit:1000
});
    
pool.getConnection((err) => {
    if(err) return console.log(err.message);
    console.log("connected to the database");
});

module.exports = pool;