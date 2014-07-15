SCRIPTS_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)
DATA_PATH=$SCRIPTS_PATH/../data

#speakers
cat $DATA_PATH/osconfeed | ./jq -r '["serial", "name", "photo","url", "twitter"],(.Schedule.speakers[] | [.serial,.name, .photo, .url, .twitter]) | @csv' > $DATA_PATH/speakers.csv

#venues
cat $DATA_PATH/osconfeed | ./jq -r '["serial", "name"],(.Schedule.venues[] | [.serial,.name]) | @csv' > $DATA_PATH/venues.csv

#events
cat $DATA_PATH/osconfeed | ./jq -r '["serial", "name", "time_start","time_end", "venue_serial","event_type","categories","speakers"],(.Schedule.events[] | [.serial,.name, .time_start, .time_stop, .venue_serial, .event_type, ([(.categories[] | split("&amp;") |join("&"))] | join("|")), .speakers | if (. | type) == "null" then "" else (. | tostring | ltrimstr("[") | rtrimstr("]")) end]) | @csv' > $DATA_PATH/events.csv