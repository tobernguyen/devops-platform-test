# Stage 1
FROM node:12-alpine as yarn-install
WORKDIR /usr/src/app
# Install app dependencies
COPY package.json yarn.lock ./
RUN yarn --frozen-lockfile --no-cache && \
    yarn cache clean

# Runtime container with minimal dependencies
FROM node:12-alpine

WORKDIR /usr/src/app
COPY --from=yarn-install /usr/src/app/node_modules /usr/src/app/node_modules
# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "index.js" ]
