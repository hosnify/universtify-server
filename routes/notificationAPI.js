const express = require("express");
const { PrismaClient } = require("@prisma/client");

const router = express.Router();
const prisma = new PrismaClient();

//Create notification
router.post("/notification", async (req, res) => {
  try {
    const { receiverId, status, data } = req.body;
    const createNotification = await prisma.notifications.create({
      data: {
        receiverId: Number(receiverId),
        status,
        data,
      },
    });
    res.json(createNotification);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});

//GET all notifications for user by userid
router.get("/user/:id/notifications", async (req, res) => {
  const { id } = req.params;
  try {
    const notifications = await prisma.student.findMany({
      where: { receiverId: Number(id) },
    });
    res.json(notifications);
  } catch (err) {
    res.json({ error: "wrong data", errMsg: err });
  }
});
