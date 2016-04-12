var myVar = setInterval(randVal, 400);
var dec = 8
var pow = Math.pow(10, dec)
function randVal() {
    var rn = Math.round(Math.random() * pow) / pow
    for(var word = rn.toString(); word.length < dec + 2; word += '0'){}
    document.getElementById("randloop").innerHTML = word
}

