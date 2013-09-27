using System.Web;

namespace Workforce.DAL.linq2sql
{
    public partial class DataModelDataContext
    {
        private const string Key = "Transportation.DAL.linq2sql.dc";
        private static DataModelDataContext _instance;
        public static DataModelDataContext instance
        {
            get
            {
                if (HttpContext.Current == null)
                    return _instance ?? (_instance = new DataModelDataContext(Properties.Settings.Default.WorkforceConnectionString));

                return
                    (DataModelDataContext)(HttpContext.Current.Items[Key] ??
                        (HttpContext.Current.Items[Key] = new DataModelDataContext(Properties.Settings.Default.WorkforceConnectionString)));
            }
        }
    }
}
