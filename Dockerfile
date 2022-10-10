FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

#only used inside the docker file
ARG DEFAULT_PORT = 80

ENV PORT $DEFAULT_PORT

EXPOSE $PORT

#anonymous volume 
#VOLUME [ "/app/node_modules" ]

CMD ["npm", "start"]

#Running bind mounts: Not tied to one container, can survive container shutdown, Named volume: Survives container shutdown, Anonymous volume: Doesn't survive container shutdown. 
#docker run -d --rm -p 3000:80 -e PORT=80  --name feedback-app -v feedback:/app/feedback -v "/Users/michaelmburu/Documents/Visual Studio Code/Docker & Kubernetes /5. Feedback App:/app:ro" -v /app/temp -v /app/node_modules feedbackapp-node
#Mark a bind mount as readonly by adding :ro, but make sure to add necessary named and anonymous volumes
# N/B The longer volume path wins, e.g :app will be overwritten /app/node_modules
# To use .env file use argument --env-file ./.env in the docker run command
# To use args during build: docker build -t feedback-node:dev --build-arg DEFAULT_PORT=8000