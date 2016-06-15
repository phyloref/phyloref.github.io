#!/bin/bash

docker build -t phyloref/jekyll .
docker run --rm --label=jekyll --volume=$(pwd):/srv/jekyll -it -p 127.0.0.1:4000:4000 phyloref/jekyll
