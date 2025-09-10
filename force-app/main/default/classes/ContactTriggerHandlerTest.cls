@IsTest
public with sharing class ContactTriggerHandlerTest {
    public ContactTriggerHandlerTest() {

    }

    @IsTest
    public static void afterInsertHandlerMethod(){
         
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test 1'));
        testAccounts.add(new Account(Name = 'Test 2'));

        insert testAccounts;

        List<Contact> testContacts = new List<Contact>();
        testContacts.add(new Contact(LastName='Test Contact 1', AccountId=testAccounts[0].Id));
        testContacts.add(new Contact(LastName='Test Contact 2', AccountId=testAccounts[0].Id));
        testContacts.add(new Contact(LastName='Test Contact 3', AccountId=testAccounts[0].Id));
        testContacts.add(new Contact(LastName='Test Contact 4', AccountId=testAccounts[0].Id));
        testContacts.add(new Contact(LastName='Test Contact 5', AccountId=testAccounts[1].Id));

        insert testContacts;

        List<Account> accs = [SELECT Id, Active__c FROM Account];
        System.assertEquals(2, accs.size());
        for(Account acc:accs){
            if(acc.Name == 'Test 1'){
                System.assertEquals(2,acc.Active_co+, actual)
            }
        }
        System.assertEquals(0, accs[0].Active__c);
        System.assertEquals(0, accs[1].Active__c);


        List<Contact> allContacts = [SELECT Id  FROM Contact];
        System.assertEquals(5, allContacts.size());
    }
}