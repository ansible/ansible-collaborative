# Build the community website with Nikola
FROM registry.fedoraproject.org/fedora:39 AS builder

# Add the contents of this repository to the working directory
ADD . /ansible-collaborative

# Set the working directory
WORKDIR /ansible-collaborative

# Install Nikola and build the community website
RUN dnf install -y python3-pip && dnf clean all
RUN pip install -r requirements.in -c requirements.txt
RUN nikola build --strict

# Host the community website on a caddy web server
FROM registry.fedoraproject.org/fedora:39
EXPOSE 8080
RUN dnf install --setopt=install_weak_deps=False --best -y caddy && dnf clean all
COPY --from=builder /ansible-collaborative/output/ /var/www/html/
CMD ["/usr/bin/caddy", "file-server", "--listen", ":8080", "--root", "/var/www/html/"]
