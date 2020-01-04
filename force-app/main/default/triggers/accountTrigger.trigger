trigger accountTrigger on Account (after update) {
    List<Contact> conRcd = [Select id,Phone,AccountId from Contact where AccountId=: Trigger.newMap.KeySet()];
    List<Contact> conList = new List<Contact>();
    for(Contact con : conRcd)
    {
        Account acc =  Trigger.newMap.get(con.AccountId);
        if(acc.Phone != null)
        {
        con.Phone = acc.Phone;
        conList.add(con);
        }
    }
    if(conList!= null && conList.size()>0)
    {
        update conList;
        
    }
}