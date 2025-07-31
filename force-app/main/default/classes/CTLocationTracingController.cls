public class CTLocationTracingController {
    
    
    
    // Creating the getVisitors Method.
    public static List<Location_Tracing__c> getVisitors(String Locationid){
        return ([SELECT Id, Person__c, Location__c, Person__r.Token__c,Person__r.Health_Status__c,Visit_Date__c FROM Location_Tracing__c
				WHERE ID = :Locationid
				ORDER BY Visit_Date__c DESC NULLS LAST]);
    }
    
    // Getting the locationsByPersons Method
    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIDs){
        List<Location_Tracing__c> locationList = 
            [SELECT Id, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c 
				WHERE Person__c IN :personIDs
             	AND Visit_Date__c = LAST_N_DAYS:10];
        return locationList;
    }
    
    //Getting the LocationsByLocationID method.
    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds){
        List<Location_Tracing__c> LocationTracingList = [SELECT Id, Person__c, Location__c, Visit_Date__c FROM Location_Tracing__c 
		WHERE Location__c IN :locationIds
		AND  Person__r.Health_Status__c = 'Green' 
		AND Visit_Date__c = LAST_N_DAYS:10];
        if(LocationTracingList.size() == 0 || LocationTracingList[0] == null){
            return null;
        }
        return LocationTracingList;
    }
    
    // Checking duplicates records methods
    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newLocationTraces){
        
        //Getting the Unique IDs for the location__c
        Set<Id> locationIds = new Set<Id>();
        
        //Getting the Unique IDs for the Person__c
        Set<Id> PersonIDs = new Set<Id>();
        
        //Setting the ids from the new location trace list to the above mentioned sets
        for(Location_Tracing__c trace: newLocationTraces){
            locationIds.add(trace.Location__c);
            PersonIDs.add(trace.Person__c);
        }
        
        //Maps of Location Id, Set of Persons id.
        Map<Id,Set<Id>> mapOfExistingRecords = new Map<Id,Set<Id>>();
        
        List<Location_Tracing__c> existingRecords = [SELECT Id, Person__c, Location__c 
                                                        FROM Location_Tracing__c 
                                                        WHERE Location__c IN :locationIds
                                                        AND Person__c IN :personIds];
        
        // list of duplicate records
        List<Location_Tracing__c> duplicates = new List<Location_Tracing__c>();


        if(existingRecords != null && existingRecords.size() > 0){
            for (Location_Tracing__c trace : existingRecords) {
                if(! mapOfExistingRecords.containsKey(trace.Location__c)){
                    mapOfExistingRecords.put(trace.Location__c, new Set<Id>());
                }
                // add person ids to map set
                mapOfExistingRecords.get(trace.Location__c).add(trace.Person__c);
            }
            
            // loop over new location tracing records
            for (Location_Tracing__c trace : newLocationTraces) {
                // first check for location id
                // if item found in map, then check for person in set
                if(mapOfExistingRecords.containsKey(trace.Location__c) 
                    && mapOfExistingRecords.get(trace.Location__c).contains(trace.Person__c)){
                        duplicates.add(trace);
                }
            }
        }

        return duplicates;
    }
}