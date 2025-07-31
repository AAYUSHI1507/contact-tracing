public class CTLocationController {

    public static List<Location__c> getRecentStatusChanges(){
        // Fetch the most recent 100 Location records ordered by Status_Update_Date__c
         List<Location__c> Locationlist =
         [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c 
			ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
         return Locationlist;
    }
    
    //Searching the location with the search term
    public static List<Location__c> searchLocations(String searchTerm){
        searchTerm = searchTerm+'%'; 
         List<Location__c> LocationList =
         [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c 
  			WHERE Name LIKE :searchTerm OR Pincode__c LIKE :searchTerm OR Address__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC NULLS LAST];
         return LocationList;
    }
    
    // Getting the Location By id
    public static Location__c getLocationById(String locationID){
         List<Location__c> location = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c
                                   WHERE Id = :locationID];
         if(location.size() == 0 || location == null){
             return null;
         }
       	return location[0];
}
    //CT controller location getStatusCount
    
    
    public static Map<String,Integer> getStatusCount(){
        Map<String,Integer> statusCountupdate = new Map<String,Integer>(); 
        
        for(AggregateResult a: [SELECT Status__c,COUNT(ID) totalCount FROM Location__c GROUP BY Status__c]){
            //System.debug(a.get('totalCount'));
            statusCountupdate.put(String.valueOf(a.get('Status__c')),Integer.valueOf(a.get('totalCount')));
        }
        
        return statusCountupdate;
    }

    /**
     * @description Update the Red Score for a set of Location IDs.
     * @Date 31 July 2025
     * @param locationIds Set<Id>
     * @return void
     */
    public static void updateRedScore(Set<Id> locationIds){


        //Initializing the list
        List<Location__c> locationToUpdate = new List<Location__c>();

        AggregateResult[] redPeople =[SELECT Location__c, COUNT(Id) total FROM Location_Tracing__c 
        WHERE Person__r.Health_Status__c = 'Red'
        AND Visit_Date__c = LAST_N_DAYS:10
        AND Location__c IN :locationIds
        GROUP BY Location__c];

        for(AggregateResult ar : redPeople){
            String locationId = String.valueOf(ar.get('Location__c'));
            Integer redScore = (Integer)ar.get('total');
            String status = getStatus(redScore);
            locationToUpdate.add(new Location__c(Id = locationId, Red_Score__c = redScore, Status__c = status));
        }

        if(locationToUpdate != null && locationToUpdate.size() > 0){
            update locationToUpdate;
        }
    }
    public static string getStatus(Integer redScore){
        if(redScore == 0){
            return 'Green';
        } else if(redScore <= 5){
            return 'Yellow';
        } 
        else if(redScore <= 10){
            return 'Orange';
        }
        else {
            return 'Red';
        }
    }
}