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
Array.prototype.sum = function()
{
    var res = 0
    for (var i = 0; i < this.length; i++)
    {
        res += this[i];
    }
    return res;
}
var sum =   new Array().
                range(1, 99).
                filter(function (n) { return (n % 3 == 0); }).
                sum();
WScript.Echo(sum);
