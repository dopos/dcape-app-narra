# dcape-app-narra

> Приложение ядра [dcape](https://github.com/dopos/dcape) для ограничения доступа к приватным ресурсам.

[![GitHub Release][1]][2] [![GitHub code size in bytes][3]]() [![GitHub license][4]][5]

[1]: https://img.shields.io/github/release/dopos/dcape-app-narra.svg
[2]: https://github.com/dopos/dcape-app-narra/releases
[3]: https://img.shields.io/github/languages/code-size/dopos/dcape-app-narra.svg
[4]: https://img.shields.io/github/license/dopos/dcape-app-narra.svg
[5]: LICENSE

 Роль в dcape | Сервис | Docker image
 --- | --- | ---
 auth | [narra](https://github.com/dopos/narra) | [ghcr.io/dopos/narra](https://github.com/dopos/narra/pkgs/container/narra)

## Назначение

Сервис OAuth2 авторизации, который разрешает доступ к ресурсу только участникам заданной в настройках организации gitea.

## Ресурсы dcape с ограниченным доступом

* [фронтенд **dcape**](html/private) - список развернутых на сервере приложений и сервисов
* [настройки приложений dcape](https://github.com/dopos/dcape-app-enfist)
* [router](https://github.com/dopos/dcape-app-traefik) dasboard
* статистика [ns](https://github.com/dopos/dcape-app-powerdns)

## Подключение авторизации к приложениям dcape

docker-compose.yml

```yml
services:
  app:
    labels:
      - "traefik.http.routers.${APP_TAG}.middlewares=narra" # Require gitea auth

```

---

## Install

Приложение разворачивается в составе [dcape](https://github.com/dopos/dcape).

## License

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2017-2024 Aleksei Kovrizhkin <lekovr+dopos@gmail.com>
