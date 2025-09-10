# Use a minimal Ubuntu image
FROM ubuntu:22.04

# Non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y wget curl unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Dyalog APL (personal/educational license)
# Replace with actual installer URL
RUN wget -O /tmp/apl_installer.sh "https://www.dyalog.com/downloads/apl/linux/apl_installer.sh" && \
    bash /tmp/apl_installer.sh && \
    rm /tmp/apl_installer.sh

# Set working directory
WORKDIR /app

# Copy APL analyzer into container
COPY analyzer.apl /app/analyzer.apl

# Default command to run analyzer
ENTRYPOINT ["dyalog", "/app/analyzer.apl"]
