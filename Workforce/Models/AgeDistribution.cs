using System;
using System.Collections.Generic;
using System.Linq;
using Workforce.DAL;
using Workforce.DAL.linq2sql;

namespace Workforce.Models
{
    public class EmployeeRow
    {
        public int Id { get; set; }
        public int BirthYear { get; set; }
        public int CriticalYear { get; set; }
        public int PensionYear { get; set; }
        public DateTime BirthDate { get; set; }
        public DateTime PensionDate { get; set; }
        public string OccupationArea { get; set; }
        public string Location { get; set; }
        public string JobGroup { get; set; }
        public string JobFamily { get; set; }
        public string JobFunction { get; set; }
        public string JobLevel { get; set; }
        public string Gender { get; set; }
    }

    public class AgeDistribution
    {
        public List<spAgeDistributionResult> Results { get; private set; }
        public List<spAgeDistributionTotalsResult> Totals { get; private set; }
        public List<EmployeeRow> Employees { get; private set; }
        public List<string> JobFamilies { get; private set; }
        public List<string> JobFunctions { get; private set; }

        public AgeDistribution()
        {
            Results = new ReportDao().GetAgeDistribution(50);
            Totals = new ReportDao().GetAgeDistributionTotals(50);
            Employees = new ReportDao().GetEmployees(50)
                .Select(emp => new EmployeeRow
                                   {
                                       Id = emp.ID,
                                       BirthYear = emp.BirthYear ?? 0,
                                       CriticalYear = emp.CriticalYear ?? 0,
                                       PensionYear = emp.PensionYear ?? 0,
                                       BirthDate = emp.BirthDate.Value,
                                       PensionDate = emp.PensionDate.Value,
                                       OccupationArea = emp.OccupationArea,
                                       Location = emp.Location,
                                       JobGroup= emp.GroupName,
                                       JobFamily = emp.FamName,
                                       JobFunction = emp.FuncName,
                                       JobLevel = emp.LevelName,
                                       Gender = emp.Gender
                                   })
                .ToList();

            JobFamilies = new LookupDao().GetJobFamilies();
            JobFunctions = new LookupDao().GetJobFunctions();
        }

    }
}