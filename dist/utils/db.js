"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const mysql2_1 = __importDefault(require("mysql2"));
const dotenv_1 = require("dotenv");
(0, dotenv_1.config)();
const pool = mysql2_1.default
    .createPool({
    host: "localhost",
    user: "root",
    database: "kombo",
    password: process.env.MYSQL_PASSWORD,
})
    .promise();
exports.default = pool;
