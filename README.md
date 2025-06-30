private async Task<bool> ValidateCredentials(string username, string password)
{
    var client = _httpClientFactory.CreateClient();

    var apiUrl = "https://servicesdev.juscoltd.com/ADService/API/ADID/ADService";
    var apiKeyName = "x-api-key";  // Replace with actual API key header name
    var apiKeyValue = "your-api-key-here";  // Replace with actual API key value

    // Hardcoded values for testing
    var requestBody = new
    {
        Domain = "tatasteel",
        PNo = "AEUPC9300H",
        Password = "jusco@4321"
    };

    var jsonContent = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json");

    client.DefaultRequestHeaders.Add(apiKeyName, apiKeyValue);

    try
    {
        var response = await client.PostAsync(apiUrl, jsonContent);

        if (response.IsSuccessStatusCode)
        {
            // Optionally inspect response JSON here
            return true;
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }

    return false;
}
