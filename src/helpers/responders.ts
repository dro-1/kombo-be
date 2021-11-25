import { Response } from "express";

export const sendError = (
  errorMessage: string,
  statusCode: number,
  res: Response
): void => {
  res.status(statusCode).send({
    status: "Failed",
    message: errorMessage,
  });
};

export const sendSuccess = (
  successMessage: string,
  statusCode: number,
  res: Response
): void => {
  res.status(statusCode).send({
    status: "Success",
    message: successMessage,
  });
};

export const sendData = (data: any, statusCode: number, res: Response) => {
  res.status(statusCode).send({
    status: "Success",
    data,
  });
};
