const express = require("express");
const path = require("path");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const logger = require("morgan");
const passport = require("passport");
const LocalStrategy = require("passport-local");
const passportJWT = require("passport-jwt");

const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const app = express();

app.use(express.json());
app.use(passport.initialize());
app.use(cors());

const JWTStrategy = passportJWT.Strategy;
///////// auth //////////
const apiRouter = require("./routes/authAPI");
app.use("/api", apiRouter);

let user;

passport.use(
  new LocalStrategy(
    {
      usernameField: "email",
    },
    async (email, password, done) => {
      user = await prisma.student.findUnique({
        where: { email: email.toString() },
        select: {
          id: true,
          email: true,
          password: true,
        },
      });
      if (!user) {
        user = await prisma.supervisor.findUnique({
          where: { email: email },
          select: {
            id: true,
            email: true,
            password: true,
          },
        });
        user && (user["role"] = "supervisor");
      } else {
        user && (user["role"] = "student");
      }

      if (user && email === user.email && password === user.password) {
        return done(null, user);
      } else {
        return done(null, false);
      }
    }
  )
);

passport.use(
  new JWTStrategy(
    {
      jwtFromRequest: passportJWT.ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: "jwt_secret", // just for development
    },
    (jwt_payload, done) => {
      if (user.id === jwt_payload.user.id) {
        return done(null, user);
      } else {
        return done(null, false, {
          message: "Token not matched",
        });
      }
    }
  )
);

///////////////////////////
//creat student
app.post("/student", async (req, res) => {
  const {
    fname,
    lname,
    gender,
    password,
    email,
    level,
    semester,
    program,
    major,
    creditDone,
    creditHave,
    supervisorId,
    GPA,
    lastTermGPA,
  } = req.body;
  // try {
  const createStudent = await prisma.student.create({
    data: {
      fname,
      lname,
      gender,
      password,
      email,
      level: Number(level),
      program,
      major,
      creditDone: Number(creditDone),
      creditHave: Number(creditHave),
      supervisorId: Number(supervisorId),
      GPA: Number(GPA),
      lastTermGPA: Number(lastTermGPA),
    },
  });
  res.json(createStudent);
  // } catch (err) {
  //   res.json({ error: "wrong data", errMsg: err });

  // }
});

//GET all students
app.get("/students", async (req, res) => {
  try {
    const students = await prisma.student.findMany({
      include: {
        coursesFinished: { include: { course: true } },
        enrollments: true,
      },
    });
    res.json(students);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET user
app.post("/user", async (req, res) => {
  const { email, password } = req.body;
  try {
    let user = await prisma.student.findUnique({
      where: { email: email.toString() },
      select: {
        id: true,
        email: true,
        password: true,
      },
    });
    if (!user) {
      user = await prisma.supervisor.findUnique({
        where: { email: email },
        select: {
          email: true,
          password: true,
        },
      });
    }
    res.json(user);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET student by id
app.get("/student/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const student = await prisma.student.findUnique({
      where: { id: Number(id) },
      include: {
        coursesFinished: { include: { course: true } },
        enrollments: true,
      },
    });
    res.json(student);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET student finished courses by id
app.get("/student/:id/courses", async (req, res) => {
  const { id } = req.params;
  try {
    const studentCourses = await prisma.student.findUnique({
      where: { id: Number(id) },
      select: {
        coursesFinished: {
          include: { course: true },
        },
      },
    });
    res.json(studentCourses);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET student enrollments by id
app.get("/student/:id/enrollments", async (req, res) => {
  const { id } = req.params;
  try {
    const studentEnrollments = await prisma.student.findUnique({
      where: { id: Number(id) },
      select: {
        enrollments: {
          include: {
            course: true,
            student: {
              select: {
                fname: true,
                lname: true,
              },
            },
            supervisor: {
              select: {
                fname: true,
                lname: true,
              },
            },
          },
        },
      },
    });
    res.json(studentEnrollments);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//UPDATE supervisor of a student
app.put("/student/:id/supervisor/:supervisorid", async (req, res) => {
  const { id, supervisorid } = req.params;
  try {
    const updatedStudent = await prisma.student.update({
      where: { id: Number(id) || undefined },
      data: { supervisorId: Number(supervisorid) || undefined },
    });
    res.json(updatedStudent);
  } catch (error) {
    res.json({ error: `student with ID ${id} does not exist in the database` });
  }
});

//UPDATE password of a student
app.put("/student/:id/password", async (req, res) => {
  const { id } = req.params;
  const { password } = req.body;
  try {
    const updatedStudent = await prisma.student.update({
      where: { id: Number(id) || undefined },
      data: { password: password || undefined },
    });
    res.json(updatedStudent);
  } catch (error) {
    res.json({ error: `student with ID ${id} does not exist in the database` });
  }
});

//UPDATE finished courses for a student
app.put("/student/:id/finishedcourses", async (req, res) => {
  const { id } = req.params;
  const { finishedcourses } = req.body; // array of courses IDs
  try {
    const updatedStudent = await prisma.student.update({
      where: { id: Number(id) || undefined },
      data: { coursesFinished: { connect: finishedcourses } },
    });
    res.json(updatedStudent);
  } catch (error) {
    res.json({
      error: `student with ID ${id} does not exist in the database or courses does not exist`,
    });
  }
});

//UPDATE finished courses for a student // 0% happened // will be removed
app.put("/student/:id/enrollments", async (req, res) => {
  const { id } = req.params;
  const { enrollments } = req.body; // array of enrollments IDs
  try {
    const updatedStudent = await prisma.student.update({
      where: { id: Number(id) || undefined },
      data: { enrollments: { connect: enrollments } },
    });
    res.json(updatedStudent);
  } catch (error) {
    res.json({
      error: `student with ID ${id} does not exist in the database or courses does not exist`,
    });
  }
});

//DELETE student
app.delete("/student/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const deleteStudent = await prisma.student.delete({
      where: { id },
    });
    res.json(deleteStudent);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

/////////////////////////////////////////////
////////////////////////////////////////////
///////////////////////////////////////////
//////////////////////////////////////////
/////////////////////////////////////////

//GET all supervisors
app.get("/supervisors", async (req, res) => {
  try {
    const supervisors = await prisma.supervisor.findMany();
    res.json(supervisors);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET supervisor by id
app.get("/supervisor/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const supervisor = await prisma.supervisor.findUnique({
      where: { id: Number(id) },
    });
    res.json(supervisor);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//creat supervisor
app.post("/supervisor", async (req, res) => {
  const { fname, lname, gender, password, email } = req.body;
  try {
    const createSupervisor = await prisma.supervisor.create({
      data: {
        fname,
        lname,
        gender,
        password,
        email,
      },
    });
    res.json(createSupervisor);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//UPDATE password of a supervisor
app.put("/supervisor/:id/password", async (req, res) => {
  const { id } = req.params;
  const { password } = req.body;
  try {
    const updatedSupervisor = await prisma.supervisor.update({
      where: { id: Number(id) || undefined },
      data: { password: password || undefined },
    });
    res.json(updatedSupervisor);
  } catch (error) {
    res.json({
      error: `supervisor with ID ${id} does not exist in the database`,
    });
  }
});

/////////////////////////////////////////////
////////////////////////////////////////////
///////////////////////////////////////////
//////////////////////////////////////////
/////////////////////////////////////////

//GET all courses
app.get("/courses", async (req, res) => {
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
app.get("/course/:id", async (req, res) => {
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
app.get("/course/:id/enrollments", async (req, res) => {
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
app.get("/courses/:major/:level", async (req, res) => {
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
app.post("/course", async (req, res) => {
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
app.put("/course/:id/prerequisites", async (req, res) => {
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
app.post("/finishedcourse", async (req, res) => {
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
    res.json(createFinishedCourse);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});
/////////////////////////////////////////////
////////////////////////////////////////////
///////////////////////////////////////////
//////////////////////////////////////////
/////////////////////////////////////////

//GET all enrollments
app.get("/enrollments", async (req, res) => {
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
app.get("/enrollment/:id", async (req, res) => {
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
app.post("/enrollment", async (req, res) => {
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
app.put("/enrollment/:id", async (req, res) => {
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
app.delete("/enrollment/:id", async (req, res) => {
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
/////////////////////////////////////////////
////////////////////////////////////////////
///////////////////////////////////////////
//////////////////////////////////////////
/////////////////////////////////////////
async function main() {
  const server = app.listen(8888, () =>
    console.log(`
🚀 Server ready at: http://localhost:8888
⭐️ See sample requests: http://pris.ly/e/ts/rest-express#3-using-the-rest-api`)
  );
}

main()
  .catch((e) => {
    console.error(e);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
