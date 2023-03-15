@Istest
public class AccountTriggerHandler_test {
    public static testMethod void cqinterview(){

        //create Account
        Account account = new Account();
        account.Name = 'test';
        insert account;
        
        List<SQX_Team_Members__c> teammembers = [select id from SQX_Team_Members__c where Account__c =: account.Id];
        Account acc = [select id,Active__c from Account where Id =: account.Id];
        //Assert : check records created
        system.assertEquals(2,teammembers.size(),'Two team members records should create but not created');
        //Assert : check active check box is default false
        system.assertEquals(false,acc.Active__c,'Account active status should be false but true');
         
        //Update Account
		account.Active__c = true;
        database.SaveResult SaveResult = Database.update(Account, false);
        
        //Assert: account should not Active
        system.assertEquals(false, saveresult.isSuccess(), 'Cannot activate account without HR or Admin team member record.');
        
        teammembers[0].Member_Type__c = 'HR';
        update teammembers[0];
        teammembers[1].Member_Type__c = 'Admin';
        update teammembers[1];
        
        account.Active__c = true;
        database.SaveResult SaveResult1 = Database.update(Account, false);
        
        //Assert: account should Active
        system.assertEquals(true, saveresult1.isSuccess(), 'account should Active but not');
        
        }  
    }
