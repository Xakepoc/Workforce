using Workforce.DAL.linq2sql;

namespace Workforce.DAL
{
    public class EmployeeSkill
    {
        public int EmployeeId { get; set; }
        public int SkillId { get; set; }
        public int Rating { get; set; }
        public bool DevelopmentOpportunity { get; set; }

        public static EmployeeSkill Load(tblEmployeeSkill item)
        {
            return new EmployeeSkill
                       {
                           EmployeeId = item.EmployeeId,
                           SkillId = item.SkillId,
                           Rating = item.Rating,
                           DevelopmentOpportunity = item.DevelopmentOpportunity ?? false
                       };
        }
    }
}
