import { Router } from "express";
import * as userController from "../controllers/user";

const router = Router();

router.post("/findCity", userController.findCity);

export default router;
