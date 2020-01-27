function compareUrlForPop(key, url){
    var rex = new RegExp(key, 'g');
    var a = rex.exec(url);
    if (a == null) {
        return 0;
    } else {
        return 1;
    }
}

function regCheckUrls(url, webData) {
    // The info.js should be sorted from the most specific to the least specific.
    for (const key in webData.webData) {
        comp = compareUrlForPop(key, url);
        if (comp === 1 ) {
            return key;
        }
    }
    return url;
};


document.addEventListener('DOMContentLoaded', function () {
    var test = document.getElementById("reminder").innerHTML;

   chrome.tabs.query (
        { currentWindow: true, active: true }, 
        function(tabs) {
            var activeTab = tabs[0];
            var address = activeTab.url;
            chrome.storage.local.get(['webData'], function(webData){
                document.getElementById("firstRow").innerHTML = address;
                var newaddress = regCheckUrls(address, webData);
                var score = webData.webData[newaddress];
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

