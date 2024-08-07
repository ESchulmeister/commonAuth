using System;
using System.Collections.Generic;
using System.Data;

namespace DTB.Authentication
{
    // This class is marked as internal so the component can be delivered as a single assembly.
    
    internal static class DbExtensions
    {
        #region Methods

        #region ReadColumn overloads

        #region IDataReader

        #region By Name
        public static string ReadColumn(this IDataReader oIDataReader, string sName)
        {
            return oIDataReader.ReadColumn(sName, String.Empty);
        }
        public static string ReadColumn(this IDataReader oIDataReader, string sName, string sDefault)
        {
            return oIDataReader.ReadColumn<string>(sName, sDefault);
        }
        public static int ReadColumn(this IDataReader oIDataReader, string sName, int iDefault)
        {
            return oIDataReader.ReadColumn<int>(sName, iDefault);
        }
        public static int? ReadColumn(this IDataReader oIDataReader, string sName, int? iDefault)
        {
            int iValue = oIDataReader.ReadColumn<int>(sName, (iDefault == null) ? int.MinValue : iDefault.Value);
            return (iValue == int.MinValue) ? iDefault : (int?)iValue;
        }
        public static short ReadColumn(this IDataReader oIDataReader, string sName, short shDefault)
        {
            return oIDataReader.ReadColumn<short>(sName, shDefault);
        }
        public static short? ReadColumn(this IDataReader oIDataReader, string sName, short? shDefault)
        {
            short shValue = oIDataReader.ReadColumn<short>(sName, (shDefault == null) ? short.MinValue : shDefault.Value);
            return (shValue == short.MinValue) ? shDefault : (short?)shValue;
        }
        public static bool ReadColumn(this IDataReader oIDataReader, string sName, bool bDefault)
        {
            return oIDataReader.ReadColumn<bool>(sName, bDefault);
        }
        public static bool? ReadColumn(this IDataReader oIDataReader, string sName, bool? bDefault)
        {
            return oIDataReader.ReadColumn<bool>(sName, (bDefault == null) ? false : bDefault.Value);
        }

        public static double ReadColumn(this IDataReader oIDataReader, string sName, double dDefault, int iDecimals = int.MinValue)
        {
            double dOutput = oIDataReader.ReadColumn<double>(sName, dDefault);

            return (dOutput == double.MinValue || iDecimals == int.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static double? ReadColumn(this IDataReader oIDataReader, string sName, double? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = double.MinValue;
            }
            double dOutput = oIDataReader.ReadColumn(sName, dDefault.Value, iDecimals);

            return (dOutput == double.MinValue) ? dDefault : (double?)dOutput;
        }
        public static float ReadColumn(this IDataReader oIDataReader, string sName, float fDefault)
        {
            return oIDataReader.ReadColumn<float>(sName, fDefault);
        }
        public static float? ReadColumn(this IDataReader oIDataReader, string sName, float? fDefault)
        {
            float iValue = oIDataReader.ReadColumn<float>(sName, (fDefault == null) ? float.MinValue : fDefault.Value);
            return (iValue == float.MinValue) ? fDefault : (float?)iValue;
        }

        public static decimal ReadColumn(this IDataReader oIDataReader, string sName, decimal dDefault, int iDecimals = int.MinValue)
        {
            decimal dOutput = oIDataReader.ReadColumn<decimal>(sName, dDefault);

            return (dOutput == decimal.MinValue || iDecimals == int.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static decimal? ReadColumn(this IDataReader oIDataReader, string sName, decimal? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = decimal.MinValue;
            }
            decimal dOutput = oIDataReader.ReadColumn(sName, dDefault.Value, iDecimals);

            return (dOutput == decimal.MinValue) ? dDefault : (decimal?)dOutput;
        }
        public static DateTime ReadColumn(this IDataReader oIDataReader, string sName, DateTime dtDefault)
        {
            return oIDataReader.ReadColumn<DateTime>(sName, dtDefault);
        }

        public static T ReadColumn<T>(this IDataReader oIDataReader, string sName, T oDefault)
        {
            if (!oIDataReader.HasColumn(sName))
            {
                return oDefault;
            }

            return DbExtensions.ReadColumnValue<T>(oIDataReader[sName], oDefault);
        }
        #endregion

        #region By Position
        public static decimal ReadColumn(this IDataReader oIDataReader, int iPosition, decimal iDefault, int iDecimals = int.MinValue)
        {
            decimal dOutput = DbExtensions.ReadColumnValue<decimal>(oIDataReader[iPosition], iDefault);

            return (dOutput == decimal.MinValue || iDefault == int.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static decimal? ReadColumn(this IDataReader oIDataReader, int iPosition, decimal? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = decimal.MinValue;
            }
            decimal dOutput = oIDataReader.ReadColumn(iPosition, dDefault.Value, iDecimals);

            return (dOutput == decimal.MinValue) ? dDefault : (decimal?)dOutput;
        }

        public static double ReadColumn(this IDataReader oIDataReader, int iPosition, double dDefault, int iDecimals = int.MinValue)
        {
            double dOutput = DbExtensions.ReadColumnValue<double>(oIDataReader[iPosition], dDefault);

            return (dOutput == double.MinValue || dDefault == double.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static double? ReadColumn(this IDataReader oIDataReader, int iPosition, double? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = double.MinValue;
            }
            double dOutput = oIDataReader.ReadColumn(iPosition, dDefault.Value, iDecimals);

            return (dOutput == double.MinValue) ? dDefault : (double?)dOutput;
        }

        public static float ReadColumn(this IDataReader oIDataReader, int iPosition, float fDefault)
        {
            return DbExtensions.ReadColumnValue<float>(oIDataReader[iPosition], fDefault);
        }
        public static float? ReadColumn(this IDataReader oIDataReader, int iPosition, float? fDefault)
        {
            float fValue = DbExtensions.ReadColumnValue<float>(oIDataReader[iPosition], (fDefault == null) ? float.MinValue : fDefault.Value);
            return (fValue == float.MinValue) ? fDefault : (float?)fValue;
        }

        public static int ReadColumn(this IDataReader oIDataReader, int iPosition, int iDefault)
        {
            return DbExtensions.ReadColumnValue<int>(oIDataReader[iPosition], iDefault);
        }
        public static int? ReadColumn(this IDataReader oIDataReader, int iPosition, int? iDefault)
        {
            int iValue = DbExtensions.ReadColumnValue<int>(oIDataReader[iPosition], (iDefault == null) ? int.MinValue : iDefault.Value);
            return (iValue == int.MinValue) ? iDefault : (int?)iValue;
        }
        public static long ReadColumn(this IDataReader oIDataReader, int iPosition, long lDefault)
        {
            return DbExtensions.ReadColumnValue<long>(oIDataReader[iPosition], lDefault);
        }
        public static long? ReadColumn(this IDataReader oIDataReader, int iPosition, long? lDefault)
        {
            long lValue = DbExtensions.ReadColumnValue<long>(oIDataReader[iPosition], (lDefault == null) ? long.MinValue : lDefault.Value);
            return (lValue == long.MinValue) ? lDefault : (long?)lValue;
        }

        public static short ReadColumn(this IDataReader oIDataReader, short iPosition, short shDefault)
        {
            return DbExtensions.ReadColumnValue<short>(oIDataReader[iPosition], shDefault);
        }
        public static short? ReadColumn(this IDataReader oIDataReader, int iPosition, short? shDefault)
        {
            short shValue = DbExtensions.ReadColumnValue<short>(oIDataReader[iPosition], (shDefault == null) ? short.MinValue : shDefault.Value);
            return (shValue == short.MinValue) ? shDefault : (short?)shValue;
        }

        public static DateTime ReadColumn(this IDataReader oIDataReader, int iPosition, DateTime dtDefault)
        {
            return DbExtensions.ReadColumnValue<DateTime>(oIDataReader[iPosition], dtDefault);
        }
        public static DateTime? ReadColumn(this IDataReader oIDataReader, int iPosition, DateTime? dtDefault)
        {
            DateTime dtValue = DbExtensions.ReadColumnValue<DateTime>(oIDataReader[iPosition], (dtDefault == null) ? DateTime.MinValue : dtDefault.Value);
            return (dtValue == DateTime.MinValue) ? dtDefault : (DateTime?)dtValue;
        }

        public static string ReadColumn(this IDataReader oIDataReader, int iPosition, string sDefault)
        {
            return DbExtensions.ReadColumnValue<string>(oIDataReader[iPosition], sDefault);
        }
        #endregion

        public static bool HasColumn(this IDataReader oIDataReader, string sName)
        {
            for (int iColumn = 0; iColumn < oIDataReader.FieldCount; iColumn++)
            {
                string sColumnName = oIDataReader.GetName(iColumn);
                if (String.Compare(sColumnName, sName, true) == 0)
                {
                    return true;
                }
            }

            return false;
        }
        #endregion

        #region DataRow
        public static int ReadColumn(this DataRow oDataRow, string sName)
        {
            return oDataRow.ReadColumn(sName, int.MinValue);
        }

        public static string ReadColumn(this DataRow oDataRow, string sName, string sDefault)
        {
            return oDataRow.ReadColumn<string>(sName, sDefault);
        }
        public static int ReadColumn(this DataRow oDataRow, string sName, int iDefault)
        {
            return oDataRow.ReadColumn<int>(sName, iDefault);
        }
        public static int? ReadColumn(this DataRow oDataRow, string sName, int? iDefault)
        {
            int iValue = oDataRow.ReadColumn<int>(sName, (iDefault == null) ? int.MinValue : iDefault.Value);
            return (iValue == int.MinValue) ? iDefault : (int?)iValue;
        }
        public static long ReadColumn(this DataRow oDataRow, string sName, long lDefault)
        {
            return oDataRow.ReadColumn<long>(sName, lDefault);
        }
        public static long? ReadColumn(this DataRow oDataRow, string sName, long? lDefault)
        {
            long lValue = oDataRow.ReadColumn<long>(sName, (lDefault == null) ? long.MinValue : lDefault.Value);
            return (lValue == long.MinValue) ? lDefault : (long?)lValue;
        }
        public static short ReadColumn(this DataRow oDataRow, string sName, short shDefault)
        {
            return oDataRow.ReadColumn<short>(sName, shDefault);
        }
        public static short? ReadColumn(this DataRow oDataRow, string sName, short? shDefault)
        {
            short shValue = oDataRow.ReadColumn<short>(sName, (shDefault == null) ? short.MinValue : shDefault.Value);
            return (shValue == short.MinValue) ? shDefault : (short?)shValue;
        }
        public static bool ReadColumn(this DataRow oDataRow, string sName, bool bDefault)
        {
            return oDataRow.ReadColumn<bool>(sName, bDefault);
        }
        public static bool? ReadColumn(this DataRow oDataRow, string sName, bool? bDefault)
        {
            bool bValue = oDataRow.ReadColumn<bool>(sName, (bDefault == null) ? false : bDefault.Value);
            return (bool?)bValue;
        }
        public static decimal ReadColumn(this DataRow oDataRow, string sName, decimal dDefault)
        {
            return oDataRow.ReadColumn<decimal>(sName, dDefault);
        }
        public static decimal? ReadColumn(this DataRow oDataRow, string sName, decimal? dDefault)
        {
            decimal dValue = oDataRow.ReadColumn<decimal>(sName, (dDefault == null) ? decimal.MinValue : dDefault.Value);
            return (dValue == decimal.MinValue) ? dDefault : (decimal?)dValue;
        }
        public static double ReadColumn(this DataRow oDataRow, string sName, double dDefault, int iDecimals = int.MinValue)
        {
            double dOutput = oDataRow.ReadColumn<double>(sName, dDefault);

            return (dOutput == double.MinValue || iDecimals == int.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static double? ReadColumn(this DataRow oDataRow, string sName, double? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = double.MinValue;
            }
            double dOutput = oDataRow.ReadColumn(sName, dDefault.Value, iDecimals);

            return (dOutput == double.MinValue) ? dDefault : (double?)dOutput;
        }
        public static decimal ReadColumn(this DataRow oDataRow, string sName, decimal dDefault, int iDecimals = int.MinValue)
        {
            decimal dOutput = oDataRow.ReadColumn<decimal>(sName, dDefault);

            return (dOutput == decimal.MinValue || iDecimals == int.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static decimal? ReadColumn(this DataRow oDataRow, string sName, decimal? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = decimal.MinValue;
            }
            decimal dOutput = oDataRow.ReadColumn(sName, dDefault.Value, iDecimals);

            return (dOutput == decimal.MinValue) ? dDefault : (decimal?)dOutput;
        }

        public static float ReadColumn(this DataRow oDataRow, string sName, float fDefault)
        {
            return oDataRow.ReadColumn<float>(sName, fDefault);
        }
        public static float? ReadColumn(this DataRow oDataRow, string sName, float? fDefault)
        {
            float fValue = oDataRow.ReadColumn<float>(sName, (fDefault == null) ? float.MinValue : fDefault.Value);
            return (fValue == float.MinValue) ? fDefault : (float?)fValue;
        }
        public static DateTime ReadColumn(this DataRow oDataRow, string sName, DateTime dtDefault)
        {
            return oDataRow.ReadColumn<DateTime>(sName, dtDefault);
        }
        public static DateTime? ReadColumn(this DataRow oDataRow, string sName, DateTime? dtDefault)
        {
            DateTime dtValue = oDataRow.ReadColumn<DateTime>(sName, (dtDefault == null) ? DateTime.MinValue : dtDefault.Value);
            return (dtValue == DateTime.MinValue) ? dtDefault : (DateTime?)dtValue;
        }

        public static T ReadColumn<T>(this DataRow oDataRow, string sName, T oDefault)
        {
            if (!oDataRow.Table.Columns.Contains(sName))
            {
                return oDefault;
            }

            return DbExtensions.ReadColumnValue<T>(oDataRow[sName], oDefault);
        }

        public static decimal ReadColumn(this DataRow oDataRow, int iPosition, decimal dDefault, int iDecimals = int.MinValue)
        {
            decimal dOutput = DbExtensions.ReadColumnValue<decimal>(oDataRow[iPosition], dDefault);

            return (dOutput == decimal.MinValue || iDecimals == int.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static decimal? ReadColumn(this DataRow oDataRow, int iPosition, decimal? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = decimal.MinValue;
            }
            decimal dOutput = oDataRow.ReadColumn(iPosition, dDefault.Value, iDecimals);

            return (dOutput == decimal.MinValue) ? dDefault : (decimal?)dOutput;
        }

        public static double ReadColumn(this DataRow oDataRow, int iPosition, double dDefault, int iDecimals = int.MinValue)
        {
            double dOutput = DbExtensions.ReadColumnValue<double>(oDataRow[iPosition], dDefault);

            return (dOutput == double.MinValue || iDecimals == int.MinValue) ? dOutput : Math.Round(dOutput, iDecimals, MidpointRounding.AwayFromZero);
        }
        public static double? ReadColumn(this DataRow oDataRow, int iPosition, double? dDefault, int iDecimals = int.MinValue)
        {
            if (dDefault == null)
            {
                dDefault = double.MinValue;
            }
            double dOutput = oDataRow.ReadColumn(iPosition, dDefault.Value, iDecimals);

            return (dOutput == double.MinValue) ? dDefault : (double?)dOutput;
        }

        public static float ReadColumn(this DataRow oDataRow, int iPosition, float fDefault)
        {
            return DbExtensions.ReadColumnValue<float>(oDataRow[iPosition], fDefault);
        }
        public static float? ReadColumn(this DataRow oDataRow, int iPosition, float? fDefault)
        {
            float fValue = DbExtensions.ReadColumnValue<float>(oDataRow[iPosition], (fDefault == null) ? float.MinValue : fDefault.Value);
            return (fValue == float.MinValue) ? fDefault : (float?)fValue;
        }

        public static int ReadColumn(this DataRow oDataRow, int iPosition, int iDefault)
        {
            return DbExtensions.ReadColumnValue<int>(oDataRow[iPosition], iDefault);
        }
        public static int? ReadColumn(this DataRow oDataRow, int iPosition, int? iDefault)
        {
            int iValue = DbExtensions.ReadColumnValue<int>(oDataRow[iPosition], (iDefault == null) ? int.MinValue : iDefault.Value);
            return (iValue == int.MinValue) ? iDefault : (int?)iValue;
        }
        public static long ReadColumn(this DataRow oDataRow, int iPosition, long lDefault)
        {
            return DbExtensions.ReadColumnValue<long>(oDataRow[iPosition], lDefault);
        }
        public static long? ReadColumn(this DataRow oDataRow, int iPosition, long? lDefault)
        {
            long lValue = DbExtensions.ReadColumnValue<long>(oDataRow[iPosition], (lDefault == null) ? long.MinValue : lDefault.Value);
            return (lValue == long.MinValue) ? lDefault : (long?)lValue;
        }

        public static short ReadColumn(this DataRow oDataRow, short iPosition, short shDefault)
        {
            return DbExtensions.ReadColumnValue<short>(oDataRow[iPosition], shDefault);
        }
        public static short? ReadColumn(this DataRow oDataRow, int iPosition, short? shDefault)
        {
            short shValue = DbExtensions.ReadColumnValue<short>(oDataRow[iPosition], (shDefault == null) ? short.MinValue : shDefault.Value);
            return (shValue == short.MinValue) ? shDefault : (short?)shValue;
        }

        public static DateTime ReadColumn(this DataRow oDataRow, int iPosition, DateTime dtDefault)
        {
            return DbExtensions.ReadColumnValue<DateTime>(oDataRow[iPosition], dtDefault);
        }
        public static DateTime? ReadColumn(this DataRow oDataRow, int iPosition, DateTime? dtDefault)
        {
            DateTime dtValue = DbExtensions.ReadColumnValue<DateTime>(oDataRow[iPosition], (dtDefault == null) ? DateTime.MinValue : dtDefault.Value);
            return (dtValue == DateTime.MinValue) ? dtDefault : (DateTime?)dtValue;
        }

        public static string ReadColumn(this DataRow oDataRow, int iPosition, string sDefault)
        {
            return DbExtensions.ReadColumnValue<string>(oDataRow[iPosition], sDefault);
        }

        public static T ReadColumnValue<T>(object oColValue, T oDefault)
        {
            if (oColValue == null || oColValue == System.DBNull.Value)
            {
                return oDefault;
            }

            T oReturnValue;
            try
            {
                oReturnValue = (T)oColValue;
            }
            catch (Exception)
            {
                return oDefault;
            }

            return oReturnValue;
        }

        public static void AssertRowCount(this DataTable oDataTable, int iExpectedRowCount, bool bAllowEmptyTable = true)
        {
            int iActualRowCount = oDataTable.Rows.Count;

            if (iActualRowCount == iExpectedRowCount)
            {
                return;
            }

            if (bAllowEmptyTable && (iActualRowCount == 0))
            {
                return;
            }

            throw new DataException(String.Format("{0} rows expected, {1} returned", iExpectedRowCount.ToString("#,##0"), iActualRowCount.ToString("#,##0")));
        }

        public static string[] TableNames(this DataSet oDataSet)
        {
            List<string> lstNames = new List<string>();
            foreach (DataTable oDataTable in oDataSet.Tables)
            {
                lstNames.Add(oDataTable.TableName);
            }

            return lstNames.ToArray();
        }

        public static DataRow[] SelectChildRows(this DataRow oDataRow, string sTableName, string sQuery)
        {
            DataSet oDataSet = oDataRow.Table.DataSet;
            if (oDataSet == null)
            {
                return new DataRow[] {};
            }

            DataTable oChildDataTable = oDataSet.Tables[sTableName];
            if (oChildDataTable == null)
            {
                return new DataRow[] {};
            }

            return oChildDataTable.Select(sQuery);
        }

        #endregion

        #endregion

        #endregion
    }

}
