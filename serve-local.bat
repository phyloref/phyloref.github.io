rem docker build --pull -t phyloref/jekyll .
docker run --rm --volume=%CD%:/srv/jekyll -it -e JEKYLL_ENV=production -p 127.0.0.1:4000:4000 phyloref/jekyll jekyll serve --config _config.yml,_config-dev.yml --drafts
