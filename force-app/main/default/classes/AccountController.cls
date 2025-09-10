public class AccountController {
    public static List<Account> insertAccount(List<Account> accountToInsert){
        INSERT accountToInsert;
        System.debug('Successfully inserted from vscode to salesforce org');
        return accountToInsert;
    }
    
    //Insert a single Account
    public static Account insertAccount(Account accountToInsert){
        INSERT accountToInsert;
        return accountToInsert;
    }
    
    //Give the first  records in the List sorted by the created Date
    public static List<Account> getAllAccounts(){
        List<Account> accountList = [SELECT Name,Phone FROM Account ORDER BY CreatedDate DESC];
        return accountList;
    }
    
    //Printing all the records.
    public static void printAllAccounts(){
        List<Account> accountList = getAllAccounts();
        
        for(Account acc: accountList){
            System.debug('Account Name: '+ acc.Name+'\t'+'Phone No: '+acc.Phone);
        }
    }
    
    // Size if of the accounts records
    public static void getAccountsListSize(){
        List<Account> accountList = getAllAccounts();
        System.debug(accountList.size());
    }
}