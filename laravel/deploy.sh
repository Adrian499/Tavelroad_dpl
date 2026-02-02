#!bin/bash

ssh dplprod_adrian@100.76.80.23"
  cd $(dirname $0)
  git pull
  composer install
"
