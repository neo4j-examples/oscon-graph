SCRIPTS_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)

curl -O 'http://www.oreilly.com/pub/sc/osconfeed'
mv osconfeed $SCRIPTS_PATH/../data/