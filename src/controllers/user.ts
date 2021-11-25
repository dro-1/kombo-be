import { Request, Response } from "express";
import { sendData, sendError } from "../helpers/responders";
import { CityController } from "../models/city";

export const findCity = (req: Request, res: Response) => {
  const { input, language }: { input: string; language: string } = req.body;
  if (!input || !language)
    return sendError("Input and Language are required", 400, res);

  CityController.findByInput(input, language)
    .then((response) => {
      sendData(response[0], 200, res);
    })
    .catch((err) => {
      console.log(err.message);
      sendError("Invalid Input or Language", 400, res);
    });
};
