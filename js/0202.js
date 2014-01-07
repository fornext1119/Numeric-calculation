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
Array.prototype.filter = function(func)
{
    var array = new Array();
    var j = 0;
    for (var i = 0; i < this.length; i++)
    {
        if (func(this[i])) array[j++] = this[i];
    }
    return array;
}
var array = new Array().
    range(1, 9).
    filter(function (n) { return (n % 3 == 0); }).
    map(function (n) { WScript.Echo(n); });
