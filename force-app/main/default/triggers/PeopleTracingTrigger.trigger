trigger PeopleTracingTrigger on People_Tracing__c (before insert) {

    // Handle before insert event for People_Tracing__c object
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            PeopleTracingTriggerHandler.beforeInsert(Trigger.New);
        }
    }
}