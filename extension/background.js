function changeIconBad(){
    chrome.browserAction.setIcon({path: "images/icon-bad.png"});
}

function changeIconGood(){
    chrome.browserAction.setIcon({path: "images/icon32.png"});
}

function compareUrl(url, score, request){
    if (url.localeCompare(request.url) == 0) {
        console.log(url, score);
        if (score > 6) {
            changeIconGood();
        } else {
            changeIconBad();
        }
    } else {
        changeIconBad();
    };
}

const url = chrome.runtime.getURL('data/info.json');

chrome.extension.onConnect.addListener(function(port) {
    console.log("Connected .....");
    port.onMessage.addListener(function(msg) {
         console.log("message recieved" + msg);
         port.postMessage("Hi Popup.js");
    });
});                    

(function readJSON(){
    chrome.runtime.getPackageDirectoryEntry(function(root) {
        root.getFile("data/info.json", {}, function(fileEntry) {
            fileEntry.file(function(file) {
                var reader = new FileReader();
                var flag = 0;
                reader.onloadend = function(e) {
                    var webData = JSON.parse(this.result);
                    chrome.storage.local.set(webData);
                };
                reader.readAsText(file);
                

            });
        });
    });
})();


chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
    chrome.storage.local.get(['webData'], function(webData){
        for (const key in webData.webData) {
            compareUrl(key, webData.webData[key], request);
        };    
    })

})