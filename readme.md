# 📚 Complete SQL Basics Notes

A beginner-friendly repository containing well-structured SQL notes, examples, assignments, and explanations to help learners understand **Structured Query Language (SQL)** from scratch.

This repository is designed for **step-by-step learning, quick revision, and interview preparation**.

---

## 🚀 About This Repository

This repository provides **clear, practical, and easy-to-understand SQL content**, covering everything from fundamentals to slightly advanced concepts.

It is useful for:

- 🎓 Students learning DBMS
- 💻 Beginners starting SQL
- 🧠 Quick revision before interviews/exams
- 👨‍💻 Developers needing a quick SQL reference

---

## 📖 Topics Covered

### 1️⃣ Introduction to SQL
- What is SQL
- What is DBMS
- Relational Databases

### 2️⃣ SQL Commands
- DDL (Data Definition Language)
- DML (Data Manipulation Language)
- DCL (Data Control Language)
- TCL (Transaction Control Language)

### 3️⃣ Table Operations
- `CREATE TABLE`
- `ALTER TABLE`
- `DROP TABLE`
- `TRUNCATE`

### 4️⃣ Data Manipulation
- `INSERT`
- `UPDATE`
- `DELETE`

### 5️⃣ Data Retrieval
- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`

### 6️⃣ Joins
- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL JOIN`

### 7️⃣ Constraints
- `PRIMARY KEY`
- `FOREIGN KEY`
- `UNIQUE`
- `NOT NULL`
- `CHECK`
- `DEFAULT`

### 8️⃣ Advanced Concepts
- Views
- Indexes
- Sequences
- Set Operations

---

## 💡 Example SQL Query

```sql
SELECT name, department
FROM employees
WHERE salary > 50000
ORDER BY salary DESC;
```

This query retrieves employees earning more than 50,000 and sorts them by salary in descending order.

---

## 🛠 Tools to Use

You can practice SQL using:

- MySQL
- Oracle SQL
- PostgreSQL
- SQLite
- MySQL Workbench

---

## ⚙️ Installation & Setup (MySQL Workbench)

**Step 1: Install MySQL**
- Download MySQL from: https://dev.mysql.com/downloads/
- Install:
	- MySQL Server
	- MySQL Workbench
- Set a root password during installation

**Step 2: Open MySQL Workbench**
- Launch MySQL Workbench
- Click on Local Instance MySQL
- Enter your root password

**Step 3: Create a Database**
```sql
CREATE DATABASE sql_practice;
USE sql_practice;
```

**Step 4: Run SQL Files from This Repository**

**Method 1: Open SQL File**
- File → Open SQL Script
- Select .sql file
- Click Execute (⚡)

**Method 2: Copy-Paste**
- Open new SQL tab
- Paste code
- Run

**Method 3: Recommended Order**
- Table creation
- Insert data
- Constraints / Keys
- Queries / Joins / Assignments

---

## 📂 Repository Structure

```
├── 📁 Handbook & Code
│   ├── 📄 01_createusertable.sql
│   ├── 📄 02_insertdata.sql
│   ├── 📄 03_foreignkey.sql
│   ├── 📄 04_addadmin.sql
│   ├── 📄 05_log_table.sql
│   └── 📕 MySQL Handbook.pdf
├── 📁 assignments
│   ├── 📝 assignments.md
│   ├── 📕 sql_assignment.pdf
│   └── 📕 sql_views_assignment.pdf
├── 📄 Joins.sql
├── 📄 Keys.sql
├── 📄 SubQueries.sql
├── 📄 Views.sql
├── 📄 aggregateFunctions.sql
├── 📄 constraints.sql
├── 📄 companyDatabase.sql
├── 📄 exercise.sql
├── 📄 joinsExercise.sql
├── 📄 operators.sql
├── 📄 project.sql
├── 📄 questions.sql
├── 📝 readme.md
└── 📄 table_related_queries.sql
```

Structure may change as more files are added.

---

## 🎯 Who Should Use This

- Computer Science Students
- Beginners in Databases
- Coding Interview Aspirants
- Backend Developers
- Data Analysts

---

## 🤝 Contributions

Contributions are welcome!

1. Fork the repository
2. Create a new branch
3. Make improvements
4. Submit a Pull Request

---

## ⭐ Support

If you find this repository helpful:

- ⭐ Star the repository
- 🔗 Share it with others

---

## 👨‍💻 Author

**Rishiraj Pathak**  
Computer Engineering Student  
Passionate about Programming, Databases, and Software Development

GitHub:  
https://github.com/Rishiraj-Pathak-27
