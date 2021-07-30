# Setup the build container for PWA2000
FROM cupy/cupy:v9.2.0 as pwa2000_builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        git build-essential cmake && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Markjonestx/PyPWA-Utilities /tmp/pwa2000 && \
    mkdir /tmp/build && \
    cd /tmp/build && \
    cmake -DCMAKE_BUILD_TYPE=minsizerel ../pwa2000 && \
    make && \
    make install

# The "Real" container for the package.
# Since GAMP is built statically, we just need to copy the executable
# binaries over, and everything else can just be left behind
FROM cupy/cupy:v9.2.0
COPY --from=pwa2000_builder /usr/local/bin/gamp /usr/local/bin/gamp
COPY --from=pwa2000_builder /usr/local/bin/hgamp /usr/local/bin/hgamp
COPY --from=pwa2000_builder /usr/local/bin/ppgen /usr/local/bin/ppgen
COPY --from=pwa2000_builder /usr/local/bin/vamp /usr/local/bin/vamp

# This installs PyPWA straight from the git repo
RUN apt update && \
    apt install git -y --no-install-recommends && \
    pip install --no-cache-dir git+https://github.com/JeffersonLab/PyPWA.git && \
    apt purge git -y && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*
