using ClassRegApp.Web.Models;
using System.Text.Json;

namespace ClassRegApp.Web.Services
{
    public class RegistrationApiService
    {
        private readonly HttpClient _httpClient;
        private readonly IConfiguration _configuration;

        public RegistrationApiService(IHttpClientFactory httpClientFactory, IConfiguration configuration)
        {
            _httpClient = httpClientFactory.CreateClient();
            _configuration = configuration;

            _httpClient.Timeout = TimeSpan.FromSeconds(20);
        }

        public async Task<List<ClassRegistration>> GetRegistrationsAsync()
        {
            try
            {
                var registrations = await _httpClient
                    .GetFromJsonAsync<List<ClassRegistration>>(_configuration["ClassRegApi:ClassRegistrationEndpoint"], 
                    new JsonSerializerOptions(JsonSerializerDefaults.Web));

                return registrations ?? new List<ClassRegistration>();
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving class registrations from the API.", ex);
            }
        }
    }
}
