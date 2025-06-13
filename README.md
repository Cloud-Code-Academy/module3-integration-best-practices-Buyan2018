# Cloud Code Academy - Integration Developer Program
## Lesson 2: Exchange Rate API Integration - Best Practices

Welcome to the second lesson of the Integration Developer program! In this lesson, you'll build a complete Salesforce integration with an external API, implementing best practices for secure authentication, data processing, and automated scheduling.

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Configure Named Credentials to securely store API authentication details
- Create wrapper classes to deserialize JSON API responses
- Implement a service layer for making API callouts
- Build a scheduled job to automate integration updates
- Apply best practices for error handling and testing

## 📋 Exercise Overview

This exercise contains several components:

1. **ExchangeRateService.cls**
   - Service class with methods for API callouts
   - Handles communication with the ExchangeRate-API
   - Located in `force-app/main/default/classes/`

2. **ExchangeRateWrapper.cls**
   - Wrapper class for JSON deserialization
   - Maps API response to Apex objects
   - Located in `force-app/main/default/classes/`

3. **ExchangeRateScheduler.cls**
   - Scheduler for automated updates
   - Implements the Schedulable interface
   - Located in `force-app/main/default/classes/`

4. **Supporting Classes**:
   - `ExchangeRateMock.cls` - Mock HTTP class for testing
   - `ExchangeRateServiceTest.cls` - Test class for the service
   - `ExchangeRateSchedulerTest.cls` - Test class for the scheduler

5. **Custom Object**:
   - `Exchange_Rate__c` - Custom object for storing exchange rates

## 🔨 Installation

1. Clone this repository to your local machine
2. Deploy the code to your Salesforce org using:
   ```bash
   sfdx force:source:deploy -p force-app/main/default
   ```
3. Set up Named Credentials for the ExchangeRate-API (instructions below)

## 🔑 Named Credential Setup

1. In Salesforce Setup, navigate to **Security > Named Credentials**
2. Click **New Named Credential**
3. Configure with the following settings:
   - Label: ExchangeRate API
   - Name: ExchangeRate_API
   - URL: https://api.exchangerate-api.com/v6
   - Identity Type: Named Principal
   - Authentication Protocol: No Authentication
4. Save the configuration

## ✍️ Exercise Instructions

1. **Implement ExchangeRateWrapper.cls**
   - Create classes to deserialize the JSON response from the API
   - Map API data to Salesforce fields

2. **Complete ExchangeRateService.cls**
   - Implement methods to make callouts to the API
   - Process the response and create/update Exchange_Rate__c records
   - Add proper error handling

3. **Finish ExchangeRateScheduler.cls**
   - Implement the execute method to run the service
   - Set up proper scheduling using CRON expressions

4. **Test Your Implementation**
   - Run the provided test classes to verify your code
   - Ensure all tests pass with proper coverage

## 🎯 Success Criteria

Your implementation should:
- Pass all test methods in the provided test classes
- Properly deserialize JSON responses
- Create or update Exchange_Rate__c records
- Include comprehensive error handling
- Schedule updates to run automatically
- Follow Salesforce best practices

## 💡 Tips

- Review the API documentation at [ExchangeRate-API](https://www.exchangerate-api.com/docs/overview)
- Use the Developer Console debug logs to troubleshoot
- Test with mock responses before making actual API calls
- Pay attention to error handling for various scenarios

## 📚 Resources

- [Named Credentials in Salesforce](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_callouts_named_credentials.htm)
- [JSON Deserialization in Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_json_overview.htm)
- [Schedulable Interface](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_scheduler.htm)
- [Apex Testing Best Practices](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_best_practices.htm)

## 🏆 Challenge

Once you've completed the basic implementation, try these challenges:
1. Add support for multiple base currencies
2. Create a Lightning component to display current exchange rates
3. Implement custom logging to track integration activity
4. Use External Credentials instead of Named Credentials for enhanced security

## ❓ Support

If you need help:
- Review the test classes for expected behavior
- Check the solution code in the `solutions` directory
- Reach out to your instructor

---
Happy coding! 🚀

*This is part of the Cloud Code Academy Integration Developer certification program.*

## Copyright

© 2025 Cloud Code. All rights reserved.

This software is provided under the Cloud Code Developer Kickstart Program License (CCDKPL) Version 1.0.
The software is licensed, not sold, and is intended for personal educational purposes only as part of the Cloud Code Developer Kickstart Program.

See the full license terms in LICENSE.md for more details regarding usage restrictions, ownership, warranties, and limitations of liability.