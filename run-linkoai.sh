#!/bin/bash

ln -s /root/.nvm/versions/node/v18.16.1/bin/node /usr/bin/node

cd /var/www/linkoai

/root/.nvm/versions/node/v18.16.1/bin/npm install

/root/.nvm/versions/node/v18.16.1/bin/npm run start:prod
