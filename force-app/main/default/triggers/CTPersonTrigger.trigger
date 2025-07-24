trigger CTPersonTrigger on Person__c (before insert,after insert, after update, before update, before delete, after delete, after undelete) {
    //all events for CTPerson will be handled here

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            // todo: update health status to 'Green' and generate unique token for the person record.
            for (Person__c person_record: Trigger.New){
                person_record.Health_Status__c = 'Green';
                person_record.Token__c = CTPersonContoller.getToken(person_record.Mobile__c);
            }
        }
        when AFTER_INSERT{
            

        }
        when AFTER_UPDATE{
            List<Id> personIds = new List<Id>();
            for (Person__c person_record : Trigger.New) {
                personIds.add(person_record.Id);
            }
            Map<Id,Person__c> oldPersonMap = Trigger.oldMap;
            Map<Id,Person__c> newPersonMap = Trigger.newMap;
            List<Person__c> personListToUpdate = new List<Person__c>();
            List<Person__c> queriedPersons = [SELECT Id, Name, Status_Update_Date__c FROM Person__c WHERE Id IN :personIds];
            for (Person__c personR : queriedPersons) {
                if (oldPersonMap.get(personR.Id).Health_Status__c != newPersonMap.get(personR.Id).Health_Status__c) {
                    System.debug('person record ' + personR.Name);
                    personR.Status_Update_Date__c = Date.today();
                    System.debug('person record updateca ' + personR);
                    personListToUpdate.add(personR);
                }
            }
            if (!personListToUpdate.isEmpty()) {
                update personListToUpdate;
            }
        }
        
    }
    //Before Insert

    //After Insert

    // when health status updates,update date field - after update
    //After Update
     

}