public with sharing class CTLocationTracingTriggerHandler {
    public CTLocationTracingTriggerHandler() {

    }

    public static void beforeInsert(List<Location_Tracing__c> newRecords) {
        List<Location_Tracing__c> duplicates =
            CTLocationTracingController.checkDuplicates(newRecords);

        for (Location_Tracing__c trace: duplicates){
            // If a duplicate is found, add an error to the record
            trace.addError('Duplicate record found for Location__c :' +
                trace.Location__c + ' and Person__c :' + trace.Person__c);
        }
    }
}