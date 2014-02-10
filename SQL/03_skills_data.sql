INSERT INTO tblSkill VALUES ('Thinks strategically')
INSERT INTO tblSkill VALUES ('Develops people and organization')
INSERT INTO tblSkill VALUES ('Drives performance')
INSERT INTO tblSkill VALUES ('Manages change')
INSERT INTO tblSkill VALUES ('Collaborates well')
INSERT INTO tblSkill VALUES ('Motivates others')
INSERT INTO tblSkill VALUES ('Makes timely decisions')

INSERT INTO tblSkill VALUES ('Customer relationship management')
INSERT INTO tblSkill VALUES ('Pricing models')
INSERT INTO tblSkill VALUES ('Productivity modelling')
INSERT INTO tblSkill VALUES ('Product development and engineering')
INSERT INTO tblSkill VALUES ('Sales planning')
INSERT INTO tblSkill VALUES ('Cost modelling')
INSERT INTO tblSkill VALUES ('Marketing strategies')
INSERT INTO tblSkill VALUES ('Technical engineering')
INSERT INTO tblSkill VALUES ('Customer interaction')
INSERT INTO tblSkill VALUES ('Cost benchmarking')

GO

INSERT INTO tblSkillSet VALUES ('Leadership')
INSERT INTO tblSkillSet VALUES ('Commercial')

GO

INSERT INTO tblSkillSetSkill VALUES (1, 1, 0, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (1, 2, 1, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (1, 3, 0, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (1, 4, 1, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (1, 5, 1, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (1, 6, 0, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (1, 7, 1, 0, NULL)

INSERT INTO tblSkillSetSkill VALUES (2, 8, 0, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (2, 9, 1, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (2, 10, 1, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (2, 11, 0, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (2, 12, 1, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (2, 13, 0, 0, NULL)
INSERT INTO tblSkillSetSkill VALUES (2, 14, 1, 0, NULL)

INSERT INTO tblSkillSetSkill VALUES (2, 15, 1, 0, 4)
INSERT INTO tblSkillSetSkill VALUES (2, 16, 1, 0, 3)
INSERT INTO tblSkillSetSkill VALUES (2, 17, 1, 0, 2)


GO

CREATE PROCEDURE dbo.spGenerateSkillRatings
AS
BEGIN

	DECLARE @Upper INT
	DECLARE @Lower INT
	SET @Lower = 1
	SET @Upper = 6

	INSERT INTO tblEmployeeSkill
	SELECT
		t.EmployeeId,
		t.SkillId,
		t.Rating,
		(CASE
			WHEN t.Rating >=0
			THEN (CASE WHEN RAND(CAST(NEWID() AS binary(8))) < 0.5 THEN 0 ELSE 1 END)
			ELSE 0
		 END) AS DevelopmentOpportunity
	FROM (
		SELECT
			e.ID AS EmployeeId,
			s.Id AS SkillId,
			1 + ABS(CHECKSUM(NewId())) % 5 AS Rating,
			(CASE WHEN RAND(CAST(NEWID() AS binary(8))) < 0.5 THEN 0 ELSE 1 END) AS IsInsert
		FROM vwEmplScen e, tblSkill s
	) t
	WHERE NOT EXISTS (SELECT * FROM tblEmployeeSkill es WHERE es.EmployeeId = t.EmployeeId AND es.SkillId = t.SkillId) AND t.IsInsert = 1

END

GO

CREATE PROCEDURE [dbo].[spGetEmployeeSkills]
AS
BEGIN

	SELECT
		 emp.ID
		,s.Id AS SkillId
		,s.Name AS Skill
		,DATEDIFF(YEAR, emp.BirthDate, GETDATE()) AS Age
		,sss.IsCritical
		,sss.IsNeededInFuture
		,sss.PlanningRating
		,ss.Name AS SkillSet
		,es.Rating
		,es.DevelopmentOpportunity
		,bDiv.Name AS OccupationArea
		,ISNULL(loc.Name, '') AS Location
		,ISNULL(jGroup.GroupName, '') AS GroupName
		,ISNULL(jFam.FamName, '') AS FamName
		,ISNULL(jFunc.FuncName, '') AS FuncName
		,ISNULL(jLvl.LevelName, '') AS LevelName
		,CASE emp.Gender WHEN 2 THEN 'Female' ELSE 'Male' END AS Gender
	FROM tblEmployeeSkill es
	INNER JOIN tblSkill s ON es.SkillId = s.Id
	INNER JOIN tblSkillSetSkill sss ON es.SkillId = sss.SkillId
	INNER JOIN tblSkillSet ss ON sss.SkillSetId = ss.Id
	INNER JOIN vwEmplScen emp ON es.EmployeeId = emp.ID
	LEFT JOIN tblBusinessDiv bDiv ON emp.BusinessDiv = bDiv.BusinessDivID
	LEFT JOIN tblLocation loc ON emp.Location = loc.LocationID
	LEFT JOIN tblJobGroup jGroup ON emp.JobGroupID = jGroup.JobGroupID
	LEFT JOIN tblJobFam jFam ON emp.JobFamID = jFam.JobFamID
	LEFT JOIN tblJobFunc jFunc ON emp.JobFuncID = jFunc.JobFuncID
	LEFT JOIN tblJobLevel jLvl ON emp.JobLevID = jLvl.JobLevID
	ORDER BY emp.Id

END