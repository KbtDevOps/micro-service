FROM node:16-alpine as builder
WORKDIR /app/temp
COPY . .

RUN rm -rf node_modules && \
  NODE_ENV=production yarn install \
  --prefer-offline \
  --pure-lockfile \
  --non-interactive \
  --production=false

RUN yarn build

FROM node:16-alpine
WORKDIR /app

COPY --from=builder /app/temp/dist ./dist
COPY --from=builder /app/temp/node_modules ./node_modules
COPY --from=builder /app/temp/package.json .

RUN rm -rf /app/temp

EXPOSE 3002
CMD [ "yarn","start:prod"]