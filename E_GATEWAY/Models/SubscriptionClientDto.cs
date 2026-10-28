using System.ComponentModel.DataAnnotations;

namespace E_GATEWAY.Models
{
    public class SubscriptionClientDto
    {
        [Required, MaxLength(100)]
        public string FirstName { get; set; }

        [Required, MaxLength(100)]
        public string LastName { get; set; }

        [Required, EmailAddress, MaxLength(255)]
        public string Email { get; set; }

        [MaxLength(45)]
        public string Phone { get; set; }

        [MaxLength(1000)]
        public string Address { get; set; }

        [Required]
        public int PackageId { get; set; }

        [Required]
        public int SchoolTypeId { get; set; }

        [Required]
        public bool PaymentCompleted { get; set; }

        [Required, MaxLength(20)]
        public string PaymentMethod { get; set; }

        [Required, Range(0, double.MaxValue)]
        public decimal AmountSubscription { get; set; }
    }
}
