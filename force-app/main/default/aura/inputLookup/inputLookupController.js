({
	searchJS : function(component, event, helper) {
        try
        {
            var searchText = component.get("v.LookupSearchText");
            if(searchText != null && searchText != ''){
            	helper.search(component);
            }else{
                $A.util.removeClass(component.find("combo"), 'slds-is-open');
            }
        }
        catch(e)
        {
            console.log(e);
        }
    },
    
    selectRecordJS : function(component, event, helper) {
		var combo = component.find("combo");
        var searchBox = component.find("searchBox");
        var searchPill = component.find("searchPill");
        $A.util.addClass(searchBox, 'slds-hide');
        $A.util.removeClass(searchBox, 'slds-show');
        $A.util.addClass(searchPill, 'slds-show');
        $A.util.removeClass(searchPill, 'slds-hide');
        $A.util.removeClass(combo, 'slds-is-open');
        
        var dataSelectedItem = event.currentTarget.getAttribute("data-selectedItem");
        var SearchResultLst = component.get("v.SearchResultList");
        for(var i=0; i<SearchResultLst.length; i++){
            if(SearchResultLst[i].Id == dataSelectedItem){
                component.set("v.LookupSelectedRecord", SearchResultLst[i]);
                component.set("v.LookupSelectedRecordId", SearchResultLst[i].Id);
                break;
            }
        }
	},
    
    removeSelectionJS : function(component, event, helper) {
        try
        {
            component.set("v.LookupSearchText", null);
            component.set("v.LookupSelectedRecord", null);
            component.set("v.LookupSelectedRecordId", null);
            component.set("v.SearchResultList", []);
            var searchBox = component.find("searchBox");
            var searchPill = component.find("searchPill");
            $A.util.addClass(searchBox, 'slds-show');
            $A.util.removeClass(searchBox, 'slds-hide');
            $A.util.addClass(searchPill, 'slds-hide');
            $A.util.removeClass(searchPill, 'slds-show');
        }
        catch(e)
        {
            console.log(e);
        }
    }
})