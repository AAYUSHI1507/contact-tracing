/**
 * @description Handle before insert event for People_Tracing__c object.
 * @param newRecords List<People_Tracing__c>
 */
public with sharing class PeopleTracingTriggerHandler {
    public PeopleTracingTriggerHandler() {
        
    }
    public static void beforeInsert(List<People_Tracing__c> newRecords) {
        List<People_Tracing__c> duplicates =
            CTPeopleTracingController.checkDuplicates(newRecords);
        
        for (People_Tracing__c trace: duplicates){
            // If a duplicate is found, add an error to the record
            trace.addError('Duplicate record found for Person_1__c :' +
                trace.Person_1__c + ' and Person_2__c :' + trace.Person_2__c);
        }
    }
    
}