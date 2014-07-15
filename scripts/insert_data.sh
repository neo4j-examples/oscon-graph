SCRIPTS_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)
DATA_PATH=$SCRIPTS_PATH/../data

echo "Path to you Neo4j Database (hit return to install Neo4j)"

read DATABASE_PATH

if [ -nz $DATABASE_PATH ]; then

DATABASE_PATH="$SCRIPTS_PATH/../neo4j-community-2.1.2"

if [ ! -d $DATABASE_PATH ]; then
  curl -O dist.neo4j.org/neo4j-community-2.1.2-unix.tar.gz
  tar xvzf neo4j-community-2.1.2-unix.tar.gz
  rm neo4j-community-2.1.2-unix.tar.gz
fi

fi

echo "Using Database $DATABASE_PATH"

$DATABASE_PATH/bin/neo4j stop

# optionally delete database directory
# rm -rf $DATABASE_PATH/data/graph.db

$DATABASE_PATH/bin/neo4j-shell -path $DATABASE_PATH/data/graph.db -file $SCRIPTS_PATH/load_csv.cql
$DATABASE_PATH/bin/neo4j start

#open http://localhost:7474