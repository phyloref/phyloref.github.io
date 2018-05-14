docker run --rm --volume=%CD%:/srv/jekyll -it -e JEKYLL_ENV=production -p 127.0.0.1:4000:4000 jekyll/jekyll jekyll serve --config _config.yml,_config-dev.yml --drafts
