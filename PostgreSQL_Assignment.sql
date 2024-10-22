-- Active: 1729319967685@@127.0.0.1@5432@university_db
--create student table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    email VARCHAR(50) NOT NULL,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);
-- create course table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);
-- create enrollment table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students (student_id),
    course_id INT REFERENCES courses (course_id)
);

-- insert student data
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Sameer',
        21,
        'sameer@example.com',
        48,
        60,
        NULL
    ),
    (
        'Zoya',
        23,
        'zoya@example.com',
        52,
        58,
        NULL
    ),
    (
        'Nabil',
        22,
        'nabil@example.com',
        37,
        46,
        NULL
    ),
    (
        'Rafi',
        24,
        'rafi@example.com',
        41,
        40,
        NULL
    ),
    (
        'Sophia',
        22,
        'sophia@example.com',
        50,
        52,
        NULL
    ),
    (
        'Hasan',
        23,
        'hasan@gmail.com',
        43,
        39,
        NULL
    );

-- insert course data
INSERT INTO
    courses (course_name, credits)
VALUES ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

-- insert enrollment data
INSERT INTO
    enrollment (student_id, course_id)
VALUES (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);

-- retrieve all students name who are enrolled in the course titled 'Next.js'
SELECT student_name
FROM
    enrollment e
    JOIN students s ON e.student_id = s.student_id
    JOIN courses c ON e.course_id = c.course_id
WHERE
    course_name = 'Next.js';

-- update the student status 'Awarded' when highest total
UPDATE students
SET
    status = 'Awarded'
WHERE
    frontend_mark + backend_mark = (
        SELECT MAX(frontend_mark + backend_mark)
        FROM students
    );

-- Delete all courses that have no students enrolled
DELETE FROM courses c
WHERE
    NOT EXISTS (
        SELECT course_id
        FROM enrollment e
        where
            e.course_id = c.course_id
    );

-- retrieve student name where limit 2 and starting from 3rd student
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2
OFFSET
    2;

-- retrieve course name and number of enrolled course student
SELECT course_name, COUNT(e.student_id)
FROM
    enrollment e
    JOIN students s ON e.student_id = s.student_id
    JOIN courses c ON e.course_id = c.course_id
GROUP BY
    c.course_name;

-- calculate average age of all students
SELECT ROUND(AVG(age), 2) from students;

-- retrieve students name whose email contain 'example.com'
SELECT student_name FROM students WHERE email LIKE '%example.com'

SELECT * FROM students;

SELECT * FROM courses;

SELECT * FROM enrollment;