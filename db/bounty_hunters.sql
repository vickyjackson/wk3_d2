-- Drop table
DROP TABLE IF EXISTS bounty_hunters;

-- Create table
CREATE TABLE bounty_hunters(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  danger_level VARCHAR(255),
  bounty_value INT8
);

SELECT * FROM bounty_hunters;
