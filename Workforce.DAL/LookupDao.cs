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

        public List<SkillSetSkill> GetSkills(int setId)
        {
            var employeeSkills = dc.tblEmployeeSkills.ToList();
            return dc.tblSkillSetSkills
                .Where(s => s.SkillSetId == setId)
                .Select(s => SkillSetSkill.Load(s, employeeSkills))
                .ToList();
        }

        public List<SkillSetSkill> GetSkills()
        {
            var employeeSkills = dc.tblEmployeeSkills.ToList();
            return dc.tblSkillSetSkills.Select(s => SkillSetSkill.Load(s, employeeSkills)).ToList();
        }

        public List<Skill> GetSkillNames()
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
