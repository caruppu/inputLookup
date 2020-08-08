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
        List <sObject> returnLst = new List<sObject>();
        String qry;
        try
        {
            searchText = String.escapeSingleQuotes(searchText);
            qry = 'SELECT id, ' + (f2!=null&&f2!=''?(f2+', '):'') + (f3!=null&&f3!=''?(f3+', '):'') + f1 + ' FROM ' + obj 
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