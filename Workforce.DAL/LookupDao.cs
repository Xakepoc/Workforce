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
    }
}
