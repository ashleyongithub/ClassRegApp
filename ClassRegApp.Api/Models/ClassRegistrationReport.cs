using System.ComponentModel.DataAnnotations;

namespace ClassRegApp.Api.Models
{
    public class ClassRegistrationReport
    {
        [Key]
        public string? Class { get; set; }
        public string? TeacherName { get; set; }
        public int Registrations  { get; set; }
        public int NumberPaid { get; set; }
    }
}
