# Step 1: Use an official Node.js image as a parent image
FROM node:16 AS build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the app's source code
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use a static server to serve the app
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Step 8: Expose port 80
EXPOSE 80

# Step 9: Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
