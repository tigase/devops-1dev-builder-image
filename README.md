# 1dev generic Docker image with additional tools and configuration

## Tools on the image

Additional main tools installed on the image:

1. OpenJDK various versions 
1. Git
1. GPG
1. AWS CLI

And many others. For details, please refer directly to [Dockerfile](Dockerfile).

## Building

```shell
docker build --platform=linux/amd64 . -t tigase/devops-1dev-builder-image
docker push tigase/devops-1dev-builder-image

```