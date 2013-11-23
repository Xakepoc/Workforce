using System.Collections.Generic;
using System.Linq;
using Workforce.DAL.linq2sql;

namespace Workforce.DAL
{
    public class SkillSetSkill
    {
        public int SkillId { get; set; }
        public string Name { get; set; }
        public int SkillSetId { get; set; }
        //public SkillSet SkillSet { get; set; }
        public bool IsCritical { get; set; }
        public bool IsFuture { get; set; }
        public int PlanningRating { get; set; }

        private List<EmployeeSkill> EmployeeSkills { get; set; }

        public static SkillSetSkill Load(tblSkillSetSkill item)
        {
            return new SkillSetSkill
            {
                //SkillSet = SkillSet.Load(item.tblSkillSet),
                SkillId = item.SkillId,
                Name = item.tblSkill.Name,
                SkillSetId = item.SkillSetId,
                IsCritical = item.IsCritical,
                IsFuture = item.IsNeededInFuture ?? false,
                PlanningRating = item.PlanningRating ?? 0
            };
        }

        public static SkillSetSkill Load(tblSkillSetSkill item, List<tblEmployeeSkill> employeeSkills)
        {
            return new SkillSetSkill
            {
                //SkillSet = SkillSet.Load(item.tblSkillSet),
                SkillId = item.SkillId,
                Name = item.tblSkill.Name,
                SkillSetId = item.SkillSetId,
                IsCritical = item.IsCritical,
                IsFuture = item.IsNeededInFuture ?? false,
                PlanningRating = item.PlanningRating ?? 0,
                EmployeeSkills = employeeSkills.Where(arg => arg.SkillId == item.SkillId).Select(EmployeeSkill.Load).ToList()
            };
        }
    }
}
