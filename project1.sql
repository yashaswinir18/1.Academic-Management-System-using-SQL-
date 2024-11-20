-- Step 1: Create the database
CREATE DATABASE projectA;

-- Use the newly created database
USE projectA;

-- Step 2a: Create the StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT AUTO_INCREMENT PRIMARY KEY,
    STU_NAME VARCHAR(100) NOT NULL,
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(255)
);

-- Step 2b: Create the CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT AUTO_INCREMENT PRIMARY KEY,
    COURSE_NAME VARCHAR(100) NOT NULL,
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

-- Step 2c: Create the EnrollmentInfo table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20) CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

 
-- Insert data into StudentInfo table
INSERT INTO StudentInfo (STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES
('Alice Johnson', '1998-04-15', '1234567890', 'alice.johnson@example.com', '123 Maple Street'),
('Bob Smith', '1997-08-22', '0987654321', 'bob.smith@example.com', '456 Oak Avenue'),
('Charlie Davis', '1999-11-10', '1122334455', 'charlie.davis@example.com', '789 Pine Road');

-- Insert data into CoursesInfo table
INSERT INTO CoursesInfo (COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES
('Mathematics 101', 'Dr. Emily Carter'),
('Physics 101', 'Dr. John Miller'),
('Computer Science 101', 'Prof. Sarah Lee');

-- Insert data into EnrollmentInfo table
INSERT INTO EnrollmentInfo (STU_ID, COURSE_ID, ENROLL_STATUS) VALUES
(1, 1, 'Enrolled'),  
(1, 3, 'Enrolled'),  
(2, 2, 'Enrolled'), 
(3, 1, 'Not Enrolled'),
(3, 3, 'Enrolled');

 -- Query 1: Retrieve basic student contact information and their enrollment status
SELECT 
    s.STU_NAME, 
    s.PHONE_NO, 
    s.EMAIL_ID, 
    e.ENROLL_STATUS
FROM 
    StudentInfo s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID;

-- Query 2: List courses enrolled by a specific student (Alice Johnson)
SELECT 
    s.STU_NAME, 
    c.COURSE_NAME
FROM 
    StudentInfo s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN 
    CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE 
    s.STU_NAME = 'Alice Johnson'; 

-- Query 3: Retrieve all course names and their instructors
SELECT 
    COURSE_NAME, 
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo;

-- Query 4: Retrieve the instructor name for a specific course ('Mathematics 101')
SELECT 
    COURSE_NAME, 
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo
WHERE 
    COURSE_NAME = 'Mathematics 101'; 

-- Query 5: Retrieve instructors for specific courses ('Mathematics 101' and 'Physics 101')
SELECT 
    COURSE_NAME, 
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo
WHERE 
    COURSE_NAME IN ('Mathematics 101', 'Physics 101'); 

-- Query 6: Count the number of students enrolled in each course where the status is 'Enrolled'
SELECT 
    c.COURSE_NAME AS 'Course Name',
    COUNT(e.STU_ID) AS 'Number of Students Enrolled'
FROM 
    CoursesInfo c
JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    c.COURSE_NAME;

-- Query 7: List students enrolled in 'Mathematics 101' with their enrollment status
SELECT 
    s.STU_NAME AS 'Student Name',
    c.COURSE_NAME AS 'Course Name'
FROM 
    StudentInfo s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN 
    CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE 
    c.COURSE_NAME = 'Mathematics 101' 
    AND e.ENROLL_STATUS = 'Enrolled';

-- Query 8: Count the number of students enrolled per instructor
SELECT 
    c.COURSE_INSTRUCTOR_NAME AS 'Instructor Name',
    COUNT(e.STU_ID) AS 'Number of Students Enrolled'
FROM 
    CoursesInfo c
JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    c.COURSE_INSTRUCTOR_NAME;

-- Query 9: List students who are enrolled in more than one course
SELECT 
    s.STU_NAME AS 'Student Name',
    COUNT(e.COURSE_ID) AS 'Number of Courses Enrolled'
FROM 
    StudentInfo s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    s.STU_NAME
HAVING 
    COUNT(e.COURSE_ID) > 1;

-- Query 10: List courses with their student enrollment count in descending order
SELECT 
    c.COURSE_NAME AS 'Course Name',
    COUNT(e.STU_ID) AS 'Number of Students Enrolled'
FROM 
    CoursesInfo c
JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    c.COURSE_NAME
ORDER BY 
    COUNT(e.STU_ID) DESC;
