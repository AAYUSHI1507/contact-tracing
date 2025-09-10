public class OpportunityController {
    
    public List<Opportunity> GetOpportunityList(){
        List<Opportunity> getOppList = [SELECT ID,Name,Amount,profile__c FROM Opportunity];
        return getOppList;
    }
    public void assignToProfile(){
        List<Opportunity> opp = GetOpportunityList();
        List<Opportunity> updatedopp = new List<Opportunity>();
        for(Opportunity o: opp){
            //System.debug('ID: '+ o.Id+' Name: '+o.Name+' is being executed');
            if(o.Amount < 10000){
                o.Profile__c = 'Low'; // Low
            }
            else if(o.Amount > 10000 && o.Amount < 50000){
                o.Profile__c = 'Medium'; //Medium
            }
            else if(o.Amount > 50000){
                o.Profile__c = 'High'; //High
            }
            updatedopp.add(o);
            System.debug('ID: '+ o.Id+' Name: '+o.Name+' Amount: '+o.Amount+' Profile: '+
                         o.Profile__c+' is being executed');
        }
        UPDATE updatedopp;
    }
}