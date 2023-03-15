trigger Account_Trigger on Account (before update) {
    for(Account acc:trigger.New){
         if(Trigger.isBefore && Trigger.isUpdate )
        {
            Account_Handler.methodname(trigger.new);
        }
	}
}
