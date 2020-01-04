trigger mylead on Lead (Before Insert) {

Set<String> emaill=new set<String>();
map<string,lead> nmap = new map<string,lead>();

    For(lead l:trigger.new){
        System.debug('>>Email>>'+l.email);
        emaill.add(L.email);
    }
    
    if(emaill.size()>0){
    
List<Lead> lst   =[ Select id,name,email from lead where email in:emaill];
system.debug('>>Size of list>>'+lst.size());
for(lead a:lst)
{
  nmap.put(a.email,a);
}

for(lead a1:trigger.new )
{


 if(nmap.containsKey(a1.email))
 {
  a1.addError('Duplicate');
 }
 else
  {
  a1.leadsource = 'WEB';
   }
   
}
}
}