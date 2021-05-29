const express = require("express");
const { PrismaClient } = require("@prisma/client");

const router = express.Router();
const prisma = new PrismaClient();

//GET all courses
router.get("/courses", async (req, res) => {
  try {
    const courses = await prisma.course.findMany({
      include: {
        prerequisites: true,
        enrollments: {
          include: {
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
        },
      },
    });
    res.json(courses);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET course by id
router.get("/course/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const course = await prisma.course.findUnique({
      where: { id: Number(id) },
    });
    res.json(course);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET course enrollments by course id
router.get("/course/:id/enrollments", async (req, res) => {
  const { id } = req.params;
  try {
    const course = await prisma.course.findUnique({
      where: { id: Number(id) },
      include: {
        enrollments: {
          include: {
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
        },
      },
    });
    res.json(course);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET all courses for spacific level and major
router.get("/courses/:major/:level", async (req, res) => {
  const { major, level } = req.params;
  try {
    const courses = await prisma.course.findMany({
      where: {
        AND: [
          {
            major: major.toUpperCase(),
          },
          {
            level: Number(level),
          },
        ],
      },
      include: {
        prerequisites: true,
        prerequisitedBy: true,
      },
    });
    res.json(courses);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//creat course
router.post("/course", async (req, res) => {
  const { name, credit, discreption, courseCode, level, major } = req.body;
  try {
    const createCourse = await prisma.course.create({
      data: {
        name,
        credit: Number(credit),
        discreption,
        courseCode,
        level: Number(level),
        major,
      },
    });
    res.json(createCourse);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//UPDATE prereq
router.put("/course/:id/prerequisites", async (req, res) => {
  const { id } = req.params;
  const { prerequisites } = req.body; // array of courses codes

  try {
    const prerequisitesIDs = [];
    for await (const courseCode of prerequisites) {
      const courseId = await prisma.course.findFirst({
        where: { courseCode },
        select: { id: true },
      });

      prerequisitesIDs.push(courseId);
    }

    const updateCourse = await prisma.course.update({
      where: { id: Number(id) },
      data: {
        prerequisites: {
          connect: prerequisitesIDs,
        },
      },
    });
    res.json(updateCourse);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//creat finished course , == end enrollment by adding result
router.post("/enrollment/:id/addresult", async (req, res) => {
  const { id } = req.params;

  const { courseId, studentID, grade, semester, instructorName } = req.body;
  try {
    const createFinishedCourse = await prisma.finishedCourses.create({
      data: {
        courseId: Number(courseId),
        studentID: Number(studentID),
        grade: Number(grade),
        semester,
        instructorName,
      },
    });

    const deleteEnrollment = await prisma.enrollment.delete({
      where: { id: Number(id) },
    });

    res.json(createFinishedCourse);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

module.exports = router;
