public class Account_TriggerHelper {

    public static void AccountActivation1(List<Account> accountlist){
        Set<Id> accountIds = new Set<Id>();
         for(Account acc : accountlist) {
             if(acc.Active__c == true){
                  System.debug('accountIds' +acc.Active__c);
                 accountIds.add(acc.Id);
                  System.debug('accountIds' +accountIds);
             }
        }
        list<id> acc1id = new list<id>();
        List <SQX_Team_Members__c> tlist = [SELECT ID,Account__c,Member_Type__c from SQX_Team_Members__c where Account__c IN:accountIds and Member_Type__c ='HR'];
        List <SQX_Team_Members__c> tlist1 = [SELECT ID,Account__c,Member_Type__c from SQX_Team_Members__c where Account__c IN:accountIds and Member_Type__c ='Admin'];
        System.debug('accountIds' +tlist);
        if(tlist.size() > 0  && tlist1.size() > 0){
            for(SQX_Team_Members__c t1 : tlist){
                for(SQX_Team_Members__c t2 : tlist1){
                    if(t1.Account__c == t2.Account__c){
                        if(t1.Member_Type__c == 'HR' && t2.Member_Type__c == 'Admin'){
                            
                        } else{
                            acc1id.add(t1.Account__c);
                        }
                        
                    }
                }
            }
        }else{
            for(Account a : accountlist){
            if(a.Active__c == true){
                a.addError('Cannot activate account without HR or Admin team member record.');
            }
        }
        }
        list<Account> accountlist1 = [select id,Name from Account where id In: acc1id];
        for(Account a : accountlist1){
            if(a.Active__c == true){
                a.addError('Cannot activate account without HR or Admin team member record.');
            }
        }
    }
}