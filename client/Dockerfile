FROM node:alpine as builder
RUN mkdir /project
WORKDIR /project
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /project/build /usr/share/nginx/html