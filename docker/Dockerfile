# =========================
# Build stage
# =========================
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies
COPY app/package*.json ./
RUN npm ci --only=production

# Copy source
COPY app/src ./src

# =========================
# Runtime stage
# =========================
FROM node:20-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only what is needed
COPY --from=builder /app /app

USER appuser

EXPOSE 3000

CMD ["node", "src/server.js"]
