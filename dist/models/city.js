"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CityController = void 0;
const db_1 = __importDefault(require("../utils/db"));
const mysql2_1 = require("mysql2");
class CityController {
    constructor(city) {
        this.city = city;
    }
}
exports.CityController = CityController;
CityController.fetchAll = () => {
    return db_1.default.execute("SELECT * FROM city");
};
CityController.findByInput = (input, language) => {
    language = (0, mysql2_1.escape)(`name_${language}`).substring(1, 8);
    input = (0, mysql2_1.escape)(input + "%");
    return db_1.default.execute(`SELECT * FROM city WHERE ${language} LIKE ${input} LIMIT 20`);
};
