# Use Ubuntu base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip openjdk-17-jdk wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /root/flutter -b stable
ENV PATH="/root/flutter/bin:/root/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-download Flutter dependencies
RUN flutter doctor -v || true

# Copy project files to container
COPY . /root/app

# ✅ Set correct working directory
WORKDIR /root/app

# ✅ Allow Flutter to run as root
ENV CI=true
ENV PUB_CACHE=/root/.pub-cache
RUN flutter pub get --no-precompile

# Build release APK
RUN flutter build apk --release --no-shrink

# Move APK to /out folder
RUN mkdir -p /out && cp build/app/outputs/flutter-apk/app-release.apk /out/

# Display result
CMD echo "✅ Build complete. APK at /out/app-release.apk" && ls -la /out && sleep 3600
