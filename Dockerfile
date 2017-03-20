FROM beevelop/cordova:latest 
RUN apt-get update &&\
    apt-get install sudo &&\
	apt-get install -y --no-install-recommends apt-utils &&\
    apt-get install -y apt-transport-https &&\ 
    curl -L https://packagecloud.io/github/git-lfs/gpgkey | apt-key add - &&\ 
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash &&\
	apt-get install -y debian-archive-keyring git-lfs=1.5.5 libxml2-utils &&\ 
	apt-get install -y lftp &&\
	npm install electron-packager -g &&\
	apt-get update &&\
    apt-get -qq install git-ftp &&\
	npm install -g browserify &&\
	dpkg --add-architecture i386 &&\
    apt-get update -y &&\
	apt-get install -y software-properties-common && add-apt-repository -y ppa:wine/wine-builds &&\
	apt-get update -y &&\
	apt-get install -y winehq-devel &&\
	sudo apt-get install zip &&\
	apt-get purge -y software-properties-common &&\
	rm -rf /var/lib/apt/lists/*
	