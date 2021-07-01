const express = require("express");
const { PrismaClient } = require("@prisma/client");

const router = express.Router();
const prisma = new PrismaClient();

//GET all semester
router.get("/semesters", async (req, res) => {
  try {
    const semester = await prisma.semester.findMany();
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

//update semester semester
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

module.exports = router;
