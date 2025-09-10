public with sharing class CTLocationTriggerHandler {
    public CTLocationTriggerHandler() {
        
    }
    public static void BeforeInsert(List<Location__c> newRecords){
        for(Location__c location : newRecords){
            location.Status__c  = 'Green';
        }
    }
    public static void BeforeUpdate(List<Location__c> newRecords, Map<Id,Location__c> oldRecordsMap){
        for(Location__c location : newRecords){
            if(oldRecordsMap.get(location.Id).Status__c != location.Status__c){
                location.Status_Update_Date__c = Date.today();
            }
        }
    }
    
    public static void afterUpdate(List<Location__c> newRecords, Map<Id,Location__c> oldRecordsMap){
        {
            Set<Id> locationStatusChangeToRed = new Set<Id>();
            Set<Location_Tracing__c> UpdatedPeopleHealthStatus = new Set<Location_Tracing__c>();
            for(Location__c location : newRecords){
                if(oldRecordsMap.get(location.Id).Status__c != 'Red' && location.Status__c == 'Red'){
                    locationStatusChangeToRed.add(location.Id);
                    
                }
            }
            
            List<Location_Tracing__C> locationTraces = [SELECT Id, Visit_Date__c, Location__c,  Person__r.Health_Status__c,Person__r.Name 
                                                        FROM Location_Tracing__c
                                                        WHERE Visit_Date__c = LAST_N_DAYS:10
                                                        AND Location__c IN :locationStatusChangeToRed
                                                        AND Person__r.Health_Status__c 
                                                        IN ('Green','Yellow')];
            // Collect Person__c Ids to update their Health_Status__c
            Set<Id> personIdsToUpdate = new Set<Id>();
            for(Location_Tracing__C trace : locationTraces){
                if(trace.Person__r != null){
                    personIdsToUpdate.add(trace.Person__r.Id);
                }
            }
            if(!personIdsToUpdate.isEmpty()){
                List<Person__c> peopleToUpdate = [SELECT Id, Health_Status__c FROM Person__c WHERE Id IN :personIdsToUpdate];
                for(Person__c person : peopleToUpdate){
                    person.Health_Status__c = 'Yellow';
                }
                if(!peopleToUpdate.isEmpty()){
                    update peopleToUpdate;
                }
            }
        }
}}