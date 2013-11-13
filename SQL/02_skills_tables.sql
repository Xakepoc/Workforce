CREATE TABLE [dbo].[tblEmployeeSkill](
	[EmployeeId] [int] NOT NULL,
	[SkillId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[DevelopmentOpportunity] [bit] NULL,
 CONSTRAINT [PK_tblEmployeeSkill] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC,
	[SkillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tblSkill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[IsCritical] [bit] NOT NULL,
	[IsNeededInFuture] [bit] NULL,
	[PlanningRating] [int] NULL,
 CONSTRAINT [PK_tblSkill] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tblSkillSet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
 CONSTRAINT [PK_tblSkillSet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[tblSkillSetSkill](
	[SkillSetId] [int] NOT NULL,
	[SkillId] [int] NOT NULL,
 CONSTRAINT [PK_tblSkillSetSkill] PRIMARY KEY CLUSTERED 
(
	[SkillSetId] ASC,
	[SkillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[tblEmployeeSkill]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeSkill_tblEmployee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployee] ([ID])
GO

ALTER TABLE [dbo].[tblEmployeeSkill] CHECK CONSTRAINT [FK_EmployeeSkill_tblEmployee]
GO

ALTER TABLE [dbo].[tblEmployeeSkill]  WITH CHECK ADD  CONSTRAINT [FK_tblEmployeeSkill_tblSkill] FOREIGN KEY([SkillId])
REFERENCES [dbo].[tblSkill] ([Id])
GO

ALTER TABLE [dbo].[tblEmployeeSkill] CHECK CONSTRAINT [FK_tblEmployeeSkill_tblSkill]
GO

ALTER TABLE [dbo].[tblSkillSetSkill]  WITH CHECK ADD  CONSTRAINT [FK_tblSkillSetSkill_tblSkill] FOREIGN KEY([SkillId])
REFERENCES [dbo].[tblSkill] ([Id])
GO

ALTER TABLE [dbo].[tblSkillSetSkill] CHECK CONSTRAINT [FK_tblSkillSetSkill_tblSkill]
GO

ALTER TABLE [dbo].[tblSkillSetSkill]  WITH CHECK ADD  CONSTRAINT [FK_tblSkillSetSkill_tblSkillSet] FOREIGN KEY([SkillSetId])
REFERENCES [dbo].[tblSkillSet] ([Id])
GO

ALTER TABLE [dbo].[tblSkillSetSkill] CHECK CONSTRAINT [FK_tblSkillSetSkill_tblSkillSet]
GO


