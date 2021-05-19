const express = require("express");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

//GET all enrollments
app.get("/enrollments", async (req, res) => {
  const enrollments = await prisma.enrollment.findMany();
  res.json(enrollments);
});

//GET enrollment by id
app.get("/enrollment/:id", async (req, res) => {
  const { id } = req.params;
  const enrollment = await prisma.enrollment.findUnique({
    where: { id: Number(id) },
  });
  res.json(enrollment);
});

//creat enrollment
app.post("/enrollment", async (req, res) => {
  const { supervisorId, isAproved, studentID, courseID } = req.body;
  const createenrollment = await prisma.enrollment.create({
    data: { supervisorId, isAproved, studentID, courseID },
  });
});

//UPDATE enrollment
app.put("/enrollment/:id", async (req, res) => {
  const { id } = req.params;
  const { supervisorId, isAproved } = req.body;
  const updateCourse = await prisma.course.update({
    where: { id },
    data: {
      supervisorId,
      isAproved,
    },
  });
});
