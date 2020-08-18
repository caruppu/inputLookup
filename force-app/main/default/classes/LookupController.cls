/*
 * Class Name: LookupController
 * Depending Component: Lookup.cmp
 */
public with sharing class LookupController 
{
    @AuraEnabled
    public static List<sObject> searchObj(String obj, 
                                          String f1, 
                                          String f2, 
                                          String f3, 
                                          String searchText, 
                                          String additionalClause, 
                                          String rowLimit, 
                                          Boolean withSharing)
    {
        Boolean isObjAccessible = false;
        Boolean isF1Accessible = false;
        Boolean isF2Accessible = false;
        Boolean isF3Accessible = false;
        Boolean isValidFields = true;
        if (obj!=null && obj!='' && Schema.getGlobalDescribe().get(obj).getDescribe().isAccessible())
        {
            isObjAccessible = true;
            Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(obj).getDescribe().fields.getMap();
            if ((f1!=null && f1!='' && fieldMap.get(f1) == null) 
                || (f2!=null && f2!='' && fieldMap.get(f2) == null) 
                || (f3!=null && f3!='' && fieldMap.get(f3) == null)) {
                isValidFields = false;
            } else {
                if (f1!=null && f1!='' && fieldMap.get(f1) != null && fieldMap.get(f1).getDescribe().isAccessible())
                {
                    isF1Accessible = true;
                }
                if (f2!=null && f2!='' && fieldMap.get(f2) != null && fieldMap.get(f2).getDescribe().isAccessible())
                {
                    isF2Accessible = true;
                }
                if (f3!=null && f3!='' && fieldMap.get(f3) != null && fieldMap.get(f3).getDescribe().isAccessible())
                {
                    isF3Accessible = true;
                }
            }
        }

        List <sObject> returnLst = new List<sObject>();
        if (isObjAccessible && isF1Accessible && isValidFields)
        {
            String qry;
            try
            {
                searchText = String.escapeSingleQuotes(searchText);
                qry = 'SELECT id, ' + (isF2Accessible?(f2+', '):'') + (isF3Accessible?(f3+', '):'') + f1 + ' FROM ' + obj 
                    + ' WHERE ' + f1 + ' LIKE \'' + searchText + '%\'' + (additionalClause!=null?additionalClause:'') + ' LIMIT ' + rowLimit;
                
                if (withSharing)
                {
                    returnLst = Database.query(qry);
                }
                else
                {
                    returnLst = (new InnerController()).executeSOQL(qry);
                }
            }
            catch (Exception e)
            {
                system.debug(LoggingLevel.DEBUG, 'ERROR DEBUG: Query Framed (var qry): ' + qry);
                system.debug(LoggingLevel.DEBUG, 'ERROR DETAIL: Custom Lookup Exception: ' + e.getMessage());
                system.debug(LoggingLevel.INFO, 'ERROR INFO: Custom Lookup Exception: ' + e.getMessage());
                system.debug(LoggingLevel.ERROR, 'ERROR DETAIL: Custom Lookup Exception: ' + e.getStackTraceString());
            }
        }

        return returnLst;
    }
    
    private without sharing class InnerController
    {
        private List<sObject> executeSOQL(String qry)
        {
            return Database.query(qry);
        }
    }
}