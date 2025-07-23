trigger CTPersonTrigger on Person__c (before insert,after insert, after update, before update, before delete, after delete, after undelete) {
    //all events for CTPerson will be handled here

    switch on operationType {
        when BEFORE_INSERT {
            for (Person__C person_record: Trigger.New){
                if(person_record.person_health_status__c != 'Green') {
                    Person__c.person_health_status__c.addError('Person Health Status must be Green ');
                }
            }
        }
        
    }
    //Before Insert

    //After Insert

    // when health status updates,update date field - after update
    //After Update
     

}