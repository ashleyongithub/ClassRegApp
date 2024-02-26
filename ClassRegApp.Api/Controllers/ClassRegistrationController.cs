using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ClassRegApp.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClassRegistrationController : ControllerBase
    {
        private readonly ILogger<ClassRegistrationController> _logger;
        private readonly ClassRegDbContext _dbContext;

        public ClassRegistrationController( ClassRegDbContext dbContext, ILogger<ClassRegistrationController> logger)
        {
            _logger = logger;
            _dbContext = dbContext;
        }

        [HttpGet(Name = "GetClassRegistrationReport")]
        public async Task<ActionResult<string>> GetClassRegistrationReport()
        {
            try
            {
                var report = await _dbContext.ClassRegistrationReport
                    .FromSqlRaw("EXEC ClassRegistrationReport")
                    .ToListAsync();
                return new JsonResult(report);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retreiving data from database");
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
