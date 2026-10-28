using System;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;

namespace E_PAYMENT.Services
{

    public class EGatewayService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<EGatewayService> _logger;

        public EGatewayService(HttpClient httpClient, ILogger<EGatewayService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
        }

        
        public async Task<TResponse?> PostAsync<TRequest, TResponse>(string endpoint, TRequest payload)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync(endpoint, payload);

                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<TResponse>();
                }
                else
                {
                    _logger.LogError("Erreur lors de l'appel POST à {Endpoint}: {StatusCode} - {ReasonPhrase}",
                        endpoint, response.StatusCode, response.ReasonPhrase);
                    return default;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Exception lors de l'appel POST à {Endpoint}", endpoint);
                return default;
            }
        }
        public async Task<HttpResponseMessage> GetAsync(string endpoint)
        {
            try
            {
                var response = await _httpClient.GetAsync(endpoint);

                if (response.IsSuccessStatusCode)
                {
                    return response; // Retourner directement la réponse pour les cas spécifiques (image, binaire, etc.)
                }
                else
                {
                    _logger.LogError("Erreur lors de l'appel GET à {Endpoint}: {StatusCode} - {ReasonPhrase}",
                        endpoint, response.StatusCode, response.ReasonPhrase);
                    return null;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Exception lors de l'appel GET à {Endpoint}", endpoint);
                return null;
            }
        }

       
        public async Task<TResponse?> GetAsync<TResponse>(string endpoint)
        {
            try
            {
                var response = await _httpClient.GetAsync(endpoint);

                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<TResponse>();
                }
                else
                {
                    _logger.LogError("Erreur lors de l'appel GET à {Endpoint}: {StatusCode} - {ReasonPhrase}",
                        endpoint, response.StatusCode, response.ReasonPhrase);
                    return default;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Exception lors de l'appel GET à {Endpoint}", endpoint);
                return default;
            }
        }
    }

}
