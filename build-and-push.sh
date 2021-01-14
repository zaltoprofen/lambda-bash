#!/bin/bash -ex

account_id=$(aws sts get-caller-identity --output text --query Account)
region=ap-northeast-1

registry=$account_id.dkr.ecr.$region.amazonaws.com
ecr_repository=$registry/lambda-bash

docker build -t $ecr_repository .

aws ecr get-login-password --region $region \
  | docker login -u AWS --password-stdin $registry

docker push $ecr_repository
docker inspect ${account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-bash \
  -f '{{ index .RepoDigests 0 }}' > image-uri.txt
