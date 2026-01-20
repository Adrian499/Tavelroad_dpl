#!/bin/bash

ssh dplprod_adrian@10.102.25.40 "
  set -e
  cd /home/dplprod_adrian/Tavelroad_dpl/django
  git pull

  source .venv/bin/activate
  pip install -r requirements.txt

  # python manage.py migrate
  # python manage.py collectstatic --no-input

  supervisorctl restart travelroad
"
