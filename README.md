[HttpGet]
public async Task<IActionResult> GetAll(
    [FromQuery] DateTime fromDate, 
    [FromQuery] DateTime toDate, 
    [FromQuery] int page = 1, 
    [FromQuery] int pageSize = 100)
{
    try
    {
        string query = @"
        SELECT 
            W.LocationCode AS Loc_Code,
            W.LocationNM AS Loc_Name,
            W.AadharNo,
            ...
        FROM App_WagesDetailsJharkhand W
        WHERE 
            CONCAT(W.YearWage, '-', RIGHT('0' + CAST(W.MonthWage AS VARCHAR(2)), 2), '-01') 
            BETWEEN @FromDate AND @ToDate
        ORDER BY W.YearWage, W.MonthWage
        OFFSET @PageSize * (@Page - 1) ROWS 
        FETCH NEXT @PageSize ROWS ONLY";

        using (var connection = new SqlConnection(_connectionString))
        {
            var parameters = new { FromDate = fromDate, ToDate = toDate, Page = page, PageSize = pageSize };
            var result = await connection.QueryAsync(query, parameters);

            return Ok(result);
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine("Error: " + ex.Message);
        return StatusCode(500, new { Message = "An error occurred.", Details = ex.Message });
    }
}
