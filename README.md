# inet
internal network

## structure
```bash
inet/
|-- conf/           # config for container services(nginx, php, redis, etc...)
|-- log/            # container service log, sync by volumes
|-- src/            # default web project src, write to container:/var/www/
|-- .env.example    # `cp .env.example .env` and edit it
|-- docker-compose.yml    # docker compose config
|-- makefile        # make
```