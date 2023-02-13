# TechNetwork

RSS feed from curated personal tech blogs

## Development

```sh
$ bundle
$ rails s
```

## Production

```sh
$ docker build . -t tech -f Dockerfile.prod

$ docker run -it -p 3000:3000 \
  -e RAILS_MASTER_KEY= \
  -e RAILS_LOG_TO_STDOUT=yes \
  -e RAILS_SERVE_STATIC_FILES=yes \
  tech
```
