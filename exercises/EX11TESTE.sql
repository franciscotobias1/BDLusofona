
/*
CREATE DATABASE BikeStoresAnalytics2;


CREATE SCHEMA "metrics";

GO  


CREATE SCHEMA "events";

CREATE TABLE events.messages (
  id INT NOT NULL UNIQUE,
  message VARCHAR(255) DEFAULT 'General Event',
  dt DATETIME
)
INSERT INTO events.messages 
VALUES (1, 'ABC', GETDATE() );
*/

USE BikeStoresAnalytics2;

GO
SELECT * FROM events.messages
