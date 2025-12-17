# Use Node 22 to meet Shopify's >=20.10.0 requirement
FROM node:22-alpine

# Install openssl for Prisma
RUN apk add --no-cache openssl

WORKDIR /app

# Copy all project files
COPY . .

# Install dependencies (will now succeed with Node 22)
RUN npm install

# Generate Prisma client
RUN npx prisma generate

# Build the Remix app
RUN npm run build

# Start the application
CMD ["npm", "run", "start"]
