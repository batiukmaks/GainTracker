-- Active: 1667687456171@@127.0.0.1@3306@gaintracker

SELECT id FROM user WHERE first_name='James' AND last_name='Bond';

INSERT INTO workout (name, author_id) VALUES
    ('Push Yourself', (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('Pull Workout', (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('Leg Killer', (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('Strong Core', (SELECT id FROM user WHERE first_name='James' AND last_name='Bond'));


INSERT INTO workout_exercise (workout_id, exercise_id) VALUES
    ((SELECT id FROM workout WHERE name='Push Yourself'), (SELECT id FROM exercise WHERE name='diamond push ups')),
    ((SELECT id FROM workout WHERE name='Push Yourself'), (SELECT id FROM exercise WHERE name='handstand push up')),
    ((SELECT id FROM workout WHERE name='Push Yourself'), (SELECT id FROM exercise WHERE name='dumbbell bench press')),
    ((SELECT id FROM workout WHERE name='Push Yourself'), (SELECT id FROM exercise WHERE name='decline barbell bench press')),
    ((SELECT id FROM workout WHERE name='Push Yourself'), (SELECT id FROM exercise WHERE name='triceps dip')),
    
    ((SELECT id FROM workout WHERE name='Pull Workout'), (SELECT id FROM exercise WHERE name='muscle-up')),
    ((SELECT id FROM workout WHERE name='Pull Workout'), (SELECT id FROM exercise WHERE name='barbell curl')),
    ((SELECT id FROM workout WHERE name='Pull Workout'), (SELECT id FROM exercise WHERE name='pull-up')),
    ((SELECT id FROM workout WHERE name='Pull Workout'), (SELECT id FROM exercise WHERE name='incline hammer curl')),

    ((SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM exercise WHERE name='barbell squats')),
    ((SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM exercise WHERE name='romanian deadlift')),
    ((SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM exercise WHERE name='pistol squats')),
    ((SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM exercise WHERE name='conventional deadlift')),
    ((SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM exercise WHERE name='walking lunges')),
    ((SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM exercise WHERE name='calf raises')),

    ((SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM exercise WHERE name='push ups')),
    ((SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM exercise WHERE name='crunches')),
    ((SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM exercise WHERE name='plank')),
    ((SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM exercise WHERE name='cocoons')),
    ((SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM exercise WHERE name='hanging leg raise')),
    ((SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM exercise WHERE name='spider crawl')),
    ((SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM exercise WHERE name='mountain climber'));

update workout set name='Leg Killer' where name='Legs Killer';

INSERT INTO session (date, workout_id, user_id) VALUES
    ('2022-12-02', (SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-03', (SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-05', (SELECT id FROM workout WHERE name='Push Yourself'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-07', (SELECT id FROM workout WHERE name='Pull Workout'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-09', (SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-10', (SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-12', (SELECT id FROM workout WHERE name='Push Yourself'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-14', (SELECT id FROM workout WHERE name='Pull Workout'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-16', (SELECT id FROM workout WHERE name='Leg Killer'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-17', (SELECT id FROM workout WHERE name='Strong Core'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    ('2022-12-19', (SELECT id FROM workout WHERE name='Pull Workout'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond'));

SELECT id from session where date='2022-12-02' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond');

INSERT INTO exercise_record (date, exercise_id, session_id) VALUES 
    ('2022-12-05', (SELECT id FROM exercise WHERE name='diamond push ups'), (SELECT id from session where date='2022-12-05' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-05', (SELECT id FROM exercise WHERE name='handstand push up'), (SELECT id from session where date='2022-12-05' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-05', (SELECT id FROM exercise WHERE name='dumbbell bench press'), (SELECT id from session where date='2022-12-05' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-05', (SELECT id FROM exercise WHERE name='decline barbell bench press'), (SELECT id from session where date='2022-12-05' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-05', (SELECT id FROM exercise WHERE name='triceps dip'), (SELECT id from session where date='2022-12-05' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    ('2022-12-12', (SELECT id FROM exercise WHERE name='diamond push ups'), (SELECT id from session where date='2022-12-12' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-12', (SELECT id FROM exercise WHERE name='handstand push up'), (SELECT id from session where date='2022-12-12' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-12', (SELECT id FROM exercise WHERE name='dumbbell bench press'), (SELECT id from session where date='2022-12-12' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-12', (SELECT id FROM exercise WHERE name='decline barbell bench press'), (SELECT id from session where date='2022-12-12' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-12', (SELECT id FROM exercise WHERE name='triceps dip'), (SELECT id from session where date='2022-12-12' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    

    ('2022-12-07', (SELECT id FROM exercise WHERE name='muscle-up'), (SELECT id from session where date='2022-12-07' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-07', (SELECT id FROM exercise WHERE name='barbell curl'), (SELECT id from session where date='2022-12-07' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-07', (SELECT id FROM exercise WHERE name='pull-up'), (SELECT id from session where date='2022-12-07' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-07', (SELECT id FROM exercise WHERE name='incline hammer curl'), (SELECT id from session where date='2022-12-07' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    ('2022-12-14', (SELECT id FROM exercise WHERE name='muscle-up'), (SELECT id from session where date='2022-12-14' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-14', (SELECT id FROM exercise WHERE name='barbell curl'), (SELECT id from session where date='2022-12-14' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-14', (SELECT id FROM exercise WHERE name='pull-up'), (SELECT id from session where date='2022-12-14' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-14', (SELECT id FROM exercise WHERE name='incline hammer curl'), (SELECT id from session where date='2022-12-14' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    ('2022-12-19', (SELECT id FROM exercise WHERE name='muscle-up'), (SELECT id from session where date='2022-12-19' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-19', (SELECT id FROM exercise WHERE name='barbell curl'), (SELECT id from session where date='2022-12-19' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-19', (SELECT id FROM exercise WHERE name='pull-up'), (SELECT id from session where date='2022-12-19' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-19', (SELECT id FROM exercise WHERE name='incline hammer curl'), (SELECT id from session where date='2022-12-19' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    
    ('2022-12-02', (SELECT id FROM exercise WHERE name='barbell squats'), (SELECT id from session where date='2022-12-02' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-02', (SELECT id FROM exercise WHERE name='romanian deadlift'), (SELECT id from session where date='2022-12-02' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-02', (SELECT id FROM exercise WHERE name='pistol squats'), (SELECT id from session where date='2022-12-02' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-02', (SELECT id FROM exercise WHERE name='conventional deadlift'), (SELECT id from session where date='2022-12-02' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-02', (SELECT id FROM exercise WHERE name='walking lunges'), (SELECT id from session where date='2022-12-02' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-02', (SELECT id FROM exercise WHERE name='calf raises'), (SELECT id from session where date='2022-12-02' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    ('2022-12-09', (SELECT id FROM exercise WHERE name='barbell squats'), (SELECT id from session where date='2022-12-09' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-09', (SELECT id FROM exercise WHERE name='romanian deadlift'), (SELECT id from session where date='2022-12-09' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-09', (SELECT id FROM exercise WHERE name='pistol squats'), (SELECT id from session where date='2022-12-09' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-09', (SELECT id FROM exercise WHERE name='conventional deadlift'), (SELECT id from session where date='2022-12-09' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-09', (SELECT id FROM exercise WHERE name='walking lunges'), (SELECT id from session where date='2022-12-09' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-09', (SELECT id FROM exercise WHERE name='calf raises'), (SELECT id from session where date='2022-12-09' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    ('2022-12-16', (SELECT id FROM exercise WHERE name='barbell squats'), (SELECT id from session where date='2022-12-16' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-16', (SELECT id FROM exercise WHERE name='romanian deadlift'), (SELECT id from session where date='2022-12-16' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-16', (SELECT id FROM exercise WHERE name='pistol squats'), (SELECT id from session where date='2022-12-16' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-16', (SELECT id FROM exercise WHERE name='conventional deadlift'), (SELECT id from session where date='2022-12-16' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-16', (SELECT id FROM exercise WHERE name='walking lunges'), (SELECT id from session where date='2022-12-16' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-16', (SELECT id FROM exercise WHERE name='calf raises'), (SELECT id from session where date='2022-12-16' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    
    ('2022-12-03', (SELECT id FROM exercise WHERE name='push ups'), (SELECT id from session where date='2022-12-03' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-03', (SELECT id FROM exercise WHERE name='crunches'), (SELECT id from session where date='2022-12-03' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-03', (SELECT id FROM exercise WHERE name='plank'), (SELECT id from session where date='2022-12-03' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-03', (SELECT id FROM exercise WHERE name='cocoons'), (SELECT id from session where date='2022-12-03' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-03', (SELECT id FROM exercise WHERE name='hanging leg raise'), (SELECT id from session where date='2022-12-03' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-03', (SELECT id FROM exercise WHERE name='spider crawl'), (SELECT id from session where date='2022-12-03' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-03', (SELECT id FROM exercise WHERE name='mountain climber'), (SELECT id from session where date='2022-12-03' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    ('2022-12-10', (SELECT id FROM exercise WHERE name='push ups'), (SELECT id from session where date='2022-12-10' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-10', (SELECT id FROM exercise WHERE name='crunches'), (SELECT id from session where date='2022-12-10' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-10', (SELECT id FROM exercise WHERE name='plank'), (SELECT id from session where date='2022-12-10' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-10', (SELECT id FROM exercise WHERE name='cocoons'), (SELECT id from session where date='2022-12-10' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-10', (SELECT id FROM exercise WHERE name='hanging leg raise'), (SELECT id from session where date='2022-12-10' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-10', (SELECT id FROM exercise WHERE name='spider crawl'), (SELECT id from session where date='2022-12-10' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-10', (SELECT id FROM exercise WHERE name='mountain climber'), (SELECT id from session where date='2022-12-10' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    
    ('2022-12-17', (SELECT id FROM exercise WHERE name='push ups'), (SELECT id from session where date='2022-12-17' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-17', (SELECT id FROM exercise WHERE name='crunches'), (SELECT id from session where date='2022-12-17' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-17', (SELECT id FROM exercise WHERE name='plank'), (SELECT id from session where date='2022-12-17' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-17', (SELECT id FROM exercise WHERE name='cocoons'), (SELECT id from session where date='2022-12-17' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-17', (SELECT id FROM exercise WHERE name='hanging leg raise'), (SELECT id from session where date='2022-12-17' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-17', (SELECT id FROM exercise WHERE name='spider crawl'), (SELECT id from session where date='2022-12-17' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond'))),
    ('2022-12-17', (SELECT id FROM exercise WHERE name='mountain climber'), (SELECT id from session where date='2022-12-17' AND user_id=(SELECT id FROM user WHERE first_name='James' AND last_name='Bond')));


SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='diamond push ups');

INSERT INTO exercise_set (sequence_number, reps, weight, time, exercise_record_id) VALUES
    (1, 10, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='diamond push ups'))),
    (2, 8, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='diamond push ups'))),
    (3, 6, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='diamond push ups'))),
    (1, 14, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='diamond push ups'))),
    (2, 11, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='diamond push ups'))),
    (3, 8, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='diamond push ups'))),

    
    (1, 3, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='handstand push up'))),
    (2, 1, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='handstand push up'))),
    (3, 0, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='handstand push up'))),
    (1, 5, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='handstand push up'))),
    (2, 3, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='handstand push up'))),
    (3, 1, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='handstand push up'))),

    
    (1, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='dumbbell bench press'))),
    (2, 8, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='dumbbell bench press'))),
    (3, 5, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='dumbbell bench press'))),
    (1, 12, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='dumbbell bench press'))),
    (2, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='dumbbell bench press'))),
    (3, 5, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='dumbbell bench press'))),

    
    (1, 8, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='decline barbell bench press'))),
    (2, 5, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='decline barbell bench press'))),
    (3, 5, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='decline barbell bench press'))),
    (1, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='decline barbell bench press'))),
    (2, 7, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='decline barbell bench press'))),
    (3, 5, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='decline barbell bench press'))),

    
    (1, 12, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='triceps dip'))),
    (2, 11, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='triceps dip'))),
    (3, 7, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-05' AND exercise_id=(SELECT id FROM exercise WHERE name='triceps dip'))),
    (1, 12, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='triceps dip'))),
    (2, 12, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='triceps dip'))),
    (3, 9, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-12' AND exercise_id=(SELECT id FROM exercise WHERE name='triceps dip'))),


    (1, 4, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (2, 2, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (3, 1, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (1, 4, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (2, 2, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (3, 2, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (1, 5, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (2, 3, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),
    (3, 2, 0, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='muscle-up'))),

    (1, 10, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (2, 9, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (3, 7, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (1, 12, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (2, 9, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (3, 8, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (1, 12, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (2, 12, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),
    (3, 7, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell curl'))),

    (1, 10, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (2, 7, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (3, 4, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (1, 10, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (2, 7, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (3, 7, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (1, 12, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (2, 9, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),
    (3, 7, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='pull-up'))),

    (1, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (2, 7, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (3, 4, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-07' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (1, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (2, 8, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (3, 16, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-14' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (1, 12, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (2, 8, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),
    (3, 2, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-19' AND exercise_id=(SELECT id FROM exercise WHERE name='incline hammer curl'))),


    (1, 8, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (2, 5, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (3, 2, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (1, 8, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (2, 6, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (3, 3, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (1, 8, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (2, 7, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),
    (3, 5, 40, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='barbell squats'))),

    (1, 8, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (2, 5, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (3, 5, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (1, 9, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (2, 6, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (3, 5, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (1, 10, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (2, 7, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),
    (3, 7, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='romanian deadlift'))),

    (1, 10, 0, 0.35, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (2, 10, 0, 0.40, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (3, 10, 0, 0.55, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (1, 10, 0, 0.35, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (2, 10, 0, 0.40, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (3, 10, 0, 0.45, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (1, 10, 0, 0.30, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (2, 10, 0, 0.40, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),
    (3, 10, 0, 0.40, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='pistol squats'))),

    (1, 8, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (2, 5, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (3, 5, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (1, 9, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (2, 6, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (3, 5, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (1, 10, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (2, 7, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),
    (3, 7, 20, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='conventional deadlift'))),

    (1, 15, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (2, 14, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (3, 11, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (1, 15, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (2, 13, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (3, 12, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (1, 15, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (2, 13, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),
    (3, 13, 16, 1, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='walking lunges'))),

    (1, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (2, 7, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (3, 4, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-02' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (1, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (2, 7, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (3, 7, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-09' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (1, 10, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (2, 9, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),
    (3, 6, 16, 0, (SELECT id FROM exercise_record WHERE date='2022-12-16' AND exercise_id=(SELECT id FROM exercise WHERE name='calf raises'))),


    (1, 20, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (2, 17, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (3, 14, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (1, 21, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (2, 17, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (3, 17, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (1, 25, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (2, 19, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),
    (3, 16, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='push ups'))),

    (1, 25, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (2, 18, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (3, 17, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (1, 25, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (2, 20, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (3, 19, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (1, 25, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (2, 21, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),
    (3, 20, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='crunches'))),

    (1, 0, 0, 0.55, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (2, 0, 0, 0.30, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (3, 0, 0, 0.23, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (1, 0, 0, 0.53, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (2, 0, 0, 0.43, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (3, 0, 0, 0.29, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (1, 0, 0, 0.56, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (2, 0, 0, 0.46, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),
    (3, 0, 0, 0.36, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='plank'))),

    (1, 25, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (2, 18, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (3, 17, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (1, 25, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (2, 20, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (3, 19, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (1, 25, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (2, 21, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),
    (3, 20, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='cocoons'))),

    (1, 17, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (2, 12, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (3, 7, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (1, 18, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (2, 13, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (3, 7, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (1, 20, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (2, 17, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),
    (3, 11, 0, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='hanging leg raise'))),

    (1, 15, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (2, 12, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (3, 10, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (1, 15, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (2, 14, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (3, 10, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (1, 17, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (2, 15, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),
    (3, 14, 10, 1, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='spider crawl'))),

    (1, 0, 0, 0.46, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (2, 0, 0, 0.35, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (3, 0, 0, 0.25, (SELECT id FROM exercise_record WHERE date='2022-12-03' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (1, 0, 0, 0.52, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (2, 0, 0, 0.46, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (3, 0, 0, 0.43, (SELECT id FROM exercise_record WHERE date='2022-12-10' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (1, 0, 0, 0.57, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (2, 0, 0, 0.45, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber'))),
    (3, 0, 0, 0.44, (SELECT id FROM exercise_record WHERE date='2022-12-17' AND exercise_id=(SELECT id FROM exercise WHERE name='mountain climber')));



INSERT INTO body_measurement_record (record, date, criteria_id, user_id) VALUES
    (69.2, '2022-12-02', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (68.8, '2022-12-03', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (69.5, '2022-12-05', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (69.9, '2022-12-07', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (69.7, '2022-12-09', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (70.3, '2022-12-10', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (70.6, '2022-12-12', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (70.9, '2022-12-14', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (70.4, '2022-12-16', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (71.2, '2022-12-17', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (71.5, '2022-12-19', (SELECT id FROM body_measurement_criteria WHERE name='weight'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),

    (85.2, '2022-12-02', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (82.8, '2022-12-03', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (85.5, '2022-12-05', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (85.9, '2022-12-07', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (85.7, '2022-12-09', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (86.3, '2022-12-10', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (86.6, '2022-12-12', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (86.9, '2022-12-14', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (86.4, '2022-12-16', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (87.2, '2022-12-17', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (87.5, '2022-12-19', (SELECT id FROM body_measurement_criteria WHERE name='waist'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),

    (95.2, '2022-12-02', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (95.8, '2022-12-03', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (96.5, '2022-12-05', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (96.6, '2022-12-07', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (96.3, '2022-12-09', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (96.6, '2022-12-10', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (96.8, '2022-12-12', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.1, '2022-12-14', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.0, '2022-12-16', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.2, '2022-12-17', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.2, '2022-12-19', (SELECT id FROM body_measurement_criteria WHERE name='hips'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),

    (96.1, '2022-12-02', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (96.6, '2022-12-03', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.1, '2022-12-05', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.3, '2022-12-07', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.0, '2022-12-09', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.3, '2022-12-10', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.5, '2022-12-12', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.6, '2022-12-14', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.3, '2022-12-16', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.6, '2022-12-17', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond')),
    (97.9, '2022-12-19', (SELECT id FROM body_measurement_criteria WHERE name='chest'), (SELECT id FROM user WHERE first_name='James' AND last_name='Bond'));

