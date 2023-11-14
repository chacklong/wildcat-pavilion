FROM node:18
WORKDIR /usr/src/wildcat-pavilion
COPY . .
RUN npm install
RUN npm run build

EXPOSE 1337
CMD ["npm", "run", "develop"]