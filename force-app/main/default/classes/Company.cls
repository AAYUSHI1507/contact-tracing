public class Company {
    public String companyName;
    public String ceo;
    public Integer employeeCount;
    public long revenue;
    
    {
        System.debug('Company \'s constructor is initialized');
    }
    // List of all the customers
    private List<Clients> customersList = new List<Clients>();
    
    // add new customer
    public void addNewCustomer(String clientName,String website,String email, long phone){
        // TODO: add customer
        customersList.add(new clients(clientName,website,email,phone));
    } 
    
    // print the list of all the customers
    public void getAllCustomers(){
        // TODO: print all the customers
        for(Clients i: customersList){
            System.debug('Customer Name: '+i.clientName+'\n Website: '+ i.website+'\n email: '+ i.email+'\n Phone No : '+ i.phone + '\n');
        }
    }
    
    public void deleteCustomers(){
        customersList.remove(0);
        System.debug('The First Customer got deleted successfully...');
    }
    
    public List<Clients> getCustomerLists(){
        return this.customersList;
    }
    private class Clients{
        public String clientName;
        public String website;
        public String email;
        public long phone;
        
        clients(String clientName,String website,String email, long phone){
            this.clientName = clientName;
            this.website = website;
            this.email = email;
            this.phone = phone;
        }
    }
}