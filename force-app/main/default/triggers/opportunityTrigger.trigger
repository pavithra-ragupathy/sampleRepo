trigger opportunityTrigger on Opportunity (before update) {
    for(Id oppId : Trigger.newMap.KeySet())
    {
        Opportunity newOpp = Trigger.newMap.get(oppId);  
        //System.debug('New:'+newOpp);
        Opportunity oldOpp = Trigger.oldMap.get(oppId);
        //System.debug('Old:'+oldOpp);
        if((oldOpp.DeliveryInstallationStatus__c == 'Completed') && (newOpp.DeliveryInstallationStatus__c != 'Completed')){
           newOpp.addError('Delivery/InstallastionStatus cannot be changed from Completed');
        } 
    }
}