FROM ghcr.io/puppeteer/puppeteer:22.4.1

# Set environment variables
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Set working directory
WORKDIR /usr/src/app

USER root

# Change ownership of app directory to node user - problem
RUN chown -R node:node /usr/src/app


# Create node_modules directory (now with proper permissions)
# RUN mkdir -p node_modules

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies as node user
USER node
RUN npm ci

# Copy application code
COPY . .

# Command to run the Node.js application
CMD ["node", "index.js"]
