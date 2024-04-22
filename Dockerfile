FROM node:18-alpine as build
WORKDIR /app
COPY package-lock.json package.json tsconfig.build.json tsconfig.json .
RUN npm install
COPY src src
RUN npm run build
RUN npm prune --omit=dev

FROM node:18-alpine
WORKDIR /app
COPY --from=build /app/dist dist
COPY --from=build /app/node_modules node_modules
CMD node dist/main
