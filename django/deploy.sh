#!/bin/bash

ssh dplprod_adrian@100.76.80.23 "
  set -e
  cd /home/dplprod_adrian/Tavelroad_dpl/django
  git pull

  source .venv/bin/activate
  pip install -r requirements.txt

  # python manage.py migrate
  # python manage.py collectstatic --no-input

  supervisorctl restart travelroad
"
