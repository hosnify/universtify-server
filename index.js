const express = require("express");
const path = require("path");
const cors = require("cors");
const passport = require("./auth");
const { PrismaClient } = require("@prisma/client");
const authRouter = require("./routes/authAPI");
const courseRouter = require("./routes/courseAPI");
const enrollmentRouter = require("./routes/enrollmentAPI");
const studentRouter = require("./routes/studentAPI");
const semesterRouter = require("./routes/semesterAPI");
const studentSemesterRouter = require("./routes/studentSemesterAPI");
const supervisorRouter = require("./routes/supervisorAPI");
const coordinatorRouter = require("./routes/coordinatorAPI");
const notificationRouter = require("./routes/notificationAPI");
const majorRouter = require("./routes/majorAPI");
const filesAPI = require("./routes/filesAPI");

const prisma = new PrismaClient();
const app = express();

app.use(express.json());
app.use(passport.initialize());
app.use(cors());

app.use(courseRouter);
app.use(enrollmentRouter);
app.use(studentRouter);
app.use(semesterRouter);
app.use(studentSemesterRouter);
app.use(supervisorRouter);
app.use(coordinatorRouter);
app.use(notificationRouter);
app.use(majorRouter);
app.use(filesAPI);

app.use("/api", authRouter);

app.use(express.static(path.resolve(__dirname, "./build")));

app.get("/", (req, res) => {
  res.sendFile(path.resolve(__dirname, "./build", "index.html"));
});

app.get("/app/*", (req, res) => {
  res.sendFile(path.resolve(__dirname, "./build", "index.html"));
});
async function main() {
  const PORT = process.env.PORT || 8888;
  const server = app.listen(PORT, () => {
    console.log(`app running on port ${PORT}`);
  });
}

main()
  .catch((e) => {
    console.error(e);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
