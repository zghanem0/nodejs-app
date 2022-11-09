FROM 374031103815.dkr.ecr.us-east-1.amazonaws.com/node

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY * ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
#COPY . .
RUN npm install pm2@3 -g

EXPOSE 7777
CMD ["pm2-runtime", "start", "server.js"]

#CMD [ "npm", "start" ]
