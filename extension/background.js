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

const views = chrome.extension.getViews({
    type: "popup"
});

const url = chrome.runtime.getURL('data/info.json');

chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
	chrome.runtime.getPackageDirectoryEntry(function(root) {
		root.getFile("data/info.json", {}, function(fileEntry) {
			fileEntry.file(function(file) {
                var reader = new FileReader();
                var flag = 0;
				reader.onloadend = function(e) {
					var webData = JSON.parse(this.result);
                    console.log(webData);
                    for (const key in webData) {
                        compareUrl(key, webData[key], request);
                    }
				};
				reader.readAsText(file);
			});
		});
	});
})
