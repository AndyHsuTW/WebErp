using System;
using System.Data.SqlClient;

namespace ErpBaseLibrary.DB
{
    public static class SqlParameterExtend
    {
        /// <summary>
        /// Allow insert null value
        /// </summary>
        /// <param name="parameters"></param>
        /// <param name="parameterName"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public static SqlParameter AddWithValueSafe(this SqlParameterCollection parameters, string parameterName, object value)
        {
            return parameters.AddWithValue(parameterName, value ?? DBNull.Value);
        }

        public static SqlParameter AddWithValueDatetimeSafe(this SqlParameterCollection parameters, string parameterName,
                                                            DateTime value)
        {
            if (default(DateTime) == value)
            {
                return parameters.AddWithValue(parameterName, DBNull.Value);
            }
            else
            {
                return parameters.AddWithValue(parameterName, value);
            }
        }
    }

}
