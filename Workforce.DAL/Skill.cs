using System.Collections.Generic;
using System.Linq;
using Workforce.DAL.linq2sql;

namespace Workforce.DAL
{
    public class Skill
    {
        public int Id { get; set; }
        public string Name { get; set; }

        private List<EmployeeSkill> EmployeeSkills { get; set; }

        public double Fulfillment
        {
            get { return EmployeeSkills.Select(arg => (double)arg.Rating).Average(); }
        }

        public static Skill Load(tblSkill item)
        {
            var dao = new LookupDao();
            return new Skill
                       {
                           Id = item.Id,
                           Name = item.Name,
                           EmployeeSkills = dao.GetEmployeeSkills(item.Id)
                       };
        }

        public static Skill Load(tblSkill item, List<tblEmployeeSkill> employeeSkills)
        {
            return new Skill
            {
                Id = item.Id,
                Name = item.Name,
                EmployeeSkills = employeeSkills.Where(arg => arg.SkillId == item.Id).Select(EmployeeSkill.Load).ToList()
            };
        }
    }
}
