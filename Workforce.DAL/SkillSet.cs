using System.Collections.Generic;
using Workforce.DAL.linq2sql;

namespace Workforce.DAL
{
    public class SkillSet
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<SkillSetSkill> Skills { get { return new LookupDao().GetSkills(Id); } }

        public static SkillSet Load(tblSkillSet item)
        {
            return new SkillSet {Id = item.Id, Name = item.Name};
        }
    }
}
