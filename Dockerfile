# Use a base image with Python 3.7 or later
FROM python:3.10

# Set environment variables
ENV BS_GAME_PORT=43210 \
    BS_ADMIN_PASS=admin

# Install BombSquad server dependencies
RUN apt-get update && apt-get install -y \
    libsdl2-2.0-0 \
    libsdl2-image-2.0-0 \
    libsdl2-mixer-2.0-0 \
    libsdl2-net-2.0-0 \
    libsdl2-ttf-2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Clone BombSquad repository from GitHub
RUN git clone --depth 1 https://github.com/froemling/bombsquad.git /bombsquad

# Set working directory
WORKDIR /bombsquad

# Install BombSquad server
RUN pip3 install -r requirements.txt

# Expose BombSquad server port
EXPOSE 43210

# Start BombSquad server
CMD ["./bombsquad_server", "--game-port", "43210", "--admin-pass", "$BS_ADMIN_PASS"]
