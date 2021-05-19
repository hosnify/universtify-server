const express = require("express");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const app = express();

app.use(express.json());

//GET all supervisors
app.get("/supervisors", async (req, res) => {
  const supervisors = await prisma.supervisor.findMany();
  res.json(supervisors);
});

//GET supervisor by id
app.get("/supervisor/:id", async (req, res) => {
  const { id } = req.params;
  const supervisor = await prisma.supervisor.findUnique({
    where: { id: Number(id) },
  });
  res.json(supervisor);
});

//creat supervisor
app.post("/supervisor", async (req, res) => {
  const { fname, lname, gender, password, email } = req.body;
  const createsupervisor = await prisma.supervisor.create({
    data: {
      fname,
      lname,
      gender,
      password,
      email,
    },
  });
});
