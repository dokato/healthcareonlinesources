document.addEventListener('DOMContentLoaded', function () {
    var test = document.getElementById("firstText").innerHTML;
    document.getElementById("secondText").innerHTML=Math.random();

/* 
   chrome.tabs.query (
        { currentWindow: true, active: true }, 
        function(tabs) {
            var activeTab = tabs[0];
            var address = activeTab.url;
            alert(JSON.stringify(address));
    });
*/
});
