FROM node

# Install  nss-mdns to resolve <host-name>.local
RUN apt-get update && \
	apt-get install -y \
            avahi-daemon \
            libnss-mdns && \
	rm -rf /var/lib/apt/lists/*

# Disable d-bus for avahi
RUN sed -i \
	-e "s/#enable-dbus=yes/enable-dbus=no/" \
	-e "s/rlimit-nproc=3/rlimit-nproc=30/" \
	/etc/avahi/avahi-daemon.conf

# Install Neeo SDK directly from git
RUN npm install --verbose git+https://github.com/NEEOInc/neeo-sdk.git
