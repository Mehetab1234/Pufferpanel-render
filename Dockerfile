# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and PufferPanel
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    systemctl && \
    curl -sSL https://package.pufferpanel.com/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/pufferpanel-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/pufferpanel-archive-keyring.gpg] https://package.pufferpanel.com/repository/deb/ all main" > /etc/apt/sources.list.d/pufferpanel.list && \
    apt-get update && apt-get install -y pufferpanel && \
    apt-get clean

# Expose the PufferPanel default port
EXPOSE 8080

# Start PufferPanel on container startup
CMD ["systemctl", "start", "pufferpanel", "&&", "tail", "-f", "/dev/null"]
