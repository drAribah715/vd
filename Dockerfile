FROM coder/code-server:latest

# Install Python 3 + pip
USER root
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

# Switch back to coder user
USER coder

# Copy extensions list and install extensions
COPY extensions.list /home/coder/extensions.list
RUN cat /home/coder/extensions.list | xargs -L 1 code-server --install-extension

# Copy default VS Code settings
COPY settings.json /home/coder/.local/share/code-server/User/settings.json

EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]