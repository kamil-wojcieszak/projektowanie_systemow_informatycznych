package util

import (
	"context"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
)

func LoadAWSConfig() aws.Config {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		panic(err)
	}
	return cfg
}

func LoadEnvVariable(envVarName string) string {
	value, exists := os.LookupEnv(envVarName)
	if !exists {
		panic("Environment variable not found: " + envVarName)
	}
	return value
}
