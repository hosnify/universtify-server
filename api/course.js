const express = require("express");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

//GET all courses
app.get("/courses", async (req, res) => {
  const courses = await prisma.course.findMany();
  res.json(courses);
});

//GET course by id
app.get("/course/:id", async (req, res) => {
  const { id } = req.params;
  const course = await prisma.course.findUnique({
    where: { id: Number(id) },
  });
  res.json(course);
});

//creat course
app.post("/course", async (req, res) => {
  const { name, credit, available, courseCode } = req.body;
  const createcourse = await prisma.course.create({
    data: {
      name,
      credit,
      available,
      courseCode,
    },
  });
});

//UPDATE prereq
app.put("/course/:id/prerequisites", async (req, res) => {
  const { id } = req.params;
  const { prerequisites } = req.body; // array of courses IDs
  const updateCourse = await prisma.course.update({
    where: { id },
    data: {
      prerequisites: {
        connect: prerequisites,
      },
    },
  });
});
