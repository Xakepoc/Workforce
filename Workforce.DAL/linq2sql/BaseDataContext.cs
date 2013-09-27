using System.Configuration;
using System.Data;
using System.Data.Linq.Mapping;

namespace Workforce.DAL.linq2sql
{
    public abstract class BaseDataContext : System.Data.Linq.DataContext
    {
        protected BaseDataContext(string fileOrServerOrConnection)
            : base(GetContextConnectionString(fileOrServerOrConnection))
        {
        }
        protected BaseDataContext(string fileOrServerOrConnection, MappingSource mapping)
            : base(GetContextConnectionString(fileOrServerOrConnection), mapping)
        {
        }
        protected BaseDataContext(IDbConnection connection)
            : base(connection)
        {
        }
        protected BaseDataContext(IDbConnection connection, MappingSource mapping)
            : base(connection, mapping)
        {
        }
        private static string GetContextConnectionString(string fileOrServerOrConnection)
        {
            return ConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        }
    }
}
