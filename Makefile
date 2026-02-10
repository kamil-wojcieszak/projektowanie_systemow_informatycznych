buildBackend:
	(cd lambdas ; GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -tags lambda.norpc -o ../deployments/UsersApi/bootstrap ./entrypoints/UsersApi)
	(cd lambdas ; GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -tags lambda.norpc -o ../deployments/ProductsApi/bootstrap ./entrypoints/ProductsApi)

deployFrontend: 
	./deploy_frontend.sh

deployBackend: buildBackend
	cd infra ; terraform apply -var-file=dev.tfvars

deployAll: deployFrontend deployBackend