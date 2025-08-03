/**
 * @description Trigger for Location__c object to handle before and after insert and update events.
 * @Date 31 July 2025
 * @param insert after
 * @param update before
 * @return trigger CTLocationTrigger on
 */
trigger CTLocationTrigger on Location__c (before insert,after insert, after update, before update) {
    // all events for CTLocation will be handled here
    
    switch on Trigger.operationType {
    when BEFORE_INSERT {
        CTLocationTriggerHandler.BeforeInsert(Trigger.New);
    }
    when BEFORE_UPDATE{
        CTLocationTriggerHandler.BeforeUpdate(Trigger.New, Trigger.oldMap);
    }
    when AFTER_UPDATE{
        CTLocationTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
    }
}
}