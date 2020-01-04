public class ShowAccount {
    public List<Account> acc{get;set;}
    public ShowAccount(){
        acc = new List<Account>();
        toDisplay();
    }
    
    public Pagereference toDisplay()
    {
        acc = [SELECT Id,Name,BillingCity,Phone,Description FROM Account ORDER BY Name Asc LIMIT 20 ];
        return null;
    }

}