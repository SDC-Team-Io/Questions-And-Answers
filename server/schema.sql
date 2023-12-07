
-- DROP DATABASE IF EXISTS 'questions';
-- CREATE DATABASE 'questions';

DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS answers CASCADE;
DROP TABLE IF EXISTS photos;

CREATE TABLE questions (
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  body VARCHAR(1000),
  date_written BIGINT,
  asker_name VARCHAR(60),
  asker_email VARCHAR(60),
  reported BOOLEAN DEFAULT 'f',
  helpful INT DEFAULT 0,
  question_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE answers (
  id SERIAL PRIMARY KEY,
  question_id INT NOT NULL,
  body VARCHAR(1000),
  date_written BIGINT,
  answerer_name VARCHAR(60),
  answerer_email VARCHAR(60),
  reported BOOLEAN DEFAULT 'f',
  helpful INT DEFAULT 0,
  date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  answer_id INTEGER,
  url VARCHAR(1000),
  FOREIGN KEY (answer_id) REFERENCES answers (id) ON DELETE CASCADE
);

