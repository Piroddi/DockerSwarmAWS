# Specify a base image
FROM node:12.13.0-alpine AS alpine

WORKDIR /app

# Install some dependencies
COPY package.json .
RUN npm install 
COPY . .

EXPOSE 3004

# Default command
CMD ["npm", "run", "start"]