using Workforce.DAL.linq2sql;

namespace Workforce.DAL
{
    public abstract class BaseDao
    {
        protected DataModelDataContext dc
        {
            get { return DataModelDataContext.instance; }
        }
    }
}
