const express = require("express");
const router = express.Router();

router.post("/", (req, res) => {
  const payload = req.body;

  res.status(200).json({
    message: "Request processed successfully",
    received: payload
  });
});

module.exports = router;
