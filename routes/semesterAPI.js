const express = require("express");
const { PrismaClient } = require("@prisma/client");

const router = express.Router();
const prisma = new PrismaClient();

//GET all semesters
router.get("/semesters", async (req, res) => {
  try {
    const semester = await prisma.semester.findMany({
      include: {
        Courses: true,
        students: true,
      },
    });
    res.json(semester);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET one semester
router.get("/semester/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const semester = await prisma.semester.findUnique({
      where: { id: Number(id) },
      include: {
        Courses: true,
        students: true,
      },
    });
    res.json(semester);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});
//creat semester
router.post("/semester", async (req, res) => {
  const { type, year, coordinatorId } = req.body;
  try {
    const createsemester = await prisma.semester.create({
      data: {
        type: String(type).toUpperCase(),
        year: Number(year),
        coordinatorId: Number(coordinatorId),
      },
    });
    res.json(createsemester);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//update semester => change status
router.put("/semester/:id", async (req, res) => {
  const { id } = req.params;

  const { status } = req.body;
  try {
    const updateSemester = await prisma.semester.update({
      where: {
        id: Number(id),
      },
      data: {
        status,
      },
    });
    res.json(updateSemester);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//update semester => add course to semester
router.put("/semester/:semesterId/course/:courseId", async (req, res) => {
  const { semesterId, courseId } = req.params;
  try {
    const updateSemester = await prisma.semester
      .update({
        where: {
          id: Number(semesterId),
        },
        data: {
          Courses: {
            connect: { id: Number(courseId) },
          },
        },
      })
      .Courses();
    res.json(updateSemester);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});
module.exports = router;
