using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using Workforce.DAL.linq2sql;

namespace Workforce.DAL
{
    public class LookupDao : BaseDao
    {
        public List<string> GetJobFamilies()
        {
            return (from f in dc.tblJobFams
                   join sc in dc.tblScenJobFams on f.JobFamID equals sc.JobFamID
                   where sc.ScenID == 1
                   select f.FamName).ToList();
        }

        public List<string> GetJobFunctions()
        {
            return (from f in dc.tblJobFuncs
                    join sc in dc.tblScenJobFuncs on f.JobFuncID equals sc.JobFuncID
                    where sc.ScenID == 1
                    select f.FuncName).ToList();
        }

        public List<tblScenAgeGrp> GetAgeGroups()
        {
            return dc.tblScenAgeGrps.Where(arg => arg.ScenID == 1).ToList();
        }

        public List<Skill> GetSkills(int setId)
        {
            var employeeSkills = dc.tblEmployeeSkills.ToList();
            return (from s in dc.tblSkills
                    join ss in dc.tblSkillSetSkills on s.Id equals ss.SkillId
                    where ss.SkillSetId == setId
                    select Skill.Load(s, employeeSkills))
                .ToList();
        }

        public List<Skill> GetSkills()
        {
            var employeeSkills = dc.tblEmployeeSkills.ToList();
            return dc.tblSkills.Select(s => Skill.Load(s, employeeSkills)).ToList();
        }

        public List<EmployeeSkill> GetEmployeeSkills(int skillId)
        {
            return dc.tblEmployeeSkills.Where(arg => arg.SkillId == skillId).Select(EmployeeSkill.Load).ToList();
        }

        public List<SkillSet> GetSkillSets()
        {
            return dc.tblSkillSets.Select(SkillSet.Load).ToList();
        }
    }
}
