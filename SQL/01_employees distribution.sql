CREATE PROCEDURE [dbo].[spGetEmployees]
AS
BEGIN

	DECLARE @EndDate DATETIME = (SELECT EndDate FROM tblSzenario WHERE SzenarioID = 1)
	DECLARE @StartDate DATETIME = (SELECT StartDate FROM tblSzenario WHERE SzenarioID = 1)
	
	
	SELECT
		emp.ID
		,YEAR(emp.BirthDate) AS BirthYear
		,YEAR(PensionDate1) AS PensionYear
		,CAST(emp.BirthDate AS Date) AS BirthDate
		,CAST(emp.PensionDate1 AS Date) AS PensionDate
		,bDiv.Name AS OccupationArea
		,ISNULL(loc.Name, '') AS Location
		,ISNULL(jGroup.GroupName, '') AS GroupName
		,ISNULL(jFam.FamName, '') AS FamName
		,ISNULL(jFunc.FuncName, '') AS FuncName
		,ISNULL(jLvl.LevelName, '') AS LevelName
		,CASE emp.Gender WHEN 2 THEN 'Female' ELSE 'Male' END AS Gender
	FROM vwEmplScen emp 
	LEFT JOIN tblBusinessDiv bDiv ON emp.BusinessDiv = bDiv.BusinessDivID
	LEFT JOIN tblLocation loc ON emp.Location = loc.LocationID
	LEFT JOIN tblJobGroup jGroup ON emp.JobGroupID = jGroup.JobGroupID
	LEFT JOIN tblJobFam jFam ON emp.JobFamID = jFam.JobFamID
	LEFT JOIN tblJobFunc jFunc ON emp.JobFuncID = jFunc.JobFuncID
	LEFT JOIN tblJobLevel jLvl ON emp.JobLevID = jLvl.JobLevID
	WHERE YEAR(emp.PensionDate1) >= YEAR(@StartDate) --
	ORDER BY emp.BirthDate

END

GO


