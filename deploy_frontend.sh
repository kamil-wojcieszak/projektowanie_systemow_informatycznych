#!/bin/bash

# Default values if not provided
S3_BUCKET=pisw-static-files-dev
DISTRIBUTION_ID=E3LPHRKPUN0IJM
ENVIRONMENT=DEV

cd frontend
# npm install

# npm run build -- --configuration=dev

# cp -r dist/frontend/browser/* ../deployments/website

aws s3 cp ./dist/frontend/browser/* s3://$S3_BUCKET

aws cloudfront create-invalidation --no-cli-pager --distribution-id $DISTRIBUTION_ID --paths "/*"

# rm -rf deployments/website
