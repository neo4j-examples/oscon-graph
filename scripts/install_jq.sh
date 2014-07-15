#!/bin/bash

echo "Your platform? (l)inux, (m)ac, (w)indows: "
read platform

case $platform in
  l)
	echo "Loading for Linux"
	curl -O http://stedolan.github.io/jq/download/linux64/jq
	chmod +x jq
    ;;
  m)
	echo "Loading for Mac OSX"
	curl -O http://stedolan.github.io/jq/download/osx64/jq
	chmod +x jq
    ;;
  w)
	echo "Loading for Windows"
    curl -O http://stedolan.github.io/jq/download/win64/jq.exe
    ;;
  :)
    echo "You should enter l,m or w"
    exit 1
    ;;
esac
