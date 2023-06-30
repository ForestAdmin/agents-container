FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

RUN touch typings.js && npm run build

EXPOSE ${APPLICATION_PORT}

CMD ["npm", "run", "start:watch"]
