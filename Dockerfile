FROM node:20
WORKDIR /usr/src/wildcat-pavilion-backend-1.0

COPY . .

RUN npm install

RUN npm run build

EXPOSE 1337
CMD ["npm","run","develop"]
