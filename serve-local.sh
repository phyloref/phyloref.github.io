#!/bin/bash

docker pull jekyll/jekyll
docker run --rm --volume=$(pwd):/srv/jekyll -it -p 127.0.0.1:4000:4000 jekyll/jekyll jekyll serve --config _config.yml,_config-dev.yml --drafts
