// clean database
MATCH (n)
OPTIONAL MATCH (n)-[r]-()
DELETE n,r;

// create constraints for serials
CREATE CONSTRAINT ON (s:Speaker) ASSERT s.serial IS UNIQUE;
CREATE CONSTRAINT ON (v:Venue) ASSERT v.serial IS UNIQUE;
CREATE CONSTRAINT ON (e:Event) ASSERT e.serial IS UNIQUE;

// create indexes for lookups
CREATE INDEX ON :Speaker(name);
CREATE INDEX ON :Venue(name);
CREATE INDEX ON :Event(name);

// load speakers
LOAD CSV WITH headers FROM "file:data/speakers.csv" as line
CREATE (:Speaker{serial:line.serial, name:line.name, photo:line.photo, twitter:line.twitter})
;

//load venues
LOAD CSV WITH headers FROM "file:data/venues.csv" as line
CREATE (:Venue{serial:line.serial, name:line.name})
;


// load events
LOAD CSV WITH headers FROM "file:data/events.csv" as line
MATCH  (venue: Venue{serial:line.venue_serial})
CREATE (event:Event{serial:line.serial, name:line.name, time_start: line.time_start, time_end: line.time_end, type:line.event_type})-[:AT_VENUE]->(venue)
FOREACH (category_name in split(line.categories,"|") | MERGE (category:Category {name:category_name}) CREATE (event)-[:HAS_CATEGORY]->(category))
WITH event, line
WHERE line.speakers <> "" 
UNWIND split(line.speakers, ",") as speaker_serial
MATCH (speaker:Speaker{serial:speaker_serial})
CREATE (event)<-[:SPEAKS_AT]-(speaker)
;

// stats
MATCH (n)-[r]->()
RETURN head(labels(n)) as node, type(r) as relationship, count(*) as count
ORDER BY node, relationship
;
