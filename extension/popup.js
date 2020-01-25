document.addEventListener('DOMContentLoaded', function () {
    var test = document.getElementById("reminder").innerHTML;

   chrome.tabs.query (
        { currentWindow: true, active: true }, 
        function(tabs) {
            var activeTab = tabs[0];
            var address = activeTab.url;
            //alert(JSON.stringify(address));
            chrome.storage.local.get(['webData'], function(webData){
                document.getElementById("firstRow").innerHTML = address;
                var score = webData.webData[address];
                if (score === undefined) {
                    document.getElementById("secondRow").innerHTML = undefined;
                } else {
                    var col = (score > 6) ? 'green' : 'red';
                    var row = "<span style='color:" + col + "'>" + score + "/10</span>"
                    document.getElementById("secondRow").innerHTML = row;
                }
            })        
        });
});

