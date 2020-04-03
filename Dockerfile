FROM visibilityspots/cloudflared

USER root

RUN apk add --no-cache tor socat && \
    sed "1s/^/SocksPort 0.0.0.0:9050\n/" /etc/tor/torrc.sample > /etc/tor/torrc && \
    echo '#!/bin/sh' > /entry.sh && \
    echo 'echo "127.0.0.1 dns4torpnlfs2ifuz2s2yf3fc7rdmsbhm6rw75euj35pac6ap25zgqad.onion" >> /etc/hosts' >> /entry.sh && \
    echo 'socat TCP4-LISTEN:443,reuseaddr,fork SOCKS4A:127.0.0.1:dns4torpnlfs2ifuz2s2yf3fc7rdmsbhm6rw75euj35pac6ap25zgqad.onion:443,socksport=9050 &' >> /entry.sh && \
    echo 'cloudflared proxy-dns --address 0.0.0.0 --port 5054 --upstream "https://dns4torpnlfs2ifuz2s2yf3fc7rdmsbhm6rw75euj35pac6ap25zgqad.onion/dns-query" &' >> /entry.sh && \
    echo '/bin/su -s /bin/sh -c "tor" tor' >> /entry.sh && \
    chmod +x entry.sh

CMD ["./entry.sh"]
