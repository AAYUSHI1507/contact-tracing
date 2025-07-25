public with sharing class CTPersonTriggerHandler {
    public CTPersonTriggerHandler() {
        
    }
    
    public static void beforeInsert(List<Person__c> newRecords){
        for (Person__c person_record: newRecords){
            //Update health status to 'Green' and generate unique token for the person record.
            person_record.Health_Status__c = 'Green';
            person_record.Token__c = CTPersonContoller.getToken(person_record.Mobile__c);
            //Token is created successfully
        }
    }
    
    public static void beforeUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldRecordMaps){
        for (Person__c person_record: newRecords){
            if(oldRecordMaps.get(person_record.Id).Health_Status__c != person_record.Health_Status__c){
                person_record.Status_Update_Date__c = Date.today();
            }
        }
    }
}
