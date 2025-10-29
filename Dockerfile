# Use official Ubuntu as base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip openjdk-17-jdk wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /opt/flutter -b stable
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-download Flutter dependencies
RUN flutter doctor -v || true

# Copy project files
COPY . /app

# Get Flutter dependencies
RUN flutter pub get

# Build release APK
RUN flutter build apk --release --no-shrink

# Output APK to /out folder
RUN mkdir -p /out && cp build/app/outputs/flutter-apk/app-release.apk /out/

# Show output directory
CMD echo "✅ Build complete. APK located at /out/app-release.apk" && ls -la /out && sleep 3600
