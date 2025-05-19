FROM node:18

RUN apt-get update && \
    apt-get install -y netcat-openbsd

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN chmod +x ./scripts/wait-for-kafka.sh

CMD ["node", "src/app.js"]
