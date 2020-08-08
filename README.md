# Lightning Lookup Component
	Similar to Lightning Component Library’s Lightning:input component, this is also a very much needed component sfor any developer building forms in salesforce lightning, to lookup for records from various objects.

# Usage:
• From another parent custom component
• In Flow Builder as a custom input field

# Example
    <crl:inputLookup LookupLabel="Customer"
                    LookupIcon="standard:account" 
                    LookupObject="Account"
                    LookupField_1="Name"
                    LookupField_2="Type" 
                    LookupField_3="AccountNumber"
                    LookupAdditionalClause=" and AccountNumber like 'CD%'"
                    LookupSelectedRecord="{!v.selectedCustomer}"
                    LookupSelectedRecordId="{!v.selectedCustomerId}"
                    LookupRowLimit="6"
                    withSharing="true" />
