const express = require("express");
const router = express.Router();

router.get("/", (req, res) => {
  res.status(200).json({
    service: "credpal-node-app",
    environment: process.env.NODE_ENV || "development",
    timestamp: new Date().toISOString()
  });
});

module.exports = router;
