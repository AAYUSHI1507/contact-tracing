trigger CTPersonTrigger on Person__c (before insert,after insert, after update, before update, before delete, after delete, after undelete) {
    //all events for CTPerson will be handled here

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            // todo: update health status to 'Green' and generate unique token for the person record. 
            CTPersonTriggerHandler.beforeInsert(Trigger.New);
        }
        when AFTER_INSERT{
            

        }
        when BEFORE_UPDATE{
            CTPersonTriggerHandler.beforeUpdate(Trigger.New, Trigger.oldMap);
        }
        when AFTER_UPDATE{
            CTPersonTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
        }
    }
    //Before Insert

    //After Insert

    // when health status updates,update date field - after update
    //After Update
     

}
