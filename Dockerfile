FROM node:latest

# set working directory
RUN mkdir /main
WORKDIR /main

# copy pkg configs and caches
COPY package.json ./
COPY yarn.lock ./

# install packages
RUN yarn install

# install prisma globally
RUN yarn global add prisma
RUN yarn global add graphql-cli

ADD . .

# prisma configuration
RUN prisma deploy

EXPOSE 4000
# run post deploy hook
# RUN graphql get-schema --project prisma
# RUN graphql prepare

CMD ["node", "src/index.js"]