/**
 * @description Service class that handles API callouts to the Exchange Rate API
 * Students will implement the methods to make callouts and process responses
 */
public class ExchangeRateService {
    
    // The named credential to use for the callout
    private static final String NAMED_CREDENTIAL = 'callout:ExchangeRate_API';
    
    // The base currency to use for exchange rates
    private static final String BASE_CURRENCY = '/USD';
    private static final String LATEST = '/latest';
    private static final String GET_METHOD = 'GET';
    private static final Integer INITIAL_SUCCESS_CODE = 200;
    private static final Integer END_SUCCESS_CODE = 299;
    private static final String UNDERSCORE = '_';
    private static final String SPACE = ' ';
    /**
     * @description Makes a callout to the Exchange Rate API to get the latest exchange rates
     * @return ExchangeRateWrapper containing the response data
     */
    public static ExchangeRateWrapper getLatestRates() {
        // TODO: Implement the method to make a callout to the Exchange Rate API
        ExchangeRateWrapper rateData;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(NAMED_CREDENTIAL + LATEST + BASE_CURRENCY);
        req.setMethod(GET_METHOD);
        Http http = new Http();
        HttpResponse res = http.send(req);
        Integer statusCode = res.getStatusCode();
        String jsonResponse = res.getBody();
        if (statusCode >= INITIAL_SUCCESS_CODE && statusCode <= END_SUCCESS_CODE) {
                rateData = ExchangeRateWrapper.parse(jsonResponse);
        } else {
            throw new CalloutException('Error: callout failed');
        }
        return rateData; // Replace with actual implementation
    }
    
    /**
     * @description Processes the exchange rate data and creates or updates records
     * @param rateData The wrapper containing exchange rate data
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> processRates(ExchangeRateWrapper rateData) {
        // TODO: Implement the method to process rates and create/update records
        List<Exchange_Rate__c> exchRatesForUpsert = new List<Exchange_Rate__c>();
        for (String convRate : rateData.conversion_rates.keySet()) {
            Exchange_Rate__c exchRate = new Exchange_Rate__c();
            exchRate.Base_Currency__c = rateData.base_code;
            exchRate.Name = rateData.base_code + SPACE + convRate;
            exchRate.External_Id__c = rateData.base_code + UNDERSCORE + convRate;
            exchRate.Rate__c = rateData.conversion_rates.get(convRate);
            exchRate.Target_Currency__c = convRate;
            Long timeStamp = Long.valueOf(rateData.time_last_update_unix);
            exchRate.Last_Updated__c =Datetime.newInstance(timeStamp);
            exchRatesForUpsert.add(exchRate);
        }
        upsert exchRatesForUpsert External_Id__c;
        return exchRatesForUpsert; // Replace with actual implementation
    }
    
    /**
     * @description Combines getting and processing rates into a single operation
     * @return List<Exchange_Rate__c> The list of records created or updated
     */
    public static List<Exchange_Rate__c> updateExchangeRates() {
        // TODO: Implement the method to get and process rates
        // 1. Call getLatestRates to retrieve the data
        // 2. Call processRates to create/update records
        // 3. Return the processed records
        getLatestRates();
        List<Exchange_Rate__c> insertedRecs = processRates(getLatestRates());
        return insertedRecs; // Replace with actual implementation
    }
}