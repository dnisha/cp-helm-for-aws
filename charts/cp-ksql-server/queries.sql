-- Create a stream pageviews_original from the Kafka topic pageviews
-- CREATE STREAM pageviews_original (viewtime bigint, userid varchar, pageid varchar) 
-- WITH (kafka_topic='pageviews', value_format='DELIMITED');

-- Create a table users_original with PRIMARY KEY syntax
-- CREATE TABLE users_original (
--     userid VARCHAR PRIMARY KEY,
--     registertime BIGINT, 
--     gender VARCHAR, 
--     regionid VARCHAR
-- ) WITH (
--     kafka_topic='users', 
--     value_format='JSON'
-- );

-- -- The rest of your queries can remain the same
-- CREATE STREAM pageviews_enriched AS 
-- SELECT users_original.userid AS userid, pageid, regionid, gender 
-- FROM pageviews_original 
-- LEFT JOIN users_original ON pageviews_original.userid = users_original.userid;

-- CREATE STREAM pageviews_female AS 
-- SELECT * FROM pageviews_enriched WHERE gender = 'FEMALE';

-- CREATE STREAM pageviews_female_like_89 
-- WITH (kafka_topic='pageviews_enriched_r8_r9') AS 
-- SELECT * FROM pageviews_female WHERE regionid LIKE '%_8' OR regionid LIKE '%_9';

-- CREATE TABLE pageviews_regions 
-- WITH (VALUE_FORMAT='avro') AS 
-- SELECT gender, regionid, COUNT(*) AS numusers 
-- FROM pageviews_enriched 
-- WINDOW TUMBLING (size 30 second) 
-- GROUP BY gender, regionid 
-- HAVING COUNT(*) > 1;