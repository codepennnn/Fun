ReportParameter[] rp = new ReportParameter[]
{
    new ReportParameter("PeriodDisplay", displayPeriod)
};

ReportViewer1.LocalReport.SetParameters(rp);
ReportViewer1.LocalReport.Refresh();

=Parameters!PeriodDisplay.Value


