const express = require("express");
const { PrismaClient } = require("@prisma/client");

const router = express.Router();
const prisma = new PrismaClient();

//GET all enrollments
router.get("/enrollments", async (req, res) => {
  try {
    const enrollments = await prisma.enrollment.findMany({
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        isAproved: true,
        status: true,
        course: {
          select: {
            id: true,
            name: true,
          },
        },
        student: {
          select: {
            id: true,
            fname: true,
            lname: true,
          },
        },
        supervisor: {
          select: {
            id: true,
            fname: true,
            lname: true,
          },
        },
      },
      orderBy: [{ updatedAt: "desc" }],
    });
    res.json(enrollments);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET enrollment by id
router.get("/enrollment/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const enrollment = await prisma.enrollment.findUnique({
      where: { id: Number(id) },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        isAproved: true,
        status: true,
        course: {
          select: {
            id: true,
            name: true,
          },
        },
        student: {
          select: {
            id: true,
            fname: true,
            lname: true,
          },
        },
        supervisor: {
          select: {
            id: true,
            fname: true,
            lname: true,
          },
        },
      },
    });
    res.json(enrollment);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//creat enrollment
router.post("/enrollment", async (req, res) => {
  const { supervisorId, isAproved, studentID, courseID } = req.body;
  try {
    const createenrollment = await prisma.enrollment.create({
      data: { supervisorId, isAproved, studentID, courseID },
    });
    res.json(createenrollment);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//UPDATE enrollment
router.put("/enrollment/:id", async (req, res) => {
  const { id } = req.params;
  const { supervisorId, isAproved, status } = req.body;

  const UpdateEnrollment = await prisma.enrollment.update({
    where: { id: Number(id) },
    data: {
      supervisorId,
      isAproved: Boolean(isAproved),
      status,
    },
  });
  res.json(UpdateEnrollment);
});
//delete enrollment
router.delete("/enrollment/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const deleteEnrollment = await prisma.enrollment.delete({
      where: { id: Number(id) },
    });
    res.json(deleteEnrollment);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

module.exports = router;
