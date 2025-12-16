FROM node:18-alpine
RUN apk add --no-cache openssl

EXPOSE 3000

WORKDIR /app

# Production mode, Remix build ke liye set karenge
ENV NODE_ENV=production

# Copy package files first for caching
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm install && npm cache clean --force

# Generate Prisma client (essential for Prisma apps)
RUN npx prisma generate

# Remove Shopify CLI (optional, just keep container light)
RUN npm remove @shopify/cli

# Copy rest of the app
COPY . .

# Build Remix production assets
RUN npm run build

# Start the server
CMD ["npm", "run", "docker-start"]
