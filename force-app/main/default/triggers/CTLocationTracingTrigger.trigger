trigger CTLocationTracingTrigger on Location_Tracing__c (before insert) {

    // Handle before insert event for CTLocationTracingTrigger object
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            CTLocationTracingTriggerHandler.beforeInsert(Trigger.New);
        }
    }
}