FROM jenkins/ssh-agent:jdk11

ENV TZ="Europe/Madrid"

# Add https comms capabilities and curl and add-apt-repository commands
RUN apt-get update && apt-get install -y \
    apt-transport-https ca-certificates curl gnupg-agent \
    software-properties-common curl rsync

# Python, MYSQL, Docker client and other core dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libnspr4 libnss3 lsb-release xdg-utils libxss1 libdbus-glib-1-2 libgbm1 \
    cron unzip wget xvfb libgit2-27 \
    && pip3 install --upgrade pip

# Python modules installation
## requirements.txt contains required libraries of ALL projects.
COPY requirements.txt /tmp
WORKDIR /tmp
RUN pip3 install -r requirements.txt

# Install chromedriver and google-chrome
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/bin && \
    chmod +x /usr/bin/chromedriver && \
    rm chromedriver_linux64.zip

RUN CHROME_SETUP=google-chrome.deb && \
    wget -O $CHROME_SETUP "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" && \
    dpkg -i $CHROME_SETUP && \
    apt-get install -y -f && \
    rm $CHROME_SETUP

# WORKDIR /home/jenkins
# USER jenkins