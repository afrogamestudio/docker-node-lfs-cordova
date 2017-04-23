FROM webratio/cordova:4.3
RUN apt-get update
	# add-apt-repository -y ppa:wine/wine-builds &&\
RUN apt-get install -y software-properties-common
RUN apt-get update -y
RUN apt-get install sudo
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y apt-transport-https
# RUN apt-get install -y gradle
RUN apt-get install -y xsltproc
RUN apt-get install -y curl
# RUN apt-get install -y debian-archive-keyring git-lfs=1.5.5 libxml2-utils
    # apt-get -qq install git-ftp &&\
	# dpkg --add-architecture i386 &&\
    # curl -L https://packagecloud.io/github/git-lfs/gpgkey | apt-key add - &&\ 
    # curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash &&\
	# sudo apt-get install zip &&\
# RUN apt-get install -y software-properties-common
# RUN apt-get install -y winehq-devel
RUN apt-get install -y lftp
RUN apt-get install -y unzip
RUN npm install -g electron-packager browserify uglifyify babel-cli
RUN apt-get purge -y software-properties-common
RUN rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/default-java

# RUN curl -o gradle.zip https://downloads.gradle.org/distributions/gradle-3.5-bin.zip
ADD gradle-3.5-bin.zip gradle.zip
# RUN mkdir /usr/lib/gradle
RUN unzip gradle.zip -d /usr/lib/gradle
RUN rm -f gradle.zip
# RUN export GRADLE_HOME=/usr/lib/gradle
RUN PATH=$PATH:/usr/lib/gradle/gradle-3.5/bin/









ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/tools_r25.2.3-linux.zip" \
    ANDROID_BUILD_TOOLS_VERSION=25.0.2 \
    ANDROID_APIS="android-10,android-15,android-16,android-17,android-18,android-19,android-20,android-21,android-22,android-23,android-24,android-25" \
    ANT_HOME="/usr/share/ant" \
    MAVEN_HOME="/usr/share/maven" \
    GRADLE_HOME="/usr/lib/gradle" \
    ANDROID_HOME="/opt/android"

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION:$ANT_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin

WORKDIR /opt

RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get -qq install -y wget curl maven ant libncurses5:i386 libstdc++6:i386 zlib1g:i386 && \

    # Installs Android SDK
    mkdir android && cd android && \
    wget -O tools.zip ${ANDROID_SDK_URL} && \
    unzip tools.zip && rm tools.zip && \
    echo y | android update sdk -a -u -t platform-tools,${ANDROID_APIS},build-tools-${ANDROID_BUILD_TOOLS_VERSION} && \
    chmod a+x -R $ANDROID_HOME && \
    chown -R root:root $ANDROID_HOME && \

    # Clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean
# RUN echo y | android update sdk -u -a -s -f -t 1

# RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle
