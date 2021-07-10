// Include the multer module into the project for accepting files
const multer = require("multer");

// Include the path module (It is built-in and so need to install)
const path = require("path");
// Path module will be used to get extension name of every file entering the server

const express = require("express");
const { PrismaClient } = require("@prisma/client");

const router = express.Router();
const prisma = new PrismaClient();

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./build/static/images/avatars");
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  },
});

var upload = multer({
  storage: storage,
  limits: { fileSize: 10000000 },
  fileFilter: function fileFilter(req, file, cb) {
    // Allowed ext
    const filetypes = /jpeg|jpg|png|gif/;

    // Check ext
    const extname = filetypes.test(
      path.extname(file.originalname).toLowerCase()
    );
    // Check mime
    const mimetype = filetypes.test(file.mimetype);

    if (mimetype && extname) {
      return cb(null, true);
    } else {
      cb("Error: Images Only!");
    }
  },
}).single("avatar");

try {
  router.post("/avatar/upload", (req, res) => {
    // This is the response sent to the user in the browser once the file recieved

    upload(req, res, (err) => {
      if (err) {
        console.log(err, err.message);
        res.json({ err: "error" + err.message });
        // This will display the error message to the user
      } else {
        res.json("File Uploaded Successfully");
        // This shows the file has beem successfully uploaded
        // The image will be found in the public folder
        console.log("hi");
      }
    });
  });
} catch (error) {
  res.json(error);
  console.log(error);
}

module.exports = router;
