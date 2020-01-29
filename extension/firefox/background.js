function changeIconBad(){
    browser.browserAction.setIcon({path: "images/icon-bad.png"});
}

function changeIconGood(){
    browser.browserAction.setIcon({path: "images/icon-good.png"});
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
    browser.notifications.create({
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

const url = browser.runtime.getURL('data/info.json');

(function readJSON(){
    browser.runtime.getPackageDirectoryEntry(function(root) {
        root.getFile("data/info.json", {}, function(fileEntry) {
            fileEntry.file(function(file) {
                var reader = new FileReader();
                var flag = 0;
                reader.onloadend = function(e) {
                    var webData = JSON.parse(this.result);
                    browser.storage.local.set({"webData": webData});
                };
                reader.readAsText(file);             

            });
        });
    });
})();


browser.runtime.onMessage.addListener(function (request, sender, sendResponse) {
    browser.storage.local.get(['webData'], function(webData){
        var comp = 0;
        for (const key in webData.webData) {
            comp = compareUrl(key, request);
            if (comp === 1 ) {
                changeIcon(webData.webData[key])
                break;
            }
        };
        console.log(comp);
        if (comp === 0){
            changeIcon(-1);
        }
    })

})