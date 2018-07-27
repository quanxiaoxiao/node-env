FROM quanxiaoxiao/env:1

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y dirmngr \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1655A0AB68576280 \
  && rm -rf /tmp/* /var/lib/apt/lists/*

COPY nodesource.list /etc/apt/sources.list.d/nodesource.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends nodejs \
  && apt-get purge --auto-remove \
  && rm -rf /tmp/* /var/lib/apt/lists/*

COPY .npmrc ~/.npmrc

RUN npm info eslint-config-airbnb peerDependencies --json | \
  sed 's/[\{\},]//g ; s/: /@/g' | \
  xargs npm install -g eslint-config-airbnb babel-eslint eslint-import-resolver-webpack \
  && rm -rf ~/.npm

RUN npm install -g cloc && rm -rf ~/.npm

CMD ["zsh"]
