using System.Threading.Tasks;

namespace E_GATEWAY.Contract
{
    public interface ISubscriptionClientRepository
    {
        Task<int> InsertClientAsync(
            string firstName,
            string lastName,
            string email,
            string phone,
            string address,
            int packageId,
            int schoolTypeId,
            bool paymentCompleted,
            string paymentMethod,
            decimal amountSubscription
        );
    }
}
