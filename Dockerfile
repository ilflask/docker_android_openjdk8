FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK "25"
ENV ANDROID_BUILD_TOOLS "25.0.2"
ENV ANDROID_SDK_TOOLS "24.4.1"

# Tools
RUN apt-get --quiet update --yes \
&& apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
&& wget --quiet --output-document=android-sdk.tgz https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz \
&& tar --extract --gzip --file=android-sdk.tgz \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_COMPILE_SDK} \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS} \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository \
&& export ANDROID_HOME=$PWD/android-sdk-linux \
&& export PATH=$PATH:$PWD/android-sdk-linux/platform-tools/ \
&& mkdir "$ANDROID_HOME/licenses" || true \
&& echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license" \
&& echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license" \
&& chmod +x ./gradlew