USE StudentAuditDB;
GO

ALTER TABLE Student_Audit
ADD OldStudentName varchar(225),
NewStudentName varchar(225)


CREATE OR ALTER TRIGGER trg_Students_Audit
ON Students
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Inserted records ki audit entry
    INSERT INTO Student_Audit
    (
        StudentID,
        ActionType,
        OldStudentName,
        NewStudentName,
        OldMarks,
        NewMarks
    )
    SELECT
        i.StudentID,
        'INSERT',
        NULL,
        i.StudentName,
        NULL,
        i.Marks
    FROM inserted AS i
    LEFT JOIN deleted AS d
        ON i.StudentID = d.StudentID
    WHERE d.StudentID IS NULL;

    -- Updated records ki audit entry
    INSERT INTO Student_Audit
    (
        StudentID,
        ActionType,
        OldStudentName,
        NewStudentName,
        OldMarks,
        NewMarks
    )
    SELECT
        i.StudentID,
        'UPDATE',
        d.StudentName,
        i.StudentName,
        d.Marks,
        i.Marks
    FROM inserted AS i
    INNER JOIN deleted AS d
        ON i.StudentID = d.StudentID;
END;
GO



INSERT INTO Students (StudentName, Marks)
VALUES ('Ali Ahmed', 65);

SELECT * FROM Students;
SELECT * FROM Student_Audit;


UPDATE Students
SET Marks = 85
WHERE StudentID = 1;

SELECT * FROM Student_Audit
ORDER BY AuditID;



-- Students ki current details
SELECT * FROM Students;

-- Complete audit history
SELECT * FROM Student_Audit
ORDER BY ActionType DESC;

-- Sirf update actions
SELECT *
FROM Student_Audit
WHERE ActionType = 'UPDATE';

-- Trigger enabled hai ya nahi
SELECT name, is_disabled
FROM sys.triggers
WHERE name = 'trg_Students_Audit';

