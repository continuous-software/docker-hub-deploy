#/bin/bash

VERSION=$(node -e "console.log(require('./package.json').version)")
MAJOR=$(node -e "console.log(require('./package.json').version.split('.').slice(0,2).join('.'))")
NAME=$(node -e "console.log(require('./package.json').name)")
REGISTRY=$(node -e "console.log(require('./package.json').docker.registry)")
USER=$(node -e "console.log(require('./package.json').docker.username)")
PASS=$(node -e "console.log(require('./package.json').docker.password)")
EMAIL=$(node -e "console.log(require('./package.json').docker.email)")

echo "$VERSION"
echo "$MAJOR"
echo "login"
docker login -u="$USER" -p="$PASS" -e="$EMAIL"
echo "build"
docker build -t="$REGISTRY/$NAME" .
echo "tag"
docker tag -f $REGISTRY/$NAME $REGISTRY/$NAME:$VERSION
docker tag -f $REGISTRY/$NAME $REGISTRY/$NAME:$MAJOR
docker tag -f $REGISTRY/$NAME $REGISTRY/$NAME:latest
echo "push"
docker push $REGISTRY/$NAME