"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.findCity = void 0;
const responders_1 = require("../helpers/responders");
const city_1 = require("../models/city");
const findCity = (req, res) => {
    const { input, language } = req.body;
    if (!input || !language)
        return (0, responders_1.sendError)("Input and Language are required", 400, res);
    city_1.CityController.findByInput(input, language)
        .then((response) => {
        (0, responders_1.sendData)(response[0], 200, res);
    })
        .catch((err) => {
        console.log(err.message);
        (0, responders_1.sendError)("Invalid Input or Language", 400, res);
    });
};
exports.findCity = findCity;
