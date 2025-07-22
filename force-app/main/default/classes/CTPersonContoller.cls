public with sharing class CTPersonContoller {

    public static String getToken(String MobileNo){
        Blob targetBlob = Blob.valueOf(MobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);
        String result = EncodingUtil.base64Encode(hash);
        return result;
    }
    //Uncomment below code to enable the methods
    // public static List<Person_c> getRecentHealthChanges(){

    //     // Fetch the most recent 100 Person_c records ordered by Status_Update_Date__c
    //     List<Person_c> personList =
    //     [SELECT Name,Health_Status__c,Mobile__c,OwnerId,Status_Update_Date__c,
    //     Token__c,CreatedById FROM Person_c ORDER BY Status_Update_Date__c DESC LIMIT 100];
    //     return personList;
    // }

    // public static List<Person_c> searchPeople(String searchTerm){
    //     List<Person_c> personList =
    //     [SELECT Name,Health_Status__c,Mobile__c,OwnerId,Status_Update_Date__c,
    //     Token__c,CreatedById FROM Person_c WHERE Name LIKE :searchTerm OR Mobile__c LIKE :searchTerm OR Token__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC];
    //     return personList;
    // }

    // public static Person_c getPersonById(String personId){
    //     Person_c person = [SELECT Name,Health_Status__c,Mobile__c,OwnerId,Status_Update_Date__c,
    //     Token__c,CreatedById FROM Person_c WHERE Id = :personId LIMIT 1];
    //     return person;
    // }
}