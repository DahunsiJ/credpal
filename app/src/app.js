const express = require("express");

const healthRoute = require("./routes/health");
const statusRoute = require("./routes/status");
const processRoute = require("./routes/process");

const app = express();

// Middleware
app.use(express.json());

// Routes
app.use("/health", healthRoute);
app.use("/status", statusRoute);
app.use("/process", processRoute);

// Fallback
app.use((req, res) => {
  res.status(404).json({ message: "Route not found" });
});

module.exports = app;
