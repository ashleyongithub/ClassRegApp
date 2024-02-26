USE [DevelopmentTest]
GO

/****** Object:  StoredProcedure [dbo].[ClassRegistrationReport]    Script Date: 26/02/2024 11:17:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Adam Holt
-- Create date: 02/26/2024
-- Description:	Returns assigned classess
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[ClassRegistrationReport]
AS
BEGIN
	-- Select class name, teacher name, registration count
	-- Calculate SUM of number paid using HasPaidFees column in ClassRegistration
	-- Inner join on teacher table as all classes have a teacher
	-- Left join on ClassRegistration as not all classes are registered 
	-- Group non-aggregated columns ClassName, TeacherName
	SELECT
		C.ClassName AS [Class],
		T.TeacherName AS [TeacherName],
		COUNT(CR.STUDENT_ID) AS [Registrations],
		SUM(CASE WHEN CR.HasPaidFees = 1 THEN 1 ELSE 0 END) as [NumberPaid]
	FROM
		Class C
	JOIN
		Teacher T ON C.Teacher_ID = T.Teacher_ID
	LEFT  JOIN
		ClassRegistration CR ON C.Class_ID = CR.Class_ID
	GROUP BY
		C.ClassName, T.TeacherName
END
GO


