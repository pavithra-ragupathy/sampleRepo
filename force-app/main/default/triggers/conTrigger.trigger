trigger conTrigger on Contact(before Insert) {
	Set<Id> accountIdSet = new Set<Id>();
	for(Contact con : Trigger.new) {
		if(con.AccountId != null) {
			accountIdSet.add(con.AccountId);
		}
	}

	List<Account> accToUpdate = new List<Account>();
	if(accountIdSet.size() > 0) {
		for(Account acc : [SELECt Id, Name FROM Account WHERE Id IN : accountIdSet]) {
			acc.Name = 'Changing account name';
			accToUpdate.add(acc);
		}
 
		if(accToUpdate.size() > 0) {
			update accToUpdate;
            system.debug('accChange>>'+accToUpdate);
		}
	}

    for(Contact con : Trigger.new) {
		con.LastName = 'test con trigger';
	}
}