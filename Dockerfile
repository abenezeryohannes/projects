FROM node:18 as build

WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM node:18
WORKDIR /app
COPY package.json .
RUN npm install --omit=dev
COPY --from=build /app/dist ./dist
CMD npm run start:prod
