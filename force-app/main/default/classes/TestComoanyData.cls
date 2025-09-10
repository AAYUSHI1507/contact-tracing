@isTest
public class TestComoanyData {
     
    public static Company roll = new Company();
    
    
    @isTest
    public static void DeleteNewCustomerTest(){
        
          roll.companyName = 'Zentith';
    	  roll.ceo = 'Vansh';
    	roll.employeeCount = 10;
    	roll.revenue = 554555;
        // Create the instance of the class
        //Company roll = new Company();
        Boolean ans;
        
        roll.addNewCustomer('Mandy', 'mandy@website.com', 'Mandy@email.com', 348483739);
        roll.addNewCustomer('Sandy', 'Sandy@website.com', 'Sandy@email.com', 348083739);
        
        System.debug('This is the object information in Delete Test : '+roll+'\n'+roll.getCustomerLists());
        //Test whether that our method is deleting the first element of the list.
        String beforeDeleteList = roll.getCustomerLists()[0].clientName;
        
        roll.deleteCustomers();
        
        
        Boolean getAns = roll.getCustomerLists()[0].clientName == beforeDeleteList? true:false;
        
        System.assertEquals(false,getAns,'The delete function not working properly...');
        
    }
    
    @isTest
    public static void addNewCustomerTest(){
        // Create the instance of the class
        
        Boolean ans;
        
        roll.addNewCustomer('Mandy', 'mandy@website.com', 'Mandy@email.com', 348483739);
        roll.addNewCustomer('Sandy', 'Sandy@website.com', 'Sandy@email.com', 348083739);
        
        System.debug('This is the object information in add test: '+roll+'\n'+roll.getCustomerLists());
        
        for(Integer i = 0; i < roll.getCustomerLists().size();i++){
            if(roll.getCustomerLists()[i].clientName == 'Sandy'){
                ans = true;
                break;
            }
        }
        
        System.assertEquals(true,ans,'This does not contains');
        
    }
    
    @isTest
    public static void getAllCustomerInfoList(){
        
        Company roll1 = new Company();
        
        roll1.addNewCustomer('Sunny', 'maandy@website.com', 'Ma3ndy@email.com', 123456789);
    	roll1.addNewCustomer('Money', 'Saandy@website.com', 'Sand3y@email.com', 348083673);
        roll1.addNewCustomer('Ponty', 'Ponty@website.com', 'ponty@email.com',   342488093);
    	roll1.addNewCustomer('Simon', 'Simon3@website.com', 'Simon@email.com',  348090939);
        roll1.getAllCustomers();
        
    }
    
}