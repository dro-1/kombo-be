import mysql from "mysql2";
import { config } from "dotenv";
config();

const pool = mysql
  .createPool({
    host: "localhost",
    user: "root",
    database: "kombo",
    password: process.env.MYSQL_PASSWORD,
  })
  .promise();

export default pool;
