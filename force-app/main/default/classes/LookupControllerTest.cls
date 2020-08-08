@isTest
private class LookupControllerTest 
{
    static void testData()
    {
        List<Account> objLst = new List<Account>();
        objLst.add(new Account (Name='AAA', AccountNumber='C-090900', Site='London'));
        objLst.add(new Account (Name='BBB', AccountNumber='C-090901', Site='London'));
        objLst.add(new Account (Name='CCC', AccountNumber='C-090902', Site='London'));
        objLst.add(new Account (Name='DDD', AccountNumber='C-090903', Site='London'));
        objLst.add(new Account (Name='EEE', AccountNumber='C-090904', Site='London'));
        insert objLst;
    }
    
    static testMethod void searchObjTest()
    {
        testData();
        List<sObject> objLst1, objLst2, objLst3;
        Test.startTest();
        objLst1 = LookupController.searchObj('Account', 'Name', 'AccountNumber', 'Site', 'a', null, '5', true);
        system.assertEquals(objLst1.size()>0, true);
        
        objLst2 = LookupController.searchObj('Account', 'Name', 'AccountNumber', 'Site', 'a', null, '5', false);
        system.assertEquals(objLst2.size()>0, true);
        
        objLst3 = LookupController.searchObj('Account', 'Name', 'AccountNumdfdfber', 'Site', 'a', null, '5', false);
        system.assertEquals(objLst3.size()==0, true);
        Test.stopTest();
    }
}