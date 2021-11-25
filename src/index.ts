import express from "express";
import cors from "cors";
import mainRouter from "./routes";

const app = express();

const PORT = process.env.PORT || 3000;

app.use(cors());

app.use(express.json());

app.use(mainRouter);

app.use((req, res) => {
  res.send("You accessed a non-existent route.");
});

app.listen(PORT as number, () => {
  console.log(`Connected on PORT ${PORT}`);
});
