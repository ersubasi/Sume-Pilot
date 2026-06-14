# Static hosting for the SUME pilot site on Railway.
# Caddy serves index.html and binds to the port Railway provides ($PORT).
FROM caddy:2-alpine

COPY Caddyfile /etc/caddy/Caddyfile
COPY index.html /srv/index.html

# Railway injects $PORT at runtime; Caddyfile reads it.
EXPOSE 8080
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
