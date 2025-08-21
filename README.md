protected void C3_Records_Grid_RowDataBound(object sender, GridViewRowEventArgs e)
{
    if (e.Row.RowType == DataControlRowType.DataRow ||
        e.Row.RowType == DataControlRowType.Header)
    {
        // Assuming ID is the first column in your SELECT
        e.Row.Cells[0].Visible = false;
    }
}
