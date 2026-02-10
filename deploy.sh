#!/bin/bash

mkdir -p infra/dist

cd infra

if [ ! -d ".terraform" ]; then
    echo "Initializing Terraform..."
    terraform init
fi

terraform plan -out=tfplan -var-file=dev.tfvars

read -p "Do you want to apply this plan? (yes/no): " confirm
if [ "$confirm" = "yes" ]; then
    terraform apply tfplan
    rm tfplan
    
    echo "✨ Deployment complete!"
    echo ""
    echo "📋 Outputs:"
    terraform output
else
    echo "Deployment cancelled"
    rm tfplan
fi

cd ..
