# Lightning Lookup Component
Similar to Lightning Component Library’s Lightning:input component, this is also a very much needed component sfor any developer building forms in salesforce lightning, to lookup for records from various objects.

# Usage
1. From another parent custom component
2. In Flow Builder as a custom input field

# Example
    <c:inputLookup LookupLabel="Customer"
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
                    

# Video
<iframe width="560" height="315" src="https://www.youtube.com/embed/2tJaTBxnkY8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
