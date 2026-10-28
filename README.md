# Student Audit System

## Project Overview
The Student Audit System is a SQL Server database project designed to maintain an audit history of student records.

## Technologies Used
- Microsoft SQL Server
- T-SQL
- SQL Triggers

## Features
- Create and manage student records.
- Automatically log student INSERT operations.
- Track changes to student marks using UPDATE triggers.
- Store previous and updated marks.
- Record the date and time of audit events.

## Database Tables
- `Students`: Stores student information and marks.
- `Student_Audit`: Stores audit records and change history.

## How to Run
1. Open SQL Server Management Studio (SSMS).
2. Open `StudentAuditDB.sql`.
3. Execute the script to create the database, tables, and trigger.
4. Run the sample INSERT and UPDATE statements to test the audit functionality.
5. Query the `Student_Audit` table to verify the results.

## Learning Objectives
This project demonstrates practical use of SQL Server triggers, INSERT and UPDATE operations, JOINs, CASE expressions, and audit logging.
