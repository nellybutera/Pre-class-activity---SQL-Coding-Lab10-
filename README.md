# ALU Rwanda Student Grades DB

Hii there, welcome to our student perfomance repo! 
It is of a simple MySQL database to keep track of student grades for Linux and Python courses at ALU Rwanda.

---

## What’s in the SQL file (Table creation + queries)

- `student_performance.sql` database:
  - Creates the database and three tables: `students`, `linux_grades`, `python_grades`
  - Adds sample data for 15 students (split between 2024 & 2025 intakes)
  - Runs queries to check:
    - Who scored less than 50 in Linux
    - Who only did one course
    - Who did both courses
    - Average grades per course
    - Top-performing student overall
    - Bonus query: who failed both courses

---

## How to run it

1. Using MySQL Shell in SQL mode:  
   ```bash
   mysqlsh --sql -u root -p
2. Using CMD (Command Prompt):  
   ```bash
   mysql -u root -p