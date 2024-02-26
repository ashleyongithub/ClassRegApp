using Microsoft.AspNetCore.Mvc;
using ClassRegApp.Web.Services;

namespace ClassRegApp.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly RegistrationApiService _apiService;

        public HomeController(ILogger<HomeController> logger, RegistrationApiService apiService)
        {
            _logger = logger;
            _apiService = apiService;
        }

        public async Task<IActionResult> Index()
        {
            try
            {
                var registrations = await _apiService.GetRegistrationsAsync();
                return View(registrations);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retreiving data from API");
                return View("Error");
            }
        }
    }
}
