triggers = "";

var tab = document.getElementsByClassName('tab');
var currentTab = "";
if (tab.length > 0) {
    currentTab = tab[0].getElementsByClassName('current')[0].outerText;
}

Array.prototype.slice.call(
    document.getElementsByClassName('frameTbl')
).forEach(function(table){
    if (currentTab == "") {
        trigger = table.getAttribute("vtrigger");
    } else {
        trigger = table.getAttribute("vtrigger") + "(" + currentTab + ")";
    }

    moves = "";
    type = "";

    Array.prototype.slice.call(table.getElementsByTagName('tr')).forEach(function(item){
        ths = item.getElementsByTagName('th')
        
        if (ths.length > 0 && ths[0].className == "type") {
            type = ths[0].innerText;
            return
        }

        tds = item.getElementsByTagName('td');

        if (tds.length <= 0) {
            return
        }

        move = `VT${trigger}` + "\t" + type + "\t";

        // 技名
        move += tds[0].getElementsByTagName('p')[0].innerText + "\t";

        // 発生 ~ Vキャン硬直差(ガード)
        for (var i = 1; i < 8; i++) {
            move += tds[i].innerText.split('\n')[0] + "\t";
        }

        moves += move + "\n";
    });

    if (trigger.slice(0, 1) == 1) {
        triggers = moves + "\n" + triggers;
    } else {
        triggers += moves + "\n";
    }
});

console.log(triggers);
