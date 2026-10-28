CREATE DATABASE StudentAuditDB;
GO

USE StudentAuditDB;
GO

CREATE TABLE Students
(
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Marks INT
);

CREATE TABLE Student_Audit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    StudentName VARCHAR(100),
    OldMarks INT,
    NewMarks INT,
    ActionType VARCHAR(20),
    AuditDate DATETIME2 DEFAULT SYSDATETIME()
);

CREATE TRIGGER trg_StudentAudit
ON Students
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Student_Audit
    (
        StudentID,
        StudentName,
        OldMarks,
        NewMarks,
        ActionType
    )
    SELECT
        i.StudentID,
        i.StudentName,
        d.Marks,
        i.Marks,
        CASE
            WHEN d.StudentID IS NULL THEN 'INSERT'
            ELSE 'UPDATE'
        END
    FROM inserted AS i
    LEFT JOIN deleted AS d
        ON i.StudentID = d.StudentID;
END;
GO

INSERT INTO Students (StudentName, Marks)
VALUES ('Ali', 70);

SELECT * FROM Students;
SELECT * FROM Student_Audit;

UPDATE Students
SET Marks = 85
WHERE StudentID = 1;