namespace E_GATEWAY.Contract
{
    public interface ISubscriptionClientService
    {
        Task<int> AddSubscriptionClientAsync(
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
