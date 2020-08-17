({
	search : function(cmp) {
        var action = cmp.get("c.searchObj");
        
        var f1 = cmp.get("v.LookupField_1");
        var f2 = cmp.get("v.LookupField_2");
        var f3 = cmp.get("v.LookupField_3");
        
        action.setParams({
            'obj': cmp.get("v.LookupObject"),
            'f1': f1,
            'f2': f2,
            'f3': f3,
            'searchText': cmp.get("v.LookupSearchText"),
            'additionalClause': cmp.get("v.LookupAdditionalClause"),
            'rowLimit': cmp.get("v.LookupRowLimit"),
            'withSharing': cmp.get("v.withSharing")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") 
            {
                var res = response.getReturnValue();
                var combo = cmp.find("combo");
                if (res.length == 0) 
                {
                    cmp.set("v.Message", 'No Result Found...');
                    $A.util.removeClass(combo, 'slds-is-open');
                }
                else if (res.length > 0)
                {
                    res.forEach(function(resultItem){
                        resultItem.f1 = resultItem[f1];
                        resultItem.f2 = resultItem[f2];
                        resultItem.f3 = resultItem[f3];
                    });
                    cmp.set("v.SearchResultList", res);
                    $A.util.addClass(combo, 'slds-is-open');
                }
                else
                {
                    console.log('cLookupHelper.search: controller returned obj: ' + res);
                }
            }
        });
        
        $A.enqueueAction(action);
	}
})