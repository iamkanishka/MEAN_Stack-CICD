#Stage1 : Building client Image

FROM node:alpine3.12 as client

WORKDIR /usr/app/client/

COPY frontapp/package*.json ./

RUN npm install

COPY frontapp/ ./

RUN ls

RUN npm run build

#Stage2 : Building server Image

FROM node:alpine3.12


WORKDIR /usr/src/app/

COPY --from=client /usr/app/client/dist/frontapp ./frontapp/dist/frontapp

WORKDIR /usr/src/app/

COPY package*.json ./

RUN npm install

COPY  . ./

EXPOSE 5000

CMD ["node", "server.js"]