# !/bin/bash
set -e
echo "Deploying to ${DEPLOYMENT_ENVIRONMENT}"
echo $ACCOUNT_KEY_STAGING > service_key.txt
Invoke-Expression -Command (Get-ECRLoginCommand -Region ${AWS_DEFAULT_REGION}).Command
docker build -t ${IMAGE} .
docker tag ${IMAGE}:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/ci-cd:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-2.amazonaws.com/ci-cd:latest
echo " Successfully deployed to ${DEPLOYMENT_ENVIRONMENT}"