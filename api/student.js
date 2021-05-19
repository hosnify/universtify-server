const express = require("express");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

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
  } = req.body;
  const createStudent = await prisma.student.create({
    data: {
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
    },
  });
});

//GET all students
app.get("/students", async (req, res) => {
  const students = await prisma.student.findMany();
  res.json(students);
});

//GET student by id
app.get("/student/:id", async (req, res) => {
  const { id } = req.params;
  const student = await prisma.student.findUnique({
    where: { id: Number(id) },
  });
  res.json(student);
});

//UPDATE supervisor of a student
app.put("/student/:id/supervisor/:supervisorid", (req,res)=>{
    const { id ,supervisorid} = req.params;
    try {
        const updatedStudent = await prisma.student.update({
          where: { id: Number(id) || undefined },
          data: { supervisorId: Number(supervisorid) || undefined },
        })
        res.json(updatedStudent)
      } catch (error) {
        res.json({ error: `student with ID ${id} does not exist in the database` })
      }
})

//UPDATE finished courses for a student
app.put("/student/:id/finishedcourses", (req,res)=>{
    const { id } = req.params;
    const {finishedcourses} =req.body // array of courses IDs
    try {
        const updatedStudent = await prisma.student.update({
          where: { id: Number(id) || undefined },
          data: { coursesFinished: {connect : finishedcourses}},
        })
        res.json(updatedStudent)
      } catch (error) {
        res.json({ error: `student with ID ${id} does not exist in the database or courses does not exist` })
      }
})

//UPDATE finished courses for a student // 0% happened // will be removed
app.put("/student/:id/enrollments", (req,res)=>{
    const { id } = req.params;
    const {enrollments} =req.body // array of enrollments IDs
    try {
        const updatedStudent = await prisma.student.update({
          where: { id: Number(id) || undefined },
          data: { enrollments: {connect : enrollments}},
        })
        res.json(updatedStudent)
      } catch (error) {
        res.json({ error: `student with ID ${id} does not exist in the database or courses does not exist` })
      }
})

//DELETE student 
app.delete('/student/:id',async(req,res)=>{
    const { id } = req.params;
    const deleteStudent = await prisma.student.delete({
        where: {id}
    }) 
})




