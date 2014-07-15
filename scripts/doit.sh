SCRIPTS_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)

sh $SCRIPTS_PATH/install_jq.sh
sh $SCRIPTS_PATH/load_feed.sh
sh $SCRIPTS_PATH/create_csv.sh
sh $SCRIPTS_PATH/insert_data.sh