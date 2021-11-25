"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendData = exports.sendSuccess = exports.sendError = void 0;
const sendError = (errorMessage, statusCode, res) => {
    res.status(statusCode).send({
        status: "Failed",
        message: errorMessage,
    });
};
exports.sendError = sendError;
const sendSuccess = (successMessage, statusCode, res) => {
    res.status(statusCode).send({
        status: "Success",
        message: successMessage,
    });
};
exports.sendSuccess = sendSuccess;
const sendData = (data, statusCode, res) => {
    res.status(statusCode).send({
        status: "Success",
        data,
    });
};
exports.sendData = sendData;
