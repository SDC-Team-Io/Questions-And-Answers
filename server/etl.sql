COPY questions(id, product_id, body, date_written, asker_name, asker_email, reported, helpful)
FROM '/home/justcord10/hackreactor/rfp2310-sdc-project-atelier/questions/csv/questions.csv'
DELIMITER ','
CSV HEADER;

COPY answers(id, question_id, body, date_written, answerer_name, answerer_email, reported, helpful)
FROM '/home/justcord10/hackreactor/rfp2310-sdc-project-atelier/questions/csv/answers.csv'
DELIMITER ','
CSV HEADER;

COPY photos(id, answer_id, url)
FROM '/home/justcord10/hackreactor/rfp2310-sdc-project-atelier/questions/csv/answers_photos.csv'
DELIMITER ','
CSV HEADER;

-- need to convert temp dates into normal dates and then delete the temp columns
UPDATE questions
SET question_date = to_timestamp(date_written/1000);

UPDATE answers
SET date = to_timestamp(date_written/1000);

ALTER TABLE questions
DROP COLUMN date_written;

ALTER TABLE answers
DROP COLUMN date_written;