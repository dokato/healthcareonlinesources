document.addEventListener('DOMContentLoaded', function () {
    var test = document.getElementById("reminder").innerHTML;
    //document.getElementById("secondRow").innerHTML = Math.random();

   chrome.tabs.query (
        { currentWindow: true, active: true }, 
        function(tabs) {
            var activeTab = tabs[0];
            var address = activeTab.url;
            //alert(JSON.stringify(address));
            chrome.storage.local.get(['webData'], function(webData){
                document.getElementById("firstRow").innerHTML = address;
                document.getElementById("secondRow").innerHTML = webData.webData[address];
            })        
        });
});

