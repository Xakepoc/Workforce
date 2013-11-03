using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using Workforce.DAL.linq2sql;

namespace Workforce.DAL
{
    public class ReportDao : BaseDao
    {
        public List<spGetEmployeesResult> GetEmployees(int critAge)
        {
            return dc.spGetEmployees(critAge).ToList();
        }
    }
}
