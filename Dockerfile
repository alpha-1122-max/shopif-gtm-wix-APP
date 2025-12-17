FROM node:18-alpine
RUN apk add --no-cache openssl
WORKDIR /app
COPY . .
RUN npm install
RUN npx prisma generate
RUN npm run build
CMD ["npm", "run", "start"]
