#!/bin/bash
TAG=$1

echo $TAG

if [ -z $TAG ]; then
    echo "Usage: build.sh <tag>"
    echo "Tag must be in the form of v1.0.0"
    exit;
fi

if [ -e ../_posts/api/0200-01-01-$TAG.html ]; then
    echo "rm -r ../_posts/$TAG if you want to re-build"
    #exit;
fi

echo "--- BUILDING mapbox.js $TAG ---"


echo "Installing..."
npm install mapbox.js@$TAG

echo "Creating _posts/api/...$TAG"
sed "s/__TAG__/$TAG/" header > ../_posts/api/0200-01-01-$TAG.html
echo "version: $TAG" >> ../_posts/api/0200-01-01-$TAG.html

echo "Generating html..."

node generate.js node_modules/mapbox.js/API.md >> ../_posts/api/0200-01-01-$TAG.html

cat leaflet-reference.html >> ../_posts/api/0200-01-01-$TAG.html
