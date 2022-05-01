#Stage1 : Building client Image

FROM node:alpine3.12 as client

WORKDIR /usr/app/client/

COPY myapp/package*.json ./

RUN npm install

COPY myapp/ ./

RUN ls

RUN npm run build

#Stage2 : Building server Image

FROM node:alpine3.12

# RUN apk add --no-cache \
#     chromium \
#     nss \
#     freetype \
#     harfbuzz \
#     ca-certificates \
#     ttf-freefont \
#     nodejs \
#     yarn

# ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
#     PUPPETEER_EXECUTABLE_PATH=/usr/src/app/bin/chromium-browser

WORKDIR /usr/src/app/

COPY --from=client /usr/app/client/build/ ./client/build/

WORKDIR /usr/src/app/

COPY package*.json ./

RUN npm install

COPY  . ./

EXPOSE 5000

CMD ["node", "server.js"]