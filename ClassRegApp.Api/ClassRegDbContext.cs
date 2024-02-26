using ClassRegApp.Api.Models;
using Microsoft.EntityFrameworkCore;

namespace ClassRegApp.Api
{
    public class ClassRegDbContext :DbContext
    {
        public ClassRegDbContext(DbContextOptions<ClassRegDbContext> options) : base(options)
        {
        }

        public DbSet<ClassRegistrationReport> ClassRegistrationReport { get; set; }
    }
}
