trigger contactTrigger on Contact (after insert) {
    Set<id> accSet = new Set<id>();
    List<Contact> conList = new List<Contact>();
    Map<id,List<Contact>> accContact_Map = new Map<id,List<Contact>>();
    
    for(Contact c : Trigger.new){
    accSet.add(c.AccountId);
    }
    List<Contact> conList_2 = [Select id,AccountId from Contact where AccountId =: accSet]; 
    for(Contact ct : conList_2)
    {
        if(accContact_Map.ContainsKey(ct.AccountId))
        {
            List<Contact> conList_1 = accContact_Map.get(ct.AccountId);
            conList_1.add(ct);
            accContact_Map.put(ct.Accountid,conList_1);
        }
      
        else
        {
            conList.add(ct);
            accContact_Map.put(ct.Accountid,conList);
        }
    }    
    Map<Id,Account> acc_Map = new Map<Id,Account>([Select id,Number_of_Contacts__c from Account where id =: accContact_Map.keySet()]); 
    List<Account> accList_update = new List<Account>(); 
    for(ID curAccID : acc_Map.keySet())
    {
        List<Contact> conList_3 = accContact_Map.get(curAccID);
        Account acc = acc_Map.get(curAccID);
        acc.Number_of_Contacts__c = conList_3.size(); 
        accList_update.add(acc);
    }
    if(accList_update!=Null && accList_update.size()>0)
    {
     update accList_update;
    }
  
    
}