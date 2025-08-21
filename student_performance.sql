-- ============================================
-- ALU Rwanda Student Grades DB
-- ============================================

-- Drop DB if it exists, so we can start fresh
DROP DATABASE IF EXISTS student_performance;
CREATE DATABASE student_performance;
USE student_performance;

-- ============================================
-- 1. Make the tables
-- ============================================
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    intake_year YEAR NOT NULL
);

CREATE TABLE linux_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Linux',
    student_id INT,
    grade_obtained INT CHECK (grade_obtained BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE python_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Python',
    student_id INT,
    grade_obtained INT CHECK (grade_obtained BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- ============================================
-- 2. Put in some sample students.
-- I picked 15, split into 2 years (incase we have students from different intakes)
-- ============================================
INSERT INTO students (student_name, intake_year) VALUES
('Ange Uwimana', 2024),
('Patrick Niyonsaba', 2024),
('Divine Ingabire', 2024),
('Eric Habimana', 2024),
('Sandrine Uwitonze', 2024),
('Claude Iradukunda', 2024),
('Didier Mugisha', 2024),
('Aline Uwera', 2024),
('Innocent Nkurunziza', 2024),
('Diane Umutoni', 2024),
('Yvan Hakizimana', 2025),
('Belise Mukamana', 2025),
('Thierry Nkurikiyimana', 2025),
('Alice Nyirahabineza', 2025),
('Eliane Mukandoli', 2025);

-- ============================================
-- 3. Add Linux grades. A mix of students where some did poorly and some did really well.
-- ============================================
INSERT INTO linux_grades (student_id, grade_obtained) VALUES
(1, 78), (2, 45), (3, 66), (4, 30), (5, 82),
(6, 90), (7, 52), (8, 48), (9, 70), (10, 60),
(11, 40), (12, 85);

-- ============================================
-- 4. Add Python grades, mix of pass and fail
-- ============================================
INSERT INTO python_grades (student_id, grade_obtained) VALUES
(3, 88), (4, 72), (5, 91), (6, 60), (7, 77),
(9, 83), (10, 49), (12, 95), (13, 55), (14, 42),
(15, 78);

-- ============================================
-- 5. Who failed Linux? (less than 50)
-- ============================================
SELECT s.student_name, l.grade_obtained
FROM students s
JOIN linux_grades l ON s.student_id = l.student_id
WHERE l.grade_obtained < 50;

-- ============================================
-- 6. Students who only did one course, either Linux or Python but not both.
-- ============================================
SELECT s.student_name
FROM students s
WHERE s.student_id IN (
    SELECT student_id FROM linux_grades
    WHERE student_id NOT IN (SELECT student_id FROM python_grades)
)
UNION
SELECT s.student_name
FROM students s
WHERE s.student_id IN (
    SELECT student_id FROM python_grades
    WHERE student_id NOT IN (SELECT student_id FROM linux_grades)
);

-- ============================================
-- 7. Students who did both courses
-- ============================================
SELECT s.student_name
FROM students s
WHERE s.student_id IN (
    SELECT student_id FROM linux_grades
    WHERE student_id IN (SELECT student_id FROM python_grades)
);

-- ============================================
-- 8. Average grade per course, how everyone did.
-- ============================================
SELECT 'Linux' AS course, AVG(grade_obtained) AS avg_grade
FROM linux_grades
UNION
SELECT 'Python' AS course, AVG(grade_obtained) AS avg_grade
FROM python_grades;

-- ============================================
-- 9. Top student overall, average across both courses
-- ============================================
SELECT s.student_name, AVG(g.grade_obtained) AS avg_score
FROM students s
JOIN (
    SELECT student_id, grade_obtained FROM linux_grades
    UNION ALL
    SELECT student_id, grade_obtained FROM python_grades
) g ON s.student_id = g.student_id
GROUP BY s.student_id, s.student_name
ORDER BY avg_score DESC
LIMIT 1;

-- ============================================
-- 10. Bonus Query: students who failed both courses
-- ============================================
SELECT s.student_name
FROM students s
JOIN linux_grades l ON s.student_id = l.student_id
JOIN python_grades p ON s.student_id = p.student_id
WHERE l.grade_obtained < 50 AND p.grade_obtained < 50;
