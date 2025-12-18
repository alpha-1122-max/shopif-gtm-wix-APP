# Use Node 22 for 2025 compatibility
FROM node:22-alpine

# Install openssl for Prisma
RUN apk add --no-cache openssl

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Install ALL dependencies (including remix-serve)
RUN npm install

# Copy the rest of your code
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Build the Remix app
RUN npm run build

# Start the application
CMD ["npm", "run", "start"]
