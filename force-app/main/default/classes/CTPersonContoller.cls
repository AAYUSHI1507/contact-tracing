public with sharing class CTPersonContoller {
    
    public static String getToken(String MobileNo){
        Blob targetBlob = Blob.valueOf(MobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);
        String result = EncodingUtil.base64Encode(hash);
        return result;
    }
    //Uncomment below code to enable the methods
    public static List<Person__c> getRecentHealthChanges(){
        
        // Fetch the most recent 100 Person__c records ordered by Status_Update_Date__c
        List<Person__c> personList =
            [SELECT Name,Health_Status__c,Mobile__c,OwnerId,Status_Update_Date__c,
        Token__c,CreatedById FROM Person__c ORDER BY Status_Update_Date__c DESC LIMIT 100];
        return personList;
    }
    
    public static List<Person__c> searchPeople(String searchTerm){
        List<Person__c> personList =
            [SELECT Name,Health_Status__c,Mobile__c,OwnerId,Status_Update_Date__c,
        Token__c,CreatedById FROM Person__c WHERE Name LIKE :searchTerm OR Mobile__c LIKE :searchTerm OR Token__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC];
        return personList;
    }
    
    public static Person__c getPersonById(String personId){
        Person__c person = [SELECT Name,Health_Status__c,Mobile__c,OwnerId,Status_Update_Date__c,
        Token__c,CreatedById FROM Person__c WHERE Id = :personId LIMIT 1];
        return person;
    }
    
    public static Set<Id> getCohibitants(String personId){
        Set<Id> cohibitantIds = new Set<Id>();
        List<String> healthStatuses = new List<String>{'Green', 'Yellow'};
        // Fetch Cohibitant__c records related to the given Person__c record
        List<People_Tracing__c> peopleTraces = [SELECT Contact_Type__c, Id, Person_1__c, Person_2__c, Name 
                                                FROM People_Tracing__c  
                                                WHERE Contact_Type__c = 'Cohabitant'
                                                AND (Person_1__c = :personId OR Person_2__c = :personId)
                                                AND (Person_1__r.Health_Status__c IN :healthStatuses 
                                                OR Person_2__r.Health_Status__c IN :healthStatuses)];
        for (People_Tracing__c pt : peopleTraces) {
            if(!personId.contains(pt.Person_1__c)){
                cohibitantIds.add(pt.Person_1__c);
            }
            if(!personId.contains(pt.person_2__c)){
                cohibitantIds.add(pt.Person_2__c);
            }
        }
        return cohibitantIds;
    }
    public static Set<Id> getNeigbhours(String personId){
        Set<Id> neigbourIds = new Set<Id>();
        
        // Fetch Cohibitant__c records related to the given Person__c record
        List<People_Tracing__c> peopleTraces = [SELECT Contact_Type__c, Id, Person_1__c, Person_2__c, Name 
                                                FROM People_Tracing__c  
                                                WHERE Contact_Type__c = 'Cohabitant'
                                                AND (Person_1__c = :personId OR Person_2__c = :personId)
                                                AND (Person_1__r.Health_Status__c = 'Green'
                                                OR Person_2__r.Health_Status__c = 'Green')];
        for (People_Tracing__c pt : peopleTraces) {
            if(!personId.contains(pt.Person_1__c)){
                neigbourIds.add(pt.Person_1__c);
            }
            if(!personId.contains(pt.person_2__Fc)){
                neigbourIds.add(pt.Person_2__c);
            }
        }
        return neigbourIds;
    }
}