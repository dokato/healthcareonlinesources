function changeIconBad(){
    chrome.browserAction.setIcon({path: "images/icon-bad.png"});
}

function changeIconGood(){
    chrome.browserAction.setIcon({path: "images/icon-good.png"});
}

function compareUrl(url, request){
    var rex = new RegExp(url, 'g');
    var a = rex.exec(request.url);
    if (a == null) {
        return 0;
    } else {
        return 1;
    }
}

function notify() {
    chrome.notifications.create({
        type:     'basic',
        iconUrl:  'images/icon-bad.png',
        title:    'WHAT reminder',
        message:  'Be EXTREMELY careful when looking for a medical advice on this website',
        priority: 0});
}

function changeIcon(score){
    if (score > 6) {
        changeIconGood();
    } else if (score === 1 || score === 0) {
        changeIconBad();
        notify();
    } else {
        changeIconBad();
    }
}

function compareWithDataJSON(request) {
    // request must have url parameter
    chrome.storage.local.get(['webData'], function(webData){
        var comp = 0;
        for (const key in webData.webData) {
            comp = compareUrl(key, request);
            if (comp === 1 ) { // if data found in database changed icon to appropiate
                changeIcon(webData.webData[key])
                break;
            }
        };
        if (comp === 0){ // if hasn't been found change to red
            changeIcon(-1);
        }
    })
}

const url = chrome.runtime.getURL('data/info.json');

(function readJSON(){
    chrome.runtime.getPackageDirectoryEntry(function(root) {
        root.getFile("data/info.json", {}, function(fileEntry) {
            fileEntry.file(function(file) {
                var reader = new FileReader();
                var flag = 0;
                reader.onloadend = function(e) {
                    var webData = JSON.parse(this.result);
                    chrome.storage.local.set({"webData": webData});
                };
                reader.readAsText(file);             

            });
        });
    });
})();

chrome.tabs.onActivated.addListener(function(activeInfo){
    var tab = chrome.tabs.get(activeInfo.tabId, function(tab) {
        compareWithDataJSON(tab);
    })
});

chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
    compareWithDataJSON(request);
});
