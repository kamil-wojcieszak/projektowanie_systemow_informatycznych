buildBackend:
	(cd lambdas/orders ; npm install ; npm run build)
	(cd lambdas/products ; npm install ; npm run build)
	(cd lambdas/users ; npm install ; npm run build)

deployFrontend:

deployInfra: buildBackend
	./deploy.sh
