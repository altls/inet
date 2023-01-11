# inet
internal network

## preinstall
### 安装 [docker](https://docker.com)
### [macos可选] 安装 `dnsmasq`
> 仅限本地开发使用，线上应使用服务商提供的dns解析服务
> 此服务将开启本地dns(避免总需要手动添加子域名ip映射 到 `/etc/hosts`)，使用子路径或需自行配置子域名时 可不装
> 开启/关闭/重启dnsmasq: `brew services start/stop/restart dnsmasq`
> 若修改了项目内 `conf/dnsmasq/inet.conf`，需重新执行第三步
> 详细了解参考[dnsmasq-dev-osx](https://passingcuriosity.com/2013/dnsmasq-dev-osx/)

1. `brew install dnsmasq`

2. 开启配置文件夹
    - `vim /usr/local/etc/dnsmasq.conf`
    - 配置文件中找到并取消注释此行 `conf-dir=/usr/local/etc/dnsmasq.d/,*.conf`

3. 覆盖配置文件夹
    - 当前文件夹下执行 `make dns` (需已安装make，若无可直接执行该内部命令)
    - 执行 `dig inet @127.0.0.1` (inet替换为conf内实际自定义域名), 返回应该类似这样
    ```
    ;; ANSWER SECTION:
    inet.                 0       IN      A       127.0.0.1
    ```

4. 配置osx系统使用 dnsmasq
    - 所有请求都由dnsmasq解析: 修改系统设置中的dns配置即可
    - 或指定域名由dnsmasq解析: `mkdir -p /etc/resolver && echo "nameserver 127.0.0.1" > /etc/resolver/inet` (/etc/resolver/inet inet替换为conf内实际自定义域名)

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

## usage（using make, unix like os）
### config
`vim .env`

### build
`make build`

### stop
- `make down`
- `make clean` (down && clean storeage)

### start/restart
- `make up` （clean && up）
- `make upd` (up in dameon)

### refresh dns
- `make dns` (run it after modifing `conf/dnsmasq/inet.conf`)