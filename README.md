# A simple mail server in a Docker container

To launch the conatainer 

```services:
    mail:
      container_name: mail
      build:
        context: ./postfix
        args:
          domain: ${domain}
          subdomain: ${subdomain}
      ports:
        - "25:25"
        - "143:143"
        - "587:587"
        - "993:993"
        - "465:465"
      volumes:
        - /etc/letsencrypt/live/${domain}/fullchain.pem:/etc/letsencrypt/live/${domain}/fullchain.pem:ro
        - /etc/letsencrypt/live/${domain}/privkey.pem:/etc/letsencrypt/live/${domain}/privkey.pem:ro
        - /etc/localtime:/etc/localtime:ro
      depends_on:
        - database
        - acme
      restart: "always"```
