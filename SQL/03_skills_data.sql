INSERT INTO tblSkill VALUES ('Thinks strategically', 0, 0, NULL)
INSERT INTO tblSkill VALUES ('Develops people and organization', 1, 0, NULL)
INSERT INTO tblSkill VALUES ('Drives performance', 0, 0, NULL)
INSERT INTO tblSkill VALUES ('Manages change', 1, 0, NULL)
INSERT INTO tblSkill VALUES ('Collaborates well', 1, 0, NULL)
INSERT INTO tblSkill VALUES ('Motivates others', 0, 0, NULL)
INSERT INTO tblSkill VALUES ('Makes timely decisions', 1, 0, NULL)

INSERT INTO tblSkill VALUES ('Customer relationship management', 0, 0, NULL)
INSERT INTO tblSkill VALUES ('Pricing models', 1, 0, NULL)
INSERT INTO tblSkill VALUES ('Productivity modelling', 1, 0, NULL)
INSERT INTO tblSkill VALUES ('Product development and engineering', 0, 0, NULL)
INSERT INTO tblSkill VALUES ('Sales planning', 1, 0, NULL)
INSERT INTO tblSkill VALUES ('Cost modelling', 0, 0, NULL)
INSERT INTO tblSkill VALUES ('Marketing strategies', 1, 0, NULL)

GO

INSERT INTO tblSkillSet VALUES ('Leadership')
INSERT INTO tblSkillSet VALUES ('Commercial')

GO

INSERT INTO tblSkillSetSkill VALUES (1, 1)
INSERT INTO tblSkillSetSkill VALUES (1, 2)
INSERT INTO tblSkillSetSkill VALUES (1, 3)
INSERT INTO tblSkillSetSkill VALUES (1, 4)
INSERT INTO tblSkillSetSkill VALUES (1, 5)
INSERT INTO tblSkillSetSkill VALUES (1, 6)
INSERT INTO tblSkillSetSkill VALUES (1, 7)

INSERT INTO tblSkillSetSkill VALUES (2, 8)
INSERT INTO tblSkillSetSkill VALUES (2, 9)
INSERT INTO tblSkillSetSkill VALUES (2, 10)
INSERT INTO tblSkillSetSkill VALUES (2, 11)
INSERT INTO tblSkillSetSkill VALUES (2, 12)
INSERT INTO tblSkillSetSkill VALUES (2, 13)
INSERT INTO tblSkillSetSkill VALUES (2, 14)

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
			WHEN t.Rating >=3 
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

CREATE PROCEDURE dbo.spGetEmployeeSkills
AS
BEGIN

	SELECT
		 emp.ID
		,s.Name AS Skill
		,s.IsCritical
		,s.IsNeededInFuture
		,s.PlanningRating
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