# ALU Rwanda Student Grades DB

Hey! This repo has a simple MySQL database to keep track of student grades for Linux and Python courses at ALU Rwanda.

---

## What’s in the SQL file

- `student_performance.sql` does everything you need:
  - Makes the database and three tables: `students`, `linux_grades`, `python_grades`
  - Adds sample data for 15 students (split between 2024 & 2025 intakes)
  - Runs queries to check stuff like:
    - Who scored less than 50 in Linux
    - Who only did one course
    - Who did both courses
    - Average grades per course
    - Top-performing student overall
    - Bonus: who failed both courses (ouch 😅)

---

## How to run it

### Using MySQL Shell
1. Open MySQL Shell in SQL mode:  
   ```bash
   mysqlsh --sql -u root -p
