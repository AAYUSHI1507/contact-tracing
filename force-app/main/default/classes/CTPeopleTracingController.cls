public class CTPeopleTracingController {
    
    public static List<People_Tracing__c> getTraces(String personId){
        
        return[SELECT Id, Contact_Date__c, Person_1__c,Person_1__r.Health_Status__c,Person_1__r.Token__c,
                Person_2__c,Person_2__r.Health_Status__c,Person_2__r.Token__c 
        FROM People_Tracing__c
        WHERE Person_1__c = :personId
        OR Person_2__c = :personId
        ORDER BY Contact_Date__c DESC  ];
        
    }
    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces){
        Set<Id>  personIds = new Set<Id>();
        for(People_Tracing__c trace : newPeopleTraces){
            personIds.add(trace.Person_1__c);
            personIds.add(trace.Person_2__c);
        }
        
        //List of duplicate records
        List<People_Tracing__c> duplicateRecords = new List<People_Tracing__c>();

        //Map id and set <Id>
        Map<Id,Set<Id>> mapOfExistingReocrds = new Map<Id,Set<Id>>();

        //Querying the existing records
        List<People_Tracing__c> existingRecords = [SELECT Id, Person_1__c, Person_2__c 
                                                   FROM People_Tracing__c
                                                   WHERE Person_1__c IN :personIds
                                                   OR Person_2__c IN :personIds];
        
        if(existingRecords != null && existingRecords.size() > 0){
            for(People_Tracing__c existingRecord : existingRecords){
                if(!mapOfExistingReocrds.containsKey(existingRecord.Person_1__c)){
                    mapOfExistingReocrds.put(existingRecord.Person_1__c, new Set<Id>());
                }
                mapOfExistingReocrds.get(existingRecord.Person_1__c).add(existingRecord.Person_2__c);
                if(!mapOfExistingReocrds.containsKey(existingRecord.Person_2__c)){
                    mapOfExistingReocrds.put(existingRecord.Person_2__c, new Set<Id>());
                }
                
                mapOfExistingReocrds.get(existingRecord.Person_2__c).add(existingRecord.Person_1__c);
            }

            // loop over existingg records to find duplicates
            for(People_Tracing__c newTrace : newPeopleTraces){
                if(mapOfExistingReocrds.containsKey(newTrace.Person_1__c) &&
                     mapOfExistingReocrds.get(newTrace.Person_1__c).contains(newTrace.Person_2__c) ||
                   mapOfExistingReocrds.containsKey(newTrace.Person_2__c) &&
                     mapOfExistingReocrds.get(newTrace.Person_2__c).contains(newTrace.Person_1__c)){
                     // if duplicate found, add to the list
                    duplicateRecords.add(newTrace);
                     }
                    }
        }
        return duplicateRecords;
    }
}