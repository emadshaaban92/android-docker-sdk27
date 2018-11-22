FROM openjdk:8-jdk

RUN apt-get update && apt-get install -y wget tar unzip lib32stdc++6 lib32z1 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* 

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
    && unzip -q android-sdk.zip -d android-sdk-linux && rm android-sdk.zip

RUN mkdir android-sdk-linux/licenses && \
    printf "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > android-sdk-linux/licenses/android-sdk-license && \
    android-sdk-linux/tools/bin/sdkmanager --update > update.log && \
    android-sdk-linux/tools/bin/sdkmanager "platforms;android-27" "build-tools;27.0.3" "extras;google;m2repository" "extras;android;m2repository" > installPlatform.log && \
    export ANDROID_HOME=$PWD/android-sdk-linux && \
    export PATH=$PATH:$PWD/android-sdk-linux/platform-tools/


