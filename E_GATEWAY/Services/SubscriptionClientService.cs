using E_GATEWAY.Contract;


namespace E_GATEWAY.Services
{
    public class SubscriptionClientService : ISubscriptionClientService
    {
        private readonly ISubscriptionClientRepository _repository;

        public SubscriptionClientService(ISubscriptionClientRepository repository)
        {
            _repository = repository;
        }

        public async Task<int> AddSubscriptionClientAsync(
            string firstName,
            string lastName,
            string email,
            string phone,
            string address,
            int packageId,
            int schoolTypeId,
            bool paymentCompleted,
            string paymentMethod,
            decimal amountSubscription)
        {
            return await _repository.InsertClientAsync(
                firstName,
                lastName,
                email,
                phone,
                address,
                packageId,
                schoolTypeId,
                paymentCompleted,
                paymentMethod,
                amountSubscription
            );
        }
    }
}
