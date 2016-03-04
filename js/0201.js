Array.prototype.range = function(start, end)
{
    var array = new Array();
    var j = 0;
    for (var i = start; i <= end; i++)
    {
        array[j++] = i;
    }
    return array;
}
Array.prototype.map = function(func)
{
    for (var i = 0; i < this.length; i++)
    {
        func(this[i]);
    }
}
var array = new Array().
    range(1, 9).
    map(function (n) { WScript.Echo(n); });
