#!/bin/sh
set -x
docker image load -i ../../docker_images/db.tar
docker image load -i ../../docker_images/api.tar
docker image load -i ../../docker_images/web.tar
