# Use nginx base image
FROM nginx:alpine

# Copy our HTML into nginx default directory
COPY index.html /usr/share/nginx/html/index.html
