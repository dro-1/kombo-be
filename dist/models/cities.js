"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.City = void 0;
const db_1 = __importDefault(require("./../utils/db"));
class City {
    constructor(id, name, lat, lng) {
        this.id = id;
        this.name = name;
        this.lat = lat;
        this.lng = lng;
    }
}
exports.City = City;
City.fetchAll = () => {
    return db_1.default.execute("SELECT * FROM city");
};
