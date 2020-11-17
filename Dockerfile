FROM node:14-alpine

WORKDIR /usr/src/app

COPY package.json ./
COPY yarn.lock ./
RUN yarn install

COPY rollup.config.js ./
COPY public ./public
COPY src ./src
RUN npm run build

FROM nginx

COPY --from=0 /usr/src/app/public /usr/share/nginx/html
