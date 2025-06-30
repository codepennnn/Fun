private async Task<bool> ValidateCredentials(string username, string password)
{
    var client = _httpClientFactory.CreateClient();

    var apiUrl = "https://servicesdev.juscoltd.com/ADService/API/ADID/ADService";
    var apiKeyName = "x-api-key";  // Replace with your actual header name expected by the API
    var apiKeyValue = "your-api-key-here";  // Replace with your actual API key value

    // For testing, you can hardcode these values for API call
    username = "151514";
    password = "jusco@123";

    var requestBody = new
    {
        ADID = username,
        Password = password
    };

    var jsonContent = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json");

    client.DefaultRequestHeaders.Add(apiKeyName, apiKeyValue);

    try
    {
        var response = await client.PostAsync(apiUrl, jsonContent);

        if (response.IsSuccessStatusCode)
        {
            return true;
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.Message);
    }

    return false;
}
