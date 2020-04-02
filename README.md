# DNS-Over-Tor
DNS-Over-Tor is a built on top of visibilityspots/cloudflared. By utilizing cloudflare's cloudflared, we can resolve DNS queries over https. Cloudflare runs an endpoint to recieve these encrypted requests and resolve them.

## So what does DNS-Over-Tor do?
Resolves DNS requests over the Tor network so not even Cloudflare, our DNS provider, knows who is sending the requests.

## So how does it work (simplified)?
1) It tells Cloudflared to use localhost:443 instead of cloudflare.com
2) socat reads from localhost:443 and translates this to SOCKS5 and sends it to a onion address
3) tor understands SOCKS5, sees this onion address and sends the request over tor
4) Cloudflare is running a endpoint on the tor network. It recieves this requests and sends a response

## Usage
Port 53 is used inside the docker image. visibilityspots/cloudflared recommends running `--net host`. Either use --net host or expose port 53. Not both.

## WARNING
The extemely privacy concerned should always seek expert advice. Using Tor properly is difficult and can easily leak personal information. See https://www.torproject.org/ for more information. This docker image is not guarenteed to provide any security in itself. This is novelty.
