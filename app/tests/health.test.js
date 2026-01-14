const test = require("node:test");
const assert = require("node:assert");
const http = require("http");

test("GET /health returns status ok", async () => {
  const response = await new Promise((resolve) => {
    http.get("http://localhost:3000/health", resolve);
  });

  assert.strictEqual(response.statusCode, 200);
});
