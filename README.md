Wrapper for run PHP code in docker
===========================================

How to use
===========================================
* Copy `PHP` code to the `app` directory;
* Replace `PHP`, `XDEBUG` version in the `docker-compose.yml` file (if needed);
* Create `app/public/index.php` file for run `PHP` code;
* Add `"classmap": ["src/"]` to the `composer.json` file (`autoload` section) (if needed);
* Default timezone is `UTC` (`docker/php/common/conf.d/timezone.ini` path to the file for replace, if needed);

## How to run:

```bash
# run
make init
```

```bash
#stop
make down
```

```bash
# stop with clear volumes
make down-clear
```

```bash
# basic app init commands (if exists)
make app-init
```

```bash
# install composer dependencies (if exists)
make composer-install
```

```bash
# composer dump-autoload (if exists)
make composer-dump
```

```bash
# run unit tests (if exists)
make tests
```

```bash
# run phpstan analyze (if exists)
make phpstan
```

## Pages (links)
* [http://localhost:8080][101] `index.php` home page;

[//]: # (Pages links)

[101]: http://localhost:8080
