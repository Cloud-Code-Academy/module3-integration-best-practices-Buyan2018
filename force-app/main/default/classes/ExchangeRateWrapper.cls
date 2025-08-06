/**
 * @description Wrapper class to deserialize the JSON response from the Exchange Rate API
 * Students will implement the properties and methods to process the data
 */
public class ExchangeRateWrapper {
    private static final String UNDERSCORE = '_';
    private static final String SPACE = ' ';
    // TODO: Implement properties to match the JSON structure of the API response
    // Sample response:
    // {
    //   "base_code": "USD",
    //   "time_last_update_unix": 1740690001,
    //   "conversion_rates": {
    //     "EUR": 0.9488,
    //     "GBP": 0.8393,
    //     "JPY": 136.57,
    //     ...
    //   }
    // }
    
    // Add properties for base currency
    // public String base_code;
    public String base_code;
    // Add property for time last updated
    // public String time_last_update_unix;
    public String time_last_update_unix;
    // Add property for rates (using a map)
    // public Map<String, Decimal> conversion_rates;
    public Map<String, Decimal> conversion_rates;
    // Add property for external ID
    // This is an ID you will generate to uniquely identify the exchange rate record
    // This does not come from the API response
    // public String externalId; baseCurrency + '_' + targetCurrency

    /**
     * @description Converts the wrapper data to a list of Exchange_Rate__c records
     * @return List<Exchange_Rate__c> The list of exchange rate records
     */
    public List<Exchange_Rate__c> toExchangeRates() {
        // TODO: Implement the method to convert the wrapper data to Exchange_Rate__c records
        // 1. Create a list to hold the Exchange_Rate__c records
        // 2. Iterate through the rates map
        // 3. For each rate, create an Exchange_Rate__c record
        // 4. Return the list of records
        List<Exchange_Rate__c> exchRatesForUpsert = new List<Exchange_Rate__c>();
        ExchangeRateWrapper exchangeRate = ExchangeRateService.getLatestRates();
        for (String convRate : exchangeRate.conversion_rates.keySet()) {
            Exchange_Rate__c exchRate = new Exchange_Rate__c();
            exchRate.Base_Currency__c = exchangeRate.base_code;
            exchRate.Name = exchangeRate.base_code + SPACE + convRate;
            exchRate.External_Id__c = exchangeRate.base_code + UNDERSCORE + convRate;
            exchRate.Rate__c = exchangeRate.conversion_rates.get(convRate);
            exchRate.Target_Currency__c = convRate;
            Long timeStamp = Long.valueOf(exchangeRate.time_last_update_unix);
            exchRate.Last_Updated__c =Datetime.newInstance(timeStamp);
            exchRatesForUpsert.add(exchRate);
        }
        return exchRatesForUpsert; // Replace with actual implementation
    }
    
    /**
     * @description Static method to parse the JSON response into the wrapper class
     * @param jsonResponse The JSON response from the API
     * @return ExchangeRateWrapper The parsed wrapper instance
     */
    public static ExchangeRateWrapper parse(String jsonResponse) {
        // TODO: Implement the method to parse the JSON response
        // Use JSON.deserialize or JSON.deserializeStrict to parse the response
        ExchangeRateWrapper rateData = (ExchangeRateWrapper)JSON.deserialize
                                            (jsonResponse, ExchangeRateWrapper.class);
        return rateData; // Replace with actual implementation
    }
}