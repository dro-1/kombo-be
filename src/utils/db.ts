import mysql, { Pool } from "mysql2";

const pool = mysql
  .createPool({
    host: "localhost",
    user: "root",
    database: "kombo",
    password: "password",
  })
  .promise();

export default pool;
