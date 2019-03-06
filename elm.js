
(function() {
'use strict';

function F2(fun)
{
  function wrapper(a) { return function(b) { return fun(a,b); }; }
  wrapper.arity = 2;
  wrapper.func = fun;
  return wrapper;
}

function F3(fun)
{
  function wrapper(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  }
  wrapper.arity = 3;
  wrapper.func = fun;
  return wrapper;
}

function F4(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  }
  wrapper.arity = 4;
  wrapper.func = fun;
  return wrapper;
}

function F5(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  }
  wrapper.arity = 5;
  wrapper.func = fun;
  return wrapper;
}

function F6(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  }
  wrapper.arity = 6;
  wrapper.func = fun;
  return wrapper;
}

function F7(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  }
  wrapper.arity = 7;
  wrapper.func = fun;
  return wrapper;
}

function F8(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  }
  wrapper.arity = 8;
  wrapper.func = fun;
  return wrapper;
}

function F9(fun)
{
  function wrapper(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  }
  wrapper.arity = 9;
  wrapper.func = fun;
  return wrapper;
}

function A2(fun, a, b)
{
  return fun.arity === 2
    ? fun.func(a, b)
    : fun(a)(b);
}
function A3(fun, a, b, c)
{
  return fun.arity === 3
    ? fun.func(a, b, c)
    : fun(a)(b)(c);
}
function A4(fun, a, b, c, d)
{
  return fun.arity === 4
    ? fun.func(a, b, c, d)
    : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e)
{
  return fun.arity === 5
    ? fun.func(a, b, c, d, e)
    : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f)
{
  return fun.arity === 6
    ? fun.func(a, b, c, d, e, f)
    : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g)
{
  return fun.arity === 7
    ? fun.func(a, b, c, d, e, f, g)
    : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h)
{
  return fun.arity === 8
    ? fun.func(a, b, c, d, e, f, g, h)
    : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i)
{
  return fun.arity === 9
    ? fun.func(a, b, c, d, e, f, g, h, i)
    : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

var _elm_lang$core$Native_Bitwise = function() {

return {
	and: F2(function and(a, b) { return a & b; }),
	or: F2(function or(a, b) { return a | b; }),
	xor: F2(function xor(a, b) { return a ^ b; }),
	complement: function complement(a) { return ~a; },
	shiftLeftBy: F2(function(offset, a) { return a << offset; }),
	shiftRightBy: F2(function(offset, a) { return a >> offset; }),
	shiftRightZfBy: F2(function(offset, a) { return a >>> offset; })
};

}();

var _elm_lang$core$Bitwise$shiftRightZfBy = _elm_lang$core$Native_Bitwise.shiftRightZfBy;
var _elm_lang$core$Bitwise$shiftRightBy = _elm_lang$core$Native_Bitwise.shiftRightBy;
var _elm_lang$core$Bitwise$shiftLeftBy = _elm_lang$core$Native_Bitwise.shiftLeftBy;
var _elm_lang$core$Bitwise$complement = _elm_lang$core$Native_Bitwise.complement;
var _elm_lang$core$Bitwise$xor = _elm_lang$core$Native_Bitwise.xor;
var _elm_lang$core$Bitwise$or = _elm_lang$core$Native_Bitwise.or;
var _elm_lang$core$Bitwise$and = _elm_lang$core$Native_Bitwise.and;

//import Native.Utils //

var _elm_lang$core$Native_Basics = function() {

function div(a, b)
{
	return (a / b) | 0;
}
function rem(a, b)
{
	return a % b;
}
function mod(a, b)
{
	if (b === 0)
	{
		throw new Error('Cannot perform mod 0. Division by zero error.');
	}
	var r = a % b;
	var m = a === 0 ? 0 : (b > 0 ? (a >= 0 ? r : r + b) : -mod(-a, -b));

	return m === b ? 0 : m;
}
function logBase(base, n)
{
	return Math.log(n) / Math.log(base);
}
function negate(n)
{
	return -n;
}
function abs(n)
{
	return n < 0 ? -n : n;
}

function min(a, b)
{
	return _elm_lang$core$Native_Utils.cmp(a, b) < 0 ? a : b;
}
function max(a, b)
{
	return _elm_lang$core$Native_Utils.cmp(a, b) > 0 ? a : b;
}
function clamp(lo, hi, n)
{
	return _elm_lang$core$Native_Utils.cmp(n, lo) < 0
		? lo
		: _elm_lang$core$Native_Utils.cmp(n, hi) > 0
			? hi
			: n;
}

var ord = ['LT', 'EQ', 'GT'];

function compare(x, y)
{
	return { ctor: ord[_elm_lang$core$Native_Utils.cmp(x, y) + 1] };
}

function xor(a, b)
{
	return a !== b;
}
function not(b)
{
	return !b;
}
function isInfinite(n)
{
	return n === Infinity || n === -Infinity;
}

function truncate(n)
{
	return n | 0;
}

function degrees(d)
{
	return d * Math.PI / 180;
}
function turns(t)
{
	return 2 * Math.PI * t;
}
function fromPolar(point)
{
	var r = point._0;
	var t = point._1;
	return _elm_lang$core$Native_Utils.Tuple2(r * Math.cos(t), r * Math.sin(t));
}
function toPolar(point)
{
	var x = point._0;
	var y = point._1;
	return _elm_lang$core$Native_Utils.Tuple2(Math.sqrt(x * x + y * y), Math.atan2(y, x));
}

return {
	div: F2(div),
	rem: F2(rem),
	mod: F2(mod),

	pi: Math.PI,
	e: Math.E,
	cos: Math.cos,
	sin: Math.sin,
	tan: Math.tan,
	acos: Math.acos,
	asin: Math.asin,
	atan: Math.atan,
	atan2: F2(Math.atan2),

	degrees: degrees,
	turns: turns,
	fromPolar: fromPolar,
	toPolar: toPolar,

	sqrt: Math.sqrt,
	logBase: F2(logBase),
	negate: negate,
	abs: abs,
	min: F2(min),
	max: F2(max),
	clamp: F3(clamp),
	compare: F2(compare),

	xor: F2(xor),
	not: not,

	truncate: truncate,
	ceiling: Math.ceil,
	floor: Math.floor,
	round: Math.round,
	toFloat: function(x) { return x; },
	isNaN: isNaN,
	isInfinite: isInfinite
};

}();
//import //

var _elm_lang$core$Native_Utils = function() {

// COMPARISONS

function eq(x, y)
{
	var stack = [];
	var isEqual = eqHelp(x, y, 0, stack);
	var pair;
	while (isEqual && (pair = stack.pop()))
	{
		isEqual = eqHelp(pair.x, pair.y, 0, stack);
	}
	return isEqual;
}


function eqHelp(x, y, depth, stack)
{
	if (depth > 100)
	{
		stack.push({ x: x, y: y });
		return true;
	}

	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object')
	{
		if (typeof x === 'function')
		{
			throw new Error(
				'Trying to use `(==)` on functions. There is no way to know if functions are "the same" in the Elm sense.'
				+ ' Read more about this at http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#=='
				+ ' which describes why it is this way and what the better version will look like.'
			);
		}
		return false;
	}

	if (x === null || y === null)
	{
		return false
	}

	if (x instanceof Date)
	{
		return x.getTime() === y.getTime();
	}

	if (!('ctor' in x))
	{
		for (var key in x)
		{
			if (!eqHelp(x[key], y[key], depth + 1, stack))
			{
				return false;
			}
		}
		return true;
	}

	// convert Dicts and Sets to lists
	if (x.ctor === 'RBNode_elm_builtin' || x.ctor === 'RBEmpty_elm_builtin')
	{
		x = _elm_lang$core$Dict$toList(x);
		y = _elm_lang$core$Dict$toList(y);
	}
	if (x.ctor === 'Set_elm_builtin')
	{
		x = _elm_lang$core$Set$toList(x);
		y = _elm_lang$core$Set$toList(y);
	}

	// check if lists are equal without recursion
	if (x.ctor === '::')
	{
		var a = x;
		var b = y;
		while (a.ctor === '::' && b.ctor === '::')
		{
			if (!eqHelp(a._0, b._0, depth + 1, stack))
			{
				return false;
			}
			a = a._1;
			b = b._1;
		}
		return a.ctor === b.ctor;
	}

	// check if Arrays are equal
	if (x.ctor === '_Array')
	{
		var xs = _elm_lang$core$Native_Array.toJSArray(x);
		var ys = _elm_lang$core$Native_Array.toJSArray(y);
		if (xs.length !== ys.length)
		{
			return false;
		}
		for (var i = 0; i < xs.length; i++)
		{
			if (!eqHelp(xs[i], ys[i], depth + 1, stack))
			{
				return false;
			}
		}
		return true;
	}

	if (!eqHelp(x.ctor, y.ctor, depth + 1, stack))
	{
		return false;
	}

	for (var key in x)
	{
		if (!eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

var LT = -1, EQ = 0, GT = 1;

function cmp(x, y)
{
	if (typeof x !== 'object')
	{
		return x === y ? EQ : x < y ? LT : GT;
	}

	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? EQ : a < b ? LT : GT;
	}

	if (x.ctor === '::' || x.ctor === '[]')
	{
		while (x.ctor === '::' && y.ctor === '::')
		{
			var ord = cmp(x._0, y._0);
			if (ord !== EQ)
			{
				return ord;
			}
			x = x._1;
			y = y._1;
		}
		return x.ctor === y.ctor ? EQ : x.ctor === '[]' ? LT : GT;
	}

	if (x.ctor.slice(0, 6) === '_Tuple')
	{
		var ord;
		var n = x.ctor.slice(6) - 0;
		var err = 'cannot compare tuples with more than 6 elements.';
		if (n === 0) return EQ;
		if (n >= 1) { ord = cmp(x._0, y._0); if (ord !== EQ) return ord;
		if (n >= 2) { ord = cmp(x._1, y._1); if (ord !== EQ) return ord;
		if (n >= 3) { ord = cmp(x._2, y._2); if (ord !== EQ) return ord;
		if (n >= 4) { ord = cmp(x._3, y._3); if (ord !== EQ) return ord;
		if (n >= 5) { ord = cmp(x._4, y._4); if (ord !== EQ) return ord;
		if (n >= 6) { ord = cmp(x._5, y._5); if (ord !== EQ) return ord;
		if (n >= 7) throw new Error('Comparison error: ' + err); } } } } } }
		return EQ;
	}

	throw new Error(
		'Comparison error: comparison is only defined on ints, '
		+ 'floats, times, chars, strings, lists of comparable values, '
		+ 'and tuples of comparable values.'
	);
}


// COMMON VALUES

var Tuple0 = {
	ctor: '_Tuple0'
};

function Tuple2(x, y)
{
	return {
		ctor: '_Tuple2',
		_0: x,
		_1: y
	};
}

function chr(c)
{
	return new String(c);
}


// GUID

var count = 0;
function guid(_)
{
	return count++;
}


// RECORDS

function update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


//// LIST STUFF ////

var Nil = { ctor: '[]' };

function Cons(hd, tl)
{
	return {
		ctor: '::',
		_0: hd,
		_1: tl
	};
}

function append(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (xs.ctor === '[]')
	{
		return ys;
	}
	var root = Cons(xs._0, Nil);
	var curr = root;
	xs = xs._1;
	while (xs.ctor !== '[]')
	{
		curr._1 = Cons(xs._0, Nil);
		xs = xs._1;
		curr = curr._1;
	}
	curr._1 = ys;
	return root;
}


// CRASHES

function crash(moduleName, region)
{
	return function(message) {
		throw new Error(
			'Ran into a `Debug.crash` in module `' + moduleName + '` ' + regionToString(region) + '\n'
			+ 'The message provided by the code author is:\n\n    '
			+ message
		);
	};
}

function crashCase(moduleName, region, value)
{
	return function(message) {
		throw new Error(
			'Ran into a `Debug.crash` in module `' + moduleName + '`\n\n'
			+ 'This was caused by the `case` expression ' + regionToString(region) + '.\n'
			+ 'One of the branches ended with a crash and the following value got through:\n\n    ' + toString(value) + '\n\n'
			+ 'The message provided by the code author is:\n\n    '
			+ message
		);
	};
}

function regionToString(region)
{
	if (region.start.line == region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'between lines ' + region.start.line + ' and ' + region.end.line;
}


// TO STRING

function toString(v)
{
	var type = typeof v;
	if (type === 'function')
	{
		return '<function>';
	}

	if (type === 'boolean')
	{
		return v ? 'True' : 'False';
	}

	if (type === 'number')
	{
		return v + '';
	}

	if (v instanceof String)
	{
		return '\'' + addSlashes(v, true) + '\'';
	}

	if (type === 'string')
	{
		return '"' + addSlashes(v, false) + '"';
	}

	if (v === null)
	{
		return 'null';
	}

	if (type === 'object' && 'ctor' in v)
	{
		var ctorStarter = v.ctor.substring(0, 5);

		if (ctorStarter === '_Tupl')
		{
			var output = [];
			for (var k in v)
			{
				if (k === 'ctor') continue;
				output.push(toString(v[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (ctorStarter === '_Task')
		{
			return '<task>'
		}

		if (v.ctor === '_Array')
		{
			var list = _elm_lang$core$Array$toList(v);
			return 'Array.fromList ' + toString(list);
		}

		if (v.ctor === '<decoder>')
		{
			return '<decoder>';
		}

		if (v.ctor === '_Process')
		{
			return '<process:' + v.id + '>';
		}

		if (v.ctor === '::')
		{
			var output = '[' + toString(v._0);
			v = v._1;
			while (v.ctor === '::')
			{
				output += ',' + toString(v._0);
				v = v._1;
			}
			return output + ']';
		}

		if (v.ctor === '[]')
		{
			return '[]';
		}

		if (v.ctor === 'Set_elm_builtin')
		{
			return 'Set.fromList ' + toString(_elm_lang$core$Set$toList(v));
		}

		if (v.ctor === 'RBNode_elm_builtin' || v.ctor === 'RBEmpty_elm_builtin')
		{
			return 'Dict.fromList ' + toString(_elm_lang$core$Dict$toList(v));
		}

		var output = '';
		for (var i in v)
		{
			if (i === 'ctor') continue;
			var str = toString(v[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return v.ctor + output;
	}

	if (type === 'object')
	{
		if (v instanceof Date)
		{
			return '<' + v.toString() + '>';
		}

		if (v.elm_web_socket)
		{
			return '<websocket>';
		}

		var output = [];
		for (var k in v)
		{
			output.push(k + ' = ' + toString(v[k]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return '<internal structure>';
}

function addSlashes(str, isChar)
{
	var s = str.replace(/\\/g, '\\\\')
			  .replace(/\n/g, '\\n')
			  .replace(/\t/g, '\\t')
			  .replace(/\r/g, '\\r')
			  .replace(/\v/g, '\\v')
			  .replace(/\0/g, '\\0');
	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}


return {
	eq: eq,
	cmp: cmp,
	Tuple0: Tuple0,
	Tuple2: Tuple2,
	chr: chr,
	update: update,
	guid: guid,

	append: F2(append),

	crash: crash,
	crashCase: crashCase,

	toString: toString
};

}();
var _elm_lang$core$Basics$never = function (_p0) {
	never:
	while (true) {
		var _p1 = _p0;
		var _v1 = _p1._0;
		_p0 = _v1;
		continue never;
	}
};
var _elm_lang$core$Basics$uncurry = F2(
	function (f, _p2) {
		var _p3 = _p2;
		return A2(f, _p3._0, _p3._1);
	});
var _elm_lang$core$Basics$curry = F3(
	function (f, a, b) {
		return f(
			{ctor: '_Tuple2', _0: a, _1: b});
	});
var _elm_lang$core$Basics$flip = F3(
	function (f, b, a) {
		return A2(f, a, b);
	});
var _elm_lang$core$Basics$always = F2(
	function (a, _p4) {
		return a;
	});
var _elm_lang$core$Basics$identity = function (x) {
	return x;
};
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<|'] = F2(
	function (f, x) {
		return f(x);
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['|>'] = F2(
	function (x, f) {
		return f(x);
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['>>'] = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<<'] = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['++'] = _elm_lang$core$Native_Utils.append;
var _elm_lang$core$Basics$toString = _elm_lang$core$Native_Utils.toString;
var _elm_lang$core$Basics$isInfinite = _elm_lang$core$Native_Basics.isInfinite;
var _elm_lang$core$Basics$isNaN = _elm_lang$core$Native_Basics.isNaN;
var _elm_lang$core$Basics$toFloat = _elm_lang$core$Native_Basics.toFloat;
var _elm_lang$core$Basics$ceiling = _elm_lang$core$Native_Basics.ceiling;
var _elm_lang$core$Basics$floor = _elm_lang$core$Native_Basics.floor;
var _elm_lang$core$Basics$truncate = _elm_lang$core$Native_Basics.truncate;
var _elm_lang$core$Basics$round = _elm_lang$core$Native_Basics.round;
var _elm_lang$core$Basics$not = _elm_lang$core$Native_Basics.not;
var _elm_lang$core$Basics$xor = _elm_lang$core$Native_Basics.xor;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['||'] = _elm_lang$core$Native_Basics.or;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['&&'] = _elm_lang$core$Native_Basics.and;
var _elm_lang$core$Basics$max = _elm_lang$core$Native_Basics.max;
var _elm_lang$core$Basics$min = _elm_lang$core$Native_Basics.min;
var _elm_lang$core$Basics$compare = _elm_lang$core$Native_Basics.compare;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['>='] = _elm_lang$core$Native_Basics.ge;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<='] = _elm_lang$core$Native_Basics.le;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['>'] = _elm_lang$core$Native_Basics.gt;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['<'] = _elm_lang$core$Native_Basics.lt;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['/='] = _elm_lang$core$Native_Basics.neq;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['=='] = _elm_lang$core$Native_Basics.eq;
var _elm_lang$core$Basics$e = _elm_lang$core$Native_Basics.e;
var _elm_lang$core$Basics$pi = _elm_lang$core$Native_Basics.pi;
var _elm_lang$core$Basics$clamp = _elm_lang$core$Native_Basics.clamp;
var _elm_lang$core$Basics$logBase = _elm_lang$core$Native_Basics.logBase;
var _elm_lang$core$Basics$abs = _elm_lang$core$Native_Basics.abs;
var _elm_lang$core$Basics$negate = _elm_lang$core$Native_Basics.negate;
var _elm_lang$core$Basics$sqrt = _elm_lang$core$Native_Basics.sqrt;
var _elm_lang$core$Basics$atan2 = _elm_lang$core$Native_Basics.atan2;
var _elm_lang$core$Basics$atan = _elm_lang$core$Native_Basics.atan;
var _elm_lang$core$Basics$asin = _elm_lang$core$Native_Basics.asin;
var _elm_lang$core$Basics$acos = _elm_lang$core$Native_Basics.acos;
var _elm_lang$core$Basics$tan = _elm_lang$core$Native_Basics.tan;
var _elm_lang$core$Basics$sin = _elm_lang$core$Native_Basics.sin;
var _elm_lang$core$Basics$cos = _elm_lang$core$Native_Basics.cos;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['^'] = _elm_lang$core$Native_Basics.exp;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['%'] = _elm_lang$core$Native_Basics.mod;
var _elm_lang$core$Basics$rem = _elm_lang$core$Native_Basics.rem;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['//'] = _elm_lang$core$Native_Basics.div;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['/'] = _elm_lang$core$Native_Basics.floatDiv;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['*'] = _elm_lang$core$Native_Basics.mul;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['-'] = _elm_lang$core$Native_Basics.sub;
var _elm_lang$core$Basics_ops = _elm_lang$core$Basics_ops || {};
_elm_lang$core$Basics_ops['+'] = _elm_lang$core$Native_Basics.add;
var _elm_lang$core$Basics$toPolar = _elm_lang$core$Native_Basics.toPolar;
var _elm_lang$core$Basics$fromPolar = _elm_lang$core$Native_Basics.fromPolar;
var _elm_lang$core$Basics$turns = _elm_lang$core$Native_Basics.turns;
var _elm_lang$core$Basics$degrees = _elm_lang$core$Native_Basics.degrees;
var _elm_lang$core$Basics$radians = function (t) {
	return t;
};
var _elm_lang$core$Basics$GT = {ctor: 'GT'};
var _elm_lang$core$Basics$EQ = {ctor: 'EQ'};
var _elm_lang$core$Basics$LT = {ctor: 'LT'};
var _elm_lang$core$Basics$JustOneMore = function (a) {
	return {ctor: 'JustOneMore', _0: a};
};

//import Native.Utils //

var _elm_lang$core$Native_Debug = function() {

function log(tag, value)
{
	var msg = tag + ': ' + _elm_lang$core$Native_Utils.toString(value);
	var process = process || {};
	if (process.stdout)
	{
		process.stdout.write(msg);
	}
	else
	{
		console.log(msg);
	}
	return value;
}

function crash(message)
{
	throw new Error(message);
}

return {
	crash: crash,
	log: F2(log)
};

}();
var _elm_lang$core$Debug$crash = _elm_lang$core$Native_Debug.crash;
var _elm_lang$core$Debug$log = _elm_lang$core$Native_Debug.log;

var _elm_lang$core$Maybe$withDefault = F2(
	function ($default, maybe) {
		var _p0 = maybe;
		if (_p0.ctor === 'Just') {
			return _p0._0;
		} else {
			return $default;
		}
	});
var _elm_lang$core$Maybe$Nothing = {ctor: 'Nothing'};
var _elm_lang$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		var _p1 = maybeValue;
		if (_p1.ctor === 'Just') {
			return callback(_p1._0);
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$Just = function (a) {
	return {ctor: 'Just', _0: a};
};
var _elm_lang$core$Maybe$map = F2(
	function (f, maybe) {
		var _p2 = maybe;
		if (_p2.ctor === 'Just') {
			return _elm_lang$core$Maybe$Just(
				f(_p2._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map2 = F3(
	function (func, ma, mb) {
		var _p3 = {ctor: '_Tuple2', _0: ma, _1: mb};
		if (((_p3.ctor === '_Tuple2') && (_p3._0.ctor === 'Just')) && (_p3._1.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A2(func, _p3._0._0, _p3._1._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map3 = F4(
	function (func, ma, mb, mc) {
		var _p4 = {ctor: '_Tuple3', _0: ma, _1: mb, _2: mc};
		if ((((_p4.ctor === '_Tuple3') && (_p4._0.ctor === 'Just')) && (_p4._1.ctor === 'Just')) && (_p4._2.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A3(func, _p4._0._0, _p4._1._0, _p4._2._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map4 = F5(
	function (func, ma, mb, mc, md) {
		var _p5 = {ctor: '_Tuple4', _0: ma, _1: mb, _2: mc, _3: md};
		if (((((_p5.ctor === '_Tuple4') && (_p5._0.ctor === 'Just')) && (_p5._1.ctor === 'Just')) && (_p5._2.ctor === 'Just')) && (_p5._3.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A4(func, _p5._0._0, _p5._1._0, _p5._2._0, _p5._3._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_lang$core$Maybe$map5 = F6(
	function (func, ma, mb, mc, md, me) {
		var _p6 = {ctor: '_Tuple5', _0: ma, _1: mb, _2: mc, _3: md, _4: me};
		if ((((((_p6.ctor === '_Tuple5') && (_p6._0.ctor === 'Just')) && (_p6._1.ctor === 'Just')) && (_p6._2.ctor === 'Just')) && (_p6._3.ctor === 'Just')) && (_p6._4.ctor === 'Just')) {
			return _elm_lang$core$Maybe$Just(
				A5(func, _p6._0._0, _p6._1._0, _p6._2._0, _p6._3._0, _p6._4._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});

//import Native.Utils //

var _elm_lang$core$Native_List = function() {

var Nil = { ctor: '[]' };

function Cons(hd, tl)
{
	return { ctor: '::', _0: hd, _1: tl };
}

function fromArray(arr)
{
	var out = Nil;
	for (var i = arr.length; i--; )
	{
		out = Cons(arr[i], out);
	}
	return out;
}

function toArray(xs)
{
	var out = [];
	while (xs.ctor !== '[]')
	{
		out.push(xs._0);
		xs = xs._1;
	}
	return out;
}

function foldr(f, b, xs)
{
	var arr = toArray(xs);
	var acc = b;
	for (var i = arr.length; i--; )
	{
		acc = A2(f, arr[i], acc);
	}
	return acc;
}

function map2(f, xs, ys)
{
	var arr = [];
	while (xs.ctor !== '[]' && ys.ctor !== '[]')
	{
		arr.push(A2(f, xs._0, ys._0));
		xs = xs._1;
		ys = ys._1;
	}
	return fromArray(arr);
}

function map3(f, xs, ys, zs)
{
	var arr = [];
	while (xs.ctor !== '[]' && ys.ctor !== '[]' && zs.ctor !== '[]')
	{
		arr.push(A3(f, xs._0, ys._0, zs._0));
		xs = xs._1;
		ys = ys._1;
		zs = zs._1;
	}
	return fromArray(arr);
}

function map4(f, ws, xs, ys, zs)
{
	var arr = [];
	while (   ws.ctor !== '[]'
		   && xs.ctor !== '[]'
		   && ys.ctor !== '[]'
		   && zs.ctor !== '[]')
	{
		arr.push(A4(f, ws._0, xs._0, ys._0, zs._0));
		ws = ws._1;
		xs = xs._1;
		ys = ys._1;
		zs = zs._1;
	}
	return fromArray(arr);
}

function map5(f, vs, ws, xs, ys, zs)
{
	var arr = [];
	while (   vs.ctor !== '[]'
		   && ws.ctor !== '[]'
		   && xs.ctor !== '[]'
		   && ys.ctor !== '[]'
		   && zs.ctor !== '[]')
	{
		arr.push(A5(f, vs._0, ws._0, xs._0, ys._0, zs._0));
		vs = vs._1;
		ws = ws._1;
		xs = xs._1;
		ys = ys._1;
		zs = zs._1;
	}
	return fromArray(arr);
}

function sortBy(f, xs)
{
	return fromArray(toArray(xs).sort(function(a, b) {
		return _elm_lang$core$Native_Utils.cmp(f(a), f(b));
	}));
}

function sortWith(f, xs)
{
	return fromArray(toArray(xs).sort(function(a, b) {
		var ord = f(a)(b).ctor;
		return ord === 'EQ' ? 0 : ord === 'LT' ? -1 : 1;
	}));
}

return {
	Nil: Nil,
	Cons: Cons,
	cons: F2(Cons),
	toArray: toArray,
	fromArray: fromArray,

	foldr: F3(foldr),

	map2: F3(map2),
	map3: F4(map3),
	map4: F5(map4),
	map5: F6(map5),
	sortBy: F2(sortBy),
	sortWith: F2(sortWith)
};

}();
var _elm_lang$core$List$sortWith = _elm_lang$core$Native_List.sortWith;
var _elm_lang$core$List$sortBy = _elm_lang$core$Native_List.sortBy;
var _elm_lang$core$List$sort = function (xs) {
	return A2(_elm_lang$core$List$sortBy, _elm_lang$core$Basics$identity, xs);
};
var _elm_lang$core$List$singleton = function (value) {
	return {
		ctor: '::',
		_0: value,
		_1: {ctor: '[]'}
	};
};
var _elm_lang$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
				return list;
			} else {
				var _p0 = list;
				if (_p0.ctor === '[]') {
					return list;
				} else {
					var _v1 = n - 1,
						_v2 = _p0._1;
					n = _v1;
					list = _v2;
					continue drop;
				}
			}
		}
	});
var _elm_lang$core$List$map5 = _elm_lang$core$Native_List.map5;
var _elm_lang$core$List$map4 = _elm_lang$core$Native_List.map4;
var _elm_lang$core$List$map3 = _elm_lang$core$Native_List.map3;
var _elm_lang$core$List$map2 = _elm_lang$core$Native_List.map2;
var _elm_lang$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			var _p1 = list;
			if (_p1.ctor === '[]') {
				return false;
			} else {
				if (isOkay(_p1._0)) {
					return true;
				} else {
					var _v4 = isOkay,
						_v5 = _p1._1;
					isOkay = _v4;
					list = _v5;
					continue any;
				}
			}
		}
	});
var _elm_lang$core$List$all = F2(
	function (isOkay, list) {
		return !A2(
			_elm_lang$core$List$any,
			function (_p2) {
				return !isOkay(_p2);
			},
			list);
	});
var _elm_lang$core$List$foldr = _elm_lang$core$Native_List.foldr;
var _elm_lang$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			var _p3 = list;
			if (_p3.ctor === '[]') {
				return acc;
			} else {
				var _v7 = func,
					_v8 = A2(func, _p3._0, acc),
					_v9 = _p3._1;
				func = _v7;
				acc = _v8;
				list = _v9;
				continue foldl;
			}
		}
	});
var _elm_lang$core$List$length = function (xs) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (_p4, i) {
				return i + 1;
			}),
		0,
		xs);
};
var _elm_lang$core$List$sum = function (numbers) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (x, y) {
				return x + y;
			}),
		0,
		numbers);
};
var _elm_lang$core$List$product = function (numbers) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (x, y) {
				return x * y;
			}),
		1,
		numbers);
};
var _elm_lang$core$List$maximum = function (list) {
	var _p5 = list;
	if (_p5.ctor === '::') {
		return _elm_lang$core$Maybe$Just(
			A3(_elm_lang$core$List$foldl, _elm_lang$core$Basics$max, _p5._0, _p5._1));
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List$minimum = function (list) {
	var _p6 = list;
	if (_p6.ctor === '::') {
		return _elm_lang$core$Maybe$Just(
			A3(_elm_lang$core$List$foldl, _elm_lang$core$Basics$min, _p6._0, _p6._1));
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List$member = F2(
	function (x, xs) {
		return A2(
			_elm_lang$core$List$any,
			function (a) {
				return _elm_lang$core$Native_Utils.eq(a, x);
			},
			xs);
	});
var _elm_lang$core$List$isEmpty = function (xs) {
	var _p7 = xs;
	if (_p7.ctor === '[]') {
		return true;
	} else {
		return false;
	}
};
var _elm_lang$core$List$tail = function (list) {
	var _p8 = list;
	if (_p8.ctor === '::') {
		return _elm_lang$core$Maybe$Just(_p8._1);
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List$head = function (list) {
	var _p9 = list;
	if (_p9.ctor === '::') {
		return _elm_lang$core$Maybe$Just(_p9._0);
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$List_ops = _elm_lang$core$List_ops || {};
_elm_lang$core$List_ops['::'] = _elm_lang$core$Native_List.cons;
var _elm_lang$core$List$map = F2(
	function (f, xs) {
		return A3(
			_elm_lang$core$List$foldr,
			F2(
				function (x, acc) {
					return {
						ctor: '::',
						_0: f(x),
						_1: acc
					};
				}),
			{ctor: '[]'},
			xs);
	});
var _elm_lang$core$List$filter = F2(
	function (pred, xs) {
		var conditionalCons = F2(
			function (front, back) {
				return pred(front) ? {ctor: '::', _0: front, _1: back} : back;
			});
		return A3(
			_elm_lang$core$List$foldr,
			conditionalCons,
			{ctor: '[]'},
			xs);
	});
var _elm_lang$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _p10 = f(mx);
		if (_p10.ctor === 'Just') {
			return {ctor: '::', _0: _p10._0, _1: xs};
		} else {
			return xs;
		}
	});
var _elm_lang$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			_elm_lang$core$List$foldr,
			_elm_lang$core$List$maybeCons(f),
			{ctor: '[]'},
			xs);
	});
var _elm_lang$core$List$reverse = function (list) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (x, y) {
				return {ctor: '::', _0: x, _1: y};
			}),
		{ctor: '[]'},
		list);
};
var _elm_lang$core$List$scanl = F3(
	function (f, b, xs) {
		var scan1 = F2(
			function (x, accAcc) {
				var _p11 = accAcc;
				if (_p11.ctor === '::') {
					return {
						ctor: '::',
						_0: A2(f, x, _p11._0),
						_1: accAcc
					};
				} else {
					return {ctor: '[]'};
				}
			});
		return _elm_lang$core$List$reverse(
			A3(
				_elm_lang$core$List$foldl,
				scan1,
				{
					ctor: '::',
					_0: b,
					_1: {ctor: '[]'}
				},
				xs));
	});
var _elm_lang$core$List$append = F2(
	function (xs, ys) {
		var _p12 = ys;
		if (_p12.ctor === '[]') {
			return xs;
		} else {
			return A3(
				_elm_lang$core$List$foldr,
				F2(
					function (x, y) {
						return {ctor: '::', _0: x, _1: y};
					}),
				ys,
				xs);
		}
	});
var _elm_lang$core$List$concat = function (lists) {
	return A3(
		_elm_lang$core$List$foldr,
		_elm_lang$core$List$append,
		{ctor: '[]'},
		lists);
};
var _elm_lang$core$List$concatMap = F2(
	function (f, list) {
		return _elm_lang$core$List$concat(
			A2(_elm_lang$core$List$map, f, list));
	});
var _elm_lang$core$List$partition = F2(
	function (pred, list) {
		var step = F2(
			function (x, _p13) {
				var _p14 = _p13;
				var _p16 = _p14._0;
				var _p15 = _p14._1;
				return pred(x) ? {
					ctor: '_Tuple2',
					_0: {ctor: '::', _0: x, _1: _p16},
					_1: _p15
				} : {
					ctor: '_Tuple2',
					_0: _p16,
					_1: {ctor: '::', _0: x, _1: _p15}
				};
			});
		return A3(
			_elm_lang$core$List$foldr,
			step,
			{
				ctor: '_Tuple2',
				_0: {ctor: '[]'},
				_1: {ctor: '[]'}
			},
			list);
	});
var _elm_lang$core$List$unzip = function (pairs) {
	var step = F2(
		function (_p18, _p17) {
			var _p19 = _p18;
			var _p20 = _p17;
			return {
				ctor: '_Tuple2',
				_0: {ctor: '::', _0: _p19._0, _1: _p20._0},
				_1: {ctor: '::', _0: _p19._1, _1: _p20._1}
			};
		});
	return A3(
		_elm_lang$core$List$foldr,
		step,
		{
			ctor: '_Tuple2',
			_0: {ctor: '[]'},
			_1: {ctor: '[]'}
		},
		pairs);
};
var _elm_lang$core$List$intersperse = F2(
	function (sep, xs) {
		var _p21 = xs;
		if (_p21.ctor === '[]') {
			return {ctor: '[]'};
		} else {
			var step = F2(
				function (x, rest) {
					return {
						ctor: '::',
						_0: sep,
						_1: {ctor: '::', _0: x, _1: rest}
					};
				});
			var spersed = A3(
				_elm_lang$core$List$foldr,
				step,
				{ctor: '[]'},
				_p21._1);
			return {ctor: '::', _0: _p21._0, _1: spersed};
		}
	});
var _elm_lang$core$List$takeReverse = F3(
	function (n, list, taken) {
		takeReverse:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
				return taken;
			} else {
				var _p22 = list;
				if (_p22.ctor === '[]') {
					return taken;
				} else {
					var _v23 = n - 1,
						_v24 = _p22._1,
						_v25 = {ctor: '::', _0: _p22._0, _1: taken};
					n = _v23;
					list = _v24;
					taken = _v25;
					continue takeReverse;
				}
			}
		}
	});
var _elm_lang$core$List$takeTailRec = F2(
	function (n, list) {
		return _elm_lang$core$List$reverse(
			A3(
				_elm_lang$core$List$takeReverse,
				n,
				list,
				{ctor: '[]'}));
	});
var _elm_lang$core$List$takeFast = F3(
	function (ctr, n, list) {
		if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
			return {ctor: '[]'};
		} else {
			var _p23 = {ctor: '_Tuple2', _0: n, _1: list};
			_v26_5:
			do {
				_v26_1:
				do {
					if (_p23.ctor === '_Tuple2') {
						if (_p23._1.ctor === '[]') {
							return list;
						} else {
							if (_p23._1._1.ctor === '::') {
								switch (_p23._0) {
									case 1:
										break _v26_1;
									case 2:
										return {
											ctor: '::',
											_0: _p23._1._0,
											_1: {
												ctor: '::',
												_0: _p23._1._1._0,
												_1: {ctor: '[]'}
											}
										};
									case 3:
										if (_p23._1._1._1.ctor === '::') {
											return {
												ctor: '::',
												_0: _p23._1._0,
												_1: {
													ctor: '::',
													_0: _p23._1._1._0,
													_1: {
														ctor: '::',
														_0: _p23._1._1._1._0,
														_1: {ctor: '[]'}
													}
												}
											};
										} else {
											break _v26_5;
										}
									default:
										if ((_p23._1._1._1.ctor === '::') && (_p23._1._1._1._1.ctor === '::')) {
											var _p28 = _p23._1._1._1._0;
											var _p27 = _p23._1._1._0;
											var _p26 = _p23._1._0;
											var _p25 = _p23._1._1._1._1._0;
											var _p24 = _p23._1._1._1._1._1;
											return (_elm_lang$core$Native_Utils.cmp(ctr, 1000) > 0) ? {
												ctor: '::',
												_0: _p26,
												_1: {
													ctor: '::',
													_0: _p27,
													_1: {
														ctor: '::',
														_0: _p28,
														_1: {
															ctor: '::',
															_0: _p25,
															_1: A2(_elm_lang$core$List$takeTailRec, n - 4, _p24)
														}
													}
												}
											} : {
												ctor: '::',
												_0: _p26,
												_1: {
													ctor: '::',
													_0: _p27,
													_1: {
														ctor: '::',
														_0: _p28,
														_1: {
															ctor: '::',
															_0: _p25,
															_1: A3(_elm_lang$core$List$takeFast, ctr + 1, n - 4, _p24)
														}
													}
												}
											};
										} else {
											break _v26_5;
										}
								}
							} else {
								if (_p23._0 === 1) {
									break _v26_1;
								} else {
									break _v26_5;
								}
							}
						}
					} else {
						break _v26_5;
					}
				} while(false);
				return {
					ctor: '::',
					_0: _p23._1._0,
					_1: {ctor: '[]'}
				};
			} while(false);
			return list;
		}
	});
var _elm_lang$core$List$take = F2(
	function (n, list) {
		return A3(_elm_lang$core$List$takeFast, 0, n, list);
	});
var _elm_lang$core$List$repeatHelp = F3(
	function (result, n, value) {
		repeatHelp:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 0) < 1) {
				return result;
			} else {
				var _v27 = {ctor: '::', _0: value, _1: result},
					_v28 = n - 1,
					_v29 = value;
				result = _v27;
				n = _v28;
				value = _v29;
				continue repeatHelp;
			}
		}
	});
var _elm_lang$core$List$repeat = F2(
	function (n, value) {
		return A3(
			_elm_lang$core$List$repeatHelp,
			{ctor: '[]'},
			n,
			value);
	});
var _elm_lang$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(lo, hi) < 1) {
				var _v30 = lo,
					_v31 = hi - 1,
					_v32 = {ctor: '::', _0: hi, _1: list};
				lo = _v30;
				hi = _v31;
				list = _v32;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var _elm_lang$core$List$range = F2(
	function (lo, hi) {
		return A3(
			_elm_lang$core$List$rangeHelp,
			lo,
			hi,
			{ctor: '[]'});
	});
var _elm_lang$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			_elm_lang$core$List$map2,
			f,
			A2(
				_elm_lang$core$List$range,
				0,
				_elm_lang$core$List$length(xs) - 1),
			xs);
	});

var _elm_lang$core$Result$toMaybe = function (result) {
	var _p0 = result;
	if (_p0.ctor === 'Ok') {
		return _elm_lang$core$Maybe$Just(_p0._0);
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_lang$core$Result$withDefault = F2(
	function (def, result) {
		var _p1 = result;
		if (_p1.ctor === 'Ok') {
			return _p1._0;
		} else {
			return def;
		}
	});
var _elm_lang$core$Result$Err = function (a) {
	return {ctor: 'Err', _0: a};
};
var _elm_lang$core$Result$andThen = F2(
	function (callback, result) {
		var _p2 = result;
		if (_p2.ctor === 'Ok') {
			return callback(_p2._0);
		} else {
			return _elm_lang$core$Result$Err(_p2._0);
		}
	});
var _elm_lang$core$Result$Ok = function (a) {
	return {ctor: 'Ok', _0: a};
};
var _elm_lang$core$Result$map = F2(
	function (func, ra) {
		var _p3 = ra;
		if (_p3.ctor === 'Ok') {
			return _elm_lang$core$Result$Ok(
				func(_p3._0));
		} else {
			return _elm_lang$core$Result$Err(_p3._0);
		}
	});
var _elm_lang$core$Result$map2 = F3(
	function (func, ra, rb) {
		var _p4 = {ctor: '_Tuple2', _0: ra, _1: rb};
		if (_p4._0.ctor === 'Ok') {
			if (_p4._1.ctor === 'Ok') {
				return _elm_lang$core$Result$Ok(
					A2(func, _p4._0._0, _p4._1._0));
			} else {
				return _elm_lang$core$Result$Err(_p4._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p4._0._0);
		}
	});
var _elm_lang$core$Result$map3 = F4(
	function (func, ra, rb, rc) {
		var _p5 = {ctor: '_Tuple3', _0: ra, _1: rb, _2: rc};
		if (_p5._0.ctor === 'Ok') {
			if (_p5._1.ctor === 'Ok') {
				if (_p5._2.ctor === 'Ok') {
					return _elm_lang$core$Result$Ok(
						A3(func, _p5._0._0, _p5._1._0, _p5._2._0));
				} else {
					return _elm_lang$core$Result$Err(_p5._2._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p5._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p5._0._0);
		}
	});
var _elm_lang$core$Result$map4 = F5(
	function (func, ra, rb, rc, rd) {
		var _p6 = {ctor: '_Tuple4', _0: ra, _1: rb, _2: rc, _3: rd};
		if (_p6._0.ctor === 'Ok') {
			if (_p6._1.ctor === 'Ok') {
				if (_p6._2.ctor === 'Ok') {
					if (_p6._3.ctor === 'Ok') {
						return _elm_lang$core$Result$Ok(
							A4(func, _p6._0._0, _p6._1._0, _p6._2._0, _p6._3._0));
					} else {
						return _elm_lang$core$Result$Err(_p6._3._0);
					}
				} else {
					return _elm_lang$core$Result$Err(_p6._2._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p6._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p6._0._0);
		}
	});
var _elm_lang$core$Result$map5 = F6(
	function (func, ra, rb, rc, rd, re) {
		var _p7 = {ctor: '_Tuple5', _0: ra, _1: rb, _2: rc, _3: rd, _4: re};
		if (_p7._0.ctor === 'Ok') {
			if (_p7._1.ctor === 'Ok') {
				if (_p7._2.ctor === 'Ok') {
					if (_p7._3.ctor === 'Ok') {
						if (_p7._4.ctor === 'Ok') {
							return _elm_lang$core$Result$Ok(
								A5(func, _p7._0._0, _p7._1._0, _p7._2._0, _p7._3._0, _p7._4._0));
						} else {
							return _elm_lang$core$Result$Err(_p7._4._0);
						}
					} else {
						return _elm_lang$core$Result$Err(_p7._3._0);
					}
				} else {
					return _elm_lang$core$Result$Err(_p7._2._0);
				}
			} else {
				return _elm_lang$core$Result$Err(_p7._1._0);
			}
		} else {
			return _elm_lang$core$Result$Err(_p7._0._0);
		}
	});
var _elm_lang$core$Result$mapError = F2(
	function (f, result) {
		var _p8 = result;
		if (_p8.ctor === 'Ok') {
			return _elm_lang$core$Result$Ok(_p8._0);
		} else {
			return _elm_lang$core$Result$Err(
				f(_p8._0));
		}
	});
var _elm_lang$core$Result$fromMaybe = F2(
	function (err, maybe) {
		var _p9 = maybe;
		if (_p9.ctor === 'Just') {
			return _elm_lang$core$Result$Ok(_p9._0);
		} else {
			return _elm_lang$core$Result$Err(err);
		}
	});

//import Maybe, Native.List, Native.Utils, Result //

var _elm_lang$core$Native_String = function() {

function isEmpty(str)
{
	return str.length === 0;
}
function cons(chr, str)
{
	return chr + str;
}
function uncons(str)
{
	var hd = str[0];
	if (hd)
	{
		return _elm_lang$core$Maybe$Just(_elm_lang$core$Native_Utils.Tuple2(_elm_lang$core$Native_Utils.chr(hd), str.slice(1)));
	}
	return _elm_lang$core$Maybe$Nothing;
}
function append(a, b)
{
	return a + b;
}
function concat(strs)
{
	return _elm_lang$core$Native_List.toArray(strs).join('');
}
function length(str)
{
	return str.length;
}
function map(f, str)
{
	var out = str.split('');
	for (var i = out.length; i--; )
	{
		out[i] = f(_elm_lang$core$Native_Utils.chr(out[i]));
	}
	return out.join('');
}
function filter(pred, str)
{
	return str.split('').map(_elm_lang$core$Native_Utils.chr).filter(pred).join('');
}
function reverse(str)
{
	return str.split('').reverse().join('');
}
function foldl(f, b, str)
{
	var len = str.length;
	for (var i = 0; i < len; ++i)
	{
		b = A2(f, _elm_lang$core$Native_Utils.chr(str[i]), b);
	}
	return b;
}
function foldr(f, b, str)
{
	for (var i = str.length; i--; )
	{
		b = A2(f, _elm_lang$core$Native_Utils.chr(str[i]), b);
	}
	return b;
}
function split(sep, str)
{
	return _elm_lang$core$Native_List.fromArray(str.split(sep));
}
function join(sep, strs)
{
	return _elm_lang$core$Native_List.toArray(strs).join(sep);
}
function repeat(n, str)
{
	var result = '';
	while (n > 0)
	{
		if (n & 1)
		{
			result += str;
		}
		n >>= 1, str += str;
	}
	return result;
}
function slice(start, end, str)
{
	return str.slice(start, end);
}
function left(n, str)
{
	return n < 1 ? '' : str.slice(0, n);
}
function right(n, str)
{
	return n < 1 ? '' : str.slice(-n);
}
function dropLeft(n, str)
{
	return n < 1 ? str : str.slice(n);
}
function dropRight(n, str)
{
	return n < 1 ? str : str.slice(0, -n);
}
function pad(n, chr, str)
{
	var half = (n - str.length) / 2;
	return repeat(Math.ceil(half), chr) + str + repeat(half | 0, chr);
}
function padRight(n, chr, str)
{
	return str + repeat(n - str.length, chr);
}
function padLeft(n, chr, str)
{
	return repeat(n - str.length, chr) + str;
}

function trim(str)
{
	return str.trim();
}
function trimLeft(str)
{
	return str.replace(/^\s+/, '');
}
function trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function words(str)
{
	return _elm_lang$core$Native_List.fromArray(str.trim().split(/\s+/g));
}
function lines(str)
{
	return _elm_lang$core$Native_List.fromArray(str.split(/\r\n|\r|\n/g));
}

function toUpper(str)
{
	return str.toUpperCase();
}
function toLower(str)
{
	return str.toLowerCase();
}

function any(pred, str)
{
	for (var i = str.length; i--; )
	{
		if (pred(_elm_lang$core$Native_Utils.chr(str[i])))
		{
			return true;
		}
	}
	return false;
}
function all(pred, str)
{
	for (var i = str.length; i--; )
	{
		if (!pred(_elm_lang$core$Native_Utils.chr(str[i])))
		{
			return false;
		}
	}
	return true;
}

function contains(sub, str)
{
	return str.indexOf(sub) > -1;
}
function startsWith(sub, str)
{
	return str.indexOf(sub) === 0;
}
function endsWith(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
}
function indexes(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _elm_lang$core$Native_List.Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _elm_lang$core$Native_List.fromArray(is);
}


function toInt(s)
{
	var len = s.length;

	// if empty
	if (len === 0)
	{
		return intErr(s);
	}

	// if hex
	var c = s[0];
	if (c === '0' && s[1] === 'x')
	{
		for (var i = 2; i < len; ++i)
		{
			var c = s[i];
			if (('0' <= c && c <= '9') || ('A' <= c && c <= 'F') || ('a' <= c && c <= 'f'))
			{
				continue;
			}
			return intErr(s);
		}
		return _elm_lang$core$Result$Ok(parseInt(s, 16));
	}

	// is decimal
	if (c > '9' || (c < '0' && c !== '-' && c !== '+'))
	{
		return intErr(s);
	}
	for (var i = 1; i < len; ++i)
	{
		var c = s[i];
		if (c < '0' || '9' < c)
		{
			return intErr(s);
		}
	}

	return _elm_lang$core$Result$Ok(parseInt(s, 10));
}

function intErr(s)
{
	return _elm_lang$core$Result$Err("could not convert string '" + s + "' to an Int");
}


function toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return floatErr(s);
	}
	var n = +s;
	// faster isNaN check
	return n === n ? _elm_lang$core$Result$Ok(n) : floatErr(s);
}

function floatErr(s)
{
	return _elm_lang$core$Result$Err("could not convert string '" + s + "' to a Float");
}


function toList(str)
{
	return _elm_lang$core$Native_List.fromArray(str.split('').map(_elm_lang$core$Native_Utils.chr));
}
function fromList(chars)
{
	return _elm_lang$core$Native_List.toArray(chars).join('');
}

return {
	isEmpty: isEmpty,
	cons: F2(cons),
	uncons: uncons,
	append: F2(append),
	concat: concat,
	length: length,
	map: F2(map),
	filter: F2(filter),
	reverse: reverse,
	foldl: F3(foldl),
	foldr: F3(foldr),

	split: F2(split),
	join: F2(join),
	repeat: F2(repeat),

	slice: F3(slice),
	left: F2(left),
	right: F2(right),
	dropLeft: F2(dropLeft),
	dropRight: F2(dropRight),

	pad: F3(pad),
	padLeft: F3(padLeft),
	padRight: F3(padRight),

	trim: trim,
	trimLeft: trimLeft,
	trimRight: trimRight,

	words: words,
	lines: lines,

	toUpper: toUpper,
	toLower: toLower,

	any: F2(any),
	all: F2(all),

	contains: F2(contains),
	startsWith: F2(startsWith),
	endsWith: F2(endsWith),
	indexes: F2(indexes),

	toInt: toInt,
	toFloat: toFloat,
	toList: toList,
	fromList: fromList
};

}();

//import Native.Utils //

var _elm_lang$core$Native_Char = function() {

return {
	fromCode: function(c) { return _elm_lang$core$Native_Utils.chr(String.fromCharCode(c)); },
	toCode: function(c) { return c.charCodeAt(0); },
	toUpper: function(c) { return _elm_lang$core$Native_Utils.chr(c.toUpperCase()); },
	toLower: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLowerCase()); },
	toLocaleUpper: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLocaleUpperCase()); },
	toLocaleLower: function(c) { return _elm_lang$core$Native_Utils.chr(c.toLocaleLowerCase()); }
};

}();
var _elm_lang$core$Char$fromCode = _elm_lang$core$Native_Char.fromCode;
var _elm_lang$core$Char$toCode = _elm_lang$core$Native_Char.toCode;
var _elm_lang$core$Char$toLocaleLower = _elm_lang$core$Native_Char.toLocaleLower;
var _elm_lang$core$Char$toLocaleUpper = _elm_lang$core$Native_Char.toLocaleUpper;
var _elm_lang$core$Char$toLower = _elm_lang$core$Native_Char.toLower;
var _elm_lang$core$Char$toUpper = _elm_lang$core$Native_Char.toUpper;
var _elm_lang$core$Char$isBetween = F3(
	function (low, high, $char) {
		var code = _elm_lang$core$Char$toCode($char);
		return (_elm_lang$core$Native_Utils.cmp(
			code,
			_elm_lang$core$Char$toCode(low)) > -1) && (_elm_lang$core$Native_Utils.cmp(
			code,
			_elm_lang$core$Char$toCode(high)) < 1);
	});
var _elm_lang$core$Char$isUpper = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('A'),
	_elm_lang$core$Native_Utils.chr('Z'));
var _elm_lang$core$Char$isLower = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('a'),
	_elm_lang$core$Native_Utils.chr('z'));
var _elm_lang$core$Char$isDigit = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('0'),
	_elm_lang$core$Native_Utils.chr('9'));
var _elm_lang$core$Char$isOctDigit = A2(
	_elm_lang$core$Char$isBetween,
	_elm_lang$core$Native_Utils.chr('0'),
	_elm_lang$core$Native_Utils.chr('7'));
var _elm_lang$core$Char$isHexDigit = function ($char) {
	return _elm_lang$core$Char$isDigit($char) || (A3(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('a'),
		_elm_lang$core$Native_Utils.chr('f'),
		$char) || A3(
		_elm_lang$core$Char$isBetween,
		_elm_lang$core$Native_Utils.chr('A'),
		_elm_lang$core$Native_Utils.chr('F'),
		$char));
};

var _elm_lang$core$String$fromList = _elm_lang$core$Native_String.fromList;
var _elm_lang$core$String$toList = _elm_lang$core$Native_String.toList;
var _elm_lang$core$String$toFloat = _elm_lang$core$Native_String.toFloat;
var _elm_lang$core$String$toInt = _elm_lang$core$Native_String.toInt;
var _elm_lang$core$String$indices = _elm_lang$core$Native_String.indexes;
var _elm_lang$core$String$indexes = _elm_lang$core$Native_String.indexes;
var _elm_lang$core$String$endsWith = _elm_lang$core$Native_String.endsWith;
var _elm_lang$core$String$startsWith = _elm_lang$core$Native_String.startsWith;
var _elm_lang$core$String$contains = _elm_lang$core$Native_String.contains;
var _elm_lang$core$String$all = _elm_lang$core$Native_String.all;
var _elm_lang$core$String$any = _elm_lang$core$Native_String.any;
var _elm_lang$core$String$toLower = _elm_lang$core$Native_String.toLower;
var _elm_lang$core$String$toUpper = _elm_lang$core$Native_String.toUpper;
var _elm_lang$core$String$lines = _elm_lang$core$Native_String.lines;
var _elm_lang$core$String$words = _elm_lang$core$Native_String.words;
var _elm_lang$core$String$trimRight = _elm_lang$core$Native_String.trimRight;
var _elm_lang$core$String$trimLeft = _elm_lang$core$Native_String.trimLeft;
var _elm_lang$core$String$trim = _elm_lang$core$Native_String.trim;
var _elm_lang$core$String$padRight = _elm_lang$core$Native_String.padRight;
var _elm_lang$core$String$padLeft = _elm_lang$core$Native_String.padLeft;
var _elm_lang$core$String$pad = _elm_lang$core$Native_String.pad;
var _elm_lang$core$String$dropRight = _elm_lang$core$Native_String.dropRight;
var _elm_lang$core$String$dropLeft = _elm_lang$core$Native_String.dropLeft;
var _elm_lang$core$String$right = _elm_lang$core$Native_String.right;
var _elm_lang$core$String$left = _elm_lang$core$Native_String.left;
var _elm_lang$core$String$slice = _elm_lang$core$Native_String.slice;
var _elm_lang$core$String$repeat = _elm_lang$core$Native_String.repeat;
var _elm_lang$core$String$join = _elm_lang$core$Native_String.join;
var _elm_lang$core$String$split = _elm_lang$core$Native_String.split;
var _elm_lang$core$String$foldr = _elm_lang$core$Native_String.foldr;
var _elm_lang$core$String$foldl = _elm_lang$core$Native_String.foldl;
var _elm_lang$core$String$reverse = _elm_lang$core$Native_String.reverse;
var _elm_lang$core$String$filter = _elm_lang$core$Native_String.filter;
var _elm_lang$core$String$map = _elm_lang$core$Native_String.map;
var _elm_lang$core$String$length = _elm_lang$core$Native_String.length;
var _elm_lang$core$String$concat = _elm_lang$core$Native_String.concat;
var _elm_lang$core$String$append = _elm_lang$core$Native_String.append;
var _elm_lang$core$String$uncons = _elm_lang$core$Native_String.uncons;
var _elm_lang$core$String$cons = _elm_lang$core$Native_String.cons;
var _elm_lang$core$String$fromChar = function ($char) {
	return A2(_elm_lang$core$String$cons, $char, '');
};
var _elm_lang$core$String$isEmpty = _elm_lang$core$Native_String.isEmpty;

var _elm_lang$core$Tuple$mapSecond = F2(
	function (func, _p0) {
		var _p1 = _p0;
		return {
			ctor: '_Tuple2',
			_0: _p1._0,
			_1: func(_p1._1)
		};
	});
var _elm_lang$core$Tuple$mapFirst = F2(
	function (func, _p2) {
		var _p3 = _p2;
		return {
			ctor: '_Tuple2',
			_0: func(_p3._0),
			_1: _p3._1
		};
	});
var _elm_lang$core$Tuple$second = function (_p4) {
	var _p5 = _p4;
	return _p5._1;
};
var _elm_lang$core$Tuple$first = function (_p6) {
	var _p7 = _p6;
	return _p7._0;
};

//import //

var _elm_lang$core$Native_Platform = function() {


// PROGRAMS

function program(impl)
{
	return function(flagDecoder)
	{
		return function(object, moduleName)
		{
			object['worker'] = function worker(flags)
			{
				if (typeof flags !== 'undefined')
				{
					throw new Error(
						'The `' + moduleName + '` module does not need flags.\n'
						+ 'Call ' + moduleName + '.worker() with no arguments and you should be all set!'
					);
				}

				return initialize(
					impl.init,
					impl.update,
					impl.subscriptions,
					renderer
				);
			};
		};
	};
}

function programWithFlags(impl)
{
	return function(flagDecoder)
	{
		return function(object, moduleName)
		{
			object['worker'] = function worker(flags)
			{
				if (typeof flagDecoder === 'undefined')
				{
					throw new Error(
						'Are you trying to sneak a Never value into Elm? Trickster!\n'
						+ 'It looks like ' + moduleName + '.main is defined with `programWithFlags` but has type `Program Never`.\n'
						+ 'Use `program` instead if you do not want flags.'
					);
				}

				var result = A2(_elm_lang$core$Native_Json.run, flagDecoder, flags);
				if (result.ctor === 'Err')
				{
					throw new Error(
						moduleName + '.worker(...) was called with an unexpected argument.\n'
						+ 'I tried to convert it to an Elm value, but ran into this problem:\n\n'
						+ result._0
					);
				}

				return initialize(
					impl.init(result._0),
					impl.update,
					impl.subscriptions,
					renderer
				);
			};
		};
	};
}

function renderer(enqueue, _)
{
	return function(_) {};
}


// HTML TO PROGRAM

function htmlToProgram(vnode)
{
	var emptyBag = batch(_elm_lang$core$Native_List.Nil);
	var noChange = _elm_lang$core$Native_Utils.Tuple2(
		_elm_lang$core$Native_Utils.Tuple0,
		emptyBag
	);

	return _elm_lang$virtual_dom$VirtualDom$program({
		init: noChange,
		view: function(model) { return main; },
		update: F2(function(msg, model) { return noChange; }),
		subscriptions: function (model) { return emptyBag; }
	});
}


// INITIALIZE A PROGRAM

function initialize(init, update, subscriptions, renderer)
{
	// ambient state
	var managers = {};
	var updateView;

	// init and update state in main process
	var initApp = _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
		var model = init._0;
		updateView = renderer(enqueue, model);
		var cmds = init._1;
		var subs = subscriptions(model);
		dispatchEffects(managers, cmds, subs);
		callback(_elm_lang$core$Native_Scheduler.succeed(model));
	});

	function onMessage(msg, model)
	{
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
			var results = A2(update, msg, model);
			model = results._0;
			updateView(model);
			var cmds = results._1;
			var subs = subscriptions(model);
			dispatchEffects(managers, cmds, subs);
			callback(_elm_lang$core$Native_Scheduler.succeed(model));
		});
	}

	var mainProcess = spawnLoop(initApp, onMessage);

	function enqueue(msg)
	{
		_elm_lang$core$Native_Scheduler.rawSend(mainProcess, msg);
	}

	var ports = setupEffects(managers, enqueue);

	return ports ? { ports: ports } : {};
}


// EFFECT MANAGERS

var effectManagers = {};

function setupEffects(managers, callback)
{
	var ports;

	// setup all necessary effect managers
	for (var key in effectManagers)
	{
		var manager = effectManagers[key];

		if (manager.isForeign)
		{
			ports = ports || {};
			ports[key] = manager.tag === 'cmd'
				? setupOutgoingPort(key)
				: setupIncomingPort(key, callback);
		}

		managers[key] = makeManager(manager, callback);
	}

	return ports;
}

function makeManager(info, callback)
{
	var router = {
		main: callback,
		self: undefined
	};

	var tag = info.tag;
	var onEffects = info.onEffects;
	var onSelfMsg = info.onSelfMsg;

	function onMessage(msg, state)
	{
		if (msg.ctor === 'self')
		{
			return A3(onSelfMsg, router, msg._0, state);
		}

		var fx = msg._0;
		switch (tag)
		{
			case 'cmd':
				return A3(onEffects, router, fx.cmds, state);

			case 'sub':
				return A3(onEffects, router, fx.subs, state);

			case 'fx':
				return A4(onEffects, router, fx.cmds, fx.subs, state);
		}
	}

	var process = spawnLoop(info.init, onMessage);
	router.self = process;
	return process;
}

function sendToApp(router, msg)
{
	return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
	{
		router.main(msg);
		callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
	});
}

function sendToSelf(router, msg)
{
	return A2(_elm_lang$core$Native_Scheduler.send, router.self, {
		ctor: 'self',
		_0: msg
	});
}


// HELPER for STATEFUL LOOPS

function spawnLoop(init, onMessage)
{
	var andThen = _elm_lang$core$Native_Scheduler.andThen;

	function loop(state)
	{
		var handleMsg = _elm_lang$core$Native_Scheduler.receive(function(msg) {
			return onMessage(msg, state);
		});
		return A2(andThen, loop, handleMsg);
	}

	var task = A2(andThen, loop, init);

	return _elm_lang$core$Native_Scheduler.rawSpawn(task);
}


// BAGS

function leaf(home)
{
	return function(value)
	{
		return {
			type: 'leaf',
			home: home,
			value: value
		};
	};
}

function batch(list)
{
	return {
		type: 'node',
		branches: list
	};
}

function map(tagger, bag)
{
	return {
		type: 'map',
		tagger: tagger,
		tree: bag
	}
}


// PIPE BAGS INTO EFFECT MANAGERS

function dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	gatherEffects(true, cmdBag, effectsDict, null);
	gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		var fx = home in effectsDict
			? effectsDict[home]
			: {
				cmds: _elm_lang$core$Native_List.Nil,
				subs: _elm_lang$core$Native_List.Nil
			};

		_elm_lang$core$Native_Scheduler.rawSend(managers[home], { ctor: 'fx', _0: fx });
	}
}

function gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.type)
	{
		case 'leaf':
			var home = bag.home;
			var effect = toEffect(isCmd, home, taggers, bag.value);
			effectsDict[home] = insert(isCmd, effect, effectsDict[home]);
			return;

		case 'node':
			var list = bag.branches;
			while (list.ctor !== '[]')
			{
				gatherEffects(isCmd, list._0, effectsDict, taggers);
				list = list._1;
			}
			return;

		case 'map':
			gatherEffects(isCmd, bag.tree, effectsDict, {
				tagger: bag.tagger,
				rest: taggers
			});
			return;
	}
}

function toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		var temp = taggers;
		while (temp)
		{
			x = temp.tagger(x);
			temp = temp.rest;
		}
		return x;
	}

	var map = isCmd
		? effectManagers[home].cmdMap
		: effectManagers[home].subMap;

	return A2(map, applyTaggers, value)
}

function insert(isCmd, newEffect, effects)
{
	effects = effects || {
		cmds: _elm_lang$core$Native_List.Nil,
		subs: _elm_lang$core$Native_List.Nil
	};
	if (isCmd)
	{
		effects.cmds = _elm_lang$core$Native_List.Cons(newEffect, effects.cmds);
		return effects;
	}
	effects.subs = _elm_lang$core$Native_List.Cons(newEffect, effects.subs);
	return effects;
}


// PORTS

function checkPortName(name)
{
	if (name in effectManagers)
	{
		throw new Error('There can only be one port named `' + name + '`, but your program has multiple.');
	}
}


// OUTGOING PORTS

function outgoingPort(name, converter)
{
	checkPortName(name);
	effectManagers[name] = {
		tag: 'cmd',
		cmdMap: outgoingPortMap,
		converter: converter,
		isForeign: true
	};
	return leaf(name);
}

var outgoingPortMap = F2(function cmdMap(tagger, value) {
	return value;
});

function setupOutgoingPort(name)
{
	var subs = [];
	var converter = effectManagers[name].converter;

	// CREATE MANAGER

	var init = _elm_lang$core$Native_Scheduler.succeed(null);

	function onEffects(router, cmdList, state)
	{
		while (cmdList.ctor !== '[]')
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = converter(cmdList._0);
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
			cmdList = cmdList._1;
		}
		return init;
	}

	effectManagers[name].init = init;
	effectManagers[name].onEffects = F3(onEffects);

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}


// INCOMING PORTS

function incomingPort(name, converter)
{
	checkPortName(name);
	effectManagers[name] = {
		tag: 'sub',
		subMap: incomingPortMap,
		converter: converter,
		isForeign: true
	};
	return leaf(name);
}

var incomingPortMap = F2(function subMap(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});

function setupIncomingPort(name, callback)
{
	var sentBeforeInit = [];
	var subs = _elm_lang$core$Native_List.Nil;
	var converter = effectManagers[name].converter;
	var currentOnEffects = preInitOnEffects;
	var currentSend = preInitSend;

	// CREATE MANAGER

	var init = _elm_lang$core$Native_Scheduler.succeed(null);

	function preInitOnEffects(router, subList, state)
	{
		var postInitResult = postInitOnEffects(router, subList, state);

		for(var i = 0; i < sentBeforeInit.length; i++)
		{
			postInitSend(sentBeforeInit[i]);
		}

		sentBeforeInit = null; // to release objects held in queue
		currentSend = postInitSend;
		currentOnEffects = postInitOnEffects;
		return postInitResult;
	}

	function postInitOnEffects(router, subList, state)
	{
		subs = subList;
		return init;
	}

	function onEffects(router, subList, state)
	{
		return currentOnEffects(router, subList, state);
	}

	effectManagers[name].init = init;
	effectManagers[name].onEffects = F3(onEffects);

	// PUBLIC API

	function preInitSend(value)
	{
		sentBeforeInit.push(value);
	}

	function postInitSend(value)
	{
		var temp = subs;
		while (temp.ctor !== '[]')
		{
			callback(temp._0(value));
			temp = temp._1;
		}
	}

	function send(incomingValue)
	{
		var result = A2(_elm_lang$core$Json_Decode$decodeValue, converter, incomingValue);
		if (result.ctor === 'Err')
		{
			throw new Error('Trying to send an unexpected type of value through port `' + name + '`:\n' + result._0);
		}

		currentSend(result._0);
	}

	return { send: send };
}

return {
	// routers
	sendToApp: F2(sendToApp),
	sendToSelf: F2(sendToSelf),

	// global setup
	effectManagers: effectManagers,
	outgoingPort: outgoingPort,
	incomingPort: incomingPort,

	htmlToProgram: htmlToProgram,
	program: program,
	programWithFlags: programWithFlags,
	initialize: initialize,

	// effect bags
	leaf: leaf,
	batch: batch,
	map: F2(map)
};

}();

//import Native.Utils //

var _elm_lang$core$Native_Scheduler = function() {

var MAX_STEPS = 10000;


// TASKS

function succeed(value)
{
	return {
		ctor: '_Task_succeed',
		value: value
	};
}

function fail(error)
{
	return {
		ctor: '_Task_fail',
		value: error
	};
}

function nativeBinding(callback)
{
	return {
		ctor: '_Task_nativeBinding',
		callback: callback,
		cancel: null
	};
}

function andThen(callback, task)
{
	return {
		ctor: '_Task_andThen',
		callback: callback,
		task: task
	};
}

function onError(callback, task)
{
	return {
		ctor: '_Task_onError',
		callback: callback,
		task: task
	};
}

function receive(callback)
{
	return {
		ctor: '_Task_receive',
		callback: callback
	};
}


// PROCESSES

function rawSpawn(task)
{
	var process = {
		ctor: '_Process',
		id: _elm_lang$core$Native_Utils.guid(),
		root: task,
		stack: null,
		mailbox: []
	};

	enqueue(process);

	return process;
}

function spawn(task)
{
	return nativeBinding(function(callback) {
		var process = rawSpawn(task);
		callback(succeed(process));
	});
}

function rawSend(process, msg)
{
	process.mailbox.push(msg);
	enqueue(process);
}

function send(process, msg)
{
	return nativeBinding(function(callback) {
		rawSend(process, msg);
		callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
	});
}

function kill(process)
{
	return nativeBinding(function(callback) {
		var root = process.root;
		if (root.ctor === '_Task_nativeBinding' && root.cancel)
		{
			root.cancel();
		}

		process.root = null;

		callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
	});
}

function sleep(time)
{
	return nativeBinding(function(callback) {
		var id = setTimeout(function() {
			callback(succeed(_elm_lang$core$Native_Utils.Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}


// STEP PROCESSES

function step(numSteps, process)
{
	while (numSteps < MAX_STEPS)
	{
		var ctor = process.root.ctor;

		if (ctor === '_Task_succeed')
		{
			while (process.stack && process.stack.ctor === '_Task_onError')
			{
				process.stack = process.stack.rest;
			}
			if (process.stack === null)
			{
				break;
			}
			process.root = process.stack.callback(process.root.value);
			process.stack = process.stack.rest;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_fail')
		{
			while (process.stack && process.stack.ctor === '_Task_andThen')
			{
				process.stack = process.stack.rest;
			}
			if (process.stack === null)
			{
				break;
			}
			process.root = process.stack.callback(process.root.value);
			process.stack = process.stack.rest;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_andThen')
		{
			process.stack = {
				ctor: '_Task_andThen',
				callback: process.root.callback,
				rest: process.stack
			};
			process.root = process.root.task;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_onError')
		{
			process.stack = {
				ctor: '_Task_onError',
				callback: process.root.callback,
				rest: process.stack
			};
			process.root = process.root.task;
			++numSteps;
			continue;
		}

		if (ctor === '_Task_nativeBinding')
		{
			process.root.cancel = process.root.callback(function(newRoot) {
				process.root = newRoot;
				enqueue(process);
			});

			break;
		}

		if (ctor === '_Task_receive')
		{
			var mailbox = process.mailbox;
			if (mailbox.length === 0)
			{
				break;
			}

			process.root = process.root.callback(mailbox.shift());
			++numSteps;
			continue;
		}

		throw new Error(ctor);
	}

	if (numSteps < MAX_STEPS)
	{
		return numSteps + 1;
	}
	enqueue(process);

	return numSteps;
}


// WORK QUEUE

var working = false;
var workQueue = [];

function enqueue(process)
{
	workQueue.push(process);

	if (!working)
	{
		setTimeout(work, 0);
		working = true;
	}
}

function work()
{
	var numSteps = 0;
	var process;
	while (numSteps < MAX_STEPS && (process = workQueue.shift()))
	{
		if (process.root)
		{
			numSteps = step(numSteps, process);
		}
	}
	if (!process)
	{
		working = false;
		return;
	}
	setTimeout(work, 0);
}


return {
	succeed: succeed,
	fail: fail,
	nativeBinding: nativeBinding,
	andThen: F2(andThen),
	onError: F2(onError),
	receive: receive,

	spawn: spawn,
	kill: kill,
	sleep: sleep,
	send: F2(send),

	rawSpawn: rawSpawn,
	rawSend: rawSend
};

}();
var _elm_lang$core$Platform_Cmd$batch = _elm_lang$core$Native_Platform.batch;
var _elm_lang$core$Platform_Cmd$none = _elm_lang$core$Platform_Cmd$batch(
	{ctor: '[]'});
var _elm_lang$core$Platform_Cmd_ops = _elm_lang$core$Platform_Cmd_ops || {};
_elm_lang$core$Platform_Cmd_ops['!'] = F2(
	function (model, commands) {
		return {
			ctor: '_Tuple2',
			_0: model,
			_1: _elm_lang$core$Platform_Cmd$batch(commands)
		};
	});
var _elm_lang$core$Platform_Cmd$map = _elm_lang$core$Native_Platform.map;
var _elm_lang$core$Platform_Cmd$Cmd = {ctor: 'Cmd'};

var _elm_lang$core$Platform_Sub$batch = _elm_lang$core$Native_Platform.batch;
var _elm_lang$core$Platform_Sub$none = _elm_lang$core$Platform_Sub$batch(
	{ctor: '[]'});
var _elm_lang$core$Platform_Sub$map = _elm_lang$core$Native_Platform.map;
var _elm_lang$core$Platform_Sub$Sub = {ctor: 'Sub'};

var _elm_lang$core$Platform$hack = _elm_lang$core$Native_Scheduler.succeed;
var _elm_lang$core$Platform$sendToSelf = _elm_lang$core$Native_Platform.sendToSelf;
var _elm_lang$core$Platform$sendToApp = _elm_lang$core$Native_Platform.sendToApp;
var _elm_lang$core$Platform$programWithFlags = _elm_lang$core$Native_Platform.programWithFlags;
var _elm_lang$core$Platform$program = _elm_lang$core$Native_Platform.program;
var _elm_lang$core$Platform$Program = {ctor: 'Program'};
var _elm_lang$core$Platform$Task = {ctor: 'Task'};
var _elm_lang$core$Platform$ProcessId = {ctor: 'ProcessId'};
var _elm_lang$core$Platform$Router = {ctor: 'Router'};

var _brenden$elm_tree_diagram$TreeDiagram$ends = function (list) {
	var last = _elm_lang$core$List$head(
		_elm_lang$core$List$reverse(list));
	var first = _elm_lang$core$List$head(list);
	return A3(
		_elm_lang$core$Maybe$map2,
		F2(
			function (a, b) {
				return {ctor: '_Tuple2', _0: a, _1: b};
			}),
		first,
		last);
};
var _brenden$elm_tree_diagram$TreeDiagram$buildContour = F3(
	function (lContour, rContour, rContourOffset) {
		var combinedContour = A3(
			_elm_lang$core$List$map2,
			F2(
				function (_p1, _p0) {
					var _p2 = _p1;
					var _p3 = _p0;
					return {ctor: '_Tuple2', _0: _p2._0, _1: _p3._1 + rContourOffset};
				}),
			lContour,
			rContour);
		var rLength = _elm_lang$core$List$length(rContour);
		var lLength = _elm_lang$core$List$length(lContour);
		return (_elm_lang$core$Native_Utils.cmp(lLength, rLength) > 0) ? A2(
			_elm_lang$core$List$append,
			combinedContour,
			A2(_elm_lang$core$List$drop, rLength, lContour)) : A2(
			_elm_lang$core$List$append,
			combinedContour,
			A2(
				_elm_lang$core$List$map,
				function (_p4) {
					var _p5 = _p4;
					return {ctor: '_Tuple2', _0: _p5._0 + rContourOffset, _1: _p5._1 + rContourOffset};
				},
				A2(_elm_lang$core$List$drop, lLength, rContour)));
	});
var _brenden$elm_tree_diagram$TreeDiagram$pairwiseSubtreeOffset = F4(
	function (siblingDistance, subtreeDistance, lContour, rContour) {
		var levelDistances = A3(
			_elm_lang$core$List$map2,
			F2(
				function (_p7, _p6) {
					var _p8 = _p7;
					var _p9 = _p6;
					return _p8._1 - _p9._0;
				}),
			lContour,
			rContour);
		var _p10 = _elm_lang$core$List$maximum(levelDistances);
		if (_p10.ctor === 'Just') {
			var minDistance = (_elm_lang$core$Native_Utils.eq(
				_elm_lang$core$List$length(lContour),
				1) || _elm_lang$core$Native_Utils.eq(
				_elm_lang$core$List$length(rContour),
				1)) ? siblingDistance : subtreeDistance;
			return _p10._0 + minDistance;
		} else {
			return 0;
		}
	});
var _brenden$elm_tree_diagram$TreeDiagram$subtreeOffsets = F3(
	function (siblingDistance, subtreeDistance, contours) {
		var _p11 = _elm_lang$core$List$head(contours);
		if (_p11.ctor === 'Just') {
			var cumulativeContours = A3(
				_elm_lang$core$List$scanl,
				F2(
					function (c, _p12) {
						var _p13 = _p12;
						var _p14 = _p13._0;
						var offset = A4(_brenden$elm_tree_diagram$TreeDiagram$pairwiseSubtreeOffset, siblingDistance, subtreeDistance, _p14, c);
						return {
							ctor: '_Tuple2',
							_0: A3(_brenden$elm_tree_diagram$TreeDiagram$buildContour, _p14, c, offset),
							_1: offset
						};
					}),
				{ctor: '_Tuple2', _0: _p11._0, _1: 0},
				A2(_elm_lang$core$List$drop, 1, contours));
			return A2(
				_elm_lang$core$List$map,
				function (_p15) {
					var _p16 = _p15;
					return _p16._1;
				},
				cumulativeContours);
		} else {
			return {ctor: '[]'};
		}
	});
var _brenden$elm_tree_diagram$TreeDiagram$rootOffset = F2(
	function (lPrelimPosition, rPrelimPosition) {
		return ((((lPrelimPosition.subtreeOffset + rPrelimPosition.subtreeOffset) + lPrelimPosition.rootOffset) + rPrelimPosition.rootOffset) / 2) | 0;
	});
var _brenden$elm_tree_diagram$TreeDiagram$drawInternal = F6(
	function (width, height, drawer, drawNode, drawLine, _p17) {
		var _p18 = _p17;
		var _p24 = _p18._1;
		var subtreePositions = A2(
			_elm_lang$core$List$map,
			function (_p19) {
				var _p20 = _p19;
				return _p20._0._1;
			},
			_p24);
		var transSubtreePositions = A2(
			_elm_lang$core$List$map,
			A2(drawer.transform, width, height),
			subtreePositions);
		var transRootCoord = A3(drawer.transform, width, height, _p18._0._1);
		var _p21 = transRootCoord;
		var transRootX = _p21._0;
		var transRootY = _p21._1;
		var subtreeOffsetsFromRoot = A2(
			_elm_lang$core$List$map,
			function (_p22) {
				var _p23 = _p22;
				return {ctor: '_Tuple2', _0: _p23._0 - transRootX, _1: _p23._1 - transRootY};
			},
			transSubtreePositions);
		var rootDrawing = A2(
			drawer.position,
			transRootCoord,
			drawNode(_p18._0._0));
		var edgeDrawings = A2(
			_elm_lang$core$List$map,
			function (coord) {
				return A2(
					drawer.position,
					transRootCoord,
					drawLine(coord));
			},
			subtreeOffsetsFromRoot);
		return A2(
			_elm_lang$core$List$append,
			A2(
				_elm_lang$core$List$append,
				edgeDrawings,
				{
					ctor: '::',
					_0: rootDrawing,
					_1: {ctor: '[]'}
				}),
			A2(
				_elm_lang$core$List$concatMap,
				A5(_brenden$elm_tree_diagram$TreeDiagram$drawInternal, width, height, drawer, drawNode, drawLine),
				_p24));
	});
var _brenden$elm_tree_diagram$TreeDiagram$treeExtrema = function (_p25) {
	var _p26 = _p25;
	var _p31 = _p26._0._1._1;
	var _p30 = _p26._0._1._0;
	var extrema = A2(_elm_lang$core$List$map, _brenden$elm_tree_diagram$TreeDiagram$treeExtrema, _p26._1);
	var _p27 = _elm_lang$core$List$unzip(extrema);
	var xExtrema = _p27._0;
	var yExtrema = _p27._1;
	var _p28 = _elm_lang$core$List$unzip(xExtrema);
	var minXs = _p28._0;
	var maxXs = _p28._1;
	var minX = A2(
		_elm_lang$core$Basics$min,
		_p30,
		A2(
			_elm_lang$core$Maybe$withDefault,
			_p30,
			_elm_lang$core$List$minimum(minXs)));
	var maxX = A2(
		_elm_lang$core$Basics$max,
		_p30,
		A2(
			_elm_lang$core$Maybe$withDefault,
			_p30,
			_elm_lang$core$List$maximum(maxXs)));
	var _p29 = _elm_lang$core$List$unzip(yExtrema);
	var minYs = _p29._0;
	var maxYs = _p29._1;
	var minY = A2(
		_elm_lang$core$Basics$min,
		_p31,
		A2(
			_elm_lang$core$Maybe$withDefault,
			_p31,
			_elm_lang$core$List$minimum(minYs)));
	var maxY = A2(
		_elm_lang$core$Basics$max,
		_p31,
		A2(
			_elm_lang$core$Maybe$withDefault,
			_p31,
			_elm_lang$core$List$maximum(maxYs)));
	return {
		ctor: '_Tuple2',
		_0: {ctor: '_Tuple2', _0: minX, _1: maxX},
		_1: {ctor: '_Tuple2', _0: minY, _1: maxY}
	};
};
var _brenden$elm_tree_diagram$TreeDiagram$treeBoundingBox = function (tree) {
	var _p32 = _brenden$elm_tree_diagram$TreeDiagram$treeExtrema(tree);
	var minX = _p32._0._0;
	var maxX = _p32._0._1;
	var minY = _p32._1._0;
	var maxY = _p32._1._1;
	return {ctor: '_Tuple2', _0: maxX - minX, _1: maxY - minY};
};
var _brenden$elm_tree_diagram$TreeDiagram$drawPositioned = F5(
	function (drawer, padding, drawNode, drawLine, positionedTree) {
		var _p33 = _brenden$elm_tree_diagram$TreeDiagram$treeBoundingBox(positionedTree);
		var width = _p33._0;
		var height = _p33._1;
		var totalWidth = _elm_lang$core$Basics$round(width) + (2 * padding);
		var totalHeight = _elm_lang$core$Basics$round(height) + (2 * padding);
		return A3(
			drawer.compose,
			totalWidth,
			totalHeight,
			A6(_brenden$elm_tree_diagram$TreeDiagram$drawInternal, totalWidth, totalHeight, drawer, drawNode, drawLine, positionedTree));
	});
var _brenden$elm_tree_diagram$TreeDiagram$Drawable = F3(
	function (a, b, c) {
		return {position: a, compose: b, transform: c};
	});
var _brenden$elm_tree_diagram$TreeDiagram$PrelimPosition = F2(
	function (a, b) {
		return {subtreeOffset: a, rootOffset: b};
	});
var _brenden$elm_tree_diagram$TreeDiagram$TreeLayout = F5(
	function (a, b, c, d, e) {
		return {orientation: a, levelHeight: b, siblingDistance: c, subtreeDistance: d, padding: e};
	});
var _brenden$elm_tree_diagram$TreeDiagram$Node = F2(
	function (a, b) {
		return {ctor: 'Node', _0: a, _1: b};
	});
var _brenden$elm_tree_diagram$TreeDiagram$node = F2(
	function (val, children) {
		return A2(_brenden$elm_tree_diagram$TreeDiagram$Node, val, children);
	});
var _brenden$elm_tree_diagram$TreeDiagram$final = F4(
	function (level, levelHeight, lOffset, _p34) {
		var _p35 = _p34;
		var _p38 = _p35._1;
		var subtreePrelimPositions = A2(
			_elm_lang$core$List$map,
			function (_p36) {
				var _p37 = _p36;
				return _p37._0._1;
			},
			_p38);
		var visited = A3(
			_elm_lang$core$List$map2,
			F2(
				function (prelimPos, subtree) {
					return A4(_brenden$elm_tree_diagram$TreeDiagram$final, level + 1, levelHeight, lOffset + prelimPos.subtreeOffset, subtree);
				}),
			subtreePrelimPositions,
			_p38);
		var finalPosition = {
			ctor: '_Tuple2',
			_0: _elm_lang$core$Basics$toFloat(lOffset + _p35._0._1.rootOffset),
			_1: _elm_lang$core$Basics$toFloat(level * levelHeight)
		};
		return A2(
			_brenden$elm_tree_diagram$TreeDiagram$Node,
			{ctor: '_Tuple2', _0: _p35._0._0, _1: finalPosition},
			visited);
	});
var _brenden$elm_tree_diagram$TreeDiagram$prelim = F3(
	function (siblingDistance, subtreeDistance, _p39) {
		var _p40 = _p39;
		var _p47 = _p40._0;
		var visited = A2(
			_elm_lang$core$List$map,
			A2(_brenden$elm_tree_diagram$TreeDiagram$prelim, siblingDistance, subtreeDistance),
			_p40._1);
		var _p41 = _elm_lang$core$List$unzip(visited);
		var subtrees = _p41._0;
		var childContours = _p41._1;
		var offsets = A3(_brenden$elm_tree_diagram$TreeDiagram$subtreeOffsets, siblingDistance, subtreeDistance, childContours);
		var updatedChildren = A3(
			_elm_lang$core$List$map2,
			F2(
				function (_p42, offset) {
					var _p43 = _p42;
					return A2(
						_brenden$elm_tree_diagram$TreeDiagram$Node,
						{
							ctor: '_Tuple2',
							_0: _p43._0._0,
							_1: _elm_lang$core$Native_Utils.update(
								_p43._0._1,
								{subtreeOffset: offset})
						},
						_p43._1);
				}),
			subtrees,
			offsets);
		var _p44 = _brenden$elm_tree_diagram$TreeDiagram$ends(
			A3(
				_elm_lang$core$List$map2,
				F2(
					function (v0, v1) {
						return {ctor: '_Tuple2', _0: v0, _1: v1};
					}),
				updatedChildren,
				childContours));
		if (_p44.ctor === 'Just') {
			var _p45 = _p44._0._1._0;
			var rPrelimPos = _p45._0._1;
			var _p46 = _p44._0._0._0;
			var lPrelimPos = _p46._0._1;
			var prelimPos = {
				subtreeOffset: 0,
				rootOffset: A2(_brenden$elm_tree_diagram$TreeDiagram$rootOffset, lPrelimPos, rPrelimPos)
			};
			var rootContour = {ctor: '_Tuple2', _0: prelimPos.rootOffset, _1: prelimPos.rootOffset};
			var treeContour = {
				ctor: '::',
				_0: rootContour,
				_1: A3(_brenden$elm_tree_diagram$TreeDiagram$buildContour, _p44._0._0._1, _p44._0._1._1, rPrelimPos.subtreeOffset)
			};
			return {
				ctor: '_Tuple2',
				_0: A2(
					_brenden$elm_tree_diagram$TreeDiagram$Node,
					{ctor: '_Tuple2', _0: _p47, _1: prelimPos},
					updatedChildren),
				_1: treeContour
			};
		} else {
			return {
				ctor: '_Tuple2',
				_0: A2(
					_brenden$elm_tree_diagram$TreeDiagram$Node,
					{
						ctor: '_Tuple2',
						_0: _p47,
						_1: {subtreeOffset: 0, rootOffset: 0}
					},
					updatedChildren),
				_1: {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: 0, _1: 0},
					_1: {ctor: '[]'}
				}
			};
		}
	});
var _brenden$elm_tree_diagram$TreeDiagram$treeMap = F2(
	function (fn, _p48) {
		var _p49 = _p48;
		return A2(
			_brenden$elm_tree_diagram$TreeDiagram$Node,
			fn(_p49._0),
			A2(
				_elm_lang$core$List$map,
				_brenden$elm_tree_diagram$TreeDiagram$treeMap(fn),
				_p49._1));
	});
var _brenden$elm_tree_diagram$TreeDiagram$position = F5(
	function (siblingDistance, subtreeDistance, levelHeight, layout, tree) {
		var _p50 = A3(_brenden$elm_tree_diagram$TreeDiagram$prelim, siblingDistance, subtreeDistance, tree);
		var prelimTree = _p50._0;
		var finalTree = A4(_brenden$elm_tree_diagram$TreeDiagram$final, 0, levelHeight, 0, prelimTree);
		var _p51 = _brenden$elm_tree_diagram$TreeDiagram$treeBoundingBox(finalTree);
		var width = _p51._0;
		var height = _p51._1;
		var transform = function (_p52) {
			var _p53 = _p52;
			var _p56 = _p53._1;
			var _p55 = _p53._0;
			var _p54 = layout;
			switch (_p54.ctor) {
				case 'LeftToRight':
					return {ctor: '_Tuple2', _0: _p56 - (height / 2), _1: _p55 - (width / 2)};
				case 'RightToLeft':
					return {ctor: '_Tuple2', _0: (0 - _p56) + (height / 2), _1: _p55 - (width / 2)};
				case 'BottomToTop':
					return {ctor: '_Tuple2', _0: _p55 - (width / 2), _1: _p56 - (height / 2)};
				default:
					return {ctor: '_Tuple2', _0: _p55 - (width / 2), _1: (0 - _p56) + (height / 2)};
			}
		};
		return A2(
			_brenden$elm_tree_diagram$TreeDiagram$treeMap,
			function (_p57) {
				var _p58 = _p57;
				return {
					ctor: '_Tuple2',
					_0: _p58._0,
					_1: transform(_p58._1)
				};
			},
			finalTree);
	});
var _brenden$elm_tree_diagram$TreeDiagram$draw_ = F5(
	function (drawer, layout, drawNode, drawLine, tree) {
		var positionedTree = A5(_brenden$elm_tree_diagram$TreeDiagram$position, layout.siblingDistance, layout.subtreeDistance, layout.levelHeight, layout.orientation, tree);
		return A5(_brenden$elm_tree_diagram$TreeDiagram$drawPositioned, drawer, layout.padding, drawNode, drawLine, positionedTree);
	});
var _brenden$elm_tree_diagram$TreeDiagram$BottomToTop = {ctor: 'BottomToTop'};
var _brenden$elm_tree_diagram$TreeDiagram$bottomToTop = _brenden$elm_tree_diagram$TreeDiagram$BottomToTop;
var _brenden$elm_tree_diagram$TreeDiagram$TopToBottom = {ctor: 'TopToBottom'};
var _brenden$elm_tree_diagram$TreeDiagram$defaultTreeLayout = {orientation: _brenden$elm_tree_diagram$TreeDiagram$TopToBottom, levelHeight: 100, siblingDistance: 50, subtreeDistance: 80, padding: 40};
var _brenden$elm_tree_diagram$TreeDiagram$topToBottom = _brenden$elm_tree_diagram$TreeDiagram$TopToBottom;
var _brenden$elm_tree_diagram$TreeDiagram$RightToLeft = {ctor: 'RightToLeft'};
var _brenden$elm_tree_diagram$TreeDiagram$rightToLeft = _brenden$elm_tree_diagram$TreeDiagram$RightToLeft;
var _brenden$elm_tree_diagram$TreeDiagram$LeftToRight = {ctor: 'LeftToRight'};
var _brenden$elm_tree_diagram$TreeDiagram$leftToRight = _brenden$elm_tree_diagram$TreeDiagram$LeftToRight;

var _elm_lang$core$Color$fmod = F2(
	function (f, n) {
		var integer = _elm_lang$core$Basics$floor(f);
		return (_elm_lang$core$Basics$toFloat(
			A2(_elm_lang$core$Basics_ops['%'], integer, n)) + f) - _elm_lang$core$Basics$toFloat(integer);
	});
var _elm_lang$core$Color$rgbToHsl = F3(
	function (red, green, blue) {
		var b = _elm_lang$core$Basics$toFloat(blue) / 255;
		var g = _elm_lang$core$Basics$toFloat(green) / 255;
		var r = _elm_lang$core$Basics$toFloat(red) / 255;
		var cMax = A2(
			_elm_lang$core$Basics$max,
			A2(_elm_lang$core$Basics$max, r, g),
			b);
		var cMin = A2(
			_elm_lang$core$Basics$min,
			A2(_elm_lang$core$Basics$min, r, g),
			b);
		var c = cMax - cMin;
		var lightness = (cMax + cMin) / 2;
		var saturation = _elm_lang$core$Native_Utils.eq(lightness, 0) ? 0 : (c / (1 - _elm_lang$core$Basics$abs((2 * lightness) - 1)));
		var hue = _elm_lang$core$Basics$degrees(60) * (_elm_lang$core$Native_Utils.eq(cMax, r) ? A2(_elm_lang$core$Color$fmod, (g - b) / c, 6) : (_elm_lang$core$Native_Utils.eq(cMax, g) ? (((b - r) / c) + 2) : (((r - g) / c) + 4)));
		return {ctor: '_Tuple3', _0: hue, _1: saturation, _2: lightness};
	});
var _elm_lang$core$Color$hslToRgb = F3(
	function (hue, saturation, lightness) {
		var normHue = hue / _elm_lang$core$Basics$degrees(60);
		var chroma = (1 - _elm_lang$core$Basics$abs((2 * lightness) - 1)) * saturation;
		var x = chroma * (1 - _elm_lang$core$Basics$abs(
			A2(_elm_lang$core$Color$fmod, normHue, 2) - 1));
		var _p0 = (_elm_lang$core$Native_Utils.cmp(normHue, 0) < 0) ? {ctor: '_Tuple3', _0: 0, _1: 0, _2: 0} : ((_elm_lang$core$Native_Utils.cmp(normHue, 1) < 0) ? {ctor: '_Tuple3', _0: chroma, _1: x, _2: 0} : ((_elm_lang$core$Native_Utils.cmp(normHue, 2) < 0) ? {ctor: '_Tuple3', _0: x, _1: chroma, _2: 0} : ((_elm_lang$core$Native_Utils.cmp(normHue, 3) < 0) ? {ctor: '_Tuple3', _0: 0, _1: chroma, _2: x} : ((_elm_lang$core$Native_Utils.cmp(normHue, 4) < 0) ? {ctor: '_Tuple3', _0: 0, _1: x, _2: chroma} : ((_elm_lang$core$Native_Utils.cmp(normHue, 5) < 0) ? {ctor: '_Tuple3', _0: x, _1: 0, _2: chroma} : ((_elm_lang$core$Native_Utils.cmp(normHue, 6) < 0) ? {ctor: '_Tuple3', _0: chroma, _1: 0, _2: x} : {ctor: '_Tuple3', _0: 0, _1: 0, _2: 0}))))));
		var r = _p0._0;
		var g = _p0._1;
		var b = _p0._2;
		var m = lightness - (chroma / 2);
		return {ctor: '_Tuple3', _0: r + m, _1: g + m, _2: b + m};
	});
var _elm_lang$core$Color$toRgb = function (color) {
	var _p1 = color;
	if (_p1.ctor === 'RGBA') {
		return {red: _p1._0, green: _p1._1, blue: _p1._2, alpha: _p1._3};
	} else {
		var _p2 = A3(_elm_lang$core$Color$hslToRgb, _p1._0, _p1._1, _p1._2);
		var r = _p2._0;
		var g = _p2._1;
		var b = _p2._2;
		return {
			red: _elm_lang$core$Basics$round(255 * r),
			green: _elm_lang$core$Basics$round(255 * g),
			blue: _elm_lang$core$Basics$round(255 * b),
			alpha: _p1._3
		};
	}
};
var _elm_lang$core$Color$toHsl = function (color) {
	var _p3 = color;
	if (_p3.ctor === 'HSLA') {
		return {hue: _p3._0, saturation: _p3._1, lightness: _p3._2, alpha: _p3._3};
	} else {
		var _p4 = A3(_elm_lang$core$Color$rgbToHsl, _p3._0, _p3._1, _p3._2);
		var h = _p4._0;
		var s = _p4._1;
		var l = _p4._2;
		return {hue: h, saturation: s, lightness: l, alpha: _p3._3};
	}
};
var _elm_lang$core$Color$HSLA = F4(
	function (a, b, c, d) {
		return {ctor: 'HSLA', _0: a, _1: b, _2: c, _3: d};
	});
var _elm_lang$core$Color$hsla = F4(
	function (hue, saturation, lightness, alpha) {
		return A4(
			_elm_lang$core$Color$HSLA,
			hue - _elm_lang$core$Basics$turns(
				_elm_lang$core$Basics$toFloat(
					_elm_lang$core$Basics$floor(hue / (2 * _elm_lang$core$Basics$pi)))),
			saturation,
			lightness,
			alpha);
	});
var _elm_lang$core$Color$hsl = F3(
	function (hue, saturation, lightness) {
		return A4(_elm_lang$core$Color$hsla, hue, saturation, lightness, 1);
	});
var _elm_lang$core$Color$complement = function (color) {
	var _p5 = color;
	if (_p5.ctor === 'HSLA') {
		return A4(
			_elm_lang$core$Color$hsla,
			_p5._0 + _elm_lang$core$Basics$degrees(180),
			_p5._1,
			_p5._2,
			_p5._3);
	} else {
		var _p6 = A3(_elm_lang$core$Color$rgbToHsl, _p5._0, _p5._1, _p5._2);
		var h = _p6._0;
		var s = _p6._1;
		var l = _p6._2;
		return A4(
			_elm_lang$core$Color$hsla,
			h + _elm_lang$core$Basics$degrees(180),
			s,
			l,
			_p5._3);
	}
};
var _elm_lang$core$Color$grayscale = function (p) {
	return A4(_elm_lang$core$Color$HSLA, 0, 0, 1 - p, 1);
};
var _elm_lang$core$Color$greyscale = function (p) {
	return A4(_elm_lang$core$Color$HSLA, 0, 0, 1 - p, 1);
};
var _elm_lang$core$Color$RGBA = F4(
	function (a, b, c, d) {
		return {ctor: 'RGBA', _0: a, _1: b, _2: c, _3: d};
	});
var _elm_lang$core$Color$rgba = _elm_lang$core$Color$RGBA;
var _elm_lang$core$Color$rgb = F3(
	function (r, g, b) {
		return A4(_elm_lang$core$Color$RGBA, r, g, b, 1);
	});
var _elm_lang$core$Color$lightRed = A4(_elm_lang$core$Color$RGBA, 239, 41, 41, 1);
var _elm_lang$core$Color$red = A4(_elm_lang$core$Color$RGBA, 204, 0, 0, 1);
var _elm_lang$core$Color$darkRed = A4(_elm_lang$core$Color$RGBA, 164, 0, 0, 1);
var _elm_lang$core$Color$lightOrange = A4(_elm_lang$core$Color$RGBA, 252, 175, 62, 1);
var _elm_lang$core$Color$orange = A4(_elm_lang$core$Color$RGBA, 245, 121, 0, 1);
var _elm_lang$core$Color$darkOrange = A4(_elm_lang$core$Color$RGBA, 206, 92, 0, 1);
var _elm_lang$core$Color$lightYellow = A4(_elm_lang$core$Color$RGBA, 255, 233, 79, 1);
var _elm_lang$core$Color$yellow = A4(_elm_lang$core$Color$RGBA, 237, 212, 0, 1);
var _elm_lang$core$Color$darkYellow = A4(_elm_lang$core$Color$RGBA, 196, 160, 0, 1);
var _elm_lang$core$Color$lightGreen = A4(_elm_lang$core$Color$RGBA, 138, 226, 52, 1);
var _elm_lang$core$Color$green = A4(_elm_lang$core$Color$RGBA, 115, 210, 22, 1);
var _elm_lang$core$Color$darkGreen = A4(_elm_lang$core$Color$RGBA, 78, 154, 6, 1);
var _elm_lang$core$Color$lightBlue = A4(_elm_lang$core$Color$RGBA, 114, 159, 207, 1);
var _elm_lang$core$Color$blue = A4(_elm_lang$core$Color$RGBA, 52, 101, 164, 1);
var _elm_lang$core$Color$darkBlue = A4(_elm_lang$core$Color$RGBA, 32, 74, 135, 1);
var _elm_lang$core$Color$lightPurple = A4(_elm_lang$core$Color$RGBA, 173, 127, 168, 1);
var _elm_lang$core$Color$purple = A4(_elm_lang$core$Color$RGBA, 117, 80, 123, 1);
var _elm_lang$core$Color$darkPurple = A4(_elm_lang$core$Color$RGBA, 92, 53, 102, 1);
var _elm_lang$core$Color$lightBrown = A4(_elm_lang$core$Color$RGBA, 233, 185, 110, 1);
var _elm_lang$core$Color$brown = A4(_elm_lang$core$Color$RGBA, 193, 125, 17, 1);
var _elm_lang$core$Color$darkBrown = A4(_elm_lang$core$Color$RGBA, 143, 89, 2, 1);
var _elm_lang$core$Color$black = A4(_elm_lang$core$Color$RGBA, 0, 0, 0, 1);
var _elm_lang$core$Color$white = A4(_elm_lang$core$Color$RGBA, 255, 255, 255, 1);
var _elm_lang$core$Color$lightGrey = A4(_elm_lang$core$Color$RGBA, 238, 238, 236, 1);
var _elm_lang$core$Color$grey = A4(_elm_lang$core$Color$RGBA, 211, 215, 207, 1);
var _elm_lang$core$Color$darkGrey = A4(_elm_lang$core$Color$RGBA, 186, 189, 182, 1);
var _elm_lang$core$Color$lightGray = A4(_elm_lang$core$Color$RGBA, 238, 238, 236, 1);
var _elm_lang$core$Color$gray = A4(_elm_lang$core$Color$RGBA, 211, 215, 207, 1);
var _elm_lang$core$Color$darkGray = A4(_elm_lang$core$Color$RGBA, 186, 189, 182, 1);
var _elm_lang$core$Color$lightCharcoal = A4(_elm_lang$core$Color$RGBA, 136, 138, 133, 1);
var _elm_lang$core$Color$charcoal = A4(_elm_lang$core$Color$RGBA, 85, 87, 83, 1);
var _elm_lang$core$Color$darkCharcoal = A4(_elm_lang$core$Color$RGBA, 46, 52, 54, 1);
var _elm_lang$core$Color$Radial = F5(
	function (a, b, c, d, e) {
		return {ctor: 'Radial', _0: a, _1: b, _2: c, _3: d, _4: e};
	});
var _elm_lang$core$Color$radial = _elm_lang$core$Color$Radial;
var _elm_lang$core$Color$Linear = F3(
	function (a, b, c) {
		return {ctor: 'Linear', _0: a, _1: b, _2: c};
	});
var _elm_lang$core$Color$linear = _elm_lang$core$Color$Linear;

//import Native.List //

var _elm_lang$core$Native_Array = function() {

// A RRB-Tree has two distinct data types.
// Leaf -> "height"  is always 0
//         "table"   is an array of elements
// Node -> "height"  is always greater than 0
//         "table"   is an array of child nodes
//         "lengths" is an array of accumulated lengths of the child nodes

// M is the maximal table size. 32 seems fast. E is the allowed increase
// of search steps when concatting to find an index. Lower values will
// decrease balancing, but will increase search steps.
var M = 32;
var E = 2;

// An empty array.
var empty = {
	ctor: '_Array',
	height: 0,
	table: []
};


function get(i, array)
{
	if (i < 0 || i >= length(array))
	{
		throw new Error(
			'Index ' + i + ' is out of range. Check the length of ' +
			'your array first or use getMaybe or getWithDefault.');
	}
	return unsafeGet(i, array);
}


function unsafeGet(i, array)
{
	for (var x = array.height; x > 0; x--)
	{
		var slot = i >> (x * 5);
		while (array.lengths[slot] <= i)
		{
			slot++;
		}
		if (slot > 0)
		{
			i -= array.lengths[slot - 1];
		}
		array = array.table[slot];
	}
	return array.table[i];
}


// Sets the value at the index i. Only the nodes leading to i will get
// copied and updated.
function set(i, item, array)
{
	if (i < 0 || length(array) <= i)
	{
		return array;
	}
	return unsafeSet(i, item, array);
}


function unsafeSet(i, item, array)
{
	array = nodeCopy(array);

	if (array.height === 0)
	{
		array.table[i] = item;
	}
	else
	{
		var slot = getSlot(i, array);
		if (slot > 0)
		{
			i -= array.lengths[slot - 1];
		}
		array.table[slot] = unsafeSet(i, item, array.table[slot]);
	}
	return array;
}


function initialize(len, f)
{
	if (len <= 0)
	{
		return empty;
	}
	var h = Math.floor( Math.log(len) / Math.log(M) );
	return initialize_(f, h, 0, len);
}

function initialize_(f, h, from, to)
{
	if (h === 0)
	{
		var table = new Array((to - from) % (M + 1));
		for (var i = 0; i < table.length; i++)
		{
		  table[i] = f(from + i);
		}
		return {
			ctor: '_Array',
			height: 0,
			table: table
		};
	}

	var step = Math.pow(M, h);
	var table = new Array(Math.ceil((to - from) / step));
	var lengths = new Array(table.length);
	for (var i = 0; i < table.length; i++)
	{
		table[i] = initialize_(f, h - 1, from + (i * step), Math.min(from + ((i + 1) * step), to));
		lengths[i] = length(table[i]) + (i > 0 ? lengths[i-1] : 0);
	}
	return {
		ctor: '_Array',
		height: h,
		table: table,
		lengths: lengths
	};
}

function fromList(list)
{
	if (list.ctor === '[]')
	{
		return empty;
	}

	// Allocate M sized blocks (table) and write list elements to it.
	var table = new Array(M);
	var nodes = [];
	var i = 0;

	while (list.ctor !== '[]')
	{
		table[i] = list._0;
		list = list._1;
		i++;

		// table is full, so we can push a leaf containing it into the
		// next node.
		if (i === M)
		{
			var leaf = {
				ctor: '_Array',
				height: 0,
				table: table
			};
			fromListPush(leaf, nodes);
			table = new Array(M);
			i = 0;
		}
	}

	// Maybe there is something left on the table.
	if (i > 0)
	{
		var leaf = {
			ctor: '_Array',
			height: 0,
			table: table.splice(0, i)
		};
		fromListPush(leaf, nodes);
	}

	// Go through all of the nodes and eventually push them into higher nodes.
	for (var h = 0; h < nodes.length - 1; h++)
	{
		if (nodes[h].table.length > 0)
		{
			fromListPush(nodes[h], nodes);
		}
	}

	var head = nodes[nodes.length - 1];
	if (head.height > 0 && head.table.length === 1)
	{
		return head.table[0];
	}
	else
	{
		return head;
	}
}

// Push a node into a higher node as a child.
function fromListPush(toPush, nodes)
{
	var h = toPush.height;

	// Maybe the node on this height does not exist.
	if (nodes.length === h)
	{
		var node = {
			ctor: '_Array',
			height: h + 1,
			table: [],
			lengths: []
		};
		nodes.push(node);
	}

	nodes[h].table.push(toPush);
	var len = length(toPush);
	if (nodes[h].lengths.length > 0)
	{
		len += nodes[h].lengths[nodes[h].lengths.length - 1];
	}
	nodes[h].lengths.push(len);

	if (nodes[h].table.length === M)
	{
		fromListPush(nodes[h], nodes);
		nodes[h] = {
			ctor: '_Array',
			height: h + 1,
			table: [],
			lengths: []
		};
	}
}

// Pushes an item via push_ to the bottom right of a tree.
function push(item, a)
{
	var pushed = push_(item, a);
	if (pushed !== null)
	{
		return pushed;
	}

	var newTree = create(item, a.height);
	return siblise(a, newTree);
}

// Recursively tries to push an item to the bottom-right most
// tree possible. If there is no space left for the item,
// null will be returned.
function push_(item, a)
{
	// Handle resursion stop at leaf level.
	if (a.height === 0)
	{
		if (a.table.length < M)
		{
			var newA = {
				ctor: '_Array',
				height: 0,
				table: a.table.slice()
			};
			newA.table.push(item);
			return newA;
		}
		else
		{
		  return null;
		}
	}

	// Recursively push
	var pushed = push_(item, botRight(a));

	// There was space in the bottom right tree, so the slot will
	// be updated.
	if (pushed !== null)
	{
		var newA = nodeCopy(a);
		newA.table[newA.table.length - 1] = pushed;
		newA.lengths[newA.lengths.length - 1]++;
		return newA;
	}

	// When there was no space left, check if there is space left
	// for a new slot with a tree which contains only the item
	// at the bottom.
	if (a.table.length < M)
	{
		var newSlot = create(item, a.height - 1);
		var newA = nodeCopy(a);
		newA.table.push(newSlot);
		newA.lengths.push(newA.lengths[newA.lengths.length - 1] + length(newSlot));
		return newA;
	}
	else
	{
		return null;
	}
}

// Converts an array into a list of elements.
function toList(a)
{
	return toList_(_elm_lang$core$Native_List.Nil, a);
}

function toList_(list, a)
{
	for (var i = a.table.length - 1; i >= 0; i--)
	{
		list =
			a.height === 0
				? _elm_lang$core$Native_List.Cons(a.table[i], list)
				: toList_(list, a.table[i]);
	}
	return list;
}

// Maps a function over the elements of an array.
function map(f, a)
{
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: new Array(a.table.length)
	};
	if (a.height > 0)
	{
		newA.lengths = a.lengths;
	}
	for (var i = 0; i < a.table.length; i++)
	{
		newA.table[i] =
			a.height === 0
				? f(a.table[i])
				: map(f, a.table[i]);
	}
	return newA;
}

// Maps a function over the elements with their index as first argument.
function indexedMap(f, a)
{
	return indexedMap_(f, a, 0);
}

function indexedMap_(f, a, from)
{
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: new Array(a.table.length)
	};
	if (a.height > 0)
	{
		newA.lengths = a.lengths;
	}
	for (var i = 0; i < a.table.length; i++)
	{
		newA.table[i] =
			a.height === 0
				? A2(f, from + i, a.table[i])
				: indexedMap_(f, a.table[i], i == 0 ? from : from + a.lengths[i - 1]);
	}
	return newA;
}

function foldl(f, b, a)
{
	if (a.height === 0)
	{
		for (var i = 0; i < a.table.length; i++)
		{
			b = A2(f, a.table[i], b);
		}
	}
	else
	{
		for (var i = 0; i < a.table.length; i++)
		{
			b = foldl(f, b, a.table[i]);
		}
	}
	return b;
}

function foldr(f, b, a)
{
	if (a.height === 0)
	{
		for (var i = a.table.length; i--; )
		{
			b = A2(f, a.table[i], b);
		}
	}
	else
	{
		for (var i = a.table.length; i--; )
		{
			b = foldr(f, b, a.table[i]);
		}
	}
	return b;
}

// TODO: currently, it slices the right, then the left. This can be
// optimized.
function slice(from, to, a)
{
	if (from < 0)
	{
		from += length(a);
	}
	if (to < 0)
	{
		to += length(a);
	}
	return sliceLeft(from, sliceRight(to, a));
}

function sliceRight(to, a)
{
	if (to === length(a))
	{
		return a;
	}

	// Handle leaf level.
	if (a.height === 0)
	{
		var newA = { ctor:'_Array', height:0 };
		newA.table = a.table.slice(0, to);
		return newA;
	}

	// Slice the right recursively.
	var right = getSlot(to, a);
	var sliced = sliceRight(to - (right > 0 ? a.lengths[right - 1] : 0), a.table[right]);

	// Maybe the a node is not even needed, as sliced contains the whole slice.
	if (right === 0)
	{
		return sliced;
	}

	// Create new node.
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: a.table.slice(0, right),
		lengths: a.lengths.slice(0, right)
	};
	if (sliced.table.length > 0)
	{
		newA.table[right] = sliced;
		newA.lengths[right] = length(sliced) + (right > 0 ? newA.lengths[right - 1] : 0);
	}
	return newA;
}

function sliceLeft(from, a)
{
	if (from === 0)
	{
		return a;
	}

	// Handle leaf level.
	if (a.height === 0)
	{
		var newA = { ctor:'_Array', height:0 };
		newA.table = a.table.slice(from, a.table.length + 1);
		return newA;
	}

	// Slice the left recursively.
	var left = getSlot(from, a);
	var sliced = sliceLeft(from - (left > 0 ? a.lengths[left - 1] : 0), a.table[left]);

	// Maybe the a node is not even needed, as sliced contains the whole slice.
	if (left === a.table.length - 1)
	{
		return sliced;
	}

	// Create new node.
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: a.table.slice(left, a.table.length + 1),
		lengths: new Array(a.table.length - left)
	};
	newA.table[0] = sliced;
	var len = 0;
	for (var i = 0; i < newA.table.length; i++)
	{
		len += length(newA.table[i]);
		newA.lengths[i] = len;
	}

	return newA;
}

// Appends two trees.
function append(a,b)
{
	if (a.table.length === 0)
	{
		return b;
	}
	if (b.table.length === 0)
	{
		return a;
	}

	var c = append_(a, b);

	// Check if both nodes can be crunshed together.
	if (c[0].table.length + c[1].table.length <= M)
	{
		if (c[0].table.length === 0)
		{
			return c[1];
		}
		if (c[1].table.length === 0)
		{
			return c[0];
		}

		// Adjust .table and .lengths
		c[0].table = c[0].table.concat(c[1].table);
		if (c[0].height > 0)
		{
			var len = length(c[0]);
			for (var i = 0; i < c[1].lengths.length; i++)
			{
				c[1].lengths[i] += len;
			}
			c[0].lengths = c[0].lengths.concat(c[1].lengths);
		}

		return c[0];
	}

	if (c[0].height > 0)
	{
		var toRemove = calcToRemove(a, b);
		if (toRemove > E)
		{
			c = shuffle(c[0], c[1], toRemove);
		}
	}

	return siblise(c[0], c[1]);
}

// Returns an array of two nodes; right and left. One node _may_ be empty.
function append_(a, b)
{
	if (a.height === 0 && b.height === 0)
	{
		return [a, b];
	}

	if (a.height !== 1 || b.height !== 1)
	{
		if (a.height === b.height)
		{
			a = nodeCopy(a);
			b = nodeCopy(b);
			var appended = append_(botRight(a), botLeft(b));

			insertRight(a, appended[1]);
			insertLeft(b, appended[0]);
		}
		else if (a.height > b.height)
		{
			a = nodeCopy(a);
			var appended = append_(botRight(a), b);

			insertRight(a, appended[0]);
			b = parentise(appended[1], appended[1].height + 1);
		}
		else
		{
			b = nodeCopy(b);
			var appended = append_(a, botLeft(b));

			var left = appended[0].table.length === 0 ? 0 : 1;
			var right = left === 0 ? 1 : 0;
			insertLeft(b, appended[left]);
			a = parentise(appended[right], appended[right].height + 1);
		}
	}

	// Check if balancing is needed and return based on that.
	if (a.table.length === 0 || b.table.length === 0)
	{
		return [a, b];
	}

	var toRemove = calcToRemove(a, b);
	if (toRemove <= E)
	{
		return [a, b];
	}
	return shuffle(a, b, toRemove);
}

// Helperfunctions for append_. Replaces a child node at the side of the parent.
function insertRight(parent, node)
{
	var index = parent.table.length - 1;
	parent.table[index] = node;
	parent.lengths[index] = length(node);
	parent.lengths[index] += index > 0 ? parent.lengths[index - 1] : 0;
}

function insertLeft(parent, node)
{
	if (node.table.length > 0)
	{
		parent.table[0] = node;
		parent.lengths[0] = length(node);

		var len = length(parent.table[0]);
		for (var i = 1; i < parent.lengths.length; i++)
		{
			len += length(parent.table[i]);
			parent.lengths[i] = len;
		}
	}
	else
	{
		parent.table.shift();
		for (var i = 1; i < parent.lengths.length; i++)
		{
			parent.lengths[i] = parent.lengths[i] - parent.lengths[0];
		}
		parent.lengths.shift();
	}
}

// Returns the extra search steps for E. Refer to the paper.
function calcToRemove(a, b)
{
	var subLengths = 0;
	for (var i = 0; i < a.table.length; i++)
	{
		subLengths += a.table[i].table.length;
	}
	for (var i = 0; i < b.table.length; i++)
	{
		subLengths += b.table[i].table.length;
	}

	var toRemove = a.table.length + b.table.length;
	return toRemove - (Math.floor((subLengths - 1) / M) + 1);
}

// get2, set2 and saveSlot are helpers for accessing elements over two arrays.
function get2(a, b, index)
{
	return index < a.length
		? a[index]
		: b[index - a.length];
}

function set2(a, b, index, value)
{
	if (index < a.length)
	{
		a[index] = value;
	}
	else
	{
		b[index - a.length] = value;
	}
}

function saveSlot(a, b, index, slot)
{
	set2(a.table, b.table, index, slot);

	var l = (index === 0 || index === a.lengths.length)
		? 0
		: get2(a.lengths, a.lengths, index - 1);

	set2(a.lengths, b.lengths, index, l + length(slot));
}

// Creates a node or leaf with a given length at their arrays for perfomance.
// Is only used by shuffle.
function createNode(h, length)
{
	if (length < 0)
	{
		length = 0;
	}
	var a = {
		ctor: '_Array',
		height: h,
		table: new Array(length)
	};
	if (h > 0)
	{
		a.lengths = new Array(length);
	}
	return a;
}

// Returns an array of two balanced nodes.
function shuffle(a, b, toRemove)
{
	var newA = createNode(a.height, Math.min(M, a.table.length + b.table.length - toRemove));
	var newB = createNode(a.height, newA.table.length - (a.table.length + b.table.length - toRemove));

	// Skip the slots with size M. More precise: copy the slot references
	// to the new node
	var read = 0;
	while (get2(a.table, b.table, read).table.length % M === 0)
	{
		set2(newA.table, newB.table, read, get2(a.table, b.table, read));
		set2(newA.lengths, newB.lengths, read, get2(a.lengths, b.lengths, read));
		read++;
	}

	// Pulling items from left to right, caching in a slot before writing
	// it into the new nodes.
	var write = read;
	var slot = new createNode(a.height - 1, 0);
	var from = 0;

	// If the current slot is still containing data, then there will be at
	// least one more write, so we do not break this loop yet.
	while (read - write - (slot.table.length > 0 ? 1 : 0) < toRemove)
	{
		// Find out the max possible items for copying.
		var source = get2(a.table, b.table, read);
		var to = Math.min(M - slot.table.length, source.table.length);

		// Copy and adjust size table.
		slot.table = slot.table.concat(source.table.slice(from, to));
		if (slot.height > 0)
		{
			var len = slot.lengths.length;
			for (var i = len; i < len + to - from; i++)
			{
				slot.lengths[i] = length(slot.table[i]);
				slot.lengths[i] += (i > 0 ? slot.lengths[i - 1] : 0);
			}
		}

		from += to;

		// Only proceed to next slots[i] if the current one was
		// fully copied.
		if (source.table.length <= to)
		{
			read++; from = 0;
		}

		// Only create a new slot if the current one is filled up.
		if (slot.table.length === M)
		{
			saveSlot(newA, newB, write, slot);
			slot = createNode(a.height - 1, 0);
			write++;
		}
	}

	// Cleanup after the loop. Copy the last slot into the new nodes.
	if (slot.table.length > 0)
	{
		saveSlot(newA, newB, write, slot);
		write++;
	}

	// Shift the untouched slots to the left
	while (read < a.table.length + b.table.length )
	{
		saveSlot(newA, newB, write, get2(a.table, b.table, read));
		read++;
		write++;
	}

	return [newA, newB];
}

// Navigation functions
function botRight(a)
{
	return a.table[a.table.length - 1];
}
function botLeft(a)
{
	return a.table[0];
}

// Copies a node for updating. Note that you should not use this if
// only updating only one of "table" or "lengths" for performance reasons.
function nodeCopy(a)
{
	var newA = {
		ctor: '_Array',
		height: a.height,
		table: a.table.slice()
	};
	if (a.height > 0)
	{
		newA.lengths = a.lengths.slice();
	}
	return newA;
}

// Returns how many items are in the tree.
function length(array)
{
	if (array.height === 0)
	{
		return array.table.length;
	}
	else
	{
		return array.lengths[array.lengths.length - 1];
	}
}

// Calculates in which slot of "table" the item probably is, then
// find the exact slot via forward searching in  "lengths". Returns the index.
function getSlot(i, a)
{
	var slot = i >> (5 * a.height);
	while (a.lengths[slot] <= i)
	{
		slot++;
	}
	return slot;
}

// Recursively creates a tree with a given height containing
// only the given item.
function create(item, h)
{
	if (h === 0)
	{
		return {
			ctor: '_Array',
			height: 0,
			table: [item]
		};
	}
	return {
		ctor: '_Array',
		height: h,
		table: [create(item, h - 1)],
		lengths: [1]
	};
}

// Recursively creates a tree that contains the given tree.
function parentise(tree, h)
{
	if (h === tree.height)
	{
		return tree;
	}

	return {
		ctor: '_Array',
		height: h,
		table: [parentise(tree, h - 1)],
		lengths: [length(tree)]
	};
}

// Emphasizes blood brotherhood beneath two trees.
function siblise(a, b)
{
	return {
		ctor: '_Array',
		height: a.height + 1,
		table: [a, b],
		lengths: [length(a), length(a) + length(b)]
	};
}

function toJSArray(a)
{
	var jsArray = new Array(length(a));
	toJSArray_(jsArray, 0, a);
	return jsArray;
}

function toJSArray_(jsArray, i, a)
{
	for (var t = 0; t < a.table.length; t++)
	{
		if (a.height === 0)
		{
			jsArray[i + t] = a.table[t];
		}
		else
		{
			var inc = t === 0 ? 0 : a.lengths[t - 1];
			toJSArray_(jsArray, i + inc, a.table[t]);
		}
	}
}

function fromJSArray(jsArray)
{
	if (jsArray.length === 0)
	{
		return empty;
	}
	var h = Math.floor(Math.log(jsArray.length) / Math.log(M));
	return fromJSArray_(jsArray, h, 0, jsArray.length);
}

function fromJSArray_(jsArray, h, from, to)
{
	if (h === 0)
	{
		return {
			ctor: '_Array',
			height: 0,
			table: jsArray.slice(from, to)
		};
	}

	var step = Math.pow(M, h);
	var table = new Array(Math.ceil((to - from) / step));
	var lengths = new Array(table.length);
	for (var i = 0; i < table.length; i++)
	{
		table[i] = fromJSArray_(jsArray, h - 1, from + (i * step), Math.min(from + ((i + 1) * step), to));
		lengths[i] = length(table[i]) + (i > 0 ? lengths[i - 1] : 0);
	}
	return {
		ctor: '_Array',
		height: h,
		table: table,
		lengths: lengths
	};
}

return {
	empty: empty,
	fromList: fromList,
	toList: toList,
	initialize: F2(initialize),
	append: F2(append),
	push: F2(push),
	slice: F3(slice),
	get: F2(get),
	set: F3(set),
	map: F2(map),
	indexedMap: F2(indexedMap),
	foldl: F3(foldl),
	foldr: F3(foldr),
	length: length,

	toJSArray: toJSArray,
	fromJSArray: fromJSArray
};

}();
var _elm_lang$core$Array$append = _elm_lang$core$Native_Array.append;
var _elm_lang$core$Array$length = _elm_lang$core$Native_Array.length;
var _elm_lang$core$Array$isEmpty = function (array) {
	return _elm_lang$core$Native_Utils.eq(
		_elm_lang$core$Array$length(array),
		0);
};
var _elm_lang$core$Array$slice = _elm_lang$core$Native_Array.slice;
var _elm_lang$core$Array$set = _elm_lang$core$Native_Array.set;
var _elm_lang$core$Array$get = F2(
	function (i, array) {
		return ((_elm_lang$core$Native_Utils.cmp(0, i) < 1) && (_elm_lang$core$Native_Utils.cmp(
			i,
			_elm_lang$core$Native_Array.length(array)) < 0)) ? _elm_lang$core$Maybe$Just(
			A2(_elm_lang$core$Native_Array.get, i, array)) : _elm_lang$core$Maybe$Nothing;
	});
var _elm_lang$core$Array$push = _elm_lang$core$Native_Array.push;
var _elm_lang$core$Array$empty = _elm_lang$core$Native_Array.empty;
var _elm_lang$core$Array$filter = F2(
	function (isOkay, arr) {
		var update = F2(
			function (x, xs) {
				return isOkay(x) ? A2(_elm_lang$core$Native_Array.push, x, xs) : xs;
			});
		return A3(_elm_lang$core$Native_Array.foldl, update, _elm_lang$core$Native_Array.empty, arr);
	});
var _elm_lang$core$Array$foldr = _elm_lang$core$Native_Array.foldr;
var _elm_lang$core$Array$foldl = _elm_lang$core$Native_Array.foldl;
var _elm_lang$core$Array$indexedMap = _elm_lang$core$Native_Array.indexedMap;
var _elm_lang$core$Array$map = _elm_lang$core$Native_Array.map;
var _elm_lang$core$Array$toIndexedList = function (array) {
	return A3(
		_elm_lang$core$List$map2,
		F2(
			function (v0, v1) {
				return {ctor: '_Tuple2', _0: v0, _1: v1};
			}),
		A2(
			_elm_lang$core$List$range,
			0,
			_elm_lang$core$Native_Array.length(array) - 1),
		_elm_lang$core$Native_Array.toList(array));
};
var _elm_lang$core$Array$toList = _elm_lang$core$Native_Array.toList;
var _elm_lang$core$Array$fromList = _elm_lang$core$Native_Array.fromList;
var _elm_lang$core$Array$initialize = _elm_lang$core$Native_Array.initialize;
var _elm_lang$core$Array$repeat = F2(
	function (n, e) {
		return A2(
			_elm_lang$core$Array$initialize,
			n,
			_elm_lang$core$Basics$always(e));
	});
var _elm_lang$core$Array$Array = {ctor: 'Array'};

var _elm_lang$core$Dict$foldr = F3(
	function (f, acc, t) {
		foldr:
		while (true) {
			var _p0 = t;
			if (_p0.ctor === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var _v1 = f,
					_v2 = A3(
					f,
					_p0._1,
					_p0._2,
					A3(_elm_lang$core$Dict$foldr, f, acc, _p0._4)),
					_v3 = _p0._3;
				f = _v1;
				acc = _v2;
				t = _v3;
				continue foldr;
			}
		}
	});
var _elm_lang$core$Dict$keys = function (dict) {
	return A3(
		_elm_lang$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return {ctor: '::', _0: key, _1: keyList};
			}),
		{ctor: '[]'},
		dict);
};
var _elm_lang$core$Dict$values = function (dict) {
	return A3(
		_elm_lang$core$Dict$foldr,
		F3(
			function (key, value, valueList) {
				return {ctor: '::', _0: value, _1: valueList};
			}),
		{ctor: '[]'},
		dict);
};
var _elm_lang$core$Dict$toList = function (dict) {
	return A3(
		_elm_lang$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: key, _1: value},
					_1: list
				};
			}),
		{ctor: '[]'},
		dict);
};
var _elm_lang$core$Dict$foldl = F3(
	function (f, acc, dict) {
		foldl:
		while (true) {
			var _p1 = dict;
			if (_p1.ctor === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var _v5 = f,
					_v6 = A3(
					f,
					_p1._1,
					_p1._2,
					A3(_elm_lang$core$Dict$foldl, f, acc, _p1._3)),
					_v7 = _p1._4;
				f = _v5;
				acc = _v6;
				dict = _v7;
				continue foldl;
			}
		}
	});
var _elm_lang$core$Dict$merge = F6(
	function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
		var stepState = F3(
			function (rKey, rValue, _p2) {
				stepState:
				while (true) {
					var _p3 = _p2;
					var _p9 = _p3._1;
					var _p8 = _p3._0;
					var _p4 = _p8;
					if (_p4.ctor === '[]') {
						return {
							ctor: '_Tuple2',
							_0: _p8,
							_1: A3(rightStep, rKey, rValue, _p9)
						};
					} else {
						var _p7 = _p4._1;
						var _p6 = _p4._0._1;
						var _p5 = _p4._0._0;
						if (_elm_lang$core$Native_Utils.cmp(_p5, rKey) < 0) {
							var _v10 = rKey,
								_v11 = rValue,
								_v12 = {
								ctor: '_Tuple2',
								_0: _p7,
								_1: A3(leftStep, _p5, _p6, _p9)
							};
							rKey = _v10;
							rValue = _v11;
							_p2 = _v12;
							continue stepState;
						} else {
							if (_elm_lang$core$Native_Utils.cmp(_p5, rKey) > 0) {
								return {
									ctor: '_Tuple2',
									_0: _p8,
									_1: A3(rightStep, rKey, rValue, _p9)
								};
							} else {
								return {
									ctor: '_Tuple2',
									_0: _p7,
									_1: A4(bothStep, _p5, _p6, rValue, _p9)
								};
							}
						}
					}
				}
			});
		var _p10 = A3(
			_elm_lang$core$Dict$foldl,
			stepState,
			{
				ctor: '_Tuple2',
				_0: _elm_lang$core$Dict$toList(leftDict),
				_1: initialResult
			},
			rightDict);
		var leftovers = _p10._0;
		var intermediateResult = _p10._1;
		return A3(
			_elm_lang$core$List$foldl,
			F2(
				function (_p11, result) {
					var _p12 = _p11;
					return A3(leftStep, _p12._0, _p12._1, result);
				}),
			intermediateResult,
			leftovers);
	});
var _elm_lang$core$Dict$reportRemBug = F4(
	function (msg, c, lgot, rgot) {
		return _elm_lang$core$Native_Debug.crash(
			_elm_lang$core$String$concat(
				{
					ctor: '::',
					_0: 'Internal red-black tree invariant violated, expected ',
					_1: {
						ctor: '::',
						_0: msg,
						_1: {
							ctor: '::',
							_0: ' and got ',
							_1: {
								ctor: '::',
								_0: _elm_lang$core$Basics$toString(c),
								_1: {
									ctor: '::',
									_0: '/',
									_1: {
										ctor: '::',
										_0: lgot,
										_1: {
											ctor: '::',
											_0: '/',
											_1: {
												ctor: '::',
												_0: rgot,
												_1: {
													ctor: '::',
													_0: '\nPlease report this bug to <https://github.com/elm-lang/core/issues>',
													_1: {ctor: '[]'}
												}
											}
										}
									}
								}
							}
						}
					}
				}));
	});
var _elm_lang$core$Dict$isBBlack = function (dict) {
	var _p13 = dict;
	_v14_2:
	do {
		if (_p13.ctor === 'RBNode_elm_builtin') {
			if (_p13._0.ctor === 'BBlack') {
				return true;
			} else {
				break _v14_2;
			}
		} else {
			if (_p13._0.ctor === 'LBBlack') {
				return true;
			} else {
				break _v14_2;
			}
		}
	} while(false);
	return false;
};
var _elm_lang$core$Dict$sizeHelp = F2(
	function (n, dict) {
		sizeHelp:
		while (true) {
			var _p14 = dict;
			if (_p14.ctor === 'RBEmpty_elm_builtin') {
				return n;
			} else {
				var _v16 = A2(_elm_lang$core$Dict$sizeHelp, n + 1, _p14._4),
					_v17 = _p14._3;
				n = _v16;
				dict = _v17;
				continue sizeHelp;
			}
		}
	});
var _elm_lang$core$Dict$size = function (dict) {
	return A2(_elm_lang$core$Dict$sizeHelp, 0, dict);
};
var _elm_lang$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			var _p15 = dict;
			if (_p15.ctor === 'RBEmpty_elm_builtin') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				var _p16 = A2(_elm_lang$core$Basics$compare, targetKey, _p15._1);
				switch (_p16.ctor) {
					case 'LT':
						var _v20 = targetKey,
							_v21 = _p15._3;
						targetKey = _v20;
						dict = _v21;
						continue get;
					case 'EQ':
						return _elm_lang$core$Maybe$Just(_p15._2);
					default:
						var _v22 = targetKey,
							_v23 = _p15._4;
						targetKey = _v22;
						dict = _v23;
						continue get;
				}
			}
		}
	});
var _elm_lang$core$Dict$member = F2(
	function (key, dict) {
		var _p17 = A2(_elm_lang$core$Dict$get, key, dict);
		if (_p17.ctor === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var _elm_lang$core$Dict$maxWithDefault = F3(
	function (k, v, r) {
		maxWithDefault:
		while (true) {
			var _p18 = r;
			if (_p18.ctor === 'RBEmpty_elm_builtin') {
				return {ctor: '_Tuple2', _0: k, _1: v};
			} else {
				var _v26 = _p18._1,
					_v27 = _p18._2,
					_v28 = _p18._4;
				k = _v26;
				v = _v27;
				r = _v28;
				continue maxWithDefault;
			}
		}
	});
var _elm_lang$core$Dict$NBlack = {ctor: 'NBlack'};
var _elm_lang$core$Dict$BBlack = {ctor: 'BBlack'};
var _elm_lang$core$Dict$Black = {ctor: 'Black'};
var _elm_lang$core$Dict$blackish = function (t) {
	var _p19 = t;
	if (_p19.ctor === 'RBNode_elm_builtin') {
		var _p20 = _p19._0;
		return _elm_lang$core$Native_Utils.eq(_p20, _elm_lang$core$Dict$Black) || _elm_lang$core$Native_Utils.eq(_p20, _elm_lang$core$Dict$BBlack);
	} else {
		return true;
	}
};
var _elm_lang$core$Dict$Red = {ctor: 'Red'};
var _elm_lang$core$Dict$moreBlack = function (color) {
	var _p21 = color;
	switch (_p21.ctor) {
		case 'Black':
			return _elm_lang$core$Dict$BBlack;
		case 'Red':
			return _elm_lang$core$Dict$Black;
		case 'NBlack':
			return _elm_lang$core$Dict$Red;
		default:
			return _elm_lang$core$Native_Debug.crash('Can\'t make a double black node more black!');
	}
};
var _elm_lang$core$Dict$lessBlack = function (color) {
	var _p22 = color;
	switch (_p22.ctor) {
		case 'BBlack':
			return _elm_lang$core$Dict$Black;
		case 'Black':
			return _elm_lang$core$Dict$Red;
		case 'Red':
			return _elm_lang$core$Dict$NBlack;
		default:
			return _elm_lang$core$Native_Debug.crash('Can\'t make a negative black node less black!');
	}
};
var _elm_lang$core$Dict$LBBlack = {ctor: 'LBBlack'};
var _elm_lang$core$Dict$LBlack = {ctor: 'LBlack'};
var _elm_lang$core$Dict$RBEmpty_elm_builtin = function (a) {
	return {ctor: 'RBEmpty_elm_builtin', _0: a};
};
var _elm_lang$core$Dict$empty = _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
var _elm_lang$core$Dict$isEmpty = function (dict) {
	return _elm_lang$core$Native_Utils.eq(dict, _elm_lang$core$Dict$empty);
};
var _elm_lang$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {ctor: 'RBNode_elm_builtin', _0: a, _1: b, _2: c, _3: d, _4: e};
	});
var _elm_lang$core$Dict$ensureBlackRoot = function (dict) {
	var _p23 = dict;
	if ((_p23.ctor === 'RBNode_elm_builtin') && (_p23._0.ctor === 'Red')) {
		return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p23._1, _p23._2, _p23._3, _p23._4);
	} else {
		return dict;
	}
};
var _elm_lang$core$Dict$lessBlackTree = function (dict) {
	var _p24 = dict;
	if (_p24.ctor === 'RBNode_elm_builtin') {
		return A5(
			_elm_lang$core$Dict$RBNode_elm_builtin,
			_elm_lang$core$Dict$lessBlack(_p24._0),
			_p24._1,
			_p24._2,
			_p24._3,
			_p24._4);
	} else {
		return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
	}
};
var _elm_lang$core$Dict$balancedTree = function (col) {
	return function (xk) {
		return function (xv) {
			return function (yk) {
				return function (yv) {
					return function (zk) {
						return function (zv) {
							return function (a) {
								return function (b) {
									return function (c) {
										return function (d) {
											return A5(
												_elm_lang$core$Dict$RBNode_elm_builtin,
												_elm_lang$core$Dict$lessBlack(col),
												yk,
												yv,
												A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, xk, xv, a, b),
												A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, zk, zv, c, d));
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
};
var _elm_lang$core$Dict$blacken = function (t) {
	var _p25 = t;
	if (_p25.ctor === 'RBEmpty_elm_builtin') {
		return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
	} else {
		return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p25._1, _p25._2, _p25._3, _p25._4);
	}
};
var _elm_lang$core$Dict$redden = function (t) {
	var _p26 = t;
	if (_p26.ctor === 'RBEmpty_elm_builtin') {
		return _elm_lang$core$Native_Debug.crash('can\'t make a Leaf red');
	} else {
		return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Red, _p26._1, _p26._2, _p26._3, _p26._4);
	}
};
var _elm_lang$core$Dict$balanceHelp = function (tree) {
	var _p27 = tree;
	_v36_6:
	do {
		_v36_5:
		do {
			_v36_4:
			do {
				_v36_3:
				do {
					_v36_2:
					do {
						_v36_1:
						do {
							_v36_0:
							do {
								if (_p27.ctor === 'RBNode_elm_builtin') {
									if (_p27._3.ctor === 'RBNode_elm_builtin') {
										if (_p27._4.ctor === 'RBNode_elm_builtin') {
											switch (_p27._3._0.ctor) {
												case 'Red':
													switch (_p27._4._0.ctor) {
														case 'Red':
															if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																break _v36_0;
															} else {
																if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																	break _v36_1;
																} else {
																	if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																		break _v36_2;
																	} else {
																		if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																			break _v36_3;
																		} else {
																			break _v36_6;
																		}
																	}
																}
															}
														case 'NBlack':
															if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																break _v36_0;
															} else {
																if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																	break _v36_1;
																} else {
																	if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																		break _v36_4;
																	} else {
																		break _v36_6;
																	}
																}
															}
														default:
															if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
																break _v36_0;
															} else {
																if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
																	break _v36_1;
																} else {
																	break _v36_6;
																}
															}
													}
												case 'NBlack':
													switch (_p27._4._0.ctor) {
														case 'Red':
															if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																break _v36_2;
															} else {
																if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																	break _v36_3;
																} else {
																	if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																		break _v36_5;
																	} else {
																		break _v36_6;
																	}
																}
															}
														case 'NBlack':
															if (_p27._0.ctor === 'BBlack') {
																if ((((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																	break _v36_4;
																} else {
																	if ((((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																		break _v36_5;
																	} else {
																		break _v36_6;
																	}
																}
															} else {
																break _v36_6;
															}
														default:
															if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
																break _v36_5;
															} else {
																break _v36_6;
															}
													}
												default:
													switch (_p27._4._0.ctor) {
														case 'Red':
															if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
																break _v36_2;
															} else {
																if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
																	break _v36_3;
																} else {
																	break _v36_6;
																}
															}
														case 'NBlack':
															if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
																break _v36_4;
															} else {
																break _v36_6;
															}
														default:
															break _v36_6;
													}
											}
										} else {
											switch (_p27._3._0.ctor) {
												case 'Red':
													if ((_p27._3._3.ctor === 'RBNode_elm_builtin') && (_p27._3._3._0.ctor === 'Red')) {
														break _v36_0;
													} else {
														if ((_p27._3._4.ctor === 'RBNode_elm_builtin') && (_p27._3._4._0.ctor === 'Red')) {
															break _v36_1;
														} else {
															break _v36_6;
														}
													}
												case 'NBlack':
													if (((((_p27._0.ctor === 'BBlack') && (_p27._3._3.ctor === 'RBNode_elm_builtin')) && (_p27._3._3._0.ctor === 'Black')) && (_p27._3._4.ctor === 'RBNode_elm_builtin')) && (_p27._3._4._0.ctor === 'Black')) {
														break _v36_5;
													} else {
														break _v36_6;
													}
												default:
													break _v36_6;
											}
										}
									} else {
										if (_p27._4.ctor === 'RBNode_elm_builtin') {
											switch (_p27._4._0.ctor) {
												case 'Red':
													if ((_p27._4._3.ctor === 'RBNode_elm_builtin') && (_p27._4._3._0.ctor === 'Red')) {
														break _v36_2;
													} else {
														if ((_p27._4._4.ctor === 'RBNode_elm_builtin') && (_p27._4._4._0.ctor === 'Red')) {
															break _v36_3;
														} else {
															break _v36_6;
														}
													}
												case 'NBlack':
													if (((((_p27._0.ctor === 'BBlack') && (_p27._4._3.ctor === 'RBNode_elm_builtin')) && (_p27._4._3._0.ctor === 'Black')) && (_p27._4._4.ctor === 'RBNode_elm_builtin')) && (_p27._4._4._0.ctor === 'Black')) {
														break _v36_4;
													} else {
														break _v36_6;
													}
												default:
													break _v36_6;
											}
										} else {
											break _v36_6;
										}
									}
								} else {
									break _v36_6;
								}
							} while(false);
							return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._3._3._1)(_p27._3._3._2)(_p27._3._1)(_p27._3._2)(_p27._1)(_p27._2)(_p27._3._3._3)(_p27._3._3._4)(_p27._3._4)(_p27._4);
						} while(false);
						return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._3._1)(_p27._3._2)(_p27._3._4._1)(_p27._3._4._2)(_p27._1)(_p27._2)(_p27._3._3)(_p27._3._4._3)(_p27._3._4._4)(_p27._4);
					} while(false);
					return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._1)(_p27._2)(_p27._4._3._1)(_p27._4._3._2)(_p27._4._1)(_p27._4._2)(_p27._3)(_p27._4._3._3)(_p27._4._3._4)(_p27._4._4);
				} while(false);
				return _elm_lang$core$Dict$balancedTree(_p27._0)(_p27._1)(_p27._2)(_p27._4._1)(_p27._4._2)(_p27._4._4._1)(_p27._4._4._2)(_p27._3)(_p27._4._3)(_p27._4._4._3)(_p27._4._4._4);
			} while(false);
			return A5(
				_elm_lang$core$Dict$RBNode_elm_builtin,
				_elm_lang$core$Dict$Black,
				_p27._4._3._1,
				_p27._4._3._2,
				A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p27._1, _p27._2, _p27._3, _p27._4._3._3),
				A5(
					_elm_lang$core$Dict$balance,
					_elm_lang$core$Dict$Black,
					_p27._4._1,
					_p27._4._2,
					_p27._4._3._4,
					_elm_lang$core$Dict$redden(_p27._4._4)));
		} while(false);
		return A5(
			_elm_lang$core$Dict$RBNode_elm_builtin,
			_elm_lang$core$Dict$Black,
			_p27._3._4._1,
			_p27._3._4._2,
			A5(
				_elm_lang$core$Dict$balance,
				_elm_lang$core$Dict$Black,
				_p27._3._1,
				_p27._3._2,
				_elm_lang$core$Dict$redden(_p27._3._3),
				_p27._3._4._3),
			A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p27._1, _p27._2, _p27._3._4._4, _p27._4));
	} while(false);
	return tree;
};
var _elm_lang$core$Dict$balance = F5(
	function (c, k, v, l, r) {
		var tree = A5(_elm_lang$core$Dict$RBNode_elm_builtin, c, k, v, l, r);
		return _elm_lang$core$Dict$blackish(tree) ? _elm_lang$core$Dict$balanceHelp(tree) : tree;
	});
var _elm_lang$core$Dict$bubble = F5(
	function (c, k, v, l, r) {
		return (_elm_lang$core$Dict$isBBlack(l) || _elm_lang$core$Dict$isBBlack(r)) ? A5(
			_elm_lang$core$Dict$balance,
			_elm_lang$core$Dict$moreBlack(c),
			k,
			v,
			_elm_lang$core$Dict$lessBlackTree(l),
			_elm_lang$core$Dict$lessBlackTree(r)) : A5(_elm_lang$core$Dict$RBNode_elm_builtin, c, k, v, l, r);
	});
var _elm_lang$core$Dict$removeMax = F5(
	function (c, k, v, l, r) {
		var _p28 = r;
		if (_p28.ctor === 'RBEmpty_elm_builtin') {
			return A3(_elm_lang$core$Dict$rem, c, l, r);
		} else {
			return A5(
				_elm_lang$core$Dict$bubble,
				c,
				k,
				v,
				l,
				A5(_elm_lang$core$Dict$removeMax, _p28._0, _p28._1, _p28._2, _p28._3, _p28._4));
		}
	});
var _elm_lang$core$Dict$rem = F3(
	function (color, left, right) {
		var _p29 = {ctor: '_Tuple2', _0: left, _1: right};
		if (_p29._0.ctor === 'RBEmpty_elm_builtin') {
			if (_p29._1.ctor === 'RBEmpty_elm_builtin') {
				var _p30 = color;
				switch (_p30.ctor) {
					case 'Red':
						return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
					case 'Black':
						return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBBlack);
					default:
						return _elm_lang$core$Native_Debug.crash('cannot have bblack or nblack nodes at this point');
				}
			} else {
				var _p33 = _p29._1._0;
				var _p32 = _p29._0._0;
				var _p31 = {ctor: '_Tuple3', _0: color, _1: _p32, _2: _p33};
				if ((((_p31.ctor === '_Tuple3') && (_p31._0.ctor === 'Black')) && (_p31._1.ctor === 'LBlack')) && (_p31._2.ctor === 'Red')) {
					return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p29._1._1, _p29._1._2, _p29._1._3, _p29._1._4);
				} else {
					return A4(
						_elm_lang$core$Dict$reportRemBug,
						'Black/LBlack/Red',
						color,
						_elm_lang$core$Basics$toString(_p32),
						_elm_lang$core$Basics$toString(_p33));
				}
			}
		} else {
			if (_p29._1.ctor === 'RBEmpty_elm_builtin') {
				var _p36 = _p29._1._0;
				var _p35 = _p29._0._0;
				var _p34 = {ctor: '_Tuple3', _0: color, _1: _p35, _2: _p36};
				if ((((_p34.ctor === '_Tuple3') && (_p34._0.ctor === 'Black')) && (_p34._1.ctor === 'Red')) && (_p34._2.ctor === 'LBlack')) {
					return A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Black, _p29._0._1, _p29._0._2, _p29._0._3, _p29._0._4);
				} else {
					return A4(
						_elm_lang$core$Dict$reportRemBug,
						'Black/Red/LBlack',
						color,
						_elm_lang$core$Basics$toString(_p35),
						_elm_lang$core$Basics$toString(_p36));
				}
			} else {
				var _p40 = _p29._0._2;
				var _p39 = _p29._0._4;
				var _p38 = _p29._0._1;
				var newLeft = A5(_elm_lang$core$Dict$removeMax, _p29._0._0, _p38, _p40, _p29._0._3, _p39);
				var _p37 = A3(_elm_lang$core$Dict$maxWithDefault, _p38, _p40, _p39);
				var k = _p37._0;
				var v = _p37._1;
				return A5(_elm_lang$core$Dict$bubble, color, k, v, newLeft, right);
			}
		}
	});
var _elm_lang$core$Dict$map = F2(
	function (f, dict) {
		var _p41 = dict;
		if (_p41.ctor === 'RBEmpty_elm_builtin') {
			return _elm_lang$core$Dict$RBEmpty_elm_builtin(_elm_lang$core$Dict$LBlack);
		} else {
			var _p42 = _p41._1;
			return A5(
				_elm_lang$core$Dict$RBNode_elm_builtin,
				_p41._0,
				_p42,
				A2(f, _p42, _p41._2),
				A2(_elm_lang$core$Dict$map, f, _p41._3),
				A2(_elm_lang$core$Dict$map, f, _p41._4));
		}
	});
var _elm_lang$core$Dict$Same = {ctor: 'Same'};
var _elm_lang$core$Dict$Remove = {ctor: 'Remove'};
var _elm_lang$core$Dict$Insert = {ctor: 'Insert'};
var _elm_lang$core$Dict$update = F3(
	function (k, alter, dict) {
		var up = function (dict) {
			var _p43 = dict;
			if (_p43.ctor === 'RBEmpty_elm_builtin') {
				var _p44 = alter(_elm_lang$core$Maybe$Nothing);
				if (_p44.ctor === 'Nothing') {
					return {ctor: '_Tuple2', _0: _elm_lang$core$Dict$Same, _1: _elm_lang$core$Dict$empty};
				} else {
					return {
						ctor: '_Tuple2',
						_0: _elm_lang$core$Dict$Insert,
						_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _elm_lang$core$Dict$Red, k, _p44._0, _elm_lang$core$Dict$empty, _elm_lang$core$Dict$empty)
					};
				}
			} else {
				var _p55 = _p43._2;
				var _p54 = _p43._4;
				var _p53 = _p43._3;
				var _p52 = _p43._1;
				var _p51 = _p43._0;
				var _p45 = A2(_elm_lang$core$Basics$compare, k, _p52);
				switch (_p45.ctor) {
					case 'EQ':
						var _p46 = alter(
							_elm_lang$core$Maybe$Just(_p55));
						if (_p46.ctor === 'Nothing') {
							return {
								ctor: '_Tuple2',
								_0: _elm_lang$core$Dict$Remove,
								_1: A3(_elm_lang$core$Dict$rem, _p51, _p53, _p54)
							};
						} else {
							return {
								ctor: '_Tuple2',
								_0: _elm_lang$core$Dict$Same,
								_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p46._0, _p53, _p54)
							};
						}
					case 'LT':
						var _p47 = up(_p53);
						var flag = _p47._0;
						var newLeft = _p47._1;
						var _p48 = flag;
						switch (_p48.ctor) {
							case 'Same':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Same,
									_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p55, newLeft, _p54)
								};
							case 'Insert':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Insert,
									_1: A5(_elm_lang$core$Dict$balance, _p51, _p52, _p55, newLeft, _p54)
								};
							default:
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Remove,
									_1: A5(_elm_lang$core$Dict$bubble, _p51, _p52, _p55, newLeft, _p54)
								};
						}
					default:
						var _p49 = up(_p54);
						var flag = _p49._0;
						var newRight = _p49._1;
						var _p50 = flag;
						switch (_p50.ctor) {
							case 'Same':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Same,
									_1: A5(_elm_lang$core$Dict$RBNode_elm_builtin, _p51, _p52, _p55, _p53, newRight)
								};
							case 'Insert':
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Insert,
									_1: A5(_elm_lang$core$Dict$balance, _p51, _p52, _p55, _p53, newRight)
								};
							default:
								return {
									ctor: '_Tuple2',
									_0: _elm_lang$core$Dict$Remove,
									_1: A5(_elm_lang$core$Dict$bubble, _p51, _p52, _p55, _p53, newRight)
								};
						}
				}
			}
		};
		var _p56 = up(dict);
		var flag = _p56._0;
		var updatedDict = _p56._1;
		var _p57 = flag;
		switch (_p57.ctor) {
			case 'Same':
				return updatedDict;
			case 'Insert':
				return _elm_lang$core$Dict$ensureBlackRoot(updatedDict);
			default:
				return _elm_lang$core$Dict$blacken(updatedDict);
		}
	});
var _elm_lang$core$Dict$insert = F3(
	function (key, value, dict) {
		return A3(
			_elm_lang$core$Dict$update,
			key,
			_elm_lang$core$Basics$always(
				_elm_lang$core$Maybe$Just(value)),
			dict);
	});
var _elm_lang$core$Dict$singleton = F2(
	function (key, value) {
		return A3(_elm_lang$core$Dict$insert, key, value, _elm_lang$core$Dict$empty);
	});
var _elm_lang$core$Dict$union = F2(
	function (t1, t2) {
		return A3(_elm_lang$core$Dict$foldl, _elm_lang$core$Dict$insert, t2, t1);
	});
var _elm_lang$core$Dict$filter = F2(
	function (predicate, dictionary) {
		var add = F3(
			function (key, value, dict) {
				return A2(predicate, key, value) ? A3(_elm_lang$core$Dict$insert, key, value, dict) : dict;
			});
		return A3(_elm_lang$core$Dict$foldl, add, _elm_lang$core$Dict$empty, dictionary);
	});
var _elm_lang$core$Dict$intersect = F2(
	function (t1, t2) {
		return A2(
			_elm_lang$core$Dict$filter,
			F2(
				function (k, _p58) {
					return A2(_elm_lang$core$Dict$member, k, t2);
				}),
			t1);
	});
var _elm_lang$core$Dict$partition = F2(
	function (predicate, dict) {
		var add = F3(
			function (key, value, _p59) {
				var _p60 = _p59;
				var _p62 = _p60._1;
				var _p61 = _p60._0;
				return A2(predicate, key, value) ? {
					ctor: '_Tuple2',
					_0: A3(_elm_lang$core$Dict$insert, key, value, _p61),
					_1: _p62
				} : {
					ctor: '_Tuple2',
					_0: _p61,
					_1: A3(_elm_lang$core$Dict$insert, key, value, _p62)
				};
			});
		return A3(
			_elm_lang$core$Dict$foldl,
			add,
			{ctor: '_Tuple2', _0: _elm_lang$core$Dict$empty, _1: _elm_lang$core$Dict$empty},
			dict);
	});
var _elm_lang$core$Dict$fromList = function (assocs) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (_p63, dict) {
				var _p64 = _p63;
				return A3(_elm_lang$core$Dict$insert, _p64._0, _p64._1, dict);
			}),
		_elm_lang$core$Dict$empty,
		assocs);
};
var _elm_lang$core$Dict$remove = F2(
	function (key, dict) {
		return A3(
			_elm_lang$core$Dict$update,
			key,
			_elm_lang$core$Basics$always(_elm_lang$core$Maybe$Nothing),
			dict);
	});
var _elm_lang$core$Dict$diff = F2(
	function (t1, t2) {
		return A3(
			_elm_lang$core$Dict$foldl,
			F3(
				function (k, v, t) {
					return A2(_elm_lang$core$Dict$remove, k, t);
				}),
			t1,
			t2);
	});

//import Maybe, Native.Array, Native.List, Native.Utils, Result //

var _elm_lang$core$Native_Json = function() {


// CORE DECODERS

function succeed(msg)
{
	return {
		ctor: '<decoder>',
		tag: 'succeed',
		msg: msg
	};
}

function fail(msg)
{
	return {
		ctor: '<decoder>',
		tag: 'fail',
		msg: msg
	};
}

function decodePrimitive(tag)
{
	return {
		ctor: '<decoder>',
		tag: tag
	};
}

function decodeContainer(tag, decoder)
{
	return {
		ctor: '<decoder>',
		tag: tag,
		decoder: decoder
	};
}

function decodeNull(value)
{
	return {
		ctor: '<decoder>',
		tag: 'null',
		value: value
	};
}

function decodeField(field, decoder)
{
	return {
		ctor: '<decoder>',
		tag: 'field',
		field: field,
		decoder: decoder
	};
}

function decodeIndex(index, decoder)
{
	return {
		ctor: '<decoder>',
		tag: 'index',
		index: index,
		decoder: decoder
	};
}

function decodeKeyValuePairs(decoder)
{
	return {
		ctor: '<decoder>',
		tag: 'key-value',
		decoder: decoder
	};
}

function mapMany(f, decoders)
{
	return {
		ctor: '<decoder>',
		tag: 'map-many',
		func: f,
		decoders: decoders
	};
}

function andThen(callback, decoder)
{
	return {
		ctor: '<decoder>',
		tag: 'andThen',
		decoder: decoder,
		callback: callback
	};
}

function oneOf(decoders)
{
	return {
		ctor: '<decoder>',
		tag: 'oneOf',
		decoders: decoders
	};
}


// DECODING OBJECTS

function map1(f, d1)
{
	return mapMany(f, [d1]);
}

function map2(f, d1, d2)
{
	return mapMany(f, [d1, d2]);
}

function map3(f, d1, d2, d3)
{
	return mapMany(f, [d1, d2, d3]);
}

function map4(f, d1, d2, d3, d4)
{
	return mapMany(f, [d1, d2, d3, d4]);
}

function map5(f, d1, d2, d3, d4, d5)
{
	return mapMany(f, [d1, d2, d3, d4, d5]);
}

function map6(f, d1, d2, d3, d4, d5, d6)
{
	return mapMany(f, [d1, d2, d3, d4, d5, d6]);
}

function map7(f, d1, d2, d3, d4, d5, d6, d7)
{
	return mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
}

function map8(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
}


// DECODE HELPERS

function ok(value)
{
	return { tag: 'ok', value: value };
}

function badPrimitive(type, value)
{
	return { tag: 'primitive', type: type, value: value };
}

function badIndex(index, nestedProblems)
{
	return { tag: 'index', index: index, rest: nestedProblems };
}

function badField(field, nestedProblems)
{
	return { tag: 'field', field: field, rest: nestedProblems };
}

function badIndex(index, nestedProblems)
{
	return { tag: 'index', index: index, rest: nestedProblems };
}

function badOneOf(problems)
{
	return { tag: 'oneOf', problems: problems };
}

function bad(msg)
{
	return { tag: 'fail', msg: msg };
}

function badToString(problem)
{
	var context = '_';
	while (problem)
	{
		switch (problem.tag)
		{
			case 'primitive':
				return 'Expecting ' + problem.type
					+ (context === '_' ? '' : ' at ' + context)
					+ ' but instead got: ' + jsToString(problem.value);

			case 'index':
				context += '[' + problem.index + ']';
				problem = problem.rest;
				break;

			case 'field':
				context += '.' + problem.field;
				problem = problem.rest;
				break;

			case 'oneOf':
				var problems = problem.problems;
				for (var i = 0; i < problems.length; i++)
				{
					problems[i] = badToString(problems[i]);
				}
				return 'I ran into the following problems'
					+ (context === '_' ? '' : ' at ' + context)
					+ ':\n\n' + problems.join('\n');

			case 'fail':
				return 'I ran into a `fail` decoder'
					+ (context === '_' ? '' : ' at ' + context)
					+ ': ' + problem.msg;
		}
	}
}

function jsToString(value)
{
	return value === undefined
		? 'undefined'
		: JSON.stringify(value);
}


// DECODE

function runOnString(decoder, string)
{
	var json;
	try
	{
		json = JSON.parse(string);
	}
	catch (e)
	{
		return _elm_lang$core$Result$Err('Given an invalid JSON: ' + e.message);
	}
	return run(decoder, json);
}

function run(decoder, value)
{
	var result = runHelp(decoder, value);
	return (result.tag === 'ok')
		? _elm_lang$core$Result$Ok(result.value)
		: _elm_lang$core$Result$Err(badToString(result));
}

function runHelp(decoder, value)
{
	switch (decoder.tag)
	{
		case 'bool':
			return (typeof value === 'boolean')
				? ok(value)
				: badPrimitive('a Bool', value);

		case 'int':
			if (typeof value !== 'number') {
				return badPrimitive('an Int', value);
			}

			if (-2147483647 < value && value < 2147483647 && (value | 0) === value) {
				return ok(value);
			}

			if (isFinite(value) && !(value % 1)) {
				return ok(value);
			}

			return badPrimitive('an Int', value);

		case 'float':
			return (typeof value === 'number')
				? ok(value)
				: badPrimitive('a Float', value);

		case 'string':
			return (typeof value === 'string')
				? ok(value)
				: (value instanceof String)
					? ok(value + '')
					: badPrimitive('a String', value);

		case 'null':
			return (value === null)
				? ok(decoder.value)
				: badPrimitive('null', value);

		case 'value':
			return ok(value);

		case 'list':
			if (!(value instanceof Array))
			{
				return badPrimitive('a List', value);
			}

			var list = _elm_lang$core$Native_List.Nil;
			for (var i = value.length; i--; )
			{
				var result = runHelp(decoder.decoder, value[i]);
				if (result.tag !== 'ok')
				{
					return badIndex(i, result)
				}
				list = _elm_lang$core$Native_List.Cons(result.value, list);
			}
			return ok(list);

		case 'array':
			if (!(value instanceof Array))
			{
				return badPrimitive('an Array', value);
			}

			var len = value.length;
			var array = new Array(len);
			for (var i = len; i--; )
			{
				var result = runHelp(decoder.decoder, value[i]);
				if (result.tag !== 'ok')
				{
					return badIndex(i, result);
				}
				array[i] = result.value;
			}
			return ok(_elm_lang$core$Native_Array.fromJSArray(array));

		case 'maybe':
			var result = runHelp(decoder.decoder, value);
			return (result.tag === 'ok')
				? ok(_elm_lang$core$Maybe$Just(result.value))
				: ok(_elm_lang$core$Maybe$Nothing);

		case 'field':
			var field = decoder.field;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return badPrimitive('an object with a field named `' + field + '`', value);
			}

			var result = runHelp(decoder.decoder, value[field]);
			return (result.tag === 'ok') ? result : badField(field, result);

		case 'index':
			var index = decoder.index;
			if (!(value instanceof Array))
			{
				return badPrimitive('an array', value);
			}
			if (index >= value.length)
			{
				return badPrimitive('a longer array. Need index ' + index + ' but there are only ' + value.length + ' entries', value);
			}

			var result = runHelp(decoder.decoder, value[index]);
			return (result.tag === 'ok') ? result : badIndex(index, result);

		case 'key-value':
			if (typeof value !== 'object' || value === null || value instanceof Array)
			{
				return badPrimitive('an object', value);
			}

			var keyValuePairs = _elm_lang$core$Native_List.Nil;
			for (var key in value)
			{
				var result = runHelp(decoder.decoder, value[key]);
				if (result.tag !== 'ok')
				{
					return badField(key, result);
				}
				var pair = _elm_lang$core$Native_Utils.Tuple2(key, result.value);
				keyValuePairs = _elm_lang$core$Native_List.Cons(pair, keyValuePairs);
			}
			return ok(keyValuePairs);

		case 'map-many':
			var answer = decoder.func;
			var decoders = decoder.decoders;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = runHelp(decoders[i], value);
				if (result.tag !== 'ok')
				{
					return result;
				}
				answer = answer(result.value);
			}
			return ok(answer);

		case 'andThen':
			var result = runHelp(decoder.decoder, value);
			return (result.tag !== 'ok')
				? result
				: runHelp(decoder.callback(result.value), value);

		case 'oneOf':
			var errors = [];
			var temp = decoder.decoders;
			while (temp.ctor !== '[]')
			{
				var result = runHelp(temp._0, value);

				if (result.tag === 'ok')
				{
					return result;
				}

				errors.push(result);

				temp = temp._1;
			}
			return badOneOf(errors);

		case 'fail':
			return bad(decoder.msg);

		case 'succeed':
			return ok(decoder.msg);
	}
}


// EQUALITY

function equality(a, b)
{
	if (a === b)
	{
		return true;
	}

	if (a.tag !== b.tag)
	{
		return false;
	}

	switch (a.tag)
	{
		case 'succeed':
		case 'fail':
			return a.msg === b.msg;

		case 'bool':
		case 'int':
		case 'float':
		case 'string':
		case 'value':
			return true;

		case 'null':
			return a.value === b.value;

		case 'list':
		case 'array':
		case 'maybe':
		case 'key-value':
			return equality(a.decoder, b.decoder);

		case 'field':
			return a.field === b.field && equality(a.decoder, b.decoder);

		case 'index':
			return a.index === b.index && equality(a.decoder, b.decoder);

		case 'map-many':
			if (a.func !== b.func)
			{
				return false;
			}
			return listEquality(a.decoders, b.decoders);

		case 'andThen':
			return a.callback === b.callback && equality(a.decoder, b.decoder);

		case 'oneOf':
			return listEquality(a.decoders, b.decoders);
	}
}

function listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

function encode(indentLevel, value)
{
	return JSON.stringify(value, null, indentLevel);
}

function identity(value)
{
	return value;
}

function encodeObject(keyValuePairs)
{
	var obj = {};
	while (keyValuePairs.ctor !== '[]')
	{
		var pair = keyValuePairs._0;
		obj[pair._0] = pair._1;
		keyValuePairs = keyValuePairs._1;
	}
	return obj;
}

return {
	encode: F2(encode),
	runOnString: F2(runOnString),
	run: F2(run),

	decodeNull: decodeNull,
	decodePrimitive: decodePrimitive,
	decodeContainer: F2(decodeContainer),

	decodeField: F2(decodeField),
	decodeIndex: F2(decodeIndex),

	map1: F2(map1),
	map2: F3(map2),
	map3: F4(map3),
	map4: F5(map4),
	map5: F6(map5),
	map6: F7(map6),
	map7: F8(map7),
	map8: F9(map8),
	decodeKeyValuePairs: decodeKeyValuePairs,

	andThen: F2(andThen),
	fail: fail,
	succeed: succeed,
	oneOf: oneOf,

	identity: identity,
	encodeNull: null,
	encodeArray: _elm_lang$core$Native_Array.toJSArray,
	encodeList: _elm_lang$core$Native_List.toArray,
	encodeObject: encodeObject,

	equality: equality
};

}();

var _elm_lang$core$Json_Encode$list = _elm_lang$core$Native_Json.encodeList;
var _elm_lang$core$Json_Encode$array = _elm_lang$core$Native_Json.encodeArray;
var _elm_lang$core$Json_Encode$object = _elm_lang$core$Native_Json.encodeObject;
var _elm_lang$core$Json_Encode$null = _elm_lang$core$Native_Json.encodeNull;
var _elm_lang$core$Json_Encode$bool = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$float = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$int = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$string = _elm_lang$core$Native_Json.identity;
var _elm_lang$core$Json_Encode$encode = _elm_lang$core$Native_Json.encode;
var _elm_lang$core$Json_Encode$Value = {ctor: 'Value'};

var _elm_lang$core$Json_Decode$null = _elm_lang$core$Native_Json.decodeNull;
var _elm_lang$core$Json_Decode$value = _elm_lang$core$Native_Json.decodePrimitive('value');
var _elm_lang$core$Json_Decode$andThen = _elm_lang$core$Native_Json.andThen;
var _elm_lang$core$Json_Decode$fail = _elm_lang$core$Native_Json.fail;
var _elm_lang$core$Json_Decode$succeed = _elm_lang$core$Native_Json.succeed;
var _elm_lang$core$Json_Decode$lazy = function (thunk) {
	return A2(
		_elm_lang$core$Json_Decode$andThen,
		thunk,
		_elm_lang$core$Json_Decode$succeed(
			{ctor: '_Tuple0'}));
};
var _elm_lang$core$Json_Decode$decodeValue = _elm_lang$core$Native_Json.run;
var _elm_lang$core$Json_Decode$decodeString = _elm_lang$core$Native_Json.runOnString;
var _elm_lang$core$Json_Decode$map8 = _elm_lang$core$Native_Json.map8;
var _elm_lang$core$Json_Decode$map7 = _elm_lang$core$Native_Json.map7;
var _elm_lang$core$Json_Decode$map6 = _elm_lang$core$Native_Json.map6;
var _elm_lang$core$Json_Decode$map5 = _elm_lang$core$Native_Json.map5;
var _elm_lang$core$Json_Decode$map4 = _elm_lang$core$Native_Json.map4;
var _elm_lang$core$Json_Decode$map3 = _elm_lang$core$Native_Json.map3;
var _elm_lang$core$Json_Decode$map2 = _elm_lang$core$Native_Json.map2;
var _elm_lang$core$Json_Decode$map = _elm_lang$core$Native_Json.map1;
var _elm_lang$core$Json_Decode$oneOf = _elm_lang$core$Native_Json.oneOf;
var _elm_lang$core$Json_Decode$maybe = function (decoder) {
	return A2(_elm_lang$core$Native_Json.decodeContainer, 'maybe', decoder);
};
var _elm_lang$core$Json_Decode$index = _elm_lang$core$Native_Json.decodeIndex;
var _elm_lang$core$Json_Decode$field = _elm_lang$core$Native_Json.decodeField;
var _elm_lang$core$Json_Decode$at = F2(
	function (fields, decoder) {
		return A3(_elm_lang$core$List$foldr, _elm_lang$core$Json_Decode$field, decoder, fields);
	});
var _elm_lang$core$Json_Decode$keyValuePairs = _elm_lang$core$Native_Json.decodeKeyValuePairs;
var _elm_lang$core$Json_Decode$dict = function (decoder) {
	return A2(
		_elm_lang$core$Json_Decode$map,
		_elm_lang$core$Dict$fromList,
		_elm_lang$core$Json_Decode$keyValuePairs(decoder));
};
var _elm_lang$core$Json_Decode$array = function (decoder) {
	return A2(_elm_lang$core$Native_Json.decodeContainer, 'array', decoder);
};
var _elm_lang$core$Json_Decode$list = function (decoder) {
	return A2(_elm_lang$core$Native_Json.decodeContainer, 'list', decoder);
};
var _elm_lang$core$Json_Decode$nullable = function (decoder) {
	return _elm_lang$core$Json_Decode$oneOf(
		{
			ctor: '::',
			_0: _elm_lang$core$Json_Decode$null(_elm_lang$core$Maybe$Nothing),
			_1: {
				ctor: '::',
				_0: A2(_elm_lang$core$Json_Decode$map, _elm_lang$core$Maybe$Just, decoder),
				_1: {ctor: '[]'}
			}
		});
};
var _elm_lang$core$Json_Decode$float = _elm_lang$core$Native_Json.decodePrimitive('float');
var _elm_lang$core$Json_Decode$int = _elm_lang$core$Native_Json.decodePrimitive('int');
var _elm_lang$core$Json_Decode$bool = _elm_lang$core$Native_Json.decodePrimitive('bool');
var _elm_lang$core$Json_Decode$string = _elm_lang$core$Native_Json.decodePrimitive('string');
var _elm_lang$core$Json_Decode$Decoder = {ctor: 'Decoder'};

var _elm_lang$virtual_dom$VirtualDom_Debug$wrap;
var _elm_lang$virtual_dom$VirtualDom_Debug$wrapWithFlags;

var _elm_lang$virtual_dom$Native_VirtualDom = function() {

var STYLE_KEY = 'STYLE';
var EVENT_KEY = 'EVENT';
var ATTR_KEY = 'ATTR';
var ATTR_NS_KEY = 'ATTR_NS';

var localDoc = typeof document !== 'undefined' ? document : {};


////////////  VIRTUAL DOM NODES  ////////////


function text(string)
{
	return {
		type: 'text',
		text: string
	};
}


function node(tag)
{
	return F2(function(factList, kidList) {
		return nodeHelp(tag, factList, kidList);
	});
}


function nodeHelp(tag, factList, kidList)
{
	var organized = organizeFacts(factList);
	var namespace = organized.namespace;
	var facts = organized.facts;

	var children = [];
	var descendantsCount = 0;
	while (kidList.ctor !== '[]')
	{
		var kid = kidList._0;
		descendantsCount += (kid.descendantsCount || 0);
		children.push(kid);
		kidList = kidList._1;
	}
	descendantsCount += children.length;

	return {
		type: 'node',
		tag: tag,
		facts: facts,
		children: children,
		namespace: namespace,
		descendantsCount: descendantsCount
	};
}


function keyedNode(tag, factList, kidList)
{
	var organized = organizeFacts(factList);
	var namespace = organized.namespace;
	var facts = organized.facts;

	var children = [];
	var descendantsCount = 0;
	while (kidList.ctor !== '[]')
	{
		var kid = kidList._0;
		descendantsCount += (kid._1.descendantsCount || 0);
		children.push(kid);
		kidList = kidList._1;
	}
	descendantsCount += children.length;

	return {
		type: 'keyed-node',
		tag: tag,
		facts: facts,
		children: children,
		namespace: namespace,
		descendantsCount: descendantsCount
	};
}


function custom(factList, model, impl)
{
	var facts = organizeFacts(factList).facts;

	return {
		type: 'custom',
		facts: facts,
		model: model,
		impl: impl
	};
}


function map(tagger, node)
{
	return {
		type: 'tagger',
		tagger: tagger,
		node: node,
		descendantsCount: 1 + (node.descendantsCount || 0)
	};
}


function thunk(func, args, thunk)
{
	return {
		type: 'thunk',
		func: func,
		args: args,
		thunk: thunk,
		node: undefined
	};
}

function lazy(fn, a)
{
	return thunk(fn, [a], function() {
		return fn(a);
	});
}

function lazy2(fn, a, b)
{
	return thunk(fn, [a,b], function() {
		return A2(fn, a, b);
	});
}

function lazy3(fn, a, b, c)
{
	return thunk(fn, [a,b,c], function() {
		return A3(fn, a, b, c);
	});
}



// FACTS


function organizeFacts(factList)
{
	var namespace, facts = {};

	while (factList.ctor !== '[]')
	{
		var entry = factList._0;
		var key = entry.key;

		if (key === ATTR_KEY || key === ATTR_NS_KEY || key === EVENT_KEY)
		{
			var subFacts = facts[key] || {};
			subFacts[entry.realKey] = entry.value;
			facts[key] = subFacts;
		}
		else if (key === STYLE_KEY)
		{
			var styles = facts[key] || {};
			var styleList = entry.value;
			while (styleList.ctor !== '[]')
			{
				var style = styleList._0;
				styles[style._0] = style._1;
				styleList = styleList._1;
			}
			facts[key] = styles;
		}
		else if (key === 'namespace')
		{
			namespace = entry.value;
		}
		else if (key === 'className')
		{
			var classes = facts[key];
			facts[key] = typeof classes === 'undefined'
				? entry.value
				: classes + ' ' + entry.value;
		}
 		else
		{
			facts[key] = entry.value;
		}
		factList = factList._1;
	}

	return {
		facts: facts,
		namespace: namespace
	};
}



////////////  PROPERTIES AND ATTRIBUTES  ////////////


function style(value)
{
	return {
		key: STYLE_KEY,
		value: value
	};
}


function property(key, value)
{
	return {
		key: key,
		value: value
	};
}


function attribute(key, value)
{
	return {
		key: ATTR_KEY,
		realKey: key,
		value: value
	};
}


function attributeNS(namespace, key, value)
{
	return {
		key: ATTR_NS_KEY,
		realKey: key,
		value: {
			value: value,
			namespace: namespace
		}
	};
}


function on(name, options, decoder)
{
	return {
		key: EVENT_KEY,
		realKey: name,
		value: {
			options: options,
			decoder: decoder
		}
	};
}


function equalEvents(a, b)
{
	if (a.options !== b.options)
	{
		if (a.options.stopPropagation !== b.options.stopPropagation || a.options.preventDefault !== b.options.preventDefault)
		{
			return false;
		}
	}
	return _elm_lang$core$Native_Json.equality(a.decoder, b.decoder);
}


function mapProperty(func, property)
{
	if (property.key !== EVENT_KEY)
	{
		return property;
	}
	return on(
		property.realKey,
		property.value.options,
		A2(_elm_lang$core$Json_Decode$map, func, property.value.decoder)
	);
}


////////////  RENDER  ////////////


function render(vNode, eventNode)
{
	switch (vNode.type)
	{
		case 'thunk':
			if (!vNode.node)
			{
				vNode.node = vNode.thunk();
			}
			return render(vNode.node, eventNode);

		case 'tagger':
			var subNode = vNode.node;
			var tagger = vNode.tagger;

			while (subNode.type === 'tagger')
			{
				typeof tagger !== 'object'
					? tagger = [tagger, subNode.tagger]
					: tagger.push(subNode.tagger);

				subNode = subNode.node;
			}

			var subEventRoot = { tagger: tagger, parent: eventNode };
			var domNode = render(subNode, subEventRoot);
			domNode.elm_event_node_ref = subEventRoot;
			return domNode;

		case 'text':
			return localDoc.createTextNode(vNode.text);

		case 'node':
			var domNode = vNode.namespace
				? localDoc.createElementNS(vNode.namespace, vNode.tag)
				: localDoc.createElement(vNode.tag);

			applyFacts(domNode, eventNode, vNode.facts);

			var children = vNode.children;

			for (var i = 0; i < children.length; i++)
			{
				domNode.appendChild(render(children[i], eventNode));
			}

			return domNode;

		case 'keyed-node':
			var domNode = vNode.namespace
				? localDoc.createElementNS(vNode.namespace, vNode.tag)
				: localDoc.createElement(vNode.tag);

			applyFacts(domNode, eventNode, vNode.facts);

			var children = vNode.children;

			for (var i = 0; i < children.length; i++)
			{
				domNode.appendChild(render(children[i]._1, eventNode));
			}

			return domNode;

		case 'custom':
			var domNode = vNode.impl.render(vNode.model);
			applyFacts(domNode, eventNode, vNode.facts);
			return domNode;
	}
}



////////////  APPLY FACTS  ////////////


function applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		switch (key)
		{
			case STYLE_KEY:
				applyStyles(domNode, value);
				break;

			case EVENT_KEY:
				applyEvents(domNode, eventNode, value);
				break;

			case ATTR_KEY:
				applyAttrs(domNode, value);
				break;

			case ATTR_NS_KEY:
				applyAttrsNS(domNode, value);
				break;

			case 'value':
				if (domNode[key] !== value)
				{
					domNode[key] = value;
				}
				break;

			default:
				domNode[key] = value;
				break;
		}
	}
}

function applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}

function applyEvents(domNode, eventNode, events)
{
	var allHandlers = domNode.elm_handlers || {};

	for (var key in events)
	{
		var handler = allHandlers[key];
		var value = events[key];

		if (typeof value === 'undefined')
		{
			domNode.removeEventListener(key, handler);
			allHandlers[key] = undefined;
		}
		else if (typeof handler === 'undefined')
		{
			var handler = makeEventHandler(eventNode, value);
			domNode.addEventListener(key, handler);
			allHandlers[key] = handler;
		}
		else
		{
			handler.info = value;
		}
	}

	domNode.elm_handlers = allHandlers;
}

function makeEventHandler(eventNode, info)
{
	function eventHandler(event)
	{
		var info = eventHandler.info;

		var value = A2(_elm_lang$core$Native_Json.run, info.decoder, event);

		if (value.ctor === 'Ok')
		{
			var options = info.options;
			if (options.stopPropagation)
			{
				event.stopPropagation();
			}
			if (options.preventDefault)
			{
				event.preventDefault();
			}

			var message = value._0;

			var currentEventNode = eventNode;
			while (currentEventNode)
			{
				var tagger = currentEventNode.tagger;
				if (typeof tagger === 'function')
				{
					message = tagger(message);
				}
				else
				{
					for (var i = tagger.length; i--; )
					{
						message = tagger[i](message);
					}
				}
				currentEventNode = currentEventNode.parent;
			}
		}
	};

	eventHandler.info = info;

	return eventHandler;
}

function applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		if (typeof value === 'undefined')
		{
			domNode.removeAttribute(key);
		}
		else
		{
			domNode.setAttribute(key, value);
		}
	}
}

function applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.namespace;
		var value = pair.value;

		if (typeof value === 'undefined')
		{
			domNode.removeAttributeNS(namespace, key);
		}
		else
		{
			domNode.setAttributeNS(namespace, key, value);
		}
	}
}



////////////  DIFF  ////////////


function diff(a, b)
{
	var patches = [];
	diffHelp(a, b, patches, 0);
	return patches;
}


function makePatch(type, index, data)
{
	return {
		index: index,
		type: type,
		data: data,
		domNode: undefined,
		eventNode: undefined
	};
}


function diffHelp(a, b, patches, index)
{
	if (a === b)
	{
		return;
	}

	var aType = a.type;
	var bType = b.type;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (aType !== bType)
	{
		patches.push(makePatch('p-redraw', index, b));
		return;
	}

	// Now we know that both nodes are the same type.
	switch (bType)
	{
		case 'thunk':
			var aArgs = a.args;
			var bArgs = b.args;
			var i = aArgs.length;
			var same = a.func === b.func && i === bArgs.length;
			while (same && i--)
			{
				same = aArgs[i] === bArgs[i];
			}
			if (same)
			{
				b.node = a.node;
				return;
			}
			b.node = b.thunk();
			var subPatches = [];
			diffHelp(a.node, b.node, subPatches, 0);
			if (subPatches.length > 0)
			{
				patches.push(makePatch('p-thunk', index, subPatches));
			}
			return;

		case 'tagger':
			// gather nested taggers
			var aTaggers = a.tagger;
			var bTaggers = b.tagger;
			var nesting = false;

			var aSubNode = a.node;
			while (aSubNode.type === 'tagger')
			{
				nesting = true;

				typeof aTaggers !== 'object'
					? aTaggers = [aTaggers, aSubNode.tagger]
					: aTaggers.push(aSubNode.tagger);

				aSubNode = aSubNode.node;
			}

			var bSubNode = b.node;
			while (bSubNode.type === 'tagger')
			{
				nesting = true;

				typeof bTaggers !== 'object'
					? bTaggers = [bTaggers, bSubNode.tagger]
					: bTaggers.push(bSubNode.tagger);

				bSubNode = bSubNode.node;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && aTaggers.length !== bTaggers.length)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !pairwiseRefEqual(aTaggers, bTaggers) : aTaggers !== bTaggers)
			{
				patches.push(makePatch('p-tagger', index, bTaggers));
			}

			// diff everything below the taggers
			diffHelp(aSubNode, bSubNode, patches, index + 1);
			return;

		case 'text':
			if (a.text !== b.text)
			{
				patches.push(makePatch('p-text', index, b.text));
				return;
			}

			return;

		case 'node':
			// Bail if obvious indicators have changed. Implies more serious
			// structural changes such that it's not worth it to diff.
			if (a.tag !== b.tag || a.namespace !== b.namespace)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			var factsDiff = diffFacts(a.facts, b.facts);

			if (typeof factsDiff !== 'undefined')
			{
				patches.push(makePatch('p-facts', index, factsDiff));
			}

			diffChildren(a, b, patches, index);
			return;

		case 'keyed-node':
			// Bail if obvious indicators have changed. Implies more serious
			// structural changes such that it's not worth it to diff.
			if (a.tag !== b.tag || a.namespace !== b.namespace)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			var factsDiff = diffFacts(a.facts, b.facts);

			if (typeof factsDiff !== 'undefined')
			{
				patches.push(makePatch('p-facts', index, factsDiff));
			}

			diffKeyedChildren(a, b, patches, index);
			return;

		case 'custom':
			if (a.impl !== b.impl)
			{
				patches.push(makePatch('p-redraw', index, b));
				return;
			}

			var factsDiff = diffFacts(a.facts, b.facts);
			if (typeof factsDiff !== 'undefined')
			{
				patches.push(makePatch('p-facts', index, factsDiff));
			}

			var patch = b.impl.diff(a,b);
			if (patch)
			{
				patches.push(makePatch('p-custom', index, patch));
				return;
			}

			return;
	}
}


// assumes the incoming arrays are the same length
function pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function diffFacts(a, b, category)
{
	var diff;

	// look for changes and removals
	for (var aKey in a)
	{
		if (aKey === STYLE_KEY || aKey === EVENT_KEY || aKey === ATTR_KEY || aKey === ATTR_NS_KEY)
		{
			var subDiff = diffFacts(a[aKey], b[aKey] || {}, aKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[aKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(aKey in b))
		{
			diff = diff || {};
			diff[aKey] =
				(typeof category === 'undefined')
					? (typeof a[aKey] === 'string' ? '' : null)
					:
				(category === STYLE_KEY)
					? ''
					:
				(category === EVENT_KEY || category === ATTR_KEY)
					? undefined
					:
				{ namespace: a[aKey].namespace, value: undefined };

			continue;
		}

		var aValue = a[aKey];
		var bValue = b[aKey];

		// reference equal, so don't worry about it
		if (aValue === bValue && aKey !== 'value'
			|| category === EVENT_KEY && equalEvents(aValue, bValue))
		{
			continue;
		}

		diff = diff || {};
		diff[aKey] = bValue;
	}

	// add new stuff
	for (var bKey in b)
	{
		if (!(bKey in a))
		{
			diff = diff || {};
			diff[bKey] = b[bKey];
		}
	}

	return diff;
}


function diffChildren(aParent, bParent, patches, rootIndex)
{
	var aChildren = aParent.children;
	var bChildren = bParent.children;

	var aLen = aChildren.length;
	var bLen = bChildren.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (aLen > bLen)
	{
		patches.push(makePatch('p-remove-last', rootIndex, aLen - bLen));
	}
	else if (aLen < bLen)
	{
		patches.push(makePatch('p-append', rootIndex, bChildren.slice(aLen)));
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	var index = rootIndex;
	var minLen = aLen < bLen ? aLen : bLen;
	for (var i = 0; i < minLen; i++)
	{
		index++;
		var aChild = aChildren[i];
		diffHelp(aChild, bChildren[i], patches, index);
		index += aChild.descendantsCount || 0;
	}
}



////////////  KEYED DIFF  ////////////


function diffKeyedChildren(aParent, bParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var aChildren = aParent.children;
	var bChildren = bParent.children;
	var aLen = aChildren.length;
	var bLen = bChildren.length;
	var aIndex = 0;
	var bIndex = 0;

	var index = rootIndex;

	while (aIndex < aLen && bIndex < bLen)
	{
		var a = aChildren[aIndex];
		var b = bChildren[bIndex];

		var aKey = a._0;
		var bKey = b._0;
		var aNode = a._1;
		var bNode = b._1;

		// check if keys match

		if (aKey === bKey)
		{
			index++;
			diffHelp(aNode, bNode, localPatches, index);
			index += aNode.descendantsCount || 0;

			aIndex++;
			bIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var aLookAhead = aIndex + 1 < aLen;
		var bLookAhead = bIndex + 1 < bLen;

		if (aLookAhead)
		{
			var aNext = aChildren[aIndex + 1];
			var aNextKey = aNext._0;
			var aNextNode = aNext._1;
			var oldMatch = bKey === aNextKey;
		}

		if (bLookAhead)
		{
			var bNext = bChildren[bIndex + 1];
			var bNextKey = bNext._0;
			var bNextNode = bNext._1;
			var newMatch = aKey === bNextKey;
		}


		// swap a and b
		if (aLookAhead && bLookAhead && newMatch && oldMatch)
		{
			index++;
			diffHelp(aNode, bNextNode, localPatches, index);
			insertNode(changes, localPatches, aKey, bNode, bIndex, inserts);
			index += aNode.descendantsCount || 0;

			index++;
			removeNode(changes, localPatches, aKey, aNextNode, index);
			index += aNextNode.descendantsCount || 0;

			aIndex += 2;
			bIndex += 2;
			continue;
		}

		// insert b
		if (bLookAhead && newMatch)
		{
			index++;
			insertNode(changes, localPatches, bKey, bNode, bIndex, inserts);
			diffHelp(aNode, bNextNode, localPatches, index);
			index += aNode.descendantsCount || 0;

			aIndex += 1;
			bIndex += 2;
			continue;
		}

		// remove a
		if (aLookAhead && oldMatch)
		{
			index++;
			removeNode(changes, localPatches, aKey, aNode, index);
			index += aNode.descendantsCount || 0;

			index++;
			diffHelp(aNextNode, bNode, localPatches, index);
			index += aNextNode.descendantsCount || 0;

			aIndex += 2;
			bIndex += 1;
			continue;
		}

		// remove a, insert b
		if (aLookAhead && bLookAhead && aNextKey === bNextKey)
		{
			index++;
			removeNode(changes, localPatches, aKey, aNode, index);
			insertNode(changes, localPatches, bKey, bNode, bIndex, inserts);
			index += aNode.descendantsCount || 0;

			index++;
			diffHelp(aNextNode, bNextNode, localPatches, index);
			index += aNextNode.descendantsCount || 0;

			aIndex += 2;
			bIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (aIndex < aLen)
	{
		index++;
		var a = aChildren[aIndex];
		var aNode = a._1;
		removeNode(changes, localPatches, a._0, aNode, index);
		index += aNode.descendantsCount || 0;
		aIndex++;
	}

	var endInserts;
	while (bIndex < bLen)
	{
		endInserts = endInserts || [];
		var b = bChildren[bIndex];
		insertNode(changes, localPatches, b._0, b._1, undefined, endInserts);
		bIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || typeof endInserts !== 'undefined')
	{
		patches.push(makePatch('p-reorder', rootIndex, {
			patches: localPatches,
			inserts: inserts,
			endInserts: endInserts
		}));
	}
}



////////////  CHANGES FROM KEYED DIFF  ////////////


var POSTFIX = '_elmW6BL';


function insertNode(changes, localPatches, key, vnode, bIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (typeof entry === 'undefined')
	{
		entry = {
			tag: 'insert',
			vnode: vnode,
			index: bIndex,
			data: undefined
		};

		inserts.push({ index: bIndex, entry: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.tag === 'remove')
	{
		inserts.push({ index: bIndex, entry: entry });

		entry.tag = 'move';
		var subPatches = [];
		diffHelp(entry.vnode, vnode, subPatches, entry.index);
		entry.index = bIndex;
		entry.data.data = {
			patches: subPatches,
			entry: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	insertNode(changes, localPatches, key + POSTFIX, vnode, bIndex, inserts);
}


function removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (typeof entry === 'undefined')
	{
		var patch = makePatch('p-remove', index, undefined);
		localPatches.push(patch);

		changes[key] = {
			tag: 'remove',
			vnode: vnode,
			index: index,
			data: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.tag === 'insert')
	{
		entry.tag = 'move';
		var subPatches = [];
		diffHelp(vnode, entry.vnode, subPatches, index);

		var patch = makePatch('p-remove', index, {
			patches: subPatches,
			entry: entry
		});
		localPatches.push(patch);

		return;
	}

	// this key has already been removed or moved, a duplicate!
	removeNode(changes, localPatches, key + POSTFIX, vnode, index);
}



////////////  ADD DOM NODES  ////////////
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function addDomNodes(domNode, vNode, patches, eventNode)
{
	addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.descendantsCount, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.index;

	while (index === low)
	{
		var patchType = patch.type;

		if (patchType === 'p-thunk')
		{
			addDomNodes(domNode, vNode.node, patch.data, eventNode);
		}
		else if (patchType === 'p-reorder')
		{
			patch.domNode = domNode;
			patch.eventNode = eventNode;

			var subPatches = patch.data.patches;
			if (subPatches.length > 0)
			{
				addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 'p-remove')
		{
			patch.domNode = domNode;
			patch.eventNode = eventNode;

			var data = patch.data;
			if (typeof data !== 'undefined')
			{
				data.entry.data = domNode;
				var subPatches = data.patches;
				if (subPatches.length > 0)
				{
					addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.domNode = domNode;
			patch.eventNode = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.index) > high)
		{
			return i;
		}
	}

	switch (vNode.type)
	{
		case 'tagger':
			var subNode = vNode.node;

			while (subNode.type === "tagger")
			{
				subNode = subNode.node;
			}

			return addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);

		case 'node':
			var vChildren = vNode.children;
			var childNodes = domNode.childNodes;
			for (var j = 0; j < vChildren.length; j++)
			{
				low++;
				var vChild = vChildren[j];
				var nextLow = low + (vChild.descendantsCount || 0);
				if (low <= index && index <= nextLow)
				{
					i = addDomNodesHelp(childNodes[j], vChild, patches, i, low, nextLow, eventNode);
					if (!(patch = patches[i]) || (index = patch.index) > high)
					{
						return i;
					}
				}
				low = nextLow;
			}
			return i;

		case 'keyed-node':
			var vChildren = vNode.children;
			var childNodes = domNode.childNodes;
			for (var j = 0; j < vChildren.length; j++)
			{
				low++;
				var vChild = vChildren[j]._1;
				var nextLow = low + (vChild.descendantsCount || 0);
				if (low <= index && index <= nextLow)
				{
					i = addDomNodesHelp(childNodes[j], vChild, patches, i, low, nextLow, eventNode);
					if (!(patch = patches[i]) || (index = patch.index) > high)
					{
						return i;
					}
				}
				low = nextLow;
			}
			return i;

		case 'text':
		case 'thunk':
			throw new Error('should never traverse `text` or `thunk` nodes like this');
	}
}



////////////  APPLY PATCHES  ////////////


function applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return applyPatchesHelp(rootDomNode, patches);
}

function applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.domNode
		var newNode = applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function applyPatch(domNode, patch)
{
	switch (patch.type)
	{
		case 'p-redraw':
			return applyPatchRedraw(domNode, patch.data, patch.eventNode);

		case 'p-facts':
			applyFacts(domNode, patch.eventNode, patch.data);
			return domNode;

		case 'p-text':
			domNode.replaceData(0, domNode.length, patch.data);
			return domNode;

		case 'p-thunk':
			return applyPatchesHelp(domNode, patch.data);

		case 'p-tagger':
			if (typeof domNode.elm_event_node_ref !== 'undefined')
			{
				domNode.elm_event_node_ref.tagger = patch.data;
			}
			else
			{
				domNode.elm_event_node_ref = { tagger: patch.data, parent: patch.eventNode };
			}
			return domNode;

		case 'p-remove-last':
			var i = patch.data;
			while (i--)
			{
				domNode.removeChild(domNode.lastChild);
			}
			return domNode;

		case 'p-append':
			var newNodes = patch.data;
			for (var i = 0; i < newNodes.length; i++)
			{
				domNode.appendChild(render(newNodes[i], patch.eventNode));
			}
			return domNode;

		case 'p-remove':
			var data = patch.data;
			if (typeof data === 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.entry;
			if (typeof entry.index !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.data = applyPatchesHelp(domNode, data.patches);
			return domNode;

		case 'p-reorder':
			return applyPatchReorder(domNode, patch);

		case 'p-custom':
			var impl = patch.data;
			return impl.applyPatch(domNode, impl.data);

		default:
			throw new Error('Ran into an unknown patch!');
	}
}


function applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = render(vNode, eventNode);

	if (typeof newNode.elm_event_node_ref === 'undefined')
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function applyPatchReorder(domNode, patch)
{
	var data = patch.data;

	// remove end inserts
	var frag = applyPatchReorderEndInsertsHelp(data.endInserts, patch);

	// removals
	domNode = applyPatchesHelp(domNode, data.patches);

	// inserts
	var inserts = data.inserts;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.entry;
		var node = entry.tag === 'move'
			? entry.data
			: render(entry.vnode, patch.eventNode);
		domNode.insertBefore(node, domNode.childNodes[insert.index]);
	}

	// add end inserts
	if (typeof frag !== 'undefined')
	{
		domNode.appendChild(frag);
	}

	return domNode;
}


function applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (typeof endInserts === 'undefined')
	{
		return;
	}

	var frag = localDoc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.entry;
		frag.appendChild(entry.tag === 'move'
			? entry.data
			: render(entry.vnode, patch.eventNode)
		);
	}
	return frag;
}


// PROGRAMS

var program = makeProgram(checkNoFlags);
var programWithFlags = makeProgram(checkYesFlags);

function makeProgram(flagChecker)
{
	return F2(function(debugWrap, impl)
	{
		return function(flagDecoder)
		{
			return function(object, moduleName, debugMetadata)
			{
				var checker = flagChecker(flagDecoder, moduleName);
				if (typeof debugMetadata === 'undefined')
				{
					normalSetup(impl, object, moduleName, checker);
				}
				else
				{
					debugSetup(A2(debugWrap, debugMetadata, impl), object, moduleName, checker);
				}
			};
		};
	});
}

function staticProgram(vNode)
{
	var nothing = _elm_lang$core$Native_Utils.Tuple2(
		_elm_lang$core$Native_Utils.Tuple0,
		_elm_lang$core$Platform_Cmd$none
	);
	return A2(program, _elm_lang$virtual_dom$VirtualDom_Debug$wrap, {
		init: nothing,
		view: function() { return vNode; },
		update: F2(function() { return nothing; }),
		subscriptions: function() { return _elm_lang$core$Platform_Sub$none; }
	})();
}


// FLAG CHECKERS

function checkNoFlags(flagDecoder, moduleName)
{
	return function(init, flags, domNode)
	{
		if (typeof flags === 'undefined')
		{
			return init;
		}

		var errorMessage =
			'The `' + moduleName + '` module does not need flags.\n'
			+ 'Initialize it with no arguments and you should be all set!';

		crash(errorMessage, domNode);
	};
}

function checkYesFlags(flagDecoder, moduleName)
{
	return function(init, flags, domNode)
	{
		if (typeof flagDecoder === 'undefined')
		{
			var errorMessage =
				'Are you trying to sneak a Never value into Elm? Trickster!\n'
				+ 'It looks like ' + moduleName + '.main is defined with `programWithFlags` but has type `Program Never`.\n'
				+ 'Use `program` instead if you do not want flags.'

			crash(errorMessage, domNode);
		}

		var result = A2(_elm_lang$core$Native_Json.run, flagDecoder, flags);
		if (result.ctor === 'Ok')
		{
			return init(result._0);
		}

		var errorMessage =
			'Trying to initialize the `' + moduleName + '` module with an unexpected flag.\n'
			+ 'I tried to convert it to an Elm value, but ran into this problem:\n\n'
			+ result._0;

		crash(errorMessage, domNode);
	};
}

function crash(errorMessage, domNode)
{
	if (domNode)
	{
		domNode.innerHTML =
			'<div style="padding-left:1em;">'
			+ '<h2 style="font-weight:normal;"><b>Oops!</b> Something went wrong when starting your Elm program.</h2>'
			+ '<pre style="padding-left:1em;">' + errorMessage + '</pre>'
			+ '</div>';
	}

	throw new Error(errorMessage);
}


//  NORMAL SETUP

function normalSetup(impl, object, moduleName, flagChecker)
{
	object['embed'] = function embed(node, flags)
	{
		while (node.lastChild)
		{
			node.removeChild(node.lastChild);
		}

		return _elm_lang$core$Native_Platform.initialize(
			flagChecker(impl.init, flags, node),
			impl.update,
			impl.subscriptions,
			normalRenderer(node, impl.view)
		);
	};

	object['fullscreen'] = function fullscreen(flags)
	{
		return _elm_lang$core$Native_Platform.initialize(
			flagChecker(impl.init, flags, document.body),
			impl.update,
			impl.subscriptions,
			normalRenderer(document.body, impl.view)
		);
	};
}

function normalRenderer(parentNode, view)
{
	return function(tagger, initialModel)
	{
		var eventNode = { tagger: tagger, parent: undefined };
		var initialVirtualNode = view(initialModel);
		var domNode = render(initialVirtualNode, eventNode);
		parentNode.appendChild(domNode);
		return makeStepper(domNode, view, initialVirtualNode, eventNode);
	};
}


// STEPPER

var rAF =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { setTimeout(callback, 1000 / 60); };

function makeStepper(domNode, view, initialVirtualNode, eventNode)
{
	var state = 'NO_REQUEST';
	var currNode = initialVirtualNode;
	var nextModel;

	function updateIfNeeded()
	{
		switch (state)
		{
			case 'NO_REQUEST':
				throw new Error(
					'Unexpected draw callback.\n' +
					'Please report this to <https://github.com/elm-lang/virtual-dom/issues>.'
				);

			case 'PENDING_REQUEST':
				rAF(updateIfNeeded);
				state = 'EXTRA_REQUEST';

				var nextNode = view(nextModel);
				var patches = diff(currNode, nextNode);
				domNode = applyPatches(domNode, currNode, patches, eventNode);
				currNode = nextNode;

				return;

			case 'EXTRA_REQUEST':
				state = 'NO_REQUEST';
				return;
		}
	}

	return function stepper(model)
	{
		if (state === 'NO_REQUEST')
		{
			rAF(updateIfNeeded);
		}
		state = 'PENDING_REQUEST';
		nextModel = model;
	};
}


// DEBUG SETUP

function debugSetup(impl, object, moduleName, flagChecker)
{
	object['fullscreen'] = function fullscreen(flags)
	{
		var popoutRef = { doc: undefined };
		return _elm_lang$core$Native_Platform.initialize(
			flagChecker(impl.init, flags, document.body),
			impl.update(scrollTask(popoutRef)),
			impl.subscriptions,
			debugRenderer(moduleName, document.body, popoutRef, impl.view, impl.viewIn, impl.viewOut)
		);
	};

	object['embed'] = function fullscreen(node, flags)
	{
		var popoutRef = { doc: undefined };
		return _elm_lang$core$Native_Platform.initialize(
			flagChecker(impl.init, flags, node),
			impl.update(scrollTask(popoutRef)),
			impl.subscriptions,
			debugRenderer(moduleName, node, popoutRef, impl.view, impl.viewIn, impl.viewOut)
		);
	};
}

function scrollTask(popoutRef)
{
	return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
	{
		var doc = popoutRef.doc;
		if (doc)
		{
			var msgs = doc.getElementsByClassName('debugger-sidebar-messages')[0];
			if (msgs)
			{
				msgs.scrollTop = msgs.scrollHeight;
			}
		}
		callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
	});
}


function debugRenderer(moduleName, parentNode, popoutRef, view, viewIn, viewOut)
{
	return function(tagger, initialModel)
	{
		var appEventNode = { tagger: tagger, parent: undefined };
		var eventNode = { tagger: tagger, parent: undefined };

		// make normal stepper
		var appVirtualNode = view(initialModel);
		var appNode = render(appVirtualNode, appEventNode);
		parentNode.appendChild(appNode);
		var appStepper = makeStepper(appNode, view, appVirtualNode, appEventNode);

		// make overlay stepper
		var overVirtualNode = viewIn(initialModel)._1;
		var overNode = render(overVirtualNode, eventNode);
		parentNode.appendChild(overNode);
		var wrappedViewIn = wrapViewIn(appEventNode, overNode, viewIn);
		var overStepper = makeStepper(overNode, wrappedViewIn, overVirtualNode, eventNode);

		// make debugger stepper
		var debugStepper = makeDebugStepper(initialModel, viewOut, eventNode, parentNode, moduleName, popoutRef);

		return function stepper(model)
		{
			appStepper(model);
			overStepper(model);
			debugStepper(model);
		}
	};
}

function makeDebugStepper(initialModel, view, eventNode, parentNode, moduleName, popoutRef)
{
	var curr;
	var domNode;

	return function stepper(model)
	{
		if (!model.isDebuggerOpen)
		{
			return;
		}

		if (!popoutRef.doc)
		{
			curr = view(model);
			domNode = openDebugWindow(moduleName, popoutRef, curr, eventNode);
			return;
		}

		// switch to document of popout
		localDoc = popoutRef.doc;

		var next = view(model);
		var patches = diff(curr, next);
		domNode = applyPatches(domNode, curr, patches, eventNode);
		curr = next;

		// switch back to normal document
		localDoc = document;
	};
}

function openDebugWindow(moduleName, popoutRef, virtualNode, eventNode)
{
	var w = 900;
	var h = 360;
	var x = screen.width - w;
	var y = screen.height - h;
	var debugWindow = window.open('', '', 'width=' + w + ',height=' + h + ',left=' + x + ',top=' + y);

	// switch to window document
	localDoc = debugWindow.document;

	popoutRef.doc = localDoc;
	localDoc.title = 'Debugger - ' + moduleName;
	localDoc.body.style.margin = '0';
	localDoc.body.style.padding = '0';
	var domNode = render(virtualNode, eventNode);
	localDoc.body.appendChild(domNode);

	localDoc.addEventListener('keydown', function(event) {
		if (event.metaKey && event.which === 82)
		{
			window.location.reload();
		}
		if (event.which === 38)
		{
			eventNode.tagger({ ctor: 'Up' });
			event.preventDefault();
		}
		if (event.which === 40)
		{
			eventNode.tagger({ ctor: 'Down' });
			event.preventDefault();
		}
	});

	function close()
	{
		popoutRef.doc = undefined;
		debugWindow.close();
	}
	window.addEventListener('unload', close);
	debugWindow.addEventListener('unload', function() {
		popoutRef.doc = undefined;
		window.removeEventListener('unload', close);
		eventNode.tagger({ ctor: 'Close' });
	});

	// switch back to the normal document
	localDoc = document;

	return domNode;
}


// BLOCK EVENTS

function wrapViewIn(appEventNode, overlayNode, viewIn)
{
	var ignorer = makeIgnorer(overlayNode);
	var blocking = 'Normal';
	var overflow;

	var normalTagger = appEventNode.tagger;
	var blockTagger = function() {};

	return function(model)
	{
		var tuple = viewIn(model);
		var newBlocking = tuple._0.ctor;
		appEventNode.tagger = newBlocking === 'Normal' ? normalTagger : blockTagger;
		if (blocking !== newBlocking)
		{
			traverse('removeEventListener', ignorer, blocking);
			traverse('addEventListener', ignorer, newBlocking);

			if (blocking === 'Normal')
			{
				overflow = document.body.style.overflow;
				document.body.style.overflow = 'hidden';
			}

			if (newBlocking === 'Normal')
			{
				document.body.style.overflow = overflow;
			}

			blocking = newBlocking;
		}
		return tuple._1;
	}
}

function traverse(verbEventListener, ignorer, blocking)
{
	switch(blocking)
	{
		case 'Normal':
			return;

		case 'Pause':
			return traverseHelp(verbEventListener, ignorer, mostEvents);

		case 'Message':
			return traverseHelp(verbEventListener, ignorer, allEvents);
	}
}

function traverseHelp(verbEventListener, handler, eventNames)
{
	for (var i = 0; i < eventNames.length; i++)
	{
		document.body[verbEventListener](eventNames[i], handler, true);
	}
}

function makeIgnorer(overlayNode)
{
	return function(event)
	{
		if (event.type === 'keydown' && event.metaKey && event.which === 82)
		{
			return;
		}

		var isScroll = event.type === 'scroll' || event.type === 'wheel';

		var node = event.target;
		while (node !== null)
		{
			if (node.className === 'elm-overlay-message-details' && isScroll)
			{
				return;
			}

			if (node === overlayNode && !isScroll)
			{
				return;
			}
			node = node.parentNode;
		}

		event.stopPropagation();
		event.preventDefault();
	}
}

var mostEvents = [
	'click', 'dblclick', 'mousemove',
	'mouseup', 'mousedown', 'mouseenter', 'mouseleave',
	'touchstart', 'touchend', 'touchcancel', 'touchmove',
	'pointerdown', 'pointerup', 'pointerover', 'pointerout',
	'pointerenter', 'pointerleave', 'pointermove', 'pointercancel',
	'dragstart', 'drag', 'dragend', 'dragenter', 'dragover', 'dragleave', 'drop',
	'keyup', 'keydown', 'keypress',
	'input', 'change',
	'focus', 'blur'
];

var allEvents = mostEvents.concat('wheel', 'scroll');


return {
	node: node,
	text: text,
	custom: custom,
	map: F2(map),

	on: F3(on),
	style: style,
	property: F2(property),
	attribute: F2(attribute),
	attributeNS: F3(attributeNS),
	mapProperty: F2(mapProperty),

	lazy: F2(lazy),
	lazy2: F3(lazy2),
	lazy3: F4(lazy3),
	keyedNode: F3(keyedNode),

	program: program,
	programWithFlags: programWithFlags,
	staticProgram: staticProgram
};

}();

var _elm_lang$virtual_dom$VirtualDom$programWithFlags = function (impl) {
	return A2(_elm_lang$virtual_dom$Native_VirtualDom.programWithFlags, _elm_lang$virtual_dom$VirtualDom_Debug$wrapWithFlags, impl);
};
var _elm_lang$virtual_dom$VirtualDom$program = function (impl) {
	return A2(_elm_lang$virtual_dom$Native_VirtualDom.program, _elm_lang$virtual_dom$VirtualDom_Debug$wrap, impl);
};
var _elm_lang$virtual_dom$VirtualDom$keyedNode = _elm_lang$virtual_dom$Native_VirtualDom.keyedNode;
var _elm_lang$virtual_dom$VirtualDom$lazy3 = _elm_lang$virtual_dom$Native_VirtualDom.lazy3;
var _elm_lang$virtual_dom$VirtualDom$lazy2 = _elm_lang$virtual_dom$Native_VirtualDom.lazy2;
var _elm_lang$virtual_dom$VirtualDom$lazy = _elm_lang$virtual_dom$Native_VirtualDom.lazy;
var _elm_lang$virtual_dom$VirtualDom$defaultOptions = {stopPropagation: false, preventDefault: false};
var _elm_lang$virtual_dom$VirtualDom$onWithOptions = _elm_lang$virtual_dom$Native_VirtualDom.on;
var _elm_lang$virtual_dom$VirtualDom$on = F2(
	function (eventName, decoder) {
		return A3(_elm_lang$virtual_dom$VirtualDom$onWithOptions, eventName, _elm_lang$virtual_dom$VirtualDom$defaultOptions, decoder);
	});
var _elm_lang$virtual_dom$VirtualDom$style = _elm_lang$virtual_dom$Native_VirtualDom.style;
var _elm_lang$virtual_dom$VirtualDom$mapProperty = _elm_lang$virtual_dom$Native_VirtualDom.mapProperty;
var _elm_lang$virtual_dom$VirtualDom$attributeNS = _elm_lang$virtual_dom$Native_VirtualDom.attributeNS;
var _elm_lang$virtual_dom$VirtualDom$attribute = _elm_lang$virtual_dom$Native_VirtualDom.attribute;
var _elm_lang$virtual_dom$VirtualDom$property = _elm_lang$virtual_dom$Native_VirtualDom.property;
var _elm_lang$virtual_dom$VirtualDom$map = _elm_lang$virtual_dom$Native_VirtualDom.map;
var _elm_lang$virtual_dom$VirtualDom$text = _elm_lang$virtual_dom$Native_VirtualDom.text;
var _elm_lang$virtual_dom$VirtualDom$node = _elm_lang$virtual_dom$Native_VirtualDom.node;
var _elm_lang$virtual_dom$VirtualDom$Options = F2(
	function (a, b) {
		return {stopPropagation: a, preventDefault: b};
	});
var _elm_lang$virtual_dom$VirtualDom$Node = {ctor: 'Node'};
var _elm_lang$virtual_dom$VirtualDom$Property = {ctor: 'Property'};

var _elm_lang$html$Html$programWithFlags = _elm_lang$virtual_dom$VirtualDom$programWithFlags;
var _elm_lang$html$Html$program = _elm_lang$virtual_dom$VirtualDom$program;
var _elm_lang$html$Html$beginnerProgram = function (_p0) {
	var _p1 = _p0;
	return _elm_lang$html$Html$program(
		{
			init: A2(
				_elm_lang$core$Platform_Cmd_ops['!'],
				_p1.model,
				{ctor: '[]'}),
			update: F2(
				function (msg, model) {
					return A2(
						_elm_lang$core$Platform_Cmd_ops['!'],
						A2(_p1.update, msg, model),
						{ctor: '[]'});
				}),
			view: _p1.view,
			subscriptions: function (_p2) {
				return _elm_lang$core$Platform_Sub$none;
			}
		});
};
var _elm_lang$html$Html$map = _elm_lang$virtual_dom$VirtualDom$map;
var _elm_lang$html$Html$text = _elm_lang$virtual_dom$VirtualDom$text;
var _elm_lang$html$Html$node = _elm_lang$virtual_dom$VirtualDom$node;
var _elm_lang$html$Html$body = _elm_lang$html$Html$node('body');
var _elm_lang$html$Html$section = _elm_lang$html$Html$node('section');
var _elm_lang$html$Html$nav = _elm_lang$html$Html$node('nav');
var _elm_lang$html$Html$article = _elm_lang$html$Html$node('article');
var _elm_lang$html$Html$aside = _elm_lang$html$Html$node('aside');
var _elm_lang$html$Html$h1 = _elm_lang$html$Html$node('h1');
var _elm_lang$html$Html$h2 = _elm_lang$html$Html$node('h2');
var _elm_lang$html$Html$h3 = _elm_lang$html$Html$node('h3');
var _elm_lang$html$Html$h4 = _elm_lang$html$Html$node('h4');
var _elm_lang$html$Html$h5 = _elm_lang$html$Html$node('h5');
var _elm_lang$html$Html$h6 = _elm_lang$html$Html$node('h6');
var _elm_lang$html$Html$header = _elm_lang$html$Html$node('header');
var _elm_lang$html$Html$footer = _elm_lang$html$Html$node('footer');
var _elm_lang$html$Html$address = _elm_lang$html$Html$node('address');
var _elm_lang$html$Html$main_ = _elm_lang$html$Html$node('main');
var _elm_lang$html$Html$p = _elm_lang$html$Html$node('p');
var _elm_lang$html$Html$hr = _elm_lang$html$Html$node('hr');
var _elm_lang$html$Html$pre = _elm_lang$html$Html$node('pre');
var _elm_lang$html$Html$blockquote = _elm_lang$html$Html$node('blockquote');
var _elm_lang$html$Html$ol = _elm_lang$html$Html$node('ol');
var _elm_lang$html$Html$ul = _elm_lang$html$Html$node('ul');
var _elm_lang$html$Html$li = _elm_lang$html$Html$node('li');
var _elm_lang$html$Html$dl = _elm_lang$html$Html$node('dl');
var _elm_lang$html$Html$dt = _elm_lang$html$Html$node('dt');
var _elm_lang$html$Html$dd = _elm_lang$html$Html$node('dd');
var _elm_lang$html$Html$figure = _elm_lang$html$Html$node('figure');
var _elm_lang$html$Html$figcaption = _elm_lang$html$Html$node('figcaption');
var _elm_lang$html$Html$div = _elm_lang$html$Html$node('div');
var _elm_lang$html$Html$a = _elm_lang$html$Html$node('a');
var _elm_lang$html$Html$em = _elm_lang$html$Html$node('em');
var _elm_lang$html$Html$strong = _elm_lang$html$Html$node('strong');
var _elm_lang$html$Html$small = _elm_lang$html$Html$node('small');
var _elm_lang$html$Html$s = _elm_lang$html$Html$node('s');
var _elm_lang$html$Html$cite = _elm_lang$html$Html$node('cite');
var _elm_lang$html$Html$q = _elm_lang$html$Html$node('q');
var _elm_lang$html$Html$dfn = _elm_lang$html$Html$node('dfn');
var _elm_lang$html$Html$abbr = _elm_lang$html$Html$node('abbr');
var _elm_lang$html$Html$time = _elm_lang$html$Html$node('time');
var _elm_lang$html$Html$code = _elm_lang$html$Html$node('code');
var _elm_lang$html$Html$var = _elm_lang$html$Html$node('var');
var _elm_lang$html$Html$samp = _elm_lang$html$Html$node('samp');
var _elm_lang$html$Html$kbd = _elm_lang$html$Html$node('kbd');
var _elm_lang$html$Html$sub = _elm_lang$html$Html$node('sub');
var _elm_lang$html$Html$sup = _elm_lang$html$Html$node('sup');
var _elm_lang$html$Html$i = _elm_lang$html$Html$node('i');
var _elm_lang$html$Html$b = _elm_lang$html$Html$node('b');
var _elm_lang$html$Html$u = _elm_lang$html$Html$node('u');
var _elm_lang$html$Html$mark = _elm_lang$html$Html$node('mark');
var _elm_lang$html$Html$ruby = _elm_lang$html$Html$node('ruby');
var _elm_lang$html$Html$rt = _elm_lang$html$Html$node('rt');
var _elm_lang$html$Html$rp = _elm_lang$html$Html$node('rp');
var _elm_lang$html$Html$bdi = _elm_lang$html$Html$node('bdi');
var _elm_lang$html$Html$bdo = _elm_lang$html$Html$node('bdo');
var _elm_lang$html$Html$span = _elm_lang$html$Html$node('span');
var _elm_lang$html$Html$br = _elm_lang$html$Html$node('br');
var _elm_lang$html$Html$wbr = _elm_lang$html$Html$node('wbr');
var _elm_lang$html$Html$ins = _elm_lang$html$Html$node('ins');
var _elm_lang$html$Html$del = _elm_lang$html$Html$node('del');
var _elm_lang$html$Html$img = _elm_lang$html$Html$node('img');
var _elm_lang$html$Html$iframe = _elm_lang$html$Html$node('iframe');
var _elm_lang$html$Html$embed = _elm_lang$html$Html$node('embed');
var _elm_lang$html$Html$object = _elm_lang$html$Html$node('object');
var _elm_lang$html$Html$param = _elm_lang$html$Html$node('param');
var _elm_lang$html$Html$video = _elm_lang$html$Html$node('video');
var _elm_lang$html$Html$audio = _elm_lang$html$Html$node('audio');
var _elm_lang$html$Html$source = _elm_lang$html$Html$node('source');
var _elm_lang$html$Html$track = _elm_lang$html$Html$node('track');
var _elm_lang$html$Html$canvas = _elm_lang$html$Html$node('canvas');
var _elm_lang$html$Html$math = _elm_lang$html$Html$node('math');
var _elm_lang$html$Html$table = _elm_lang$html$Html$node('table');
var _elm_lang$html$Html$caption = _elm_lang$html$Html$node('caption');
var _elm_lang$html$Html$colgroup = _elm_lang$html$Html$node('colgroup');
var _elm_lang$html$Html$col = _elm_lang$html$Html$node('col');
var _elm_lang$html$Html$tbody = _elm_lang$html$Html$node('tbody');
var _elm_lang$html$Html$thead = _elm_lang$html$Html$node('thead');
var _elm_lang$html$Html$tfoot = _elm_lang$html$Html$node('tfoot');
var _elm_lang$html$Html$tr = _elm_lang$html$Html$node('tr');
var _elm_lang$html$Html$td = _elm_lang$html$Html$node('td');
var _elm_lang$html$Html$th = _elm_lang$html$Html$node('th');
var _elm_lang$html$Html$form = _elm_lang$html$Html$node('form');
var _elm_lang$html$Html$fieldset = _elm_lang$html$Html$node('fieldset');
var _elm_lang$html$Html$legend = _elm_lang$html$Html$node('legend');
var _elm_lang$html$Html$label = _elm_lang$html$Html$node('label');
var _elm_lang$html$Html$input = _elm_lang$html$Html$node('input');
var _elm_lang$html$Html$button = _elm_lang$html$Html$node('button');
var _elm_lang$html$Html$select = _elm_lang$html$Html$node('select');
var _elm_lang$html$Html$datalist = _elm_lang$html$Html$node('datalist');
var _elm_lang$html$Html$optgroup = _elm_lang$html$Html$node('optgroup');
var _elm_lang$html$Html$option = _elm_lang$html$Html$node('option');
var _elm_lang$html$Html$textarea = _elm_lang$html$Html$node('textarea');
var _elm_lang$html$Html$keygen = _elm_lang$html$Html$node('keygen');
var _elm_lang$html$Html$output = _elm_lang$html$Html$node('output');
var _elm_lang$html$Html$progress = _elm_lang$html$Html$node('progress');
var _elm_lang$html$Html$meter = _elm_lang$html$Html$node('meter');
var _elm_lang$html$Html$details = _elm_lang$html$Html$node('details');
var _elm_lang$html$Html$summary = _elm_lang$html$Html$node('summary');
var _elm_lang$html$Html$menuitem = _elm_lang$html$Html$node('menuitem');
var _elm_lang$html$Html$menu = _elm_lang$html$Html$node('menu');

var _evancz$elm_graphics$Native_Element = function()
{


// CREATION

var createNode =
	typeof document === 'undefined'
		?
			function(_)
			{
				return {
					style: {},
					appendChild: function() {}
				};
			}
		:
			function(elementType)
			{
				var node = document.createElement(elementType);
				node.style.padding = '0';
				node.style.margin = '0';
				return node;
			}
		;


function newElement(width, height, elementPrim)
{
	return {
		ctor: 'Element_elm_builtin',
		_0: {
			element: elementPrim,
			props: {
				width: width,
				height: height,
				opacity: 1,
				color: _elm_lang$core$Maybe$Nothing,
				href: '',
				tag: ''
			}
		}
	};
}


// PROPERTIES

function setProps(elem, node)
{
	var props = elem.props;

	var element = elem.element;
	var width = props.width - (element.adjustWidth || 0);
	var height = props.height - (element.adjustHeight || 0);
	node.style.width  = (width | 0) + 'px';
	node.style.height = (height | 0) + 'px';

	if (props.opacity !== 1)
	{
		node.style.opacity = props.opacity;
	}

	if (props.color.ctor === 'Just')
	{
		node.style.backgroundColor = _evancz$elm_graphics$Text$colorToCss(props.color._0);
	}

	if (props.tag !== '')
	{
		node.id = props.tag;
	}

	if (props.href !== '')
	{
		var anchor = createNode('a');
		anchor.href = props.href;
		anchor.style.display = 'block';
		anchor.style.pointerEvents = 'auto';
		anchor.appendChild(node);
		node = anchor;
	}

	return node;
}


// IMAGES

function image(props, img)
{
	switch (img._0.ctor)
	{
		case 'Plain':
			return plainImage(img._3);

		case 'Fitted':
			return fittedImage(props.width, props.height, img._3);

		case 'Cropped':
			return croppedImage(img, props.width, props.height, img._3);

		case 'Tiled':
			return tiledImage(img._3);
	}
}

function plainImage(src)
{
	var img = createNode('img');
	img.src = src;
	img.name = src;
	img.style.display = 'block';
	return img;
}

function tiledImage(src)
{
	var div = createNode('div');
	div.style.backgroundImage = 'url(' + src + ')';
	return div;
}

function fittedImage(w, h, src)
{
	var div = createNode('div');
	div.style.background = 'url(' + src + ') no-repeat center';
	div.style.webkitBackgroundSize = 'cover';
	div.style.MozBackgroundSize = 'cover';
	div.style.OBackgroundSize = 'cover';
	div.style.backgroundSize = 'cover';
	return div;
}

function croppedImage(elem, w, h, src)
{
	var pos = elem._0._0;
	var e = createNode('div');
	e.style.overflow = 'hidden';

	var img = createNode('img');
	img.onload = function() {
		var sw = w / elem._1, sh = h / elem._2;
		img.style.width = ((this.width * sw) | 0) + 'px';
		img.style.height = ((this.height * sh) | 0) + 'px';
		img.style.marginLeft = ((- pos._0 * sw) | 0) + 'px';
		img.style.marginTop = ((- pos._1 * sh) | 0) + 'px';
	};
	img.src = src;
	img.name = src;
	e.appendChild(img);
	return e;
}


// FLOW

function goOut(node)
{
	node.style.position = 'absolute';
	return node;
}
function goDown(node)
{
	return node;
}
function goRight(node)
{
	node.style.styleFloat = 'left';
	node.style.cssFloat = 'left';
	return node;
}

var directionTable = {
	DUp: goDown,
	DDown: goDown,
	DLeft: goRight,
	DRight: goRight,
	DIn: goOut,
	DOut: goOut
};
function needsReversal(dir)
{
	return dir === 'DUp' || dir === 'DLeft' || dir === 'DIn';
}

function flow(dir, elist)
{
	var array = _elm_lang$core$Native_List.toArray(elist);
	var container = createNode('div');
	var goDir = directionTable[dir];
	if (goDir === goOut)
	{
		container.style.pointerEvents = 'none';
	}
	if (needsReversal(dir))
	{
		array.reverse();
	}
	var len = array.length;
	for (var i = 0; i < len; ++i)
	{
		container.appendChild(goDir(render(array[i])));
	}
	return container;
}


// CONTAINER

function toPos(pos)
{
	return pos.ctor === 'Absolute'
		? pos._0 + 'px'
		: (pos._0 * 100) + '%';
}

// must clear right, left, top, bottom, and transform
// before calling this function
function setPos(pos, wrappedElement, e)
{
	var elem = wrappedElement._0;
	var element = elem.element;
	var props = elem.props;
	var w = props.width + (element.adjustWidth ? element.adjustWidth : 0);
	var h = props.height + (element.adjustHeight ? element.adjustHeight : 0);

	e.style.position = 'absolute';
	e.style.margin = 'auto';
	var transform = '';

	switch (pos.horizontal.ctor)
	{
		case 'P':
			e.style.right = toPos(pos.x);
			e.style.removeProperty('left');
			break;

		case 'Z':
			transform = 'translateX(' + ((-w / 2) | 0) + 'px) ';

		case 'N':
			e.style.left = toPos(pos.x);
			e.style.removeProperty('right');
			break;
	}
	switch (pos.vertical.ctor)
	{
		case 'N':
			e.style.bottom = toPos(pos.y);
			e.style.removeProperty('top');
			break;

		case 'Z':
			transform += 'translateY(' + ((-h / 2) | 0) + 'px)';

		case 'P':
			e.style.top = toPos(pos.y);
			e.style.removeProperty('bottom');
			break;
	}
	if (transform !== '')
	{
		addTransform(e.style, transform);
	}
	return e;
}

function addTransform(style, transform)
{
	style.transform       = transform;
	style.msTransform     = transform;
	style.MozTransform    = transform;
	style.webkitTransform = transform;
	style.OTransform      = transform;
}

function container(pos, elem)
{
	var e = render(elem);
	setPos(pos, elem, e);
	var div = createNode('div');
	div.style.position = 'relative';
	div.style.overflow = 'hidden';
	div.appendChild(e);
	return div;
}


function rawHtml(elem)
{
	var html = elem.html;
	var align = elem.align;

	var div = createNode('div');
	div.innerHTML = html;
	div.style.visibility = 'hidden';
	if (align)
	{
		div.style.textAlign = align;
	}
	div.style.visibility = 'visible';
	div.style.pointerEvents = 'auto';
	return div;
}


// TO HTML

function toHtml(element)
{
	return _elm_lang$virtual_dom$Native_VirtualDom.custom(
		_elm_lang$core$Native_List.Nil,
		element,
		implementation
	);
}


// WIDGET IMPLEMENTATION

var implementation = {
	render: render,
	diff: diff
};

function diff(a, b)
{
	var aModel = a.model;
	var bModel = b.model;

	if (aModel === bModel)
	{
		return null;
	}

	return {
		applyPatch: applyPatch,
		data: { a: aModel, b: bModel }
	};
}

function applyPatch(domNode, data)
{
	return updateAndReplace(domNode, data.a, data.b);
}


// RENDER

function render(wrappedElement)
{
	var elem = wrappedElement._0;
	return setProps(elem, makeElement(elem));
}

function makeElement(e)
{
	var elem = e.element;
	switch (elem.ctor)
	{
		case 'Image':
			return image(e.props, elem);

		case 'Flow':
			return flow(elem._0.ctor, elem._1);

		case 'Container':
			return container(elem._0, elem._1);

		case 'Spacer':
			return createNode('div');

		case 'RawHtml':
			return rawHtml(elem);

		case 'Custom':
			return elem.render(elem.model);
	}
}

function updateAndReplace(node, curr, next)
{
	var newNode = update(node, curr, next);
	if (newNode !== node)
	{
		node.parentNode.replaceChild(newNode, node);
	}
	return newNode;
}


// UPDATE

function update(node, wrappedCurrent, wrappedNext)
{
	var curr = wrappedCurrent._0;
	var next = wrappedNext._0;
	var rootNode = node;

	if (curr === next)
	{
		return rootNode;
	}

	if (node.tagName === 'A')
	{
		node = node.firstChild;
	}
	if (curr.element.ctor !== next.element.ctor)
	{
		return render(wrappedNext);
	}
	var nextE = next.element;
	var currE = curr.element;
	switch (nextE.ctor)
	{
		case 'Spacer':
			updateProps(node, curr, next);
			return rootNode;

		case 'RawHtml':
			if(currE.html.valueOf() !== nextE.html.valueOf())
			{
				node.innerHTML = nextE.html;
			}
			updateProps(node, curr, next);
			return rootNode;

		case 'Image':
			if (nextE._0.ctor === 'Plain')
			{
				if (nextE._3 !== currE._3)
				{
					node.src = nextE._3;
				}
			}
			else if (!_elm_lang$core$Native_Utils.eq(nextE, currE)
				|| next.props.width !== curr.props.width
				|| next.props.height !== curr.props.height)
			{
				return render(wrappedNext);
			}
			updateProps(node, curr, next);
			return rootNode;

		case 'Flow':
			var arr = _elm_lang$core$Native_List.toArray(nextE._1);
			for (var i = arr.length; i--; )
			{
				arr[i] = arr[i]._0.element.ctor;
			}
			if (nextE._0.ctor !== currE._0.ctor)
			{
				return render(wrappedNext);
			}
			var nexts = _elm_lang$core$Native_List.toArray(nextE._1);
			var kids = node.childNodes;
			if (nexts.length !== kids.length)
			{
				return render(wrappedNext);
			}
			var currs = _elm_lang$core$Native_List.toArray(currE._1);
			var dir = nextE._0.ctor;
			var goDir = directionTable[dir];
			var toReverse = needsReversal(dir);
			var len = kids.length;
			for (var i = len; i--; )
			{
				var subNode = kids[toReverse ? len - i - 1 : i];
				goDir(updateAndReplace(subNode, currs[i], nexts[i]));
			}
			updateProps(node, curr, next);
			return rootNode;

		case 'Container':
			var subNode = node.firstChild;
			var newSubNode = updateAndReplace(subNode, currE._1, nextE._1);
			setPos(nextE._0, nextE._1, newSubNode);
			updateProps(node, curr, next);
			return rootNode;

		case 'Custom':
			if (currE.type === nextE.type)
			{
				var updatedNode = nextE.update(node, currE.model, nextE.model);
				updateProps(updatedNode, curr, next);
				return updatedNode;
			}
			return render(wrappedNext);
	}
}

function updateProps(node, curr, next)
{
	var nextProps = next.props;
	var currProps = curr.props;

	var element = next.element;
	var width = nextProps.width - (element.adjustWidth || 0);
	var height = nextProps.height - (element.adjustHeight || 0);
	if (width !== currProps.width)
	{
		node.style.width = (width | 0) + 'px';
	}
	if (height !== currProps.height)
	{
		node.style.height = (height | 0) + 'px';
	}

	if (nextProps.opacity !== currProps.opacity)
	{
		node.style.opacity = nextProps.opacity;
	}

	var nextColor = nextProps.color.ctor === 'Just'
		? _evancz$elm_graphics$Text$colorToCss(nextProps.color._0)
		: '';
	if (node.style.backgroundColor !== nextColor)
	{
		node.style.backgroundColor = nextColor;
	}

	if (nextProps.tag !== currProps.tag)
	{
		node.id = nextProps.tag;
	}

	if (nextProps.href !== currProps.href)
	{
		if (currProps.href === '')
		{
			// add a surrounding href
			var anchor = createNode('a');
			anchor.href = nextProps.href;
			anchor.style.display = 'block';
			anchor.style.pointerEvents = 'auto';

			node.parentNode.replaceChild(anchor, node);
			anchor.appendChild(node);
		}
		else if (nextProps.href === '')
		{
			// remove the surrounding href
			var anchor = node.parentNode;
			anchor.parentNode.replaceChild(node, anchor);
		}
		else
		{
			// just update the link
			node.parentNode.href = nextProps.href;
		}
	}
}


// TEXT

function block(align)
{
	return function(text)
	{
		var raw = {
			ctor: 'RawHtml',
			html: _evancz$elm_graphics$Text$toHtmlString(text),
			align: align
		};
		var pos = htmlHeight(0, raw);
		return newElement(pos._0, pos._1, raw);
	};
}

var htmlHeight =
	typeof document !== 'undefined'
		? realHtmlHeight
		: function(a, b) { return _elm_lang$core$Native_Utils.Tuple2(0, 0); };

function realHtmlHeight(width, rawHtml)
{
	// create dummy node
	var temp = document.createElement('div');
	temp.innerHTML = rawHtml.html;
	if (width > 0)
	{
		temp.style.width = width + 'px';
	}
	temp.style.visibility = 'hidden';
	temp.style.styleFloat = 'left';
	temp.style.cssFloat = 'left';

	document.body.appendChild(temp);

	// get dimensions
	var style = window.getComputedStyle(temp, null);
	var w = Math.ceil(style.getPropertyValue('width').slice(0, -2) - 0);
	var h = Math.ceil(style.getPropertyValue('height').slice(0, -2) - 0);
	document.body.removeChild(temp);
	return _elm_lang$core$Native_Utils.Tuple2(w, h);
}


return {
	toHtml: toHtml,

	render: render,
	update: update,
	createNode: createNode,
	newElement: F3(newElement),
	addTransform: addTransform,

	block: block
};

}();


//import Maybe, Native.List //

var _elm_lang$core$Native_Regex = function() {

function escape(str)
{
	return str.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
}
function caseInsensitive(re)
{
	return new RegExp(re.source, 'gi');
}
function regex(raw)
{
	return new RegExp(raw, 'g');
}

function contains(re, string)
{
	return string.match(re) !== null;
}

function find(n, re, str)
{
	n = n.ctor === 'All' ? Infinity : n._0;
	var out = [];
	var number = 0;
	var string = str;
	var lastIndex = re.lastIndex;
	var prevLastIndex = -1;
	var result;
	while (number++ < n && (result = re.exec(string)))
	{
		if (prevLastIndex === re.lastIndex) break;
		var i = result.length - 1;
		var subs = new Array(i);
		while (i > 0)
		{
			var submatch = result[i];
			subs[--i] = submatch === undefined
				? _elm_lang$core$Maybe$Nothing
				: _elm_lang$core$Maybe$Just(submatch);
		}
		out.push({
			match: result[0],
			submatches: _elm_lang$core$Native_List.fromArray(subs),
			index: result.index,
			number: number
		});
		prevLastIndex = re.lastIndex;
	}
	re.lastIndex = lastIndex;
	return _elm_lang$core$Native_List.fromArray(out);
}

function replace(n, re, replacer, string)
{
	n = n.ctor === 'All' ? Infinity : n._0;
	var count = 0;
	function jsReplacer(match)
	{
		if (count++ >= n)
		{
			return match;
		}
		var i = arguments.length - 3;
		var submatches = new Array(i);
		while (i > 0)
		{
			var submatch = arguments[i];
			submatches[--i] = submatch === undefined
				? _elm_lang$core$Maybe$Nothing
				: _elm_lang$core$Maybe$Just(submatch);
		}
		return replacer({
			match: match,
			submatches: _elm_lang$core$Native_List.fromArray(submatches),
			index: arguments[arguments.length - 2],
			number: count
		});
	}
	return string.replace(re, jsReplacer);
}

function split(n, re, str)
{
	n = n.ctor === 'All' ? Infinity : n._0;
	if (n === Infinity)
	{
		return _elm_lang$core$Native_List.fromArray(str.split(re));
	}
	var string = str;
	var result;
	var out = [];
	var start = re.lastIndex;
	var restoreLastIndex = re.lastIndex;
	while (n--)
	{
		if (!(result = re.exec(string))) break;
		out.push(string.slice(start, result.index));
		start = re.lastIndex;
	}
	out.push(string.slice(start));
	re.lastIndex = restoreLastIndex;
	return _elm_lang$core$Native_List.fromArray(out);
}

return {
	regex: regex,
	caseInsensitive: caseInsensitive,
	escape: escape,

	contains: F2(contains),
	find: F3(find),
	replace: F4(replace),
	split: F3(split)
};

}();

var _elm_lang$core$Regex$split = _elm_lang$core$Native_Regex.split;
var _elm_lang$core$Regex$replace = _elm_lang$core$Native_Regex.replace;
var _elm_lang$core$Regex$find = _elm_lang$core$Native_Regex.find;
var _elm_lang$core$Regex$contains = _elm_lang$core$Native_Regex.contains;
var _elm_lang$core$Regex$caseInsensitive = _elm_lang$core$Native_Regex.caseInsensitive;
var _elm_lang$core$Regex$regex = _elm_lang$core$Native_Regex.regex;
var _elm_lang$core$Regex$escape = _elm_lang$core$Native_Regex.escape;
var _elm_lang$core$Regex$Match = F4(
	function (a, b, c, d) {
		return {match: a, submatches: b, index: c, number: d};
	});
var _elm_lang$core$Regex$Regex = {ctor: 'Regex'};
var _elm_lang$core$Regex$AtMost = function (a) {
	return {ctor: 'AtMost', _0: a};
};
var _elm_lang$core$Regex$All = {ctor: 'All'};

var _evancz$elm_graphics$Text$wrap = F3(
	function (maybeHref, styles, insides) {
		var linkedInsides = function () {
			var _p0 = maybeHref;
			if (_p0.ctor === 'Nothing') {
				return insides;
			} else {
				return A2(
					_elm_lang$core$Basics_ops['++'],
					'<a href=\"',
					A2(
						_elm_lang$core$Basics_ops['++'],
						_p0._0,
						A2(
							_elm_lang$core$Basics_ops['++'],
							'\">',
							A2(_elm_lang$core$Basics_ops['++'], insides, '</a>'))));
			}
		}();
		return _elm_lang$core$Native_Utils.eq(styles, '') ? linkedInsides : A2(
			_elm_lang$core$Basics_ops['++'],
			'<span style=\"',
			A2(
				_elm_lang$core$Basics_ops['++'],
				styles,
				A2(
					_elm_lang$core$Basics_ops['++'],
					'\">',
					A2(_elm_lang$core$Basics_ops['++'], linkedInsides, '</span>'))));
	});
var _evancz$elm_graphics$Text$replace = F3(
	function (from, to, str) {
		return A4(
			_elm_lang$core$Regex$replace,
			_elm_lang$core$Regex$All,
			_elm_lang$core$Regex$regex(from),
			function (_p1) {
				return to;
			},
			str);
	});
var _evancz$elm_graphics$Text$toHtmlString = function (text) {
	return A3(_evancz$elm_graphics$Text$toHtmlStringHelp, _elm_lang$core$Maybe$Nothing, '', text);
};
var _evancz$elm_graphics$Text$toHtmlStringHelp = F3(
	function (maybeHref, styles, text) {
		toHtmlStringHelp:
		while (true) {
			var _p2 = text;
			switch (_p2.ctor) {
				case 'Str':
					return A3(
						_evancz$elm_graphics$Text$wrap,
						maybeHref,
						styles,
						A2(
							_elm_lang$core$String$join,
							'<br>',
							A2(
								_elm_lang$core$List$map,
								A2(_evancz$elm_graphics$Text$replace, ' ', '&nbsp;'),
								_elm_lang$core$String$lines(
									A3(
										_evancz$elm_graphics$Text$replace,
										'>',
										'&#62;',
										A3(
											_evancz$elm_graphics$Text$replace,
											'<',
											'&#60;',
											A3(
												_evancz$elm_graphics$Text$replace,
												'\'',
												'&#39;',
												A3(_evancz$elm_graphics$Text$replace, '\"', '&#34;', _p2._0))))))));
				case 'Append':
					return A3(
						_evancz$elm_graphics$Text$wrap,
						maybeHref,
						styles,
						A2(
							_elm_lang$core$Basics_ops['++'],
							_evancz$elm_graphics$Text$toHtmlString(_p2._0),
							_evancz$elm_graphics$Text$toHtmlString(_p2._1)));
				case 'Link':
					var _v2 = _elm_lang$core$Maybe$Just(
						A2(_elm_lang$core$Maybe$withDefault, _p2._0, maybeHref)),
						_v3 = styles,
						_v4 = _p2._1;
					maybeHref = _v2;
					styles = _v3;
					text = _v4;
					continue toHtmlStringHelp;
				default:
					var _v5 = maybeHref,
						_v6 = A2(
						_elm_lang$core$Basics_ops['++'],
						styles,
						A2(
							_elm_lang$core$Basics_ops['++'],
							_p2._0,
							A2(
								_elm_lang$core$Basics_ops['++'],
								':',
								A2(_elm_lang$core$Basics_ops['++'], _p2._1, ';')))),
						_v7 = _p2._2;
					maybeHref = _v5;
					styles = _v6;
					text = _v7;
					continue toHtmlStringHelp;
			}
		}
	});
var _evancz$elm_graphics$Text$colorToCss = function (color) {
	var _p3 = _elm_lang$core$Color$toRgb(color);
	var red = _p3.red;
	var green = _p3.green;
	var blue = _p3.blue;
	var alpha = _p3.alpha;
	return A2(
		_elm_lang$core$Basics_ops['++'],
		'rgba(',
		A2(
			_elm_lang$core$Basics_ops['++'],
			_elm_lang$core$Basics$toString(red),
			A2(
				_elm_lang$core$Basics_ops['++'],
				', ',
				A2(
					_elm_lang$core$Basics_ops['++'],
					_elm_lang$core$Basics$toString(green),
					A2(
						_elm_lang$core$Basics_ops['++'],
						', ',
						A2(
							_elm_lang$core$Basics_ops['++'],
							_elm_lang$core$Basics$toString(blue),
							A2(
								_elm_lang$core$Basics_ops['++'],
								', ',
								A2(
									_elm_lang$core$Basics_ops['++'],
									_elm_lang$core$Basics$toString(alpha),
									')'))))))));
};
var _evancz$elm_graphics$Text$typefacesToString = function (faces) {
	return A2(
		_elm_lang$core$Basics_ops['++'],
		'\'',
		A2(
			_elm_lang$core$Basics_ops['++'],
			A2(_elm_lang$core$String$join, '\', \'', faces),
			'\''));
};
var _evancz$elm_graphics$Text$maybeAdd = F3(
	function (add, maybeValue, text) {
		var _p4 = maybeValue;
		if (_p4.ctor === 'Nothing') {
			return text;
		} else {
			return A2(add, _p4._0, text);
		}
	});
var _evancz$elm_graphics$Text$defaultStyle = {
	typeface: {ctor: '[]'},
	height: _elm_lang$core$Maybe$Nothing,
	color: _elm_lang$core$Color$black,
	bold: false,
	italic: false,
	line: _elm_lang$core$Maybe$Nothing
};
var _evancz$elm_graphics$Text$Style = F6(
	function (a, b, c, d, e, f) {
		return {typeface: a, height: b, color: c, bold: d, italic: e, line: f};
	});
var _evancz$elm_graphics$Text$Meta = F3(
	function (a, b, c) {
		return {ctor: 'Meta', _0: a, _1: b, _2: c};
	});
var _evancz$elm_graphics$Text$typeface = F2(
	function (faces, text) {
		var _p5 = faces;
		if (_p5.ctor === '[]') {
			return text;
		} else {
			return A3(
				_evancz$elm_graphics$Text$Meta,
				'font-family',
				_evancz$elm_graphics$Text$typefacesToString(faces),
				text);
		}
	});
var _evancz$elm_graphics$Text$monospace = function (text) {
	return A3(_evancz$elm_graphics$Text$Meta, 'font-family', 'monospace', text);
};
var _evancz$elm_graphics$Text$height = F2(
	function (px, text) {
		return A3(
			_evancz$elm_graphics$Text$Meta,
			'font-size',
			A2(
				_elm_lang$core$Basics_ops['++'],
				_elm_lang$core$Basics$toString(px),
				'px'),
			text);
	});
var _evancz$elm_graphics$Text$color = F2(
	function (color, text) {
		return A3(
			_evancz$elm_graphics$Text$Meta,
			'color',
			_evancz$elm_graphics$Text$colorToCss(color),
			text);
	});
var _evancz$elm_graphics$Text$bold = function (text) {
	return A3(_evancz$elm_graphics$Text$Meta, 'font-weight', 'bold', text);
};
var _evancz$elm_graphics$Text$italic = function (text) {
	return A3(_evancz$elm_graphics$Text$Meta, 'font-style', 'italic', text);
};
var _evancz$elm_graphics$Text$line = F2(
	function (lineTag, text) {
		var decoration = function () {
			var _p6 = lineTag;
			switch (_p6.ctor) {
				case 'Under':
					return 'underline';
				case 'Over':
					return 'overline';
				default:
					return 'line-through';
			}
		}();
		return A3(_evancz$elm_graphics$Text$Meta, 'text-decoration', decoration, text);
	});
var _evancz$elm_graphics$Text$style = F2(
	function (sty, text) {
		return A3(
			_evancz$elm_graphics$Text$maybeAdd,
			_evancz$elm_graphics$Text$height,
			sty.height,
			A3(
				_evancz$elm_graphics$Text$maybeAdd,
				_evancz$elm_graphics$Text$line,
				sty.line,
				(sty.italic ? _evancz$elm_graphics$Text$italic : _elm_lang$core$Basics$identity)(
					(sty.bold ? _evancz$elm_graphics$Text$bold : _elm_lang$core$Basics$identity)(
						A2(
							_evancz$elm_graphics$Text$typeface,
							sty.typeface,
							A2(_evancz$elm_graphics$Text$color, sty.color, text))))));
	});
var _evancz$elm_graphics$Text$Link = F2(
	function (a, b) {
		return {ctor: 'Link', _0: a, _1: b};
	});
var _evancz$elm_graphics$Text$link = _evancz$elm_graphics$Text$Link;
var _evancz$elm_graphics$Text$Append = F2(
	function (a, b) {
		return {ctor: 'Append', _0: a, _1: b};
	});
var _evancz$elm_graphics$Text$append = _evancz$elm_graphics$Text$Append;
var _evancz$elm_graphics$Text$Str = function (a) {
	return {ctor: 'Str', _0: a};
};
var _evancz$elm_graphics$Text$fromString = _evancz$elm_graphics$Text$Str;
var _evancz$elm_graphics$Text$empty = _evancz$elm_graphics$Text$fromString('');
var _evancz$elm_graphics$Text$concat = function (texts) {
	return A3(_elm_lang$core$List$foldr, _evancz$elm_graphics$Text$append, _evancz$elm_graphics$Text$empty, texts);
};
var _evancz$elm_graphics$Text$join = F2(
	function (seperator, texts) {
		return _evancz$elm_graphics$Text$concat(
			A2(_elm_lang$core$List$intersperse, seperator, texts));
	});
var _evancz$elm_graphics$Text$Through = {ctor: 'Through'};
var _evancz$elm_graphics$Text$Over = {ctor: 'Over'};
var _evancz$elm_graphics$Text$Under = {ctor: 'Under'};

var _evancz$elm_graphics$Element$justified = _evancz$elm_graphics$Native_Element.block('justify');
var _evancz$elm_graphics$Element$centered = _evancz$elm_graphics$Native_Element.block('center');
var _evancz$elm_graphics$Element$rightAligned = _evancz$elm_graphics$Native_Element.block('right');
var _evancz$elm_graphics$Element$leftAligned = _evancz$elm_graphics$Native_Element.block('left');
var _evancz$elm_graphics$Element$show = function (value) {
	return _evancz$elm_graphics$Element$leftAligned(
		_evancz$elm_graphics$Text$monospace(
			_evancz$elm_graphics$Text$fromString(
				_elm_lang$core$Basics$toString(value))));
};
var _evancz$elm_graphics$Element$newElement = _evancz$elm_graphics$Native_Element.newElement;
var _evancz$elm_graphics$Element$sizeOf = function (_p0) {
	var _p1 = _p0;
	var _p2 = _p1._0;
	return {ctor: '_Tuple2', _0: _p2.props.width, _1: _p2.props.height};
};
var _evancz$elm_graphics$Element$heightOf = function (_p3) {
	var _p4 = _p3;
	return _p4._0.props.height;
};
var _evancz$elm_graphics$Element$widthOf = function (_p5) {
	var _p6 = _p5;
	return _p6._0.props.width;
};
var _evancz$elm_graphics$Element$toHtml = _evancz$elm_graphics$Native_Element.toHtml;
var _evancz$elm_graphics$Element$Properties = F6(
	function (a, b, c, d, e, f) {
		return {width: a, height: b, opacity: c, color: d, href: e, tag: f};
	});
var _evancz$elm_graphics$Element$RawPosition = F4(
	function (a, b, c, d) {
		return {horizontal: a, vertical: b, x: c, y: d};
	});
var _evancz$elm_graphics$Element$Element_elm_builtin = function (a) {
	return {ctor: 'Element_elm_builtin', _0: a};
};
var _evancz$elm_graphics$Element$width = F2(
	function (newWidth, _p7) {
		var _p8 = _p7;
		var _p11 = _p8._0.props;
		var _p10 = _p8._0.element;
		var newHeight = function () {
			var _p9 = _p10;
			switch (_p9.ctor) {
				case 'Image':
					return _elm_lang$core$Basics$round(
						(_elm_lang$core$Basics$toFloat(_p9._2) / _elm_lang$core$Basics$toFloat(_p9._1)) * _elm_lang$core$Basics$toFloat(newWidth));
				case 'RawHtml':
					return _elm_lang$core$Tuple$second(
						A2(_evancz$elm_graphics$Native_Element.htmlHeight, newWidth, _p10));
				default:
					return _p11.height;
			}
		}();
		return _evancz$elm_graphics$Element$Element_elm_builtin(
			{
				element: _p10,
				props: _elm_lang$core$Native_Utils.update(
					_p11,
					{width: newWidth, height: newHeight})
			});
	});
var _evancz$elm_graphics$Element$height = F2(
	function (newHeight, _p12) {
		var _p13 = _p12;
		return _evancz$elm_graphics$Element$Element_elm_builtin(
			{
				element: _p13._0.element,
				props: _elm_lang$core$Native_Utils.update(
					_p13._0.props,
					{height: newHeight})
			});
	});
var _evancz$elm_graphics$Element$size = F3(
	function (w, h, e) {
		return A2(
			_evancz$elm_graphics$Element$height,
			h,
			A2(_evancz$elm_graphics$Element$width, w, e));
	});
var _evancz$elm_graphics$Element$opacity = F2(
	function (givenOpacity, _p14) {
		var _p15 = _p14;
		return _evancz$elm_graphics$Element$Element_elm_builtin(
			{
				element: _p15._0.element,
				props: _elm_lang$core$Native_Utils.update(
					_p15._0.props,
					{opacity: givenOpacity})
			});
	});
var _evancz$elm_graphics$Element$color = F2(
	function (clr, _p16) {
		var _p17 = _p16;
		return _evancz$elm_graphics$Element$Element_elm_builtin(
			{
				element: _p17._0.element,
				props: _elm_lang$core$Native_Utils.update(
					_p17._0.props,
					{
						color: _elm_lang$core$Maybe$Just(clr)
					})
			});
	});
var _evancz$elm_graphics$Element$tag = F2(
	function (name, _p18) {
		var _p19 = _p18;
		return _evancz$elm_graphics$Element$Element_elm_builtin(
			{
				element: _p19._0.element,
				props: _elm_lang$core$Native_Utils.update(
					_p19._0.props,
					{tag: name})
			});
	});
var _evancz$elm_graphics$Element$link = F2(
	function (href, _p20) {
		var _p21 = _p20;
		return _evancz$elm_graphics$Element$Element_elm_builtin(
			{
				element: _p21._0.element,
				props: _elm_lang$core$Native_Utils.update(
					_p21._0.props,
					{href: href})
			});
	});
var _evancz$elm_graphics$Element$Custom = {ctor: 'Custom'};
var _evancz$elm_graphics$Element$RawHtml = {ctor: 'RawHtml'};
var _evancz$elm_graphics$Element$Spacer = {ctor: 'Spacer'};
var _evancz$elm_graphics$Element$spacer = F2(
	function (w, h) {
		return A3(_evancz$elm_graphics$Element$newElement, w, h, _evancz$elm_graphics$Element$Spacer);
	});
var _evancz$elm_graphics$Element$empty = A2(_evancz$elm_graphics$Element$spacer, 0, 0);
var _evancz$elm_graphics$Element$Flow = F2(
	function (a, b) {
		return {ctor: 'Flow', _0: a, _1: b};
	});
var _evancz$elm_graphics$Element$flow = F2(
	function (dir, es) {
		var newFlow = F2(
			function (w, h) {
				return A3(
					_evancz$elm_graphics$Element$newElement,
					w,
					h,
					A2(_evancz$elm_graphics$Element$Flow, dir, es));
			});
		var maxOrZero = function (list) {
			return A2(
				_elm_lang$core$Maybe$withDefault,
				0,
				_elm_lang$core$List$maximum(list));
		};
		var hs = A2(_elm_lang$core$List$map, _evancz$elm_graphics$Element$heightOf, es);
		var ws = A2(_elm_lang$core$List$map, _evancz$elm_graphics$Element$widthOf, es);
		if (_elm_lang$core$Native_Utils.eq(
			es,
			{ctor: '[]'})) {
			return _evancz$elm_graphics$Element$empty;
		} else {
			var _p22 = dir;
			switch (_p22.ctor) {
				case 'DUp':
					return A2(
						newFlow,
						maxOrZero(ws),
						_elm_lang$core$List$sum(hs));
				case 'DDown':
					return A2(
						newFlow,
						maxOrZero(ws),
						_elm_lang$core$List$sum(hs));
				case 'DLeft':
					return A2(
						newFlow,
						_elm_lang$core$List$sum(ws),
						maxOrZero(hs));
				case 'DRight':
					return A2(
						newFlow,
						_elm_lang$core$List$sum(ws),
						maxOrZero(hs));
				case 'DIn':
					return A2(
						newFlow,
						maxOrZero(ws),
						maxOrZero(hs));
				default:
					return A2(
						newFlow,
						maxOrZero(ws),
						maxOrZero(hs));
			}
		}
	});
var _evancz$elm_graphics$Element$Container = F2(
	function (a, b) {
		return {ctor: 'Container', _0: a, _1: b};
	});
var _evancz$elm_graphics$Element$container = F4(
	function (w, h, _p23, e) {
		var _p24 = _p23;
		return A3(
			_evancz$elm_graphics$Element$newElement,
			w,
			h,
			A2(_evancz$elm_graphics$Element$Container, _p24._0, e));
	});
var _evancz$elm_graphics$Element$Image = F4(
	function (a, b, c, d) {
		return {ctor: 'Image', _0: a, _1: b, _2: c, _3: d};
	});
var _evancz$elm_graphics$Element$Tiled = {ctor: 'Tiled'};
var _evancz$elm_graphics$Element$tiledImage = F3(
	function (w, h, src) {
		return A3(
			_evancz$elm_graphics$Element$newElement,
			w,
			h,
			A4(_evancz$elm_graphics$Element$Image, _evancz$elm_graphics$Element$Tiled, w, h, src));
	});
var _evancz$elm_graphics$Element$Cropped = function (a) {
	return {ctor: 'Cropped', _0: a};
};
var _evancz$elm_graphics$Element$croppedImage = F4(
	function (pos, w, h, src) {
		return A3(
			_evancz$elm_graphics$Element$newElement,
			w,
			h,
			A4(
				_evancz$elm_graphics$Element$Image,
				_evancz$elm_graphics$Element$Cropped(pos),
				w,
				h,
				src));
	});
var _evancz$elm_graphics$Element$Fitted = {ctor: 'Fitted'};
var _evancz$elm_graphics$Element$fittedImage = F3(
	function (w, h, src) {
		return A3(
			_evancz$elm_graphics$Element$newElement,
			w,
			h,
			A4(_evancz$elm_graphics$Element$Image, _evancz$elm_graphics$Element$Fitted, w, h, src));
	});
var _evancz$elm_graphics$Element$Plain = {ctor: 'Plain'};
var _evancz$elm_graphics$Element$image = F3(
	function (w, h, src) {
		return A3(
			_evancz$elm_graphics$Element$newElement,
			w,
			h,
			A4(_evancz$elm_graphics$Element$Image, _evancz$elm_graphics$Element$Plain, w, h, src));
	});
var _evancz$elm_graphics$Element$N = {ctor: 'N'};
var _evancz$elm_graphics$Element$Z = {ctor: 'Z'};
var _evancz$elm_graphics$Element$P = {ctor: 'P'};
var _evancz$elm_graphics$Element$Relative = function (a) {
	return {ctor: 'Relative', _0: a};
};
var _evancz$elm_graphics$Element$relative = _evancz$elm_graphics$Element$Relative;
var _evancz$elm_graphics$Element$Absolute = function (a) {
	return {ctor: 'Absolute', _0: a};
};
var _evancz$elm_graphics$Element$absolute = _evancz$elm_graphics$Element$Absolute;
var _evancz$elm_graphics$Element$Position = function (a) {
	return {ctor: 'Position', _0: a};
};
var _evancz$elm_graphics$Element$middle = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$Z,
		vertical: _evancz$elm_graphics$Element$Z,
		x: _evancz$elm_graphics$Element$Relative(0.5),
		y: _evancz$elm_graphics$Element$Relative(0.5)
	});
var _evancz$elm_graphics$Element$topLeft = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$N,
		vertical: _evancz$elm_graphics$Element$P,
		x: _evancz$elm_graphics$Element$Absolute(0),
		y: _evancz$elm_graphics$Element$Absolute(0)
	});
var _evancz$elm_graphics$Element$topRight = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$P,
		vertical: _evancz$elm_graphics$Element$P,
		x: _evancz$elm_graphics$Element$Absolute(0),
		y: _evancz$elm_graphics$Element$Absolute(0)
	});
var _evancz$elm_graphics$Element$bottomLeft = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$N,
		vertical: _evancz$elm_graphics$Element$N,
		x: _evancz$elm_graphics$Element$Absolute(0),
		y: _evancz$elm_graphics$Element$Absolute(0)
	});
var _evancz$elm_graphics$Element$bottomRight = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$P,
		vertical: _evancz$elm_graphics$Element$N,
		x: _evancz$elm_graphics$Element$Absolute(0),
		y: _evancz$elm_graphics$Element$Absolute(0)
	});
var _evancz$elm_graphics$Element$midLeft = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$N,
		vertical: _evancz$elm_graphics$Element$Z,
		x: _evancz$elm_graphics$Element$Absolute(0),
		y: _evancz$elm_graphics$Element$Relative(0.5)
	});
var _evancz$elm_graphics$Element$midRight = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$P,
		vertical: _evancz$elm_graphics$Element$Z,
		x: _evancz$elm_graphics$Element$Absolute(0),
		y: _evancz$elm_graphics$Element$Relative(0.5)
	});
var _evancz$elm_graphics$Element$midTop = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$Z,
		vertical: _evancz$elm_graphics$Element$P,
		x: _evancz$elm_graphics$Element$Relative(0.5),
		y: _evancz$elm_graphics$Element$Absolute(0)
	});
var _evancz$elm_graphics$Element$midBottom = _evancz$elm_graphics$Element$Position(
	{
		horizontal: _evancz$elm_graphics$Element$Z,
		vertical: _evancz$elm_graphics$Element$N,
		x: _evancz$elm_graphics$Element$Relative(0.5),
		y: _evancz$elm_graphics$Element$Absolute(0)
	});
var _evancz$elm_graphics$Element$middleAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$Z, vertical: _evancz$elm_graphics$Element$Z, x: x, y: y});
	});
var _evancz$elm_graphics$Element$topLeftAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$N, vertical: _evancz$elm_graphics$Element$P, x: x, y: y});
	});
var _evancz$elm_graphics$Element$topRightAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$P, vertical: _evancz$elm_graphics$Element$P, x: x, y: y});
	});
var _evancz$elm_graphics$Element$bottomLeftAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$N, vertical: _evancz$elm_graphics$Element$N, x: x, y: y});
	});
var _evancz$elm_graphics$Element$bottomRightAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$P, vertical: _evancz$elm_graphics$Element$N, x: x, y: y});
	});
var _evancz$elm_graphics$Element$midLeftAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$N, vertical: _evancz$elm_graphics$Element$Z, x: x, y: y});
	});
var _evancz$elm_graphics$Element$midRightAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$P, vertical: _evancz$elm_graphics$Element$Z, x: x, y: y});
	});
var _evancz$elm_graphics$Element$midTopAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$Z, vertical: _evancz$elm_graphics$Element$P, x: x, y: y});
	});
var _evancz$elm_graphics$Element$midBottomAt = F2(
	function (x, y) {
		return _evancz$elm_graphics$Element$Position(
			{horizontal: _evancz$elm_graphics$Element$Z, vertical: _evancz$elm_graphics$Element$N, x: x, y: y});
	});
var _evancz$elm_graphics$Element$DOut = {ctor: 'DOut'};
var _evancz$elm_graphics$Element$layers = function (es) {
	var hs = A2(_elm_lang$core$List$map, _evancz$elm_graphics$Element$heightOf, es);
	var ws = A2(_elm_lang$core$List$map, _evancz$elm_graphics$Element$widthOf, es);
	return A3(
		_evancz$elm_graphics$Element$newElement,
		A2(
			_elm_lang$core$Maybe$withDefault,
			0,
			_elm_lang$core$List$maximum(ws)),
		A2(
			_elm_lang$core$Maybe$withDefault,
			0,
			_elm_lang$core$List$maximum(hs)),
		A2(_evancz$elm_graphics$Element$Flow, _evancz$elm_graphics$Element$DOut, es));
};
var _evancz$elm_graphics$Element$outward = _evancz$elm_graphics$Element$DOut;
var _evancz$elm_graphics$Element$DIn = {ctor: 'DIn'};
var _evancz$elm_graphics$Element$inward = _evancz$elm_graphics$Element$DIn;
var _evancz$elm_graphics$Element$DRight = {ctor: 'DRight'};
var _evancz$elm_graphics$Element$right = _evancz$elm_graphics$Element$DRight;
var _evancz$elm_graphics$Element$beside = F2(
	function (lft, rht) {
		return A3(
			_evancz$elm_graphics$Element$newElement,
			_evancz$elm_graphics$Element$widthOf(lft) + _evancz$elm_graphics$Element$widthOf(rht),
			A2(
				_elm_lang$core$Basics$max,
				_evancz$elm_graphics$Element$heightOf(lft),
				_evancz$elm_graphics$Element$heightOf(rht)),
			A2(
				_evancz$elm_graphics$Element$Flow,
				_evancz$elm_graphics$Element$right,
				{
					ctor: '::',
					_0: lft,
					_1: {
						ctor: '::',
						_0: rht,
						_1: {ctor: '[]'}
					}
				}));
	});
var _evancz$elm_graphics$Element$DLeft = {ctor: 'DLeft'};
var _evancz$elm_graphics$Element$left = _evancz$elm_graphics$Element$DLeft;
var _evancz$elm_graphics$Element$DDown = {ctor: 'DDown'};
var _evancz$elm_graphics$Element$above = F2(
	function (hi, lo) {
		return A3(
			_evancz$elm_graphics$Element$newElement,
			A2(
				_elm_lang$core$Basics$max,
				_evancz$elm_graphics$Element$widthOf(hi),
				_evancz$elm_graphics$Element$widthOf(lo)),
			_evancz$elm_graphics$Element$heightOf(hi) + _evancz$elm_graphics$Element$heightOf(lo),
			A2(
				_evancz$elm_graphics$Element$Flow,
				_evancz$elm_graphics$Element$DDown,
				{
					ctor: '::',
					_0: hi,
					_1: {
						ctor: '::',
						_0: lo,
						_1: {ctor: '[]'}
					}
				}));
	});
var _evancz$elm_graphics$Element$below = F2(
	function (lo, hi) {
		return A3(
			_evancz$elm_graphics$Element$newElement,
			A2(
				_elm_lang$core$Basics$max,
				_evancz$elm_graphics$Element$widthOf(hi),
				_evancz$elm_graphics$Element$widthOf(lo)),
			_evancz$elm_graphics$Element$heightOf(hi) + _evancz$elm_graphics$Element$heightOf(lo),
			A2(
				_evancz$elm_graphics$Element$Flow,
				_evancz$elm_graphics$Element$DDown,
				{
					ctor: '::',
					_0: hi,
					_1: {
						ctor: '::',
						_0: lo,
						_1: {ctor: '[]'}
					}
				}));
	});
var _evancz$elm_graphics$Element$down = _evancz$elm_graphics$Element$DDown;
var _evancz$elm_graphics$Element$DUp = {ctor: 'DUp'};
var _evancz$elm_graphics$Element$up = _evancz$elm_graphics$Element$DUp;

var _evancz$elm_graphics$Native_Collage = function()
{

function setStrokeStyle(ctx, style)
{
	ctx.lineWidth = style.width;

	var cap = style.cap.ctor;
	ctx.lineCap = cap === 'Flat'
		? 'butt'
		: cap === 'Round'
			? 'round'
			: 'square';

	var join = style.join.ctor;
	ctx.lineJoin = join === 'Smooth'
		? 'round'
		: join === 'Sharp'
			? 'miter'
			: 'bevel';

	ctx.miterLimit = style.join._0 || 10;
	ctx.strokeStyle = _evancz$elm_graphics$Text$colorToCss(style.color);
}

function setFillStyle(redo, ctx, style)
{
	var sty = style.ctor;
	ctx.fillStyle = sty === 'Solid'
		? _evancz$elm_graphics$Text$colorToCss(style._0)
		: sty === 'Texture'
			? texture(redo, ctx, style._0)
			: gradient(ctx, style._0);
}

function trace(ctx, path)
{
	var points = _elm_lang$core$Native_List.toArray(path);
	var i = points.length - 1;
	if (i <= 0)
	{
		return;
	}
	ctx.moveTo(points[i]._0, points[i]._1);
	while (i--)
	{
		ctx.lineTo(points[i]._0, points[i]._1);
	}
	if (path.closed)
	{
		i = points.length - 1;
		ctx.lineTo(points[i]._0, points[i]._1);
	}
}

function line(ctx, style, path)
{
	if (style.dashing.ctor === '[]')
	{
		trace(ctx, path);
	}
	else
	{
		customLineHelp(ctx, style, path);
	}
	ctx.scale(1, -1);
	ctx.stroke();
}

function customLineHelp(ctx, style, path)
{
	var points = _elm_lang$core$Native_List.toArray(path);
	if (path.closed)
	{
		points.push(points[0]);
	}
	var pattern = _elm_lang$core$Native_List.toArray(style.dashing);
	var i = points.length - 1;
	if (i <= 0)
	{
		return;
	}
	var x0 = points[i]._0, y0 = points[i]._1;
	var x1 = 0, y1 = 0, dx = 0, dy = 0, remaining = 0;
	var pindex = 0, plen = pattern.length;
	var draw = true, segmentLength = pattern[0];
	ctx.moveTo(x0, y0);
	while (i--)
	{
		x1 = points[i]._0;
		y1 = points[i]._1;
		dx = x1 - x0;
		dy = y1 - y0;
		remaining = Math.sqrt(dx * dx + dy * dy);
		while (segmentLength <= remaining)
		{
			x0 += dx * segmentLength / remaining;
			y0 += dy * segmentLength / remaining;
			ctx[draw ? 'lineTo' : 'moveTo'](x0, y0);
			// update starting position
			dx = x1 - x0;
			dy = y1 - y0;
			remaining = Math.sqrt(dx * dx + dy * dy);
			// update pattern
			draw = !draw;
			pindex = (pindex + 1) % plen;
			segmentLength = pattern[pindex];
		}
		if (remaining > 0)
		{
			ctx[draw ? 'lineTo' : 'moveTo'](x1, y1);
			segmentLength -= remaining;
		}
		x0 = x1;
		y0 = y1;
	}
}

function drawLine(ctx, style, path)
{
	setStrokeStyle(ctx, style);
	return line(ctx, style, path);
}

function texture(redo, ctx, src)
{
	var img = new Image();
	img.src = src;
	img.onload = redo;
	return ctx.createPattern(img, 'repeat');
}

function gradient(ctx, grad)
{
	var g;
	var stops = [];
	if (grad.ctor === 'Linear')
	{
		var p0 = grad._0, p1 = grad._1;
		g = ctx.createLinearGradient(p0._0, -p0._1, p1._0, -p1._1);
		stops = _elm_lang$core$Native_List.toArray(grad._2);
	}
	else
	{
		var p0 = grad._0, p2 = grad._2;
		g = ctx.createRadialGradient(p0._0, -p0._1, grad._1, p2._0, -p2._1, grad._3);
		stops = _elm_lang$core$Native_List.toArray(grad._4);
	}
	var len = stops.length;
	for (var i = 0; i < len; ++i)
	{
		var stop = stops[i];
		g.addColorStop(stop._0, _evancz$elm_graphics$Text$colorToCss(stop._1));
	}
	return g;
}

function drawShape(redo, ctx, style, path)
{
	trace(ctx, path);
	setFillStyle(redo, ctx, style);
	ctx.scale(1, -1);
	ctx.fill();
}


// TEXT RENDERING

function fillText(redo, ctx, text)
{
	drawText(ctx, text, ctx.fillText);
}

function strokeText(redo, ctx, style, text)
{
	setStrokeStyle(ctx, style);
	// Use native canvas API for dashes only for text for now
	// Degrades to non-dashed on IE 9 + 10
	if (style.dashing.ctor !== '[]' && ctx.setLineDash)
	{
		var pattern = _elm_lang$core$Native_List.toArray(style.dashing);
		ctx.setLineDash(pattern);
	}
	drawText(ctx, text, ctx.strokeText);
}

function drawText(ctx, text, canvasDrawFn)
{
	var textChunks = chunkText(copy(defaultFacts), text);

	var totalWidth = 0;
	var maxHeight = 0;
	var numChunks = textChunks.length;

	ctx.scale(1,-1);

	for (var i = numChunks; i--; )
	{
		var chunk = textChunks[i];
		ctx.font = chunk.font;
		var metrics = ctx.measureText(chunk.text);
		chunk.width = metrics.width;
		totalWidth += chunk.width;
		if (chunk.height > maxHeight)
		{
			maxHeight = chunk.height;
		}
	}

	var x = -totalWidth / 2.0;
	for (var i = 0; i < numChunks; ++i)
	{
		var chunk = textChunks[i];
		ctx.font = chunk.font;
		ctx.fillStyle = chunk.color;
		canvasDrawFn.call(ctx, chunk.text, x, maxHeight / 2);
		x += chunk.width;
	}
}

function toFont(facts)
{
	return facts['font-style']
		+ ' ' + facts['font-variant']
		+ ' ' + facts['font-weight']
		+ ' ' + facts['font-size']
		+ ' ' + facts['font-family'];
}


// Convert the object returned by the text module
// into something we can use for styling canvas text
function chunkText(facts, text)
{
	switch (text.ctor)
	{
		case 'Append':
			var leftChunks = chunkText(copy(facts), text._0);
			var rightChunks = chunkText(copy(facts), text._1);
			return leftChunks.concat(rightChunks);

		case 'Str':
			return [{
				text: text._0,
				color: facts['color'],
				height: facts['font-size'].slice(0, -2) | 0,
				font: toFont(facts)
			}];

		case 'Link':
			return chunkText(facts, text._1);

		case 'Meta':
			facts[text._0] = text._1;
			return chunkText(facts, text._2);
	}
}

function copy(facts)
{
	return {
		'font-style': facts['font-style'],
		'font-variant': facts['font-variant'],
		'font-weight': facts['font-weight'],
		'font-size': facts['font-size'],
		'font-family': facts['font-family'],
		'color': facts['color']
	};
}

var defaultFacts = {
	'font-style': 'normal',
	'font-variant': 'normal',
	'font-weight': 'normal',
	'font-size': '12px',
	'font-family': 'sans-serif',
	'color': 'black'
};


// IMAGES

function drawImage(redo, ctx, form)
{
	var img = new Image();
	img.onload = redo;
	img.src = form._3;
	var w = form._0,
		h = form._1,
		pos = form._2,
		srcX = pos._0,
		srcY = pos._1,
		srcW = w,
		srcH = h,
		destX = -w / 2,
		destY = -h / 2,
		destW = w,
		destH = h;

	ctx.scale(1, -1);
	ctx.drawImage(img, srcX, srcY, srcW, srcH, destX, destY, destW, destH);
}

function renderForm(redo, ctx, form)
{
	ctx.save();

	var x = form.x,
		y = form.y,
		theta = form.theta,
		scale = form.scale;

	if (x !== 0 || y !== 0)
	{
		ctx.translate(x, y);
	}
	if (theta !== 0)
	{
		ctx.rotate(theta % (Math.PI * 2));
	}
	if (scale !== 1)
	{
		ctx.scale(scale, scale);
	}
	if (form.alpha !== 1)
	{
		ctx.globalAlpha = ctx.globalAlpha * form.alpha;
	}

	ctx.beginPath();
	var f = form.form;
	switch (f.ctor)
	{
		case 'FPath':
			drawLine(ctx, f._0, f._1);
			break;

		case 'FImage':
			drawImage(redo, ctx, f);
			break;

		case 'FShape':
			if (f._0.ctor === 'Line')
			{
				f._1.closed = true;
				drawLine(ctx, f._0._0, f._1);
			}
			else
			{
				drawShape(redo, ctx, f._0._0, f._1);
			}
			break;

		case 'FText':
			fillText(redo, ctx, f._0);
			break;

		case 'FOutlinedText':
			strokeText(redo, ctx, f._0, f._1);
			break;
	}
	ctx.restore();
}

function formToMatrix(form)
{
	var scale = form.scale;
	var matrix = A6( _evancz$elm_graphics$Transform$matrix, scale, 0, 0, scale, form.x, form.y );

	var theta = form.theta;
	if (theta !== 0)
	{
		matrix = A2(
			_evancz$elm_graphics$Transform$multiply,
			matrix,
			_evancz$elm_graphics$Transform$rotation(theta)
		);
	}

   return matrix;
}

function str(n)
{
	if (n < 0.00001 && n > -0.00001)
	{
		return 0;
	}
	return n;
}

function makeTransform(w, h, form, matrices)
{
	var props = form.form._0._0.props;
	var m = A6(
		_evancz$elm_graphics$Transform$matrix,
		1,
		0,
		0,
		-1,
		(w - props.width ) / 2,
		(h - props.height) / 2
	);

	var len = matrices.length;
	for (var i = 0; i < len; ++i)
	{
		m = A2( _evancz$elm_graphics$Transform$multiply, m, matrices[i] );
	}
	m = A2( _evancz$elm_graphics$Transform$multiply, m, formToMatrix(form) );

	return 'matrix(' +
		str( m[0]) + ', ' + str( m[3]) + ', ' +
		str(-m[1]) + ', ' + str(-m[4]) + ', ' +
		str( m[2]) + ', ' + str( m[5]) + ')';
}

function stepperHelp(list)
{
	var arr = _elm_lang$core$Native_List.toArray(list);
	var i = 0;
	function peekNext()
	{
		return i < arr.length ? arr[i]._0.form.ctor : '';
	}
	// assumes that there is a next element
	function next()
	{
		var out = arr[i]._0;
		++i;
		return out;
	}
	return {
		peekNext: peekNext,
		next: next
	};
}

function formStepper(forms)
{
	var ps = [stepperHelp(forms)];
	var matrices = [];
	var alphas = [];
	function peekNext()
	{
		var len = ps.length;
		var formType = '';
		for (var i = 0; i < len; ++i )
		{
			if (formType = ps[i].peekNext()) return formType;
		}
		return '';
	}
	// assumes that there is a next element
	function next(ctx)
	{
		while (!ps[0].peekNext())
		{
			ps.shift();
			matrices.pop();
			alphas.shift();
			if (ctx)
			{
				ctx.restore();
			}
		}
		var out = ps[0].next();
		var f = out.form;
		if (f.ctor === 'FGroup')
		{
			ps.unshift(stepperHelp(f._1));
			var m = A2(_evancz$elm_graphics$Transform$multiply, f._0, formToMatrix(out));
			ctx.save();
			ctx.transform(m[0], m[3], m[1], m[4], m[2], m[5]);
			matrices.push(m);

			var alpha = (alphas[0] || 1) * out.alpha;
			alphas.unshift(alpha);
			ctx.globalAlpha = alpha;
		}
		return out;
	}
	function transforms()
	{
		return matrices;
	}
	function alpha()
	{
		return alphas[0] || 1;
	}
	return {
		peekNext: peekNext,
		next: next,
		transforms: transforms,
		alpha: alpha
	};
}

function makeCanvas(w, h)
{
	var canvas = _evancz$elm_graphics$Native_Element.createNode('canvas');
	canvas.style.width  = w + 'px';
	canvas.style.height = h + 'px';
	canvas.style.display = 'block';
	canvas.style.position = 'absolute';
	var ratio = window.devicePixelRatio || 1;
	canvas.width  = w * ratio;
	canvas.height = h * ratio;
	return canvas;
}

function render(model)
{
	var div = _evancz$elm_graphics$Native_Element.createNode('div');
	div.style.overflow = 'hidden';
	div.style.position = 'relative';
	update(div, model, model);
	return div;
}

function nodeStepper(w, h, div)
{
	var kids = div.childNodes;
	var i = 0;
	var ratio = window.devicePixelRatio || 1;

	function transform(transforms, ctx)
	{
		ctx.translate( w / 2 * ratio, h / 2 * ratio );
		ctx.scale( ratio, -ratio );
		var len = transforms.length;
		for (var i = 0; i < len; ++i)
		{
			var m = transforms[i];
			ctx.save();
			ctx.transform(m[0], m[3], m[1], m[4], m[2], m[5]);
		}
		return ctx;
	}
	function nextContext(transforms)
	{
		while (i < kids.length)
		{
			var node = kids[i];
			if (node.getContext)
			{
				node.width = w * ratio;
				node.height = h * ratio;
				node.style.width = w + 'px';
				node.style.height = h + 'px';
				++i;
				return transform(transforms, node.getContext('2d'));
			}
			div.removeChild(node);
		}
		var canvas = makeCanvas(w, h);
		div.appendChild(canvas);
		// we have added a new node, so we must step our position
		++i;
		return transform(transforms, canvas.getContext('2d'));
	}
	function addElement(matrices, alpha, form)
	{
		var kid = kids[i];
		var elem = form.form._0;

		var node = (!kid || kid.getContext)
			? _evancz$elm_graphics$Native_Element.render(elem)
			: _evancz$elm_graphics$Native_Element.update(kid, kid.oldElement, elem);

		node.style.position = 'absolute';
		node.style.opacity = alpha * form.alpha * elem._0.props.opacity;
		_evancz$elm_graphics$Native_Element.addTransform(node.style, makeTransform(w, h, form, matrices));
		node.oldElement = elem;
		++i;
		if (!kid)
		{
			div.appendChild(node);
		}
		else
		{
			div.insertBefore(node, kid);
		}
	}
	function clearRest()
	{
		while (i < kids.length)
		{
			div.removeChild(kids[i]);
		}
	}
	return {
		nextContext: nextContext,
		addElement: addElement,
		clearRest: clearRest
	};
}


function update(div, _, model)
{
	var w = model.w;
	var h = model.h;

	var forms = formStepper(model.forms);
	var nodes = nodeStepper(w, h, div);
	var ctx = null;
	var formType = '';

	while (formType = forms.peekNext())
	{
		// make sure we have context if we need it
		if (ctx === null && formType !== 'FElement')
		{
			ctx = nodes.nextContext(forms.transforms());
			ctx.globalAlpha = forms.alpha();
		}

		var form = forms.next(ctx);
		// if it is FGroup, all updates are made within formStepper when next is called.
		if (formType === 'FElement')
		{
			// update or insert an element, get a new context
			nodes.addElement(forms.transforms(), forms.alpha(), form);
			ctx = null;
		}
		else if (formType !== 'FGroup')
		{
			renderForm(function() { update(div, model, model); }, ctx, form);
		}
	}
	nodes.clearRest();
	return div;
}


function collage(w, h, forms)
{
	return A3(_evancz$elm_graphics$Native_Element.newElement, w, h, {
		ctor: 'Custom',
		type: 'Collage',
		render: render,
		update: update,
		model: {w: w, h: h, forms: forms}
	});
}

return {
	collage: F3(collage)
};

}();

var _evancz$elm_graphics$Native_Transform = function()
{

var A;
if (typeof Float32Array === 'undefined')
{
	A = function(arr)
	{
		this.length = arr.length;
		this[0] = arr[0];
		this[1] = arr[1];
		this[2] = arr[2];
		this[3] = arr[3];
		this[4] = arr[4];
		this[5] = arr[5];
	};
}
else
{
	A = Float32Array;
}

// layout of matrix in an array is
//
//   | m11 m12 dx |
//   | m21 m22 dy |
//   |  0   0   1 |
//
//  new A([ m11, m12, dx, m21, m22, dy ])

var identity = new A([1, 0, 0, 0, 1, 0]);

function matrix(m11, m12, m21, m22, dx, dy)
{
	return new A([m11, m12, dx, m21, m22, dy]);
}

function rotation(t)
{
	var c = Math.cos(t);
	var s = Math.sin(t);
	return new A([c, -s, 0, s, c, 0]);
}

function rotate(t, m)
{
	var c = Math.cos(t);
	var s = Math.sin(t);
	var m11 = m[0], m12 = m[1], m21 = m[3], m22 = m[4];
	return new A([
		m11 * c + m12 * s,
		-m11 * s + m12 * c,
		m[2],
		m21 * c + m22 * s,
		-m21 * s + m22 * c,
		m[5]
	]);
}

function multiply(m, n)
{
	var m11 = m[0], m12 = m[1], m21 = m[3], m22 = m[4], mdx = m[2], mdy = m[5];
	var n11 = n[0], n12 = n[1], n21 = n[3], n22 = n[4], ndx = n[2], ndy = n[5];
	return new A([
		m11 * n11 + m12 * n21,
		m11 * n12 + m12 * n22,
		m11 * ndx + m12 * ndy + mdx,
		m21 * n11 + m22 * n21,
		m21 * n12 + m22 * n22,
		m21 * ndx + m22 * ndy + mdy
	]);
}

return {
	identity: identity,
	matrix: F6(matrix),
	rotation: rotation,
	multiply: F2(multiply)
};

}();

var _evancz$elm_graphics$Transform$multiply = _evancz$elm_graphics$Native_Transform.multiply;
var _evancz$elm_graphics$Transform$rotation = _evancz$elm_graphics$Native_Transform.rotation;
var _evancz$elm_graphics$Transform$matrix = _evancz$elm_graphics$Native_Transform.matrix;
var _evancz$elm_graphics$Transform$translation = F2(
	function (x, y) {
		return A6(_evancz$elm_graphics$Transform$matrix, 1, 0, 0, 1, x, y);
	});
var _evancz$elm_graphics$Transform$scale = function (s) {
	return A6(_evancz$elm_graphics$Transform$matrix, s, 0, 0, s, 0, 0);
};
var _evancz$elm_graphics$Transform$scaleX = function (x) {
	return A6(_evancz$elm_graphics$Transform$matrix, x, 0, 0, 1, 0, 0);
};
var _evancz$elm_graphics$Transform$scaleY = function (y) {
	return A6(_evancz$elm_graphics$Transform$matrix, 1, 0, 0, y, 0, 0);
};
var _evancz$elm_graphics$Transform$identity = _evancz$elm_graphics$Native_Transform.identity;
var _evancz$elm_graphics$Transform$Transform = {ctor: 'Transform'};

var _evancz$elm_graphics$Collage$collage = _evancz$elm_graphics$Native_Collage.collage;
var _evancz$elm_graphics$Collage$LineStyle = F6(
	function (a, b, c, d, e, f) {
		return {color: a, width: b, cap: c, join: d, dashing: e, dashOffset: f};
	});
var _evancz$elm_graphics$Collage$Form_elm_builtin = function (a) {
	return {ctor: 'Form_elm_builtin', _0: a};
};
var _evancz$elm_graphics$Collage$form = function (f) {
	return _evancz$elm_graphics$Collage$Form_elm_builtin(
		{theta: 0, scale: 1, x: 0, y: 0, alpha: 1, form: f});
};
var _evancz$elm_graphics$Collage$move = F2(
	function (_p1, _p0) {
		var _p2 = _p1;
		var _p3 = _p0;
		var _p4 = _p3._0;
		return _evancz$elm_graphics$Collage$Form_elm_builtin(
			_elm_lang$core$Native_Utils.update(
				_p4,
				{x: _p4.x + _p2._0, y: _p4.y + _p2._1}));
	});
var _evancz$elm_graphics$Collage$moveX = F2(
	function (x, _p5) {
		var _p6 = _p5;
		var _p7 = _p6._0;
		return _evancz$elm_graphics$Collage$Form_elm_builtin(
			_elm_lang$core$Native_Utils.update(
				_p7,
				{x: _p7.x + x}));
	});
var _evancz$elm_graphics$Collage$moveY = F2(
	function (y, _p8) {
		var _p9 = _p8;
		var _p10 = _p9._0;
		return _evancz$elm_graphics$Collage$Form_elm_builtin(
			_elm_lang$core$Native_Utils.update(
				_p10,
				{y: _p10.y + y}));
	});
var _evancz$elm_graphics$Collage$scale = F2(
	function (s, _p11) {
		var _p12 = _p11;
		var _p13 = _p12._0;
		return _evancz$elm_graphics$Collage$Form_elm_builtin(
			_elm_lang$core$Native_Utils.update(
				_p13,
				{scale: _p13.scale * s}));
	});
var _evancz$elm_graphics$Collage$rotate = F2(
	function (t, _p14) {
		var _p15 = _p14;
		var _p16 = _p15._0;
		return _evancz$elm_graphics$Collage$Form_elm_builtin(
			_elm_lang$core$Native_Utils.update(
				_p16,
				{theta: _p16.theta + t}));
	});
var _evancz$elm_graphics$Collage$alpha = F2(
	function (a, _p17) {
		var _p18 = _p17;
		return _evancz$elm_graphics$Collage$Form_elm_builtin(
			_elm_lang$core$Native_Utils.update(
				_p18._0,
				{alpha: a}));
	});
var _evancz$elm_graphics$Collage$Grad = function (a) {
	return {ctor: 'Grad', _0: a};
};
var _evancz$elm_graphics$Collage$Texture = function (a) {
	return {ctor: 'Texture', _0: a};
};
var _evancz$elm_graphics$Collage$Solid = function (a) {
	return {ctor: 'Solid', _0: a};
};
var _evancz$elm_graphics$Collage$Padded = {ctor: 'Padded'};
var _evancz$elm_graphics$Collage$Round = {ctor: 'Round'};
var _evancz$elm_graphics$Collage$Flat = {ctor: 'Flat'};
var _evancz$elm_graphics$Collage$Clipped = {ctor: 'Clipped'};
var _evancz$elm_graphics$Collage$Sharp = function (a) {
	return {ctor: 'Sharp', _0: a};
};
var _evancz$elm_graphics$Collage$defaultLine = {
	color: _elm_lang$core$Color$black,
	width: 1,
	cap: _evancz$elm_graphics$Collage$Flat,
	join: _evancz$elm_graphics$Collage$Sharp(10),
	dashing: {ctor: '[]'},
	dashOffset: 0
};
var _evancz$elm_graphics$Collage$solid = function (clr) {
	return _elm_lang$core$Native_Utils.update(
		_evancz$elm_graphics$Collage$defaultLine,
		{color: clr});
};
var _evancz$elm_graphics$Collage$dashed = function (clr) {
	return _elm_lang$core$Native_Utils.update(
		_evancz$elm_graphics$Collage$defaultLine,
		{
			color: clr,
			dashing: {
				ctor: '::',
				_0: 8,
				_1: {
					ctor: '::',
					_0: 4,
					_1: {ctor: '[]'}
				}
			}
		});
};
var _evancz$elm_graphics$Collage$dotted = function (clr) {
	return _elm_lang$core$Native_Utils.update(
		_evancz$elm_graphics$Collage$defaultLine,
		{
			color: clr,
			dashing: {
				ctor: '::',
				_0: 3,
				_1: {
					ctor: '::',
					_0: 3,
					_1: {ctor: '[]'}
				}
			}
		});
};
var _evancz$elm_graphics$Collage$Smooth = {ctor: 'Smooth'};
var _evancz$elm_graphics$Collage$FGroup = F2(
	function (a, b) {
		return {ctor: 'FGroup', _0: a, _1: b};
	});
var _evancz$elm_graphics$Collage$group = function (fs) {
	return _evancz$elm_graphics$Collage$form(
		A2(_evancz$elm_graphics$Collage$FGroup, _evancz$elm_graphics$Transform$identity, fs));
};
var _evancz$elm_graphics$Collage$groupTransform = F2(
	function (matrix, fs) {
		return _evancz$elm_graphics$Collage$form(
			A2(_evancz$elm_graphics$Collage$FGroup, matrix, fs));
	});
var _evancz$elm_graphics$Collage$FElement = function (a) {
	return {ctor: 'FElement', _0: a};
};
var _evancz$elm_graphics$Collage$toForm = function (e) {
	return _evancz$elm_graphics$Collage$form(
		_evancz$elm_graphics$Collage$FElement(e));
};
var _evancz$elm_graphics$Collage$FImage = F4(
	function (a, b, c, d) {
		return {ctor: 'FImage', _0: a, _1: b, _2: c, _3: d};
	});
var _evancz$elm_graphics$Collage$sprite = F4(
	function (w, h, pos, src) {
		return _evancz$elm_graphics$Collage$form(
			A4(_evancz$elm_graphics$Collage$FImage, w, h, pos, src));
	});
var _evancz$elm_graphics$Collage$FText = function (a) {
	return {ctor: 'FText', _0: a};
};
var _evancz$elm_graphics$Collage$text = function (t) {
	return _evancz$elm_graphics$Collage$form(
		_evancz$elm_graphics$Collage$FText(t));
};
var _evancz$elm_graphics$Collage$FOutlinedText = F2(
	function (a, b) {
		return {ctor: 'FOutlinedText', _0: a, _1: b};
	});
var _evancz$elm_graphics$Collage$outlinedText = F2(
	function (ls, t) {
		return _evancz$elm_graphics$Collage$form(
			A2(_evancz$elm_graphics$Collage$FOutlinedText, ls, t));
	});
var _evancz$elm_graphics$Collage$FShape = F2(
	function (a, b) {
		return {ctor: 'FShape', _0: a, _1: b};
	});
var _evancz$elm_graphics$Collage$FPath = F2(
	function (a, b) {
		return {ctor: 'FPath', _0: a, _1: b};
	});
var _evancz$elm_graphics$Collage$traced = F2(
	function (style, _p19) {
		var _p20 = _p19;
		return _evancz$elm_graphics$Collage$form(
			A2(_evancz$elm_graphics$Collage$FPath, style, _p20._0));
	});
var _evancz$elm_graphics$Collage$Fill = function (a) {
	return {ctor: 'Fill', _0: a};
};
var _evancz$elm_graphics$Collage$fill = F2(
	function (style, _p21) {
		var _p22 = _p21;
		return _evancz$elm_graphics$Collage$form(
			A2(
				_evancz$elm_graphics$Collage$FShape,
				_evancz$elm_graphics$Collage$Fill(style),
				_p22._0));
	});
var _evancz$elm_graphics$Collage$filled = F2(
	function (color, shape) {
		return A2(
			_evancz$elm_graphics$Collage$fill,
			_evancz$elm_graphics$Collage$Solid(color),
			shape);
	});
var _evancz$elm_graphics$Collage$textured = F2(
	function (src, shape) {
		return A2(
			_evancz$elm_graphics$Collage$fill,
			_evancz$elm_graphics$Collage$Texture(src),
			shape);
	});
var _evancz$elm_graphics$Collage$gradient = F2(
	function (grad, shape) {
		return A2(
			_evancz$elm_graphics$Collage$fill,
			_evancz$elm_graphics$Collage$Grad(grad),
			shape);
	});
var _evancz$elm_graphics$Collage$Line = function (a) {
	return {ctor: 'Line', _0: a};
};
var _evancz$elm_graphics$Collage$outlined = F2(
	function (style, _p23) {
		var _p24 = _p23;
		return _evancz$elm_graphics$Collage$form(
			A2(
				_evancz$elm_graphics$Collage$FShape,
				_evancz$elm_graphics$Collage$Line(style),
				_p24._0));
	});
var _evancz$elm_graphics$Collage$Path = function (a) {
	return {ctor: 'Path', _0: a};
};
var _evancz$elm_graphics$Collage$path = function (ps) {
	return _evancz$elm_graphics$Collage$Path(ps);
};
var _evancz$elm_graphics$Collage$segment = F2(
	function (p1, p2) {
		return _evancz$elm_graphics$Collage$Path(
			{
				ctor: '::',
				_0: p1,
				_1: {
					ctor: '::',
					_0: p2,
					_1: {ctor: '[]'}
				}
			});
	});
var _evancz$elm_graphics$Collage$Shape = function (a) {
	return {ctor: 'Shape', _0: a};
};
var _evancz$elm_graphics$Collage$polygon = function (points) {
	return _evancz$elm_graphics$Collage$Shape(points);
};
var _evancz$elm_graphics$Collage$rect = F2(
	function (w, h) {
		var hh = h / 2;
		var hw = w / 2;
		return _evancz$elm_graphics$Collage$Shape(
			{
				ctor: '::',
				_0: {ctor: '_Tuple2', _0: 0 - hw, _1: 0 - hh},
				_1: {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: 0 - hw, _1: hh},
					_1: {
						ctor: '::',
						_0: {ctor: '_Tuple2', _0: hw, _1: hh},
						_1: {
							ctor: '::',
							_0: {ctor: '_Tuple2', _0: hw, _1: 0 - hh},
							_1: {ctor: '[]'}
						}
					}
				}
			});
	});
var _evancz$elm_graphics$Collage$square = function (n) {
	return A2(_evancz$elm_graphics$Collage$rect, n, n);
};
var _evancz$elm_graphics$Collage$oval = F2(
	function (w, h) {
		var hh = h / 2;
		var hw = w / 2;
		var n = 50;
		var t = (2 * _elm_lang$core$Basics$pi) / n;
		var f = function (i) {
			return {
				ctor: '_Tuple2',
				_0: hw * _elm_lang$core$Basics$cos(
					t * _elm_lang$core$Basics$toFloat(i)),
				_1: hh * _elm_lang$core$Basics$sin(
					t * _elm_lang$core$Basics$toFloat(i))
			};
		};
		return _evancz$elm_graphics$Collage$Shape(
			A2(
				_elm_lang$core$List$map,
				f,
				A2(_elm_lang$core$List$range, 0, n - 1)));
	});
var _evancz$elm_graphics$Collage$circle = function (r) {
	return A2(_evancz$elm_graphics$Collage$oval, 2 * r, 2 * r);
};
var _evancz$elm_graphics$Collage$ngon = F2(
	function (n, r) {
		var m = _elm_lang$core$Basics$toFloat(n);
		var t = (2 * _elm_lang$core$Basics$pi) / m;
		var f = function (i) {
			return {
				ctor: '_Tuple2',
				_0: r * _elm_lang$core$Basics$cos(
					t * _elm_lang$core$Basics$toFloat(i)),
				_1: r * _elm_lang$core$Basics$sin(
					t * _elm_lang$core$Basics$toFloat(i))
			};
		};
		return _evancz$elm_graphics$Collage$Shape(
			A2(
				_elm_lang$core$List$map,
				f,
				A2(_elm_lang$core$List$range, 0, n - 1)));
	});

var _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasTransform = F3(
	function (width, height, coord) {
		return coord;
	});
var _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasCompose = F3(
	function (width, height, forms) {
		return A3(_evancz$elm_graphics$Collage$collage, width, height, forms);
	});
var _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasPosition = F2(
	function (coord, form) {
		return A2(_evancz$elm_graphics$Collage$move, coord, form);
	});
var _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasDrawable = A3(_brenden$elm_tree_diagram$TreeDiagram$Drawable, _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasPosition, _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasCompose, _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasTransform);
var _brenden$elm_tree_diagram$TreeDiagram_Canvas$draw = F4(
	function (layout, drawNode, drawLine, tree) {
		return A5(_brenden$elm_tree_diagram$TreeDiagram$draw_, _brenden$elm_tree_diagram$TreeDiagram_Canvas$canvasDrawable, layout, drawNode, drawLine, tree);
	});

var _elm_lang$core$Task$onError = _elm_lang$core$Native_Scheduler.onError;
var _elm_lang$core$Task$andThen = _elm_lang$core$Native_Scheduler.andThen;
var _elm_lang$core$Task$spawnCmd = F2(
	function (router, _p0) {
		var _p1 = _p0;
		return _elm_lang$core$Native_Scheduler.spawn(
			A2(
				_elm_lang$core$Task$andThen,
				_elm_lang$core$Platform$sendToApp(router),
				_p1._0));
	});
var _elm_lang$core$Task$fail = _elm_lang$core$Native_Scheduler.fail;
var _elm_lang$core$Task$mapError = F2(
	function (convert, task) {
		return A2(
			_elm_lang$core$Task$onError,
			function (_p2) {
				return _elm_lang$core$Task$fail(
					convert(_p2));
			},
			task);
	});
var _elm_lang$core$Task$succeed = _elm_lang$core$Native_Scheduler.succeed;
var _elm_lang$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			_elm_lang$core$Task$andThen,
			function (a) {
				return _elm_lang$core$Task$succeed(
					func(a));
			},
			taskA);
	});
var _elm_lang$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			_elm_lang$core$Task$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					function (b) {
						return _elm_lang$core$Task$succeed(
							A2(func, a, b));
					},
					taskB);
			},
			taskA);
	});
var _elm_lang$core$Task$map3 = F4(
	function (func, taskA, taskB, taskC) {
		return A2(
			_elm_lang$core$Task$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					function (b) {
						return A2(
							_elm_lang$core$Task$andThen,
							function (c) {
								return _elm_lang$core$Task$succeed(
									A3(func, a, b, c));
							},
							taskC);
					},
					taskB);
			},
			taskA);
	});
var _elm_lang$core$Task$map4 = F5(
	function (func, taskA, taskB, taskC, taskD) {
		return A2(
			_elm_lang$core$Task$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					function (b) {
						return A2(
							_elm_lang$core$Task$andThen,
							function (c) {
								return A2(
									_elm_lang$core$Task$andThen,
									function (d) {
										return _elm_lang$core$Task$succeed(
											A4(func, a, b, c, d));
									},
									taskD);
							},
							taskC);
					},
					taskB);
			},
			taskA);
	});
var _elm_lang$core$Task$map5 = F6(
	function (func, taskA, taskB, taskC, taskD, taskE) {
		return A2(
			_elm_lang$core$Task$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Task$andThen,
					function (b) {
						return A2(
							_elm_lang$core$Task$andThen,
							function (c) {
								return A2(
									_elm_lang$core$Task$andThen,
									function (d) {
										return A2(
											_elm_lang$core$Task$andThen,
											function (e) {
												return _elm_lang$core$Task$succeed(
													A5(func, a, b, c, d, e));
											},
											taskE);
									},
									taskD);
							},
							taskC);
					},
					taskB);
			},
			taskA);
	});
var _elm_lang$core$Task$sequence = function (tasks) {
	var _p3 = tasks;
	if (_p3.ctor === '[]') {
		return _elm_lang$core$Task$succeed(
			{ctor: '[]'});
	} else {
		return A3(
			_elm_lang$core$Task$map2,
			F2(
				function (x, y) {
					return {ctor: '::', _0: x, _1: y};
				}),
			_p3._0,
			_elm_lang$core$Task$sequence(_p3._1));
	}
};
var _elm_lang$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			_elm_lang$core$Task$map,
			function (_p4) {
				return {ctor: '_Tuple0'};
			},
			_elm_lang$core$Task$sequence(
				A2(
					_elm_lang$core$List$map,
					_elm_lang$core$Task$spawnCmd(router),
					commands)));
	});
var _elm_lang$core$Task$init = _elm_lang$core$Task$succeed(
	{ctor: '_Tuple0'});
var _elm_lang$core$Task$onSelfMsg = F3(
	function (_p7, _p6, _p5) {
		return _elm_lang$core$Task$succeed(
			{ctor: '_Tuple0'});
	});
var _elm_lang$core$Task$command = _elm_lang$core$Native_Platform.leaf('Task');
var _elm_lang$core$Task$Perform = function (a) {
	return {ctor: 'Perform', _0: a};
};
var _elm_lang$core$Task$perform = F2(
	function (toMessage, task) {
		return _elm_lang$core$Task$command(
			_elm_lang$core$Task$Perform(
				A2(_elm_lang$core$Task$map, toMessage, task)));
	});
var _elm_lang$core$Task$attempt = F2(
	function (resultToMessage, task) {
		return _elm_lang$core$Task$command(
			_elm_lang$core$Task$Perform(
				A2(
					_elm_lang$core$Task$onError,
					function (_p8) {
						return _elm_lang$core$Task$succeed(
							resultToMessage(
								_elm_lang$core$Result$Err(_p8)));
					},
					A2(
						_elm_lang$core$Task$andThen,
						function (_p9) {
							return _elm_lang$core$Task$succeed(
								resultToMessage(
									_elm_lang$core$Result$Ok(_p9)));
						},
						task))));
	});
var _elm_lang$core$Task$cmdMap = F2(
	function (tagger, _p10) {
		var _p11 = _p10;
		return _elm_lang$core$Task$Perform(
			A2(_elm_lang$core$Task$map, tagger, _p11._0));
	});
_elm_lang$core$Native_Platform.effectManagers['Task'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Task$init, onEffects: _elm_lang$core$Task$onEffects, onSelfMsg: _elm_lang$core$Task$onSelfMsg, tag: 'cmd', cmdMap: _elm_lang$core$Task$cmdMap};

//import Native.Scheduler //

var _elm_lang$core$Native_Time = function() {

var now = _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
{
	callback(_elm_lang$core$Native_Scheduler.succeed(Date.now()));
});

function setInterval_(interval, task)
{
	return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback)
	{
		var id = setInterval(function() {
			_elm_lang$core$Native_Scheduler.rawSpawn(task);
		}, interval);

		return function() { clearInterval(id); };
	});
}

return {
	now: now,
	setInterval_: F2(setInterval_)
};

}();
var _elm_lang$core$Time$setInterval = _elm_lang$core$Native_Time.setInterval_;
var _elm_lang$core$Time$spawnHelp = F3(
	function (router, intervals, processes) {
		var _p0 = intervals;
		if (_p0.ctor === '[]') {
			return _elm_lang$core$Task$succeed(processes);
		} else {
			var _p1 = _p0._0;
			var spawnRest = function (id) {
				return A3(
					_elm_lang$core$Time$spawnHelp,
					router,
					_p0._1,
					A3(_elm_lang$core$Dict$insert, _p1, id, processes));
			};
			var spawnTimer = _elm_lang$core$Native_Scheduler.spawn(
				A2(
					_elm_lang$core$Time$setInterval,
					_p1,
					A2(_elm_lang$core$Platform$sendToSelf, router, _p1)));
			return A2(_elm_lang$core$Task$andThen, spawnRest, spawnTimer);
		}
	});
var _elm_lang$core$Time$addMySub = F2(
	function (_p2, state) {
		var _p3 = _p2;
		var _p6 = _p3._1;
		var _p5 = _p3._0;
		var _p4 = A2(_elm_lang$core$Dict$get, _p5, state);
		if (_p4.ctor === 'Nothing') {
			return A3(
				_elm_lang$core$Dict$insert,
				_p5,
				{
					ctor: '::',
					_0: _p6,
					_1: {ctor: '[]'}
				},
				state);
		} else {
			return A3(
				_elm_lang$core$Dict$insert,
				_p5,
				{ctor: '::', _0: _p6, _1: _p4._0},
				state);
		}
	});
var _elm_lang$core$Time$inMilliseconds = function (t) {
	return t;
};
var _elm_lang$core$Time$millisecond = 1;
var _elm_lang$core$Time$second = 1000 * _elm_lang$core$Time$millisecond;
var _elm_lang$core$Time$minute = 60 * _elm_lang$core$Time$second;
var _elm_lang$core$Time$hour = 60 * _elm_lang$core$Time$minute;
var _elm_lang$core$Time$inHours = function (t) {
	return t / _elm_lang$core$Time$hour;
};
var _elm_lang$core$Time$inMinutes = function (t) {
	return t / _elm_lang$core$Time$minute;
};
var _elm_lang$core$Time$inSeconds = function (t) {
	return t / _elm_lang$core$Time$second;
};
var _elm_lang$core$Time$now = _elm_lang$core$Native_Time.now;
var _elm_lang$core$Time$onSelfMsg = F3(
	function (router, interval, state) {
		var _p7 = A2(_elm_lang$core$Dict$get, interval, state.taggers);
		if (_p7.ctor === 'Nothing') {
			return _elm_lang$core$Task$succeed(state);
		} else {
			var tellTaggers = function (time) {
				return _elm_lang$core$Task$sequence(
					A2(
						_elm_lang$core$List$map,
						function (tagger) {
							return A2(
								_elm_lang$core$Platform$sendToApp,
								router,
								tagger(time));
						},
						_p7._0));
			};
			return A2(
				_elm_lang$core$Task$andThen,
				function (_p8) {
					return _elm_lang$core$Task$succeed(state);
				},
				A2(_elm_lang$core$Task$andThen, tellTaggers, _elm_lang$core$Time$now));
		}
	});
var _elm_lang$core$Time$subscription = _elm_lang$core$Native_Platform.leaf('Time');
var _elm_lang$core$Time$State = F2(
	function (a, b) {
		return {taggers: a, processes: b};
	});
var _elm_lang$core$Time$init = _elm_lang$core$Task$succeed(
	A2(_elm_lang$core$Time$State, _elm_lang$core$Dict$empty, _elm_lang$core$Dict$empty));
var _elm_lang$core$Time$onEffects = F3(
	function (router, subs, _p9) {
		var _p10 = _p9;
		var rightStep = F3(
			function (_p12, id, _p11) {
				var _p13 = _p11;
				return {
					ctor: '_Tuple3',
					_0: _p13._0,
					_1: _p13._1,
					_2: A2(
						_elm_lang$core$Task$andThen,
						function (_p14) {
							return _p13._2;
						},
						_elm_lang$core$Native_Scheduler.kill(id))
				};
			});
		var bothStep = F4(
			function (interval, taggers, id, _p15) {
				var _p16 = _p15;
				return {
					ctor: '_Tuple3',
					_0: _p16._0,
					_1: A3(_elm_lang$core$Dict$insert, interval, id, _p16._1),
					_2: _p16._2
				};
			});
		var leftStep = F3(
			function (interval, taggers, _p17) {
				var _p18 = _p17;
				return {
					ctor: '_Tuple3',
					_0: {ctor: '::', _0: interval, _1: _p18._0},
					_1: _p18._1,
					_2: _p18._2
				};
			});
		var newTaggers = A3(_elm_lang$core$List$foldl, _elm_lang$core$Time$addMySub, _elm_lang$core$Dict$empty, subs);
		var _p19 = A6(
			_elm_lang$core$Dict$merge,
			leftStep,
			bothStep,
			rightStep,
			newTaggers,
			_p10.processes,
			{
				ctor: '_Tuple3',
				_0: {ctor: '[]'},
				_1: _elm_lang$core$Dict$empty,
				_2: _elm_lang$core$Task$succeed(
					{ctor: '_Tuple0'})
			});
		var spawnList = _p19._0;
		var existingDict = _p19._1;
		var killTask = _p19._2;
		return A2(
			_elm_lang$core$Task$andThen,
			function (newProcesses) {
				return _elm_lang$core$Task$succeed(
					A2(_elm_lang$core$Time$State, newTaggers, newProcesses));
			},
			A2(
				_elm_lang$core$Task$andThen,
				function (_p20) {
					return A3(_elm_lang$core$Time$spawnHelp, router, spawnList, existingDict);
				},
				killTask));
	});
var _elm_lang$core$Time$Every = F2(
	function (a, b) {
		return {ctor: 'Every', _0: a, _1: b};
	});
var _elm_lang$core$Time$every = F2(
	function (interval, tagger) {
		return _elm_lang$core$Time$subscription(
			A2(_elm_lang$core$Time$Every, interval, tagger));
	});
var _elm_lang$core$Time$subMap = F2(
	function (f, _p21) {
		var _p22 = _p21;
		return A2(
			_elm_lang$core$Time$Every,
			_p22._0,
			function (_p23) {
				return f(
					_p22._1(_p23));
			});
	});
_elm_lang$core$Native_Platform.effectManagers['Time'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Time$init, onEffects: _elm_lang$core$Time$onEffects, onSelfMsg: _elm_lang$core$Time$onSelfMsg, tag: 'sub', subMap: _elm_lang$core$Time$subMap};

var _mgold$elm_random_pcg$Random_Pcg$toJson = function (_p0) {
	var _p1 = _p0;
	return _elm_lang$core$Json_Encode$list(
		{
			ctor: '::',
			_0: _elm_lang$core$Json_Encode$int(_p1._0),
			_1: {
				ctor: '::',
				_0: _elm_lang$core$Json_Encode$int(_p1._1),
				_1: {ctor: '[]'}
			}
		});
};
var _mgold$elm_random_pcg$Random_Pcg$mul32 = F2(
	function (a, b) {
		var bl = b & 65535;
		var bh = 65535 & (b >>> 16);
		var al = a & 65535;
		var ah = 65535 & (a >>> 16);
		return 0 | ((al * bl) + ((((ah * bl) + (al * bh)) << 16) >>> 0));
	});
var _mgold$elm_random_pcg$Random_Pcg$listHelp = F4(
	function (list, n, generate, seed) {
		listHelp:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 1) < 0) {
				return {ctor: '_Tuple2', _0: list, _1: seed};
			} else {
				var _p2 = generate(seed);
				var value = _p2._0;
				var newSeed = _p2._1;
				var _v1 = {ctor: '::', _0: value, _1: list},
					_v2 = n - 1,
					_v3 = generate,
					_v4 = newSeed;
				list = _v1;
				n = _v2;
				generate = _v3;
				seed = _v4;
				continue listHelp;
			}
		}
	});
var _mgold$elm_random_pcg$Random_Pcg$minInt = -2147483648;
var _mgold$elm_random_pcg$Random_Pcg$maxInt = 2147483647;
var _mgold$elm_random_pcg$Random_Pcg$bit27 = 1.34217728e8;
var _mgold$elm_random_pcg$Random_Pcg$bit53 = 9.007199254740992e15;
var _mgold$elm_random_pcg$Random_Pcg$peel = function (_p3) {
	var _p4 = _p3;
	var _p5 = _p4._0;
	var word = (_p5 ^ (_p5 >>> ((_p5 >>> 28) + 4))) * 277803737;
	return ((word >>> 22) ^ word) >>> 0;
};
var _mgold$elm_random_pcg$Random_Pcg$step = F2(
	function (_p6, seed) {
		var _p7 = _p6;
		return _p7._0(seed);
	});
var _mgold$elm_random_pcg$Random_Pcg$retry = F3(
	function (generator, predicate, seed) {
		retry:
		while (true) {
			var _p8 = A2(_mgold$elm_random_pcg$Random_Pcg$step, generator, seed);
			var candidate = _p8._0;
			var newSeed = _p8._1;
			if (predicate(candidate)) {
				return {ctor: '_Tuple2', _0: candidate, _1: newSeed};
			} else {
				var _v7 = generator,
					_v8 = predicate,
					_v9 = newSeed;
				generator = _v7;
				predicate = _v8;
				seed = _v9;
				continue retry;
			}
		}
	});
var _mgold$elm_random_pcg$Random_Pcg$Generator = function (a) {
	return {ctor: 'Generator', _0: a};
};
var _mgold$elm_random_pcg$Random_Pcg$list = F2(
	function (n, _p9) {
		var _p10 = _p9;
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed) {
				return A4(
					_mgold$elm_random_pcg$Random_Pcg$listHelp,
					{ctor: '[]'},
					n,
					_p10._0,
					seed);
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$constant = function (value) {
	return _mgold$elm_random_pcg$Random_Pcg$Generator(
		function (seed) {
			return {ctor: '_Tuple2', _0: value, _1: seed};
		});
};
var _mgold$elm_random_pcg$Random_Pcg$map = F2(
	function (func, _p11) {
		var _p12 = _p11;
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed0) {
				var _p13 = _p12._0(seed0);
				var a = _p13._0;
				var seed1 = _p13._1;
				return {
					ctor: '_Tuple2',
					_0: func(a),
					_1: seed1
				};
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$map2 = F3(
	function (func, _p15, _p14) {
		var _p16 = _p15;
		var _p17 = _p14;
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed0) {
				var _p18 = _p16._0(seed0);
				var a = _p18._0;
				var seed1 = _p18._1;
				var _p19 = _p17._0(seed1);
				var b = _p19._0;
				var seed2 = _p19._1;
				return {
					ctor: '_Tuple2',
					_0: A2(func, a, b),
					_1: seed2
				};
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$pair = F2(
	function (genA, genB) {
		return A3(
			_mgold$elm_random_pcg$Random_Pcg$map2,
			F2(
				function (v0, v1) {
					return {ctor: '_Tuple2', _0: v0, _1: v1};
				}),
			genA,
			genB);
	});
var _mgold$elm_random_pcg$Random_Pcg$andMap = _mgold$elm_random_pcg$Random_Pcg$map2(
	F2(
		function (x, y) {
			return y(x);
		}));
var _mgold$elm_random_pcg$Random_Pcg$map3 = F4(
	function (func, _p22, _p21, _p20) {
		var _p23 = _p22;
		var _p24 = _p21;
		var _p25 = _p20;
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed0) {
				var _p26 = _p23._0(seed0);
				var a = _p26._0;
				var seed1 = _p26._1;
				var _p27 = _p24._0(seed1);
				var b = _p27._0;
				var seed2 = _p27._1;
				var _p28 = _p25._0(seed2);
				var c = _p28._0;
				var seed3 = _p28._1;
				return {
					ctor: '_Tuple2',
					_0: A3(func, a, b, c),
					_1: seed3
				};
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$map4 = F5(
	function (func, _p32, _p31, _p30, _p29) {
		var _p33 = _p32;
		var _p34 = _p31;
		var _p35 = _p30;
		var _p36 = _p29;
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed0) {
				var _p37 = _p33._0(seed0);
				var a = _p37._0;
				var seed1 = _p37._1;
				var _p38 = _p34._0(seed1);
				var b = _p38._0;
				var seed2 = _p38._1;
				var _p39 = _p35._0(seed2);
				var c = _p39._0;
				var seed3 = _p39._1;
				var _p40 = _p36._0(seed3);
				var d = _p40._0;
				var seed4 = _p40._1;
				return {
					ctor: '_Tuple2',
					_0: A4(func, a, b, c, d),
					_1: seed4
				};
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$map5 = F6(
	function (func, _p45, _p44, _p43, _p42, _p41) {
		var _p46 = _p45;
		var _p47 = _p44;
		var _p48 = _p43;
		var _p49 = _p42;
		var _p50 = _p41;
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed0) {
				var _p51 = _p46._0(seed0);
				var a = _p51._0;
				var seed1 = _p51._1;
				var _p52 = _p47._0(seed1);
				var b = _p52._0;
				var seed2 = _p52._1;
				var _p53 = _p48._0(seed2);
				var c = _p53._0;
				var seed3 = _p53._1;
				var _p54 = _p49._0(seed3);
				var d = _p54._0;
				var seed4 = _p54._1;
				var _p55 = _p50._0(seed4);
				var e = _p55._0;
				var seed5 = _p55._1;
				return {
					ctor: '_Tuple2',
					_0: A5(func, a, b, c, d, e),
					_1: seed5
				};
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$andThen = F2(
	function (callback, _p56) {
		var _p57 = _p56;
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed) {
				var _p58 = _p57._0(seed);
				var result = _p58._0;
				var newSeed = _p58._1;
				var _p59 = callback(result);
				var generateB = _p59._0;
				return generateB(newSeed);
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$maybe = F2(
	function (genBool, genA) {
		return A2(
			_mgold$elm_random_pcg$Random_Pcg$andThen,
			function (b) {
				return b ? A2(_mgold$elm_random_pcg$Random_Pcg$map, _elm_lang$core$Maybe$Just, genA) : _mgold$elm_random_pcg$Random_Pcg$constant(_elm_lang$core$Maybe$Nothing);
			},
			genBool);
	});
var _mgold$elm_random_pcg$Random_Pcg$filter = F2(
	function (predicate, generator) {
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			A2(_mgold$elm_random_pcg$Random_Pcg$retry, generator, predicate));
	});
var _mgold$elm_random_pcg$Random_Pcg$Seed = F2(
	function (a, b) {
		return {ctor: 'Seed', _0: a, _1: b};
	});
var _mgold$elm_random_pcg$Random_Pcg$next = function (_p60) {
	var _p61 = _p60;
	var _p62 = _p61._1;
	return A2(_mgold$elm_random_pcg$Random_Pcg$Seed, ((_p61._0 * 1664525) + _p62) >>> 0, _p62);
};
var _mgold$elm_random_pcg$Random_Pcg$initialSeed = function (x) {
	var _p63 = _mgold$elm_random_pcg$Random_Pcg$next(
		A2(_mgold$elm_random_pcg$Random_Pcg$Seed, 0, 1013904223));
	var state1 = _p63._0;
	var incr = _p63._1;
	var state2 = (state1 + x) >>> 0;
	return _mgold$elm_random_pcg$Random_Pcg$next(
		A2(_mgold$elm_random_pcg$Random_Pcg$Seed, state2, incr));
};
var _mgold$elm_random_pcg$Random_Pcg$generate = F2(
	function (toMsg, generator) {
		return A2(
			_elm_lang$core$Task$perform,
			toMsg,
			A2(
				_elm_lang$core$Task$map,
				function (_p64) {
					return _elm_lang$core$Tuple$first(
						A2(
							_mgold$elm_random_pcg$Random_Pcg$step,
							generator,
							_mgold$elm_random_pcg$Random_Pcg$initialSeed(
								_elm_lang$core$Basics$round(_p64))));
				},
				_elm_lang$core$Time$now));
	});
var _mgold$elm_random_pcg$Random_Pcg$int = F2(
	function (a, b) {
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed0) {
				var _p65 = (_elm_lang$core$Native_Utils.cmp(a, b) < 0) ? {ctor: '_Tuple2', _0: a, _1: b} : {ctor: '_Tuple2', _0: b, _1: a};
				var lo = _p65._0;
				var hi = _p65._1;
				var range = (hi - lo) + 1;
				if (_elm_lang$core$Native_Utils.eq((range - 1) & range, 0)) {
					return {
						ctor: '_Tuple2',
						_0: (((range - 1) & _mgold$elm_random_pcg$Random_Pcg$peel(seed0)) >>> 0) + lo,
						_1: _mgold$elm_random_pcg$Random_Pcg$next(seed0)
					};
				} else {
					var threshhold = A2(_elm_lang$core$Basics$rem, (0 - range) >>> 0, range) >>> 0;
					var accountForBias = function (seed) {
						accountForBias:
						while (true) {
							var seedN = _mgold$elm_random_pcg$Random_Pcg$next(seed);
							var x = _mgold$elm_random_pcg$Random_Pcg$peel(seed);
							if (_elm_lang$core$Native_Utils.cmp(x, threshhold) < 0) {
								var _v28 = seedN;
								seed = _v28;
								continue accountForBias;
							} else {
								return {
									ctor: '_Tuple2',
									_0: A2(_elm_lang$core$Basics$rem, x, range) + lo,
									_1: seedN
								};
							}
						}
					};
					return accountForBias(seed0);
				}
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$bool = A2(
	_mgold$elm_random_pcg$Random_Pcg$map,
	F2(
		function (x, y) {
			return _elm_lang$core$Native_Utils.eq(x, y);
		})(1),
	A2(_mgold$elm_random_pcg$Random_Pcg$int, 0, 1));
var _mgold$elm_random_pcg$Random_Pcg$choice = F2(
	function (x, y) {
		return A2(
			_mgold$elm_random_pcg$Random_Pcg$map,
			function (b) {
				return b ? x : y;
			},
			_mgold$elm_random_pcg$Random_Pcg$bool);
	});
var _mgold$elm_random_pcg$Random_Pcg$oneIn = function (n) {
	return A2(
		_mgold$elm_random_pcg$Random_Pcg$map,
		F2(
			function (x, y) {
				return _elm_lang$core$Native_Utils.eq(x, y);
			})(1),
		A2(_mgold$elm_random_pcg$Random_Pcg$int, 1, n));
};
var _mgold$elm_random_pcg$Random_Pcg$sample = function () {
	var find = F2(
		function (k, ys) {
			find:
			while (true) {
				var _p66 = ys;
				if (_p66.ctor === '[]') {
					return _elm_lang$core$Maybe$Nothing;
				} else {
					if (_elm_lang$core$Native_Utils.eq(k, 0)) {
						return _elm_lang$core$Maybe$Just(_p66._0);
					} else {
						var _v30 = k - 1,
							_v31 = _p66._1;
						k = _v30;
						ys = _v31;
						continue find;
					}
				}
			}
		});
	return function (xs) {
		return A2(
			_mgold$elm_random_pcg$Random_Pcg$map,
			function (i) {
				return A2(find, i, xs);
			},
			A2(
				_mgold$elm_random_pcg$Random_Pcg$int,
				0,
				_elm_lang$core$List$length(xs) - 1));
	};
}();
var _mgold$elm_random_pcg$Random_Pcg$float = F2(
	function (min, max) {
		return _mgold$elm_random_pcg$Random_Pcg$Generator(
			function (seed0) {
				var range = _elm_lang$core$Basics$abs(max - min);
				var n0 = _mgold$elm_random_pcg$Random_Pcg$peel(seed0);
				var hi = _elm_lang$core$Basics$toFloat(67108863 & n0) * 1.0;
				var seed1 = _mgold$elm_random_pcg$Random_Pcg$next(seed0);
				var n1 = _mgold$elm_random_pcg$Random_Pcg$peel(seed1);
				var lo = _elm_lang$core$Basics$toFloat(134217727 & n1) * 1.0;
				var val = ((hi * _mgold$elm_random_pcg$Random_Pcg$bit27) + lo) / _mgold$elm_random_pcg$Random_Pcg$bit53;
				var scaled = (val * range) + min;
				return {
					ctor: '_Tuple2',
					_0: scaled,
					_1: _mgold$elm_random_pcg$Random_Pcg$next(seed1)
				};
			});
	});
var _mgold$elm_random_pcg$Random_Pcg$frequency = function (pairs) {
	var pick = F2(
		function (choices, n) {
			pick:
			while (true) {
				var _p67 = choices;
				if ((_p67.ctor === '::') && (_p67._0.ctor === '_Tuple2')) {
					var _p68 = _p67._0._0;
					if (_elm_lang$core$Native_Utils.cmp(n, _p68) < 1) {
						return _p67._0._1;
					} else {
						var _v33 = _p67._1,
							_v34 = n - _p68;
						choices = _v33;
						n = _v34;
						continue pick;
					}
				} else {
					return _elm_lang$core$Native_Utils.crashCase(
						'Random.Pcg',
						{
							start: {line: 677, column: 13},
							end: {line: 685, column: 77}
						},
						_p67)('Empty list passed to Random.Pcg.frequency!');
				}
			}
		});
	var total = _elm_lang$core$List$sum(
		A2(
			_elm_lang$core$List$map,
			function (_p70) {
				return _elm_lang$core$Basics$abs(
					_elm_lang$core$Tuple$first(_p70));
			},
			pairs));
	return A2(
		_mgold$elm_random_pcg$Random_Pcg$andThen,
		pick(pairs),
		A2(_mgold$elm_random_pcg$Random_Pcg$float, 0, total));
};
var _mgold$elm_random_pcg$Random_Pcg$choices = function (gens) {
	return _mgold$elm_random_pcg$Random_Pcg$frequency(
		A2(
			_elm_lang$core$List$map,
			function (g) {
				return {ctor: '_Tuple2', _0: 1, _1: g};
			},
			gens));
};
var _mgold$elm_random_pcg$Random_Pcg$independentSeed = _mgold$elm_random_pcg$Random_Pcg$Generator(
	function (seed0) {
		var gen = A2(_mgold$elm_random_pcg$Random_Pcg$int, 0, -1);
		var _p71 = A2(
			_mgold$elm_random_pcg$Random_Pcg$step,
			A4(
				_mgold$elm_random_pcg$Random_Pcg$map3,
				F3(
					function (v0, v1, v2) {
						return {ctor: '_Tuple3', _0: v0, _1: v1, _2: v2};
					}),
				gen,
				gen,
				gen),
			seed0);
		var state = _p71._0._0;
		var b = _p71._0._1;
		var c = _p71._0._2;
		var seed1 = _p71._1;
		var incr = (1 | (b ^ c)) >>> 0;
		return {
			ctor: '_Tuple2',
			_0: seed1,
			_1: _mgold$elm_random_pcg$Random_Pcg$next(
				A2(_mgold$elm_random_pcg$Random_Pcg$Seed, state, incr))
		};
	});
var _mgold$elm_random_pcg$Random_Pcg$fastForward = F2(
	function (delta0, _p72) {
		var _p73 = _p72;
		var _p76 = _p73._1;
		var helper = F6(
			function (accMult, accPlus, curMult, curPlus, delta, repeat) {
				helper:
				while (true) {
					var newDelta = delta >>> 1;
					var curMult_ = A2(_mgold$elm_random_pcg$Random_Pcg$mul32, curMult, curMult);
					var curPlus_ = A2(_mgold$elm_random_pcg$Random_Pcg$mul32, curMult + 1, curPlus);
					var _p74 = _elm_lang$core$Native_Utils.eq(delta & 1, 1) ? {
						ctor: '_Tuple2',
						_0: A2(_mgold$elm_random_pcg$Random_Pcg$mul32, accMult, curMult),
						_1: (A2(_mgold$elm_random_pcg$Random_Pcg$mul32, accPlus, curMult) + curPlus) >>> 0
					} : {ctor: '_Tuple2', _0: accMult, _1: accPlus};
					var accMult_ = _p74._0;
					var accPlus_ = _p74._1;
					if (_elm_lang$core$Native_Utils.eq(newDelta, 0)) {
						if ((_elm_lang$core$Native_Utils.cmp(delta0, 0) < 0) && repeat) {
							var _v36 = accMult_,
								_v37 = accPlus_,
								_v38 = curMult_,
								_v39 = curPlus_,
								_v40 = -1,
								_v41 = false;
							accMult = _v36;
							accPlus = _v37;
							curMult = _v38;
							curPlus = _v39;
							delta = _v40;
							repeat = _v41;
							continue helper;
						} else {
							return {ctor: '_Tuple2', _0: accMult_, _1: accPlus_};
						}
					} else {
						var _v42 = accMult_,
							_v43 = accPlus_,
							_v44 = curMult_,
							_v45 = curPlus_,
							_v46 = newDelta,
							_v47 = repeat;
						accMult = _v42;
						accPlus = _v43;
						curMult = _v44;
						curPlus = _v45;
						delta = _v46;
						repeat = _v47;
						continue helper;
					}
				}
			});
		var _p75 = A6(helper, 1, 0, 1664525, _p76, delta0, true);
		var accMultFinal = _p75._0;
		var accPlusFinal = _p75._1;
		return A2(
			_mgold$elm_random_pcg$Random_Pcg$Seed,
			(A2(_mgold$elm_random_pcg$Random_Pcg$mul32, accMultFinal, _p73._0) + accPlusFinal) >>> 0,
			_p76);
	});
var _mgold$elm_random_pcg$Random_Pcg$fromJson = _elm_lang$core$Json_Decode$oneOf(
	{
		ctor: '::',
		_0: A3(
			_elm_lang$core$Json_Decode$map2,
			_mgold$elm_random_pcg$Random_Pcg$Seed,
			A2(_elm_lang$core$Json_Decode$index, 0, _elm_lang$core$Json_Decode$int),
			A2(_elm_lang$core$Json_Decode$index, 1, _elm_lang$core$Json_Decode$int)),
		_1: {
			ctor: '::',
			_0: A2(_elm_lang$core$Json_Decode$map, _mgold$elm_random_pcg$Random_Pcg$initialSeed, _elm_lang$core$Json_Decode$int),
			_1: {ctor: '[]'}
		}
	});

var _danyx23$elm_uuid$Uuid_Barebones$hexGenerator = A2(_mgold$elm_random_pcg$Random_Pcg$int, 0, 15);
var _danyx23$elm_uuid$Uuid_Barebones$hexDigits = function () {
	var mapChars = F2(
		function (offset, digit) {
			return _elm_lang$core$Char$fromCode(digit + offset);
		});
	return _elm_lang$core$Array$fromList(
		A2(
			_elm_lang$core$Basics_ops['++'],
			A2(
				_elm_lang$core$List$map,
				mapChars(48),
				A2(_elm_lang$core$List$range, 0, 9)),
			A2(
				_elm_lang$core$List$map,
				mapChars(97),
				A2(_elm_lang$core$List$range, 0, 5))));
}();
var _danyx23$elm_uuid$Uuid_Barebones$mapToHex = function (index) {
	var maybeResult = A2(_elm_lang$core$Basics$flip, _elm_lang$core$Array$get, _danyx23$elm_uuid$Uuid_Barebones$hexDigits)(index);
	var _p0 = maybeResult;
	if (_p0.ctor === 'Nothing') {
		return _elm_lang$core$Native_Utils.chr('x');
	} else {
		return _p0._0;
	}
};
var _danyx23$elm_uuid$Uuid_Barebones$uuidRegex = _elm_lang$core$Regex$regex('^[0-9A-Fa-f]{8,8}-[0-9A-Fa-f]{4,4}-[1-5][0-9A-Fa-f]{3,3}-[8-9A-Ba-b][0-9A-Fa-f]{3,3}-[0-9A-Fa-f]{12,12}$');
var _danyx23$elm_uuid$Uuid_Barebones$limitDigitRange8ToB = function (digit) {
	return (digit & 3) | 8;
};
var _danyx23$elm_uuid$Uuid_Barebones$toUuidString = function (thirtyOneHexDigits) {
	return _elm_lang$core$String$concat(
		{
			ctor: '::',
			_0: _elm_lang$core$String$fromList(
				A2(
					_elm_lang$core$List$map,
					_danyx23$elm_uuid$Uuid_Barebones$mapToHex,
					A2(_elm_lang$core$List$take, 8, thirtyOneHexDigits))),
			_1: {
				ctor: '::',
				_0: '-',
				_1: {
					ctor: '::',
					_0: _elm_lang$core$String$fromList(
						A2(
							_elm_lang$core$List$map,
							_danyx23$elm_uuid$Uuid_Barebones$mapToHex,
							A2(
								_elm_lang$core$List$take,
								4,
								A2(_elm_lang$core$List$drop, 8, thirtyOneHexDigits)))),
					_1: {
						ctor: '::',
						_0: '-',
						_1: {
							ctor: '::',
							_0: '4',
							_1: {
								ctor: '::',
								_0: _elm_lang$core$String$fromList(
									A2(
										_elm_lang$core$List$map,
										_danyx23$elm_uuid$Uuid_Barebones$mapToHex,
										A2(
											_elm_lang$core$List$take,
											3,
											A2(_elm_lang$core$List$drop, 12, thirtyOneHexDigits)))),
								_1: {
									ctor: '::',
									_0: '-',
									_1: {
										ctor: '::',
										_0: _elm_lang$core$String$fromList(
											A2(
												_elm_lang$core$List$map,
												_danyx23$elm_uuid$Uuid_Barebones$mapToHex,
												A2(
													_elm_lang$core$List$map,
													_danyx23$elm_uuid$Uuid_Barebones$limitDigitRange8ToB,
													A2(
														_elm_lang$core$List$take,
														1,
														A2(_elm_lang$core$List$drop, 15, thirtyOneHexDigits))))),
										_1: {
											ctor: '::',
											_0: _elm_lang$core$String$fromList(
												A2(
													_elm_lang$core$List$map,
													_danyx23$elm_uuid$Uuid_Barebones$mapToHex,
													A2(
														_elm_lang$core$List$take,
														3,
														A2(_elm_lang$core$List$drop, 16, thirtyOneHexDigits)))),
											_1: {
												ctor: '::',
												_0: '-',
												_1: {
													ctor: '::',
													_0: _elm_lang$core$String$fromList(
														A2(
															_elm_lang$core$List$map,
															_danyx23$elm_uuid$Uuid_Barebones$mapToHex,
															A2(
																_elm_lang$core$List$take,
																12,
																A2(_elm_lang$core$List$drop, 19, thirtyOneHexDigits)))),
													_1: {ctor: '[]'}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		});
};
var _danyx23$elm_uuid$Uuid_Barebones$isValidUuid = function (uuidAsString) {
	return A2(_elm_lang$core$Regex$contains, _danyx23$elm_uuid$Uuid_Barebones$uuidRegex, uuidAsString);
};
var _danyx23$elm_uuid$Uuid_Barebones$uuidStringGenerator = A2(
	_mgold$elm_random_pcg$Random_Pcg$map,
	_danyx23$elm_uuid$Uuid_Barebones$toUuidString,
	A2(_mgold$elm_random_pcg$Random_Pcg$list, 31, _danyx23$elm_uuid$Uuid_Barebones$hexGenerator));

var _danyx23$elm_uuid$Uuid$toString = function (_p0) {
	var _p1 = _p0;
	return _p1._0;
};
var _danyx23$elm_uuid$Uuid$encode = function (_p2) {
	return _elm_lang$core$Json_Encode$string(
		_danyx23$elm_uuid$Uuid$toString(_p2));
};
var _danyx23$elm_uuid$Uuid$Uuid = function (a) {
	return {ctor: 'Uuid', _0: a};
};
var _danyx23$elm_uuid$Uuid$fromString = function (text) {
	return _danyx23$elm_uuid$Uuid_Barebones$isValidUuid(text) ? _elm_lang$core$Maybe$Just(
		_danyx23$elm_uuid$Uuid$Uuid(
			_elm_lang$core$String$toLower(text))) : _elm_lang$core$Maybe$Nothing;
};
var _danyx23$elm_uuid$Uuid$decoder = A2(
	_elm_lang$core$Json_Decode$andThen,
	function (string) {
		var _p3 = _danyx23$elm_uuid$Uuid$fromString(string);
		if (_p3.ctor === 'Just') {
			return _elm_lang$core$Json_Decode$succeed(_p3._0);
		} else {
			return _elm_lang$core$Json_Decode$fail('Not a valid UUID');
		}
	},
	_elm_lang$core$Json_Decode$string);
var _danyx23$elm_uuid$Uuid$uuidGenerator = A2(_mgold$elm_random_pcg$Random_Pcg$map, _danyx23$elm_uuid$Uuid$Uuid, _danyx23$elm_uuid$Uuid_Barebones$uuidStringGenerator);

var _eeue56$elm_all_dict$EveryDict$foldr = F3(
	function (f, acc, t) {
		foldr:
		while (true) {
			var _p0 = t;
			if (_p0.ctor === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var _v1 = f,
					_v2 = A3(
					f,
					_p0._1,
					_p0._2,
					A3(_eeue56$elm_all_dict$EveryDict$foldr, f, acc, _p0._4)),
					_v3 = _p0._3;
				f = _v1;
				acc = _v2;
				t = _v3;
				continue foldr;
			}
		}
	});
var _eeue56$elm_all_dict$EveryDict$keys = function (dict) {
	return A3(
		_eeue56$elm_all_dict$EveryDict$foldr,
		F3(
			function (key, value, keyList) {
				return {ctor: '::', _0: key, _1: keyList};
			}),
		{ctor: '[]'},
		dict);
};
var _eeue56$elm_all_dict$EveryDict$values = function (dict) {
	return A3(
		_eeue56$elm_all_dict$EveryDict$foldr,
		F3(
			function (key, value, valueList) {
				return {ctor: '::', _0: value, _1: valueList};
			}),
		{ctor: '[]'},
		dict);
};
var _eeue56$elm_all_dict$EveryDict$toList = function (dict) {
	return A3(
		_eeue56$elm_all_dict$EveryDict$foldr,
		F3(
			function (key, value, list) {
				return {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: key, _1: value},
					_1: list
				};
			}),
		{ctor: '[]'},
		dict);
};
var _eeue56$elm_all_dict$EveryDict$foldl = F3(
	function (f, acc, dict) {
		foldl:
		while (true) {
			var _p1 = dict;
			if (_p1.ctor === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var _v5 = f,
					_v6 = A3(
					f,
					_p1._1,
					_p1._2,
					A3(_eeue56$elm_all_dict$EveryDict$foldl, f, acc, _p1._3)),
					_v7 = _p1._4;
				f = _v5;
				acc = _v6;
				dict = _v7;
				continue foldl;
			}
		}
	});
var _eeue56$elm_all_dict$EveryDict$isBBlack = function (dict) {
	var _p2 = dict;
	_v8_2:
	do {
		if (_p2.ctor === 'RBNode_elm_builtin') {
			if (_p2._0.ctor === 'BBlack') {
				return true;
			} else {
				break _v8_2;
			}
		} else {
			if (_p2._0.ctor === 'LBBlack') {
				return true;
			} else {
				break _v8_2;
			}
		}
	} while(false);
	return false;
};
var _eeue56$elm_all_dict$EveryDict$showFlag = function (f) {
	var _p3 = f;
	switch (_p3.ctor) {
		case 'Insert':
			return 'Insert';
		case 'Remove':
			return 'Remove';
		default:
			return 'Same';
	}
};
var _eeue56$elm_all_dict$EveryDict$sizeHelp = F2(
	function (n, dict) {
		sizeHelp:
		while (true) {
			var _p4 = dict;
			if (_p4.ctor === 'RBEmpty_elm_builtin') {
				return n;
			} else {
				var _v11 = A2(_eeue56$elm_all_dict$EveryDict$sizeHelp, n + 1, _p4._4),
					_v12 = _p4._3;
				n = _v11;
				dict = _v12;
				continue sizeHelp;
			}
		}
	});
var _eeue56$elm_all_dict$EveryDict$size = function (dict) {
	return A2(_eeue56$elm_all_dict$EveryDict$sizeHelp, 0, dict);
};
var _eeue56$elm_all_dict$EveryDict$isEmpty = function (dict) {
	var _p5 = dict;
	if (_p5.ctor === 'RBEmpty_elm_builtin') {
		return true;
	} else {
		return false;
	}
};
var _eeue56$elm_all_dict$EveryDict$max = function (dict) {
	max:
	while (true) {
		var _p6 = dict;
		if (_p6.ctor === 'RBNode_elm_builtin') {
			if (_p6._4.ctor === 'RBEmpty_elm_builtin') {
				return {ctor: '_Tuple2', _0: _p6._1, _1: _p6._2};
			} else {
				var _v15 = _p6._4;
				dict = _v15;
				continue max;
			}
		} else {
			return _elm_lang$core$Native_Utils.crashCase(
				'EveryDict',
				{
					start: {line: 127, column: 5},
					end: {line: 135, column: 51}
				},
				_p6)('(max Empty) is not defined');
		}
	}
};
var _eeue56$elm_all_dict$EveryDict$min = function (dict) {
	min:
	while (true) {
		var _p8 = dict;
		if (_p8.ctor === 'RBNode_elm_builtin') {
			if ((_p8._3.ctor === 'RBEmpty_elm_builtin') && (_p8._3._0.ctor === 'LBlack')) {
				return {ctor: '_Tuple2', _0: _p8._1, _1: _p8._2};
			} else {
				var _v17 = _p8._3;
				dict = _v17;
				continue min;
			}
		} else {
			return _elm_lang$core$Native_Utils.crashCase(
				'EveryDict',
				{
					start: {line: 115, column: 5},
					end: {line: 123, column: 51}
				},
				_p8)('(min Empty) is not defined');
		}
	}
};
var _eeue56$elm_all_dict$EveryDict$eq = F2(
	function (first, second) {
		return _elm_lang$core$Native_Utils.eq(
			_eeue56$elm_all_dict$EveryDict$toList(first),
			_eeue56$elm_all_dict$EveryDict$toList(second));
	});
var _eeue56$elm_all_dict$EveryDict$ord = _elm_lang$core$Basics$toString;
var _eeue56$elm_all_dict$EveryDict$get_ = F2(
	function (targetKey, dict) {
		get_:
		while (true) {
			var _p10 = dict;
			if (_p10.ctor === 'RBEmpty_elm_builtin') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				var _p11 = A2(
					_elm_lang$core$Basics$compare,
					_eeue56$elm_all_dict$EveryDict$ord(targetKey),
					_eeue56$elm_all_dict$EveryDict$ord(_p10._1));
				switch (_p11.ctor) {
					case 'LT':
						var _v20 = targetKey,
							_v21 = _p10._3;
						targetKey = _v20;
						dict = _v21;
						continue get_;
					case 'EQ':
						return _elm_lang$core$Maybe$Just(_p10._2);
					default:
						var _v22 = targetKey,
							_v23 = _p10._4;
						targetKey = _v22;
						dict = _v23;
						continue get_;
				}
			}
		}
	});
var _eeue56$elm_all_dict$EveryDict$get = F2(
	function (targetKey, dict) {
		return A2(_eeue56$elm_all_dict$EveryDict$get_, targetKey, dict);
	});
var _eeue56$elm_all_dict$EveryDict$member = F2(
	function (key, dict) {
		var _p12 = A2(_eeue56$elm_all_dict$EveryDict$get_, key, dict);
		if (_p12.ctor === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var _eeue56$elm_all_dict$EveryDict$showLColor = function (color) {
	var _p13 = color;
	if (_p13.ctor === 'LBlack') {
		return 'LBlack';
	} else {
		return 'LBBlack';
	}
};
var _eeue56$elm_all_dict$EveryDict$showNColor = function (c) {
	var _p14 = c;
	switch (_p14.ctor) {
		case 'Red':
			return 'Red';
		case 'Black':
			return 'Black';
		case 'BBlack':
			return 'BBlack';
		default:
			return 'NBlack';
	}
};
var _eeue56$elm_all_dict$EveryDict$reportRemBug = F4(
	function (msg, c, lgot, rgot) {
		return _elm_lang$core$Native_Utils.crash(
			'EveryDict',
			{
				start: {line: 320, column: 3},
				end: {line: 320, column: 14}
			})(
			_elm_lang$core$String$concat(
				{
					ctor: '::',
					_0: 'Internal red-black tree invariant violated, expected ',
					_1: {
						ctor: '::',
						_0: msg,
						_1: {
							ctor: '::',
							_0: ' and got ',
							_1: {
								ctor: '::',
								_0: _eeue56$elm_all_dict$EveryDict$showNColor(c),
								_1: {
									ctor: '::',
									_0: '/',
									_1: {
										ctor: '::',
										_0: lgot,
										_1: {
											ctor: '::',
											_0: '/',
											_1: {
												ctor: '::',
												_0: rgot,
												_1: {
													ctor: '::',
													_0: '\nPlease report this bug to <https://github.com/elm-lang/Elm/issues>',
													_1: {ctor: '[]'}
												}
											}
										}
									}
								}
							}
						}
					}
				}));
	});
var _eeue56$elm_all_dict$EveryDict$NBlack = {ctor: 'NBlack'};
var _eeue56$elm_all_dict$EveryDict$BBlack = {ctor: 'BBlack'};
var _eeue56$elm_all_dict$EveryDict$Black = {ctor: 'Black'};
var _eeue56$elm_all_dict$EveryDict$blackish = function (t) {
	var _p15 = t;
	if (_p15.ctor === 'RBNode_elm_builtin') {
		var _p16 = _p15._0;
		return _elm_lang$core$Native_Utils.eq(_p16, _eeue56$elm_all_dict$EveryDict$Black) || _elm_lang$core$Native_Utils.eq(_p16, _eeue56$elm_all_dict$EveryDict$BBlack);
	} else {
		return true;
	}
};
var _eeue56$elm_all_dict$EveryDict$Red = {ctor: 'Red'};
var _eeue56$elm_all_dict$EveryDict$moreBlack = function (color) {
	var _p17 = color;
	switch (_p17.ctor) {
		case 'Black':
			return _eeue56$elm_all_dict$EveryDict$BBlack;
		case 'Red':
			return _eeue56$elm_all_dict$EveryDict$Black;
		case 'NBlack':
			return _eeue56$elm_all_dict$EveryDict$Red;
		default:
			return _elm_lang$core$Native_Utils.crashCase(
				'EveryDict',
				{
					start: {line: 294, column: 5},
					end: {line: 298, column: 73}
				},
				_p17)('Can\'t make a double black node more black!');
	}
};
var _eeue56$elm_all_dict$EveryDict$lessBlack = function (color) {
	var _p19 = color;
	switch (_p19.ctor) {
		case 'BBlack':
			return _eeue56$elm_all_dict$EveryDict$Black;
		case 'Black':
			return _eeue56$elm_all_dict$EveryDict$Red;
		case 'Red':
			return _eeue56$elm_all_dict$EveryDict$NBlack;
		default:
			return _elm_lang$core$Native_Utils.crashCase(
				'EveryDict',
				{
					start: {line: 303, column: 5},
					end: {line: 307, column: 75}
				},
				_p19)('Can\'t make a negative black node less black!');
	}
};
var _eeue56$elm_all_dict$EveryDict$LBBlack = {ctor: 'LBBlack'};
var _eeue56$elm_all_dict$EveryDict$LBlack = {ctor: 'LBlack'};
var _eeue56$elm_all_dict$EveryDict$RBEmpty_elm_builtin = function (a) {
	return {ctor: 'RBEmpty_elm_builtin', _0: a};
};
var _eeue56$elm_all_dict$EveryDict$empty = _eeue56$elm_all_dict$EveryDict$RBEmpty_elm_builtin(_eeue56$elm_all_dict$EveryDict$LBlack);
var _eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {ctor: 'RBNode_elm_builtin', _0: a, _1: b, _2: c, _3: d, _4: e};
	});
var _eeue56$elm_all_dict$EveryDict$ensureBlackRoot = function (dict) {
	var _p21 = dict;
	if (_p21.ctor === 'RBNode_elm_builtin') {
		switch (_p21._0.ctor) {
			case 'Red':
				return A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, _p21._1, _p21._2, _p21._3, _p21._4);
			case 'Black':
				return dict;
			default:
				return dict;
		}
	} else {
		return dict;
	}
};
var _eeue56$elm_all_dict$EveryDict$lessBlackTree = function (dict) {
	var _p22 = dict;
	if (_p22.ctor === 'RBNode_elm_builtin') {
		return A5(
			_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin,
			_eeue56$elm_all_dict$EveryDict$lessBlack(_p22._0),
			_p22._1,
			_p22._2,
			_p22._3,
			_p22._4);
	} else {
		if (_p22._0.ctor === 'LBBlack') {
			return _eeue56$elm_all_dict$EveryDict$RBEmpty_elm_builtin(_eeue56$elm_all_dict$EveryDict$LBlack);
		} else {
			return dict;
		}
	}
};
var _eeue56$elm_all_dict$EveryDict$blacken = function (t) {
	var _p23 = t;
	if (_p23.ctor === 'RBEmpty_elm_builtin') {
		return _eeue56$elm_all_dict$EveryDict$RBEmpty_elm_builtin(_eeue56$elm_all_dict$EveryDict$LBlack);
	} else {
		return A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, _p23._1, _p23._2, _p23._3, _p23._4);
	}
};
var _eeue56$elm_all_dict$EveryDict$redden = function (t) {
	var _p24 = t;
	if (_p24.ctor === 'RBEmpty_elm_builtin') {
		return _elm_lang$core$Native_Utils.crashCase(
			'EveryDict',
			{
				start: {line: 440, column: 5},
				end: {line: 442, column: 69}
			},
			_p24)('can\'t make a Leaf red');
	} else {
		return A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Red, _p24._1, _p24._2, _p24._3, _p24._4);
	}
};
var _eeue56$elm_all_dict$EveryDict$balance_node = function (t) {
	var assemble = function (col) {
		return function (xk) {
			return function (xv) {
				return function (yk) {
					return function (yv) {
						return function (zk) {
							return function (zv) {
								return function (a) {
									return function (b) {
										return function (c) {
											return function (d) {
												return A5(
													_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin,
													_eeue56$elm_all_dict$EveryDict$lessBlack(col),
													yk,
													yv,
													A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, xk, xv, a, b),
													A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, zk, zv, c, d));
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
	if (_eeue56$elm_all_dict$EveryDict$blackish(t)) {
		var _p26 = t;
		_v34_6:
		do {
			_v34_5:
			do {
				_v34_4:
				do {
					_v34_3:
					do {
						_v34_2:
						do {
							_v34_1:
							do {
								_v34_0:
								do {
									if (_p26.ctor === 'RBNode_elm_builtin') {
										if (_p26._3.ctor === 'RBNode_elm_builtin') {
											if (_p26._4.ctor === 'RBNode_elm_builtin') {
												switch (_p26._3._0.ctor) {
													case 'Red':
														switch (_p26._4._0.ctor) {
															case 'Red':
																if ((_p26._3._3.ctor === 'RBNode_elm_builtin') && (_p26._3._3._0.ctor === 'Red')) {
																	break _v34_0;
																} else {
																	if ((_p26._3._4.ctor === 'RBNode_elm_builtin') && (_p26._3._4._0.ctor === 'Red')) {
																		break _v34_1;
																	} else {
																		if ((_p26._4._3.ctor === 'RBNode_elm_builtin') && (_p26._4._3._0.ctor === 'Red')) {
																			break _v34_2;
																		} else {
																			if ((_p26._4._4.ctor === 'RBNode_elm_builtin') && (_p26._4._4._0.ctor === 'Red')) {
																				break _v34_3;
																			} else {
																				break _v34_6;
																			}
																		}
																	}
																}
															case 'NBlack':
																if ((_p26._3._3.ctor === 'RBNode_elm_builtin') && (_p26._3._3._0.ctor === 'Red')) {
																	break _v34_0;
																} else {
																	if ((_p26._3._4.ctor === 'RBNode_elm_builtin') && (_p26._3._4._0.ctor === 'Red')) {
																		break _v34_1;
																	} else {
																		if (((_p26._0.ctor === 'BBlack') && (_p26._4._3.ctor === 'RBNode_elm_builtin')) && (_p26._4._3._0.ctor === 'Black')) {
																			break _v34_4;
																		} else {
																			break _v34_6;
																		}
																	}
																}
															default:
																if ((_p26._3._3.ctor === 'RBNode_elm_builtin') && (_p26._3._3._0.ctor === 'Red')) {
																	break _v34_0;
																} else {
																	if ((_p26._3._4.ctor === 'RBNode_elm_builtin') && (_p26._3._4._0.ctor === 'Red')) {
																		break _v34_1;
																	} else {
																		break _v34_6;
																	}
																}
														}
													case 'NBlack':
														switch (_p26._4._0.ctor) {
															case 'Red':
																if ((_p26._4._3.ctor === 'RBNode_elm_builtin') && (_p26._4._3._0.ctor === 'Red')) {
																	break _v34_2;
																} else {
																	if ((_p26._4._4.ctor === 'RBNode_elm_builtin') && (_p26._4._4._0.ctor === 'Red')) {
																		break _v34_3;
																	} else {
																		if (((_p26._0.ctor === 'BBlack') && (_p26._3._4.ctor === 'RBNode_elm_builtin')) && (_p26._3._4._0.ctor === 'Black')) {
																			break _v34_5;
																		} else {
																			break _v34_6;
																		}
																	}
																}
															case 'NBlack':
																if (_p26._0.ctor === 'BBlack') {
																	if ((_p26._4._3.ctor === 'RBNode_elm_builtin') && (_p26._4._3._0.ctor === 'Black')) {
																		break _v34_4;
																	} else {
																		if ((_p26._3._4.ctor === 'RBNode_elm_builtin') && (_p26._3._4._0.ctor === 'Black')) {
																			break _v34_5;
																		} else {
																			break _v34_6;
																		}
																	}
																} else {
																	break _v34_6;
																}
															default:
																if (((_p26._0.ctor === 'BBlack') && (_p26._3._4.ctor === 'RBNode_elm_builtin')) && (_p26._3._4._0.ctor === 'Black')) {
																	break _v34_5;
																} else {
																	break _v34_6;
																}
														}
													default:
														switch (_p26._4._0.ctor) {
															case 'Red':
																if ((_p26._4._3.ctor === 'RBNode_elm_builtin') && (_p26._4._3._0.ctor === 'Red')) {
																	break _v34_2;
																} else {
																	if ((_p26._4._4.ctor === 'RBNode_elm_builtin') && (_p26._4._4._0.ctor === 'Red')) {
																		break _v34_3;
																	} else {
																		break _v34_6;
																	}
																}
															case 'NBlack':
																if (((_p26._0.ctor === 'BBlack') && (_p26._4._3.ctor === 'RBNode_elm_builtin')) && (_p26._4._3._0.ctor === 'Black')) {
																	break _v34_4;
																} else {
																	break _v34_6;
																}
															default:
																break _v34_6;
														}
												}
											} else {
												switch (_p26._3._0.ctor) {
													case 'Red':
														if ((_p26._3._3.ctor === 'RBNode_elm_builtin') && (_p26._3._3._0.ctor === 'Red')) {
															break _v34_0;
														} else {
															if ((_p26._3._4.ctor === 'RBNode_elm_builtin') && (_p26._3._4._0.ctor === 'Red')) {
																break _v34_1;
															} else {
																break _v34_6;
															}
														}
													case 'NBlack':
														if (((_p26._0.ctor === 'BBlack') && (_p26._3._4.ctor === 'RBNode_elm_builtin')) && (_p26._3._4._0.ctor === 'Black')) {
															break _v34_5;
														} else {
															break _v34_6;
														}
													default:
														break _v34_6;
												}
											}
										} else {
											if (_p26._4.ctor === 'RBNode_elm_builtin') {
												switch (_p26._4._0.ctor) {
													case 'Red':
														if ((_p26._4._3.ctor === 'RBNode_elm_builtin') && (_p26._4._3._0.ctor === 'Red')) {
															break _v34_2;
														} else {
															if ((_p26._4._4.ctor === 'RBNode_elm_builtin') && (_p26._4._4._0.ctor === 'Red')) {
																break _v34_3;
															} else {
																break _v34_6;
															}
														}
													case 'NBlack':
														if (((_p26._0.ctor === 'BBlack') && (_p26._4._3.ctor === 'RBNode_elm_builtin')) && (_p26._4._3._0.ctor === 'Black')) {
															break _v34_4;
														} else {
															break _v34_6;
														}
													default:
														break _v34_6;
												}
											} else {
												break _v34_6;
											}
										}
									} else {
										break _v34_6;
									}
								} while(false);
								return assemble(_p26._0)(_p26._3._3._1)(_p26._3._3._2)(_p26._3._1)(_p26._3._2)(_p26._1)(_p26._2)(_p26._3._3._3)(_p26._3._3._4)(_p26._3._4)(_p26._4);
							} while(false);
							return assemble(_p26._0)(_p26._3._1)(_p26._3._2)(_p26._3._4._1)(_p26._3._4._2)(_p26._1)(_p26._2)(_p26._3._3)(_p26._3._4._3)(_p26._3._4._4)(_p26._4);
						} while(false);
						return assemble(_p26._0)(_p26._1)(_p26._2)(_p26._4._3._1)(_p26._4._3._2)(_p26._4._1)(_p26._4._2)(_p26._3)(_p26._4._3._3)(_p26._4._3._4)(_p26._4._4);
					} while(false);
					return assemble(_p26._0)(_p26._1)(_p26._2)(_p26._4._1)(_p26._4._2)(_p26._4._4._1)(_p26._4._4._2)(_p26._3)(_p26._4._3)(_p26._4._4._3)(_p26._4._4._4);
				} while(false);
				var _p28 = _p26._4._4;
				var _p27 = _p28;
				if ((_p27.ctor === 'RBNode_elm_builtin') && (_p27._0.ctor === 'Black')) {
					return A5(
						_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin,
						_eeue56$elm_all_dict$EveryDict$Black,
						_p26._4._3._1,
						_p26._4._3._2,
						A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, _p26._1, _p26._2, _p26._3, _p26._4._3._3),
						A5(
							_eeue56$elm_all_dict$EveryDict$balance,
							_eeue56$elm_all_dict$EveryDict$Black,
							_p26._4._1,
							_p26._4._2,
							_p26._4._3._4,
							_eeue56$elm_all_dict$EveryDict$redden(_p28)));
				} else {
					return t;
				}
			} while(false);
			var _p30 = _p26._3._3;
			var _p29 = _p30;
			if ((_p29.ctor === 'RBNode_elm_builtin') && (_p29._0.ctor === 'Black')) {
				return A5(
					_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin,
					_eeue56$elm_all_dict$EveryDict$Black,
					_p26._3._4._1,
					_p26._3._4._2,
					A5(
						_eeue56$elm_all_dict$EveryDict$balance,
						_eeue56$elm_all_dict$EveryDict$Black,
						_p26._3._1,
						_p26._3._2,
						_eeue56$elm_all_dict$EveryDict$redden(_p30),
						_p26._3._4._3),
					A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, _p26._1, _p26._2, _p26._3._4._4, _p26._4));
			} else {
				return t;
			}
		} while(false);
		return t;
	} else {
		return t;
	}
};
var _eeue56$elm_all_dict$EveryDict$balance = F5(
	function (c, k, v, l, r) {
		return _eeue56$elm_all_dict$EveryDict$balance_node(
			A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, c, k, v, l, r));
	});
var _eeue56$elm_all_dict$EveryDict$bubble = F5(
	function (c, k, v, l, r) {
		return (_eeue56$elm_all_dict$EveryDict$isBBlack(l) || _eeue56$elm_all_dict$EveryDict$isBBlack(r)) ? A5(
			_eeue56$elm_all_dict$EveryDict$balance,
			_eeue56$elm_all_dict$EveryDict$moreBlack(c),
			k,
			v,
			_eeue56$elm_all_dict$EveryDict$lessBlackTree(l),
			_eeue56$elm_all_dict$EveryDict$lessBlackTree(r)) : A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, c, k, v, l, r);
	});
var _eeue56$elm_all_dict$EveryDict$remove_max = F5(
	function (c, k, v, l, r) {
		var _p31 = r;
		if (_p31.ctor === 'RBEmpty_elm_builtin') {
			return A3(_eeue56$elm_all_dict$EveryDict$rem, c, l, r);
		} else {
			return A5(
				_eeue56$elm_all_dict$EveryDict$bubble,
				c,
				k,
				v,
				l,
				A5(_eeue56$elm_all_dict$EveryDict$remove_max, _p31._0, _p31._1, _p31._2, _p31._3, _p31._4));
		}
	});
var _eeue56$elm_all_dict$EveryDict$rem = F3(
	function (c, l, r) {
		var _p32 = {ctor: '_Tuple2', _0: l, _1: r};
		if (_p32._0.ctor === 'RBEmpty_elm_builtin') {
			if (_p32._1.ctor === 'RBEmpty_elm_builtin') {
				var _p33 = c;
				switch (_p33.ctor) {
					case 'Red':
						return _eeue56$elm_all_dict$EveryDict$RBEmpty_elm_builtin(_eeue56$elm_all_dict$EveryDict$LBlack);
					case 'Black':
						return _eeue56$elm_all_dict$EveryDict$RBEmpty_elm_builtin(_eeue56$elm_all_dict$EveryDict$LBBlack);
					default:
						return _eeue56$elm_all_dict$Native_Debug.crash('cannot have bblack or nblack nodes at this point');
				}
			} else {
				var _p36 = _p32._1._0;
				var _p35 = _p32._0._0;
				var _p34 = {ctor: '_Tuple3', _0: c, _1: _p35, _2: _p36};
				if ((((_p34.ctor === '_Tuple3') && (_p34._0.ctor === 'Black')) && (_p34._1.ctor === 'LBlack')) && (_p34._2.ctor === 'Red')) {
					return A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, _p32._1._1, _p32._1._2, _p32._1._3, _p32._1._4);
				} else {
					return A4(
						_eeue56$elm_all_dict$EveryDict$reportRemBug,
						'Black/LBlack/Red',
						c,
						_eeue56$elm_all_dict$EveryDict$showLColor(_p35),
						_eeue56$elm_all_dict$EveryDict$showNColor(_p36));
				}
			}
		} else {
			if (_p32._1.ctor === 'RBEmpty_elm_builtin') {
				var _p39 = _p32._1._0;
				var _p38 = _p32._0._0;
				var _p37 = {ctor: '_Tuple3', _0: c, _1: _p38, _2: _p39};
				if ((((_p37.ctor === '_Tuple3') && (_p37._0.ctor === 'Black')) && (_p37._1.ctor === 'Red')) && (_p37._2.ctor === 'LBlack')) {
					return A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Black, _p32._0._1, _p32._0._2, _p32._0._3, _p32._0._4);
				} else {
					return A4(
						_eeue56$elm_all_dict$EveryDict$reportRemBug,
						'Black/Red/LBlack',
						c,
						_eeue56$elm_all_dict$EveryDict$showNColor(_p38),
						_eeue56$elm_all_dict$EveryDict$showLColor(_p39));
				}
			} else {
				var _p45 = _p32._0._2;
				var _p44 = _p32._0._4;
				var _p43 = _p32._0._3;
				var _p42 = _p32._0._1;
				var _p41 = _p32._0._0;
				var l_ = A5(_eeue56$elm_all_dict$EveryDict$remove_max, _p41, _p42, _p45, _p43, _p44);
				var r = A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _p32._1._0, _p32._1._1, _p32._1._2, _p32._1._3, _p32._1._4);
				var l = A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _p41, _p42, _p45, _p43, _p44);
				var _p40 = _eeue56$elm_all_dict$EveryDict$max(l);
				var k = _p40._0;
				var v = _p40._1;
				return A5(_eeue56$elm_all_dict$EveryDict$bubble, c, k, v, l_, r);
			}
		}
	});
var _eeue56$elm_all_dict$EveryDict$map = F2(
	function (f, dict) {
		var _p46 = dict;
		if (_p46.ctor === 'RBEmpty_elm_builtin') {
			return _eeue56$elm_all_dict$EveryDict$RBEmpty_elm_builtin(_p46._0);
		} else {
			var _p47 = _p46._1;
			return A5(
				_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin,
				_p46._0,
				_p47,
				A2(f, _p47, _p46._2),
				A2(_eeue56$elm_all_dict$EveryDict$map, f, _p46._3),
				A2(_eeue56$elm_all_dict$EveryDict$map, f, _p46._4));
		}
	});
var _eeue56$elm_all_dict$EveryDict$Same = {ctor: 'Same'};
var _eeue56$elm_all_dict$EveryDict$Remove = {ctor: 'Remove'};
var _eeue56$elm_all_dict$EveryDict$Insert = {ctor: 'Insert'};
var _eeue56$elm_all_dict$EveryDict$update = F3(
	function (k, alter, dict) {
		var up = function (dict) {
			var _p48 = dict;
			if (_p48.ctor === 'RBEmpty_elm_builtin') {
				var _p49 = alter(_elm_lang$core$Maybe$Nothing);
				if (_p49.ctor === 'Nothing') {
					return {ctor: '_Tuple2', _0: _eeue56$elm_all_dict$EveryDict$Same, _1: _eeue56$elm_all_dict$EveryDict$empty};
				} else {
					return {
						ctor: '_Tuple2',
						_0: _eeue56$elm_all_dict$EveryDict$Insert,
						_1: A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _eeue56$elm_all_dict$EveryDict$Red, k, _p49._0, _eeue56$elm_all_dict$EveryDict$empty, _eeue56$elm_all_dict$EveryDict$empty)
					};
				}
			} else {
				var _p60 = _p48._2;
				var _p59 = _p48._4;
				var _p58 = _p48._3;
				var _p57 = _p48._1;
				var _p56 = _p48._0;
				var _p50 = A2(
					_elm_lang$core$Basics$compare,
					_eeue56$elm_all_dict$EveryDict$ord(k),
					_eeue56$elm_all_dict$EveryDict$ord(_p57));
				switch (_p50.ctor) {
					case 'EQ':
						var _p51 = alter(
							_elm_lang$core$Maybe$Just(_p60));
						if (_p51.ctor === 'Nothing') {
							return {
								ctor: '_Tuple2',
								_0: _eeue56$elm_all_dict$EveryDict$Remove,
								_1: A3(_eeue56$elm_all_dict$EveryDict$rem, _p56, _p58, _p59)
							};
						} else {
							return {
								ctor: '_Tuple2',
								_0: _eeue56$elm_all_dict$EveryDict$Same,
								_1: A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _p56, _p57, _p51._0, _p58, _p59)
							};
						}
					case 'LT':
						var _p52 = up(_p58);
						var flag = _p52._0;
						var newLeft = _p52._1;
						var _p53 = flag;
						switch (_p53.ctor) {
							case 'Same':
								return {
									ctor: '_Tuple2',
									_0: _eeue56$elm_all_dict$EveryDict$Same,
									_1: A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _p56, _p57, _p60, newLeft, _p59)
								};
							case 'Insert':
								return {
									ctor: '_Tuple2',
									_0: _eeue56$elm_all_dict$EveryDict$Insert,
									_1: A5(_eeue56$elm_all_dict$EveryDict$balance, _p56, _p57, _p60, newLeft, _p59)
								};
							default:
								return {
									ctor: '_Tuple2',
									_0: _eeue56$elm_all_dict$EveryDict$Remove,
									_1: A5(_eeue56$elm_all_dict$EveryDict$bubble, _p56, _p57, _p60, newLeft, _p59)
								};
						}
					default:
						var _p54 = up(_p59);
						var flag = _p54._0;
						var newRight = _p54._1;
						var _p55 = flag;
						switch (_p55.ctor) {
							case 'Same':
								return {
									ctor: '_Tuple2',
									_0: _eeue56$elm_all_dict$EveryDict$Same,
									_1: A5(_eeue56$elm_all_dict$EveryDict$RBNode_elm_builtin, _p56, _p57, _p60, _p58, newRight)
								};
							case 'Insert':
								return {
									ctor: '_Tuple2',
									_0: _eeue56$elm_all_dict$EveryDict$Insert,
									_1: A5(_eeue56$elm_all_dict$EveryDict$balance, _p56, _p57, _p60, _p58, newRight)
								};
							default:
								return {
									ctor: '_Tuple2',
									_0: _eeue56$elm_all_dict$EveryDict$Remove,
									_1: A5(_eeue56$elm_all_dict$EveryDict$bubble, _p56, _p57, _p60, _p58, newRight)
								};
						}
				}
			}
		};
		var _p61 = up(dict);
		var flag = _p61._0;
		var updatedDict = _p61._1;
		var _p62 = flag;
		switch (_p62.ctor) {
			case 'Same':
				return updatedDict;
			case 'Insert':
				return _eeue56$elm_all_dict$EveryDict$ensureBlackRoot(updatedDict);
			default:
				return _eeue56$elm_all_dict$EveryDict$blacken(updatedDict);
		}
	});
var _eeue56$elm_all_dict$EveryDict$insert = F3(
	function (key, value, dict) {
		return A3(
			_eeue56$elm_all_dict$EveryDict$update,
			key,
			_elm_lang$core$Basics$always(
				_elm_lang$core$Maybe$Just(value)),
			dict);
	});
var _eeue56$elm_all_dict$EveryDict$singleton = F2(
	function (key, value) {
		return A3(_eeue56$elm_all_dict$EveryDict$insert, key, value, _eeue56$elm_all_dict$EveryDict$empty);
	});
var _eeue56$elm_all_dict$EveryDict$union = F2(
	function (t1, t2) {
		return A3(_eeue56$elm_all_dict$EveryDict$foldl, _eeue56$elm_all_dict$EveryDict$insert, t2, t1);
	});
var _eeue56$elm_all_dict$EveryDict$fromList = function (assocs) {
	return A3(
		_elm_lang$core$List$foldl,
		F2(
			function (_p63, dict) {
				var _p64 = _p63;
				return A3(_eeue56$elm_all_dict$EveryDict$insert, _p64._0, _p64._1, dict);
			}),
		_eeue56$elm_all_dict$EveryDict$empty,
		assocs);
};
var _eeue56$elm_all_dict$EveryDict$filter = F2(
	function (predicate, dictionary) {
		var add = F3(
			function (key, value, dict) {
				return A2(predicate, key, value) ? A3(_eeue56$elm_all_dict$EveryDict$insert, key, value, dict) : dict;
			});
		return A3(_eeue56$elm_all_dict$EveryDict$foldl, add, _eeue56$elm_all_dict$EveryDict$empty, dictionary);
	});
var _eeue56$elm_all_dict$EveryDict$intersect = F2(
	function (t1, t2) {
		return A2(
			_eeue56$elm_all_dict$EveryDict$filter,
			F2(
				function (k, _p65) {
					return A2(_eeue56$elm_all_dict$EveryDict$member, k, t2);
				}),
			t1);
	});
var _eeue56$elm_all_dict$EveryDict$partition = F2(
	function (predicate, dict) {
		var add = F3(
			function (key, value, _p66) {
				var _p67 = _p66;
				var _p69 = _p67._1;
				var _p68 = _p67._0;
				return A2(predicate, key, value) ? {
					ctor: '_Tuple2',
					_0: A3(_eeue56$elm_all_dict$EveryDict$insert, key, value, _p68),
					_1: _p69
				} : {
					ctor: '_Tuple2',
					_0: _p68,
					_1: A3(_eeue56$elm_all_dict$EveryDict$insert, key, value, _p69)
				};
			});
		return A3(
			_eeue56$elm_all_dict$EveryDict$foldl,
			add,
			{ctor: '_Tuple2', _0: _eeue56$elm_all_dict$EveryDict$empty, _1: _eeue56$elm_all_dict$EveryDict$empty},
			dict);
	});
var _eeue56$elm_all_dict$EveryDict$remove = F2(
	function (key, dict) {
		return A3(
			_eeue56$elm_all_dict$EveryDict$update,
			key,
			_elm_lang$core$Basics$always(_elm_lang$core$Maybe$Nothing),
			dict);
	});
var _eeue56$elm_all_dict$EveryDict$diff = F2(
	function (t1, t2) {
		return A3(
			_eeue56$elm_all_dict$EveryDict$foldl,
			F3(
				function (k, v, t) {
					return A2(_eeue56$elm_all_dict$EveryDict$remove, k, t);
				}),
			t1,
			t2);
	});

var _elm_lang$core$Random$onSelfMsg = F3(
	function (_p1, _p0, seed) {
		return _elm_lang$core$Task$succeed(seed);
	});
var _elm_lang$core$Random$magicNum8 = 2147483562;
var _elm_lang$core$Random$range = function (_p2) {
	return {ctor: '_Tuple2', _0: 0, _1: _elm_lang$core$Random$magicNum8};
};
var _elm_lang$core$Random$magicNum7 = 2147483399;
var _elm_lang$core$Random$magicNum6 = 2147483563;
var _elm_lang$core$Random$magicNum5 = 3791;
var _elm_lang$core$Random$magicNum4 = 40692;
var _elm_lang$core$Random$magicNum3 = 52774;
var _elm_lang$core$Random$magicNum2 = 12211;
var _elm_lang$core$Random$magicNum1 = 53668;
var _elm_lang$core$Random$magicNum0 = 40014;
var _elm_lang$core$Random$step = F2(
	function (_p3, seed) {
		var _p4 = _p3;
		return _p4._0(seed);
	});
var _elm_lang$core$Random$onEffects = F3(
	function (router, commands, seed) {
		var _p5 = commands;
		if (_p5.ctor === '[]') {
			return _elm_lang$core$Task$succeed(seed);
		} else {
			var _p6 = A2(_elm_lang$core$Random$step, _p5._0._0, seed);
			var value = _p6._0;
			var newSeed = _p6._1;
			return A2(
				_elm_lang$core$Task$andThen,
				function (_p7) {
					return A3(_elm_lang$core$Random$onEffects, router, _p5._1, newSeed);
				},
				A2(_elm_lang$core$Platform$sendToApp, router, value));
		}
	});
var _elm_lang$core$Random$listHelp = F4(
	function (list, n, generate, seed) {
		listHelp:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(n, 1) < 0) {
				return {
					ctor: '_Tuple2',
					_0: _elm_lang$core$List$reverse(list),
					_1: seed
				};
			} else {
				var _p8 = generate(seed);
				var value = _p8._0;
				var newSeed = _p8._1;
				var _v2 = {ctor: '::', _0: value, _1: list},
					_v3 = n - 1,
					_v4 = generate,
					_v5 = newSeed;
				list = _v2;
				n = _v3;
				generate = _v4;
				seed = _v5;
				continue listHelp;
			}
		}
	});
var _elm_lang$core$Random$minInt = -2147483648;
var _elm_lang$core$Random$maxInt = 2147483647;
var _elm_lang$core$Random$iLogBase = F2(
	function (b, i) {
		return (_elm_lang$core$Native_Utils.cmp(i, b) < 0) ? 1 : (1 + A2(_elm_lang$core$Random$iLogBase, b, (i / b) | 0));
	});
var _elm_lang$core$Random$command = _elm_lang$core$Native_Platform.leaf('Random');
var _elm_lang$core$Random$Generator = function (a) {
	return {ctor: 'Generator', _0: a};
};
var _elm_lang$core$Random$list = F2(
	function (n, _p9) {
		var _p10 = _p9;
		return _elm_lang$core$Random$Generator(
			function (seed) {
				return A4(
					_elm_lang$core$Random$listHelp,
					{ctor: '[]'},
					n,
					_p10._0,
					seed);
			});
	});
var _elm_lang$core$Random$map = F2(
	function (func, _p11) {
		var _p12 = _p11;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p13 = _p12._0(seed0);
				var a = _p13._0;
				var seed1 = _p13._1;
				return {
					ctor: '_Tuple2',
					_0: func(a),
					_1: seed1
				};
			});
	});
var _elm_lang$core$Random$map2 = F3(
	function (func, _p15, _p14) {
		var _p16 = _p15;
		var _p17 = _p14;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p18 = _p16._0(seed0);
				var a = _p18._0;
				var seed1 = _p18._1;
				var _p19 = _p17._0(seed1);
				var b = _p19._0;
				var seed2 = _p19._1;
				return {
					ctor: '_Tuple2',
					_0: A2(func, a, b),
					_1: seed2
				};
			});
	});
var _elm_lang$core$Random$pair = F2(
	function (genA, genB) {
		return A3(
			_elm_lang$core$Random$map2,
			F2(
				function (v0, v1) {
					return {ctor: '_Tuple2', _0: v0, _1: v1};
				}),
			genA,
			genB);
	});
var _elm_lang$core$Random$map3 = F4(
	function (func, _p22, _p21, _p20) {
		var _p23 = _p22;
		var _p24 = _p21;
		var _p25 = _p20;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p26 = _p23._0(seed0);
				var a = _p26._0;
				var seed1 = _p26._1;
				var _p27 = _p24._0(seed1);
				var b = _p27._0;
				var seed2 = _p27._1;
				var _p28 = _p25._0(seed2);
				var c = _p28._0;
				var seed3 = _p28._1;
				return {
					ctor: '_Tuple2',
					_0: A3(func, a, b, c),
					_1: seed3
				};
			});
	});
var _elm_lang$core$Random$map4 = F5(
	function (func, _p32, _p31, _p30, _p29) {
		var _p33 = _p32;
		var _p34 = _p31;
		var _p35 = _p30;
		var _p36 = _p29;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p37 = _p33._0(seed0);
				var a = _p37._0;
				var seed1 = _p37._1;
				var _p38 = _p34._0(seed1);
				var b = _p38._0;
				var seed2 = _p38._1;
				var _p39 = _p35._0(seed2);
				var c = _p39._0;
				var seed3 = _p39._1;
				var _p40 = _p36._0(seed3);
				var d = _p40._0;
				var seed4 = _p40._1;
				return {
					ctor: '_Tuple2',
					_0: A4(func, a, b, c, d),
					_1: seed4
				};
			});
	});
var _elm_lang$core$Random$map5 = F6(
	function (func, _p45, _p44, _p43, _p42, _p41) {
		var _p46 = _p45;
		var _p47 = _p44;
		var _p48 = _p43;
		var _p49 = _p42;
		var _p50 = _p41;
		return _elm_lang$core$Random$Generator(
			function (seed0) {
				var _p51 = _p46._0(seed0);
				var a = _p51._0;
				var seed1 = _p51._1;
				var _p52 = _p47._0(seed1);
				var b = _p52._0;
				var seed2 = _p52._1;
				var _p53 = _p48._0(seed2);
				var c = _p53._0;
				var seed3 = _p53._1;
				var _p54 = _p49._0(seed3);
				var d = _p54._0;
				var seed4 = _p54._1;
				var _p55 = _p50._0(seed4);
				var e = _p55._0;
				var seed5 = _p55._1;
				return {
					ctor: '_Tuple2',
					_0: A5(func, a, b, c, d, e),
					_1: seed5
				};
			});
	});
var _elm_lang$core$Random$andThen = F2(
	function (callback, _p56) {
		var _p57 = _p56;
		return _elm_lang$core$Random$Generator(
			function (seed) {
				var _p58 = _p57._0(seed);
				var result = _p58._0;
				var newSeed = _p58._1;
				var _p59 = callback(result);
				var genB = _p59._0;
				return genB(newSeed);
			});
	});
var _elm_lang$core$Random$State = F2(
	function (a, b) {
		return {ctor: 'State', _0: a, _1: b};
	});
var _elm_lang$core$Random$initState = function (seed) {
	var s = A2(_elm_lang$core$Basics$max, seed, 0 - seed);
	var q = (s / (_elm_lang$core$Random$magicNum6 - 1)) | 0;
	var s2 = A2(_elm_lang$core$Basics_ops['%'], q, _elm_lang$core$Random$magicNum7 - 1);
	var s1 = A2(_elm_lang$core$Basics_ops['%'], s, _elm_lang$core$Random$magicNum6 - 1);
	return A2(_elm_lang$core$Random$State, s1 + 1, s2 + 1);
};
var _elm_lang$core$Random$next = function (_p60) {
	var _p61 = _p60;
	var _p63 = _p61._1;
	var _p62 = _p61._0;
	var k2 = (_p63 / _elm_lang$core$Random$magicNum3) | 0;
	var rawState2 = (_elm_lang$core$Random$magicNum4 * (_p63 - (k2 * _elm_lang$core$Random$magicNum3))) - (k2 * _elm_lang$core$Random$magicNum5);
	var newState2 = (_elm_lang$core$Native_Utils.cmp(rawState2, 0) < 0) ? (rawState2 + _elm_lang$core$Random$magicNum7) : rawState2;
	var k1 = (_p62 / _elm_lang$core$Random$magicNum1) | 0;
	var rawState1 = (_elm_lang$core$Random$magicNum0 * (_p62 - (k1 * _elm_lang$core$Random$magicNum1))) - (k1 * _elm_lang$core$Random$magicNum2);
	var newState1 = (_elm_lang$core$Native_Utils.cmp(rawState1, 0) < 0) ? (rawState1 + _elm_lang$core$Random$magicNum6) : rawState1;
	var z = newState1 - newState2;
	var newZ = (_elm_lang$core$Native_Utils.cmp(z, 1) < 0) ? (z + _elm_lang$core$Random$magicNum8) : z;
	return {
		ctor: '_Tuple2',
		_0: newZ,
		_1: A2(_elm_lang$core$Random$State, newState1, newState2)
	};
};
var _elm_lang$core$Random$split = function (_p64) {
	var _p65 = _p64;
	var _p68 = _p65._1;
	var _p67 = _p65._0;
	var _p66 = _elm_lang$core$Tuple$second(
		_elm_lang$core$Random$next(_p65));
	var t1 = _p66._0;
	var t2 = _p66._1;
	var new_s2 = _elm_lang$core$Native_Utils.eq(_p68, 1) ? (_elm_lang$core$Random$magicNum7 - 1) : (_p68 - 1);
	var new_s1 = _elm_lang$core$Native_Utils.eq(_p67, _elm_lang$core$Random$magicNum6 - 1) ? 1 : (_p67 + 1);
	return {
		ctor: '_Tuple2',
		_0: A2(_elm_lang$core$Random$State, new_s1, t2),
		_1: A2(_elm_lang$core$Random$State, t1, new_s2)
	};
};
var _elm_lang$core$Random$Seed = function (a) {
	return {ctor: 'Seed', _0: a};
};
var _elm_lang$core$Random$int = F2(
	function (a, b) {
		return _elm_lang$core$Random$Generator(
			function (_p69) {
				var _p70 = _p69;
				var _p75 = _p70._0;
				var base = 2147483561;
				var f = F3(
					function (n, acc, state) {
						f:
						while (true) {
							var _p71 = n;
							if (_p71 === 0) {
								return {ctor: '_Tuple2', _0: acc, _1: state};
							} else {
								var _p72 = _p75.next(state);
								var x = _p72._0;
								var nextState = _p72._1;
								var _v27 = n - 1,
									_v28 = x + (acc * base),
									_v29 = nextState;
								n = _v27;
								acc = _v28;
								state = _v29;
								continue f;
							}
						}
					});
				var _p73 = (_elm_lang$core$Native_Utils.cmp(a, b) < 0) ? {ctor: '_Tuple2', _0: a, _1: b} : {ctor: '_Tuple2', _0: b, _1: a};
				var lo = _p73._0;
				var hi = _p73._1;
				var k = (hi - lo) + 1;
				var n = A2(_elm_lang$core$Random$iLogBase, base, k);
				var _p74 = A3(f, n, 1, _p75.state);
				var v = _p74._0;
				var nextState = _p74._1;
				return {
					ctor: '_Tuple2',
					_0: lo + A2(_elm_lang$core$Basics_ops['%'], v, k),
					_1: _elm_lang$core$Random$Seed(
						_elm_lang$core$Native_Utils.update(
							_p75,
							{state: nextState}))
				};
			});
	});
var _elm_lang$core$Random$bool = A2(
	_elm_lang$core$Random$map,
	F2(
		function (x, y) {
			return _elm_lang$core$Native_Utils.eq(x, y);
		})(1),
	A2(_elm_lang$core$Random$int, 0, 1));
var _elm_lang$core$Random$float = F2(
	function (a, b) {
		return _elm_lang$core$Random$Generator(
			function (seed) {
				var _p76 = A2(
					_elm_lang$core$Random$step,
					A2(_elm_lang$core$Random$int, _elm_lang$core$Random$minInt, _elm_lang$core$Random$maxInt),
					seed);
				var number = _p76._0;
				var newSeed = _p76._1;
				var negativeOneToOne = _elm_lang$core$Basics$toFloat(number) / _elm_lang$core$Basics$toFloat(_elm_lang$core$Random$maxInt - _elm_lang$core$Random$minInt);
				var _p77 = (_elm_lang$core$Native_Utils.cmp(a, b) < 0) ? {ctor: '_Tuple2', _0: a, _1: b} : {ctor: '_Tuple2', _0: b, _1: a};
				var lo = _p77._0;
				var hi = _p77._1;
				var scaled = ((lo + hi) / 2) + ((hi - lo) * negativeOneToOne);
				return {ctor: '_Tuple2', _0: scaled, _1: newSeed};
			});
	});
var _elm_lang$core$Random$initialSeed = function (n) {
	return _elm_lang$core$Random$Seed(
		{
			state: _elm_lang$core$Random$initState(n),
			next: _elm_lang$core$Random$next,
			split: _elm_lang$core$Random$split,
			range: _elm_lang$core$Random$range
		});
};
var _elm_lang$core$Random$init = A2(
	_elm_lang$core$Task$andThen,
	function (t) {
		return _elm_lang$core$Task$succeed(
			_elm_lang$core$Random$initialSeed(
				_elm_lang$core$Basics$round(t)));
	},
	_elm_lang$core$Time$now);
var _elm_lang$core$Random$Generate = function (a) {
	return {ctor: 'Generate', _0: a};
};
var _elm_lang$core$Random$generate = F2(
	function (tagger, generator) {
		return _elm_lang$core$Random$command(
			_elm_lang$core$Random$Generate(
				A2(_elm_lang$core$Random$map, tagger, generator)));
	});
var _elm_lang$core$Random$cmdMap = F2(
	function (func, _p78) {
		var _p79 = _p78;
		return _elm_lang$core$Random$Generate(
			A2(_elm_lang$core$Random$map, func, _p79._0));
	});
_elm_lang$core$Native_Platform.effectManagers['Random'] = {pkg: 'elm-lang/core', init: _elm_lang$core$Random$init, onEffects: _elm_lang$core$Random$onEffects, onSelfMsg: _elm_lang$core$Random$onSelfMsg, tag: 'cmd', cmdMap: _elm_lang$core$Random$cmdMap};

var _elm_community$basics_extra$Basics_Extra$turnsPerRadian = 1 / _elm_lang$core$Basics$turns(1);
var _elm_community$basics_extra$Basics_Extra$inTurns = function (angle) {
	return angle * _elm_community$basics_extra$Basics_Extra$turnsPerRadian;
};
var _elm_community$basics_extra$Basics_Extra$inRadians = _elm_lang$core$Basics$identity;
var _elm_community$basics_extra$Basics_Extra$degreesPerRadian = 1 / _elm_lang$core$Basics$degrees(1);
var _elm_community$basics_extra$Basics_Extra$inDegrees = function (angle) {
	return angle * _elm_community$basics_extra$Basics_Extra$degreesPerRadian;
};
var _elm_community$basics_extra$Basics_Extra$fmod = F2(
	function (f, n) {
		var integer = _elm_lang$core$Basics$floor(f);
		return (_elm_lang$core$Basics$toFloat(
			A2(_elm_lang$core$Basics_ops['%'], integer, n)) + f) - _elm_lang$core$Basics$toFloat(integer);
	});
var _elm_community$basics_extra$Basics_Extra$maxSafeInteger = Math.pow(2, 53) - 1;
var _elm_community$basics_extra$Basics_Extra$minSafeInteger = 0 - _elm_community$basics_extra$Basics_Extra$maxSafeInteger;
var _elm_community$basics_extra$Basics_Extra$isSafeInteger = function (number) {
	return (_elm_lang$core$Native_Utils.cmp(_elm_community$basics_extra$Basics_Extra$minSafeInteger, number) < 1) && (_elm_lang$core$Native_Utils.cmp(_elm_community$basics_extra$Basics_Extra$maxSafeInteger, number) > -1);
};
var _elm_community$basics_extra$Basics_Extra$swap = function (_p0) {
	var _p1 = _p0;
	return {ctor: '_Tuple2', _0: _p1._1, _1: _p1._0};
};
var _elm_community$basics_extra$Basics_Extra_ops = _elm_community$basics_extra$Basics_Extra_ops || {};
_elm_community$basics_extra$Basics_Extra_ops['=>'] = F2(
	function (v0, v1) {
		return {ctor: '_Tuple2', _0: v0, _1: v1};
	});

var _elm_lang$core$Set$foldr = F3(
	function (f, b, _p0) {
		var _p1 = _p0;
		return A3(
			_elm_lang$core$Dict$foldr,
			F3(
				function (k, _p2, b) {
					return A2(f, k, b);
				}),
			b,
			_p1._0);
	});
var _elm_lang$core$Set$foldl = F3(
	function (f, b, _p3) {
		var _p4 = _p3;
		return A3(
			_elm_lang$core$Dict$foldl,
			F3(
				function (k, _p5, b) {
					return A2(f, k, b);
				}),
			b,
			_p4._0);
	});
var _elm_lang$core$Set$toList = function (_p6) {
	var _p7 = _p6;
	return _elm_lang$core$Dict$keys(_p7._0);
};
var _elm_lang$core$Set$size = function (_p8) {
	var _p9 = _p8;
	return _elm_lang$core$Dict$size(_p9._0);
};
var _elm_lang$core$Set$member = F2(
	function (k, _p10) {
		var _p11 = _p10;
		return A2(_elm_lang$core$Dict$member, k, _p11._0);
	});
var _elm_lang$core$Set$isEmpty = function (_p12) {
	var _p13 = _p12;
	return _elm_lang$core$Dict$isEmpty(_p13._0);
};
var _elm_lang$core$Set$Set_elm_builtin = function (a) {
	return {ctor: 'Set_elm_builtin', _0: a};
};
var _elm_lang$core$Set$empty = _elm_lang$core$Set$Set_elm_builtin(_elm_lang$core$Dict$empty);
var _elm_lang$core$Set$singleton = function (k) {
	return _elm_lang$core$Set$Set_elm_builtin(
		A2(
			_elm_lang$core$Dict$singleton,
			k,
			{ctor: '_Tuple0'}));
};
var _elm_lang$core$Set$insert = F2(
	function (k, _p14) {
		var _p15 = _p14;
		return _elm_lang$core$Set$Set_elm_builtin(
			A3(
				_elm_lang$core$Dict$insert,
				k,
				{ctor: '_Tuple0'},
				_p15._0));
	});
var _elm_lang$core$Set$fromList = function (xs) {
	return A3(_elm_lang$core$List$foldl, _elm_lang$core$Set$insert, _elm_lang$core$Set$empty, xs);
};
var _elm_lang$core$Set$map = F2(
	function (f, s) {
		return _elm_lang$core$Set$fromList(
			A2(
				_elm_lang$core$List$map,
				f,
				_elm_lang$core$Set$toList(s)));
	});
var _elm_lang$core$Set$remove = F2(
	function (k, _p16) {
		var _p17 = _p16;
		return _elm_lang$core$Set$Set_elm_builtin(
			A2(_elm_lang$core$Dict$remove, k, _p17._0));
	});
var _elm_lang$core$Set$union = F2(
	function (_p19, _p18) {
		var _p20 = _p19;
		var _p21 = _p18;
		return _elm_lang$core$Set$Set_elm_builtin(
			A2(_elm_lang$core$Dict$union, _p20._0, _p21._0));
	});
var _elm_lang$core$Set$intersect = F2(
	function (_p23, _p22) {
		var _p24 = _p23;
		var _p25 = _p22;
		return _elm_lang$core$Set$Set_elm_builtin(
			A2(_elm_lang$core$Dict$intersect, _p24._0, _p25._0));
	});
var _elm_lang$core$Set$diff = F2(
	function (_p27, _p26) {
		var _p28 = _p27;
		var _p29 = _p26;
		return _elm_lang$core$Set$Set_elm_builtin(
			A2(_elm_lang$core$Dict$diff, _p28._0, _p29._0));
	});
var _elm_lang$core$Set$filter = F2(
	function (p, _p30) {
		var _p31 = _p30;
		return _elm_lang$core$Set$Set_elm_builtin(
			A2(
				_elm_lang$core$Dict$filter,
				F2(
					function (k, _p32) {
						return p(k);
					}),
				_p31._0));
	});
var _elm_lang$core$Set$partition = F2(
	function (p, _p33) {
		var _p34 = _p33;
		var _p35 = A2(
			_elm_lang$core$Dict$partition,
			F2(
				function (k, _p36) {
					return p(k);
				}),
			_p34._0);
		var p1 = _p35._0;
		var p2 = _p35._1;
		return {
			ctor: '_Tuple2',
			_0: _elm_lang$core$Set$Set_elm_builtin(p1),
			_1: _elm_lang$core$Set$Set_elm_builtin(p2)
		};
	});

var _elm_community$list_extra$List_Extra$greedyGroupsOfWithStep = F3(
	function (size, step, xs) {
		var okayXs = _elm_lang$core$Native_Utils.cmp(
			_elm_lang$core$List$length(xs),
			0) > 0;
		var okayArgs = (_elm_lang$core$Native_Utils.cmp(size, 0) > 0) && (_elm_lang$core$Native_Utils.cmp(step, 0) > 0);
		var xs_ = A2(_elm_lang$core$List$drop, step, xs);
		var group = A2(_elm_lang$core$List$take, size, xs);
		return (okayArgs && okayXs) ? {
			ctor: '::',
			_0: group,
			_1: A3(_elm_community$list_extra$List_Extra$greedyGroupsOfWithStep, size, step, xs_)
		} : {ctor: '[]'};
	});
var _elm_community$list_extra$List_Extra$greedyGroupsOf = F2(
	function (size, xs) {
		return A3(_elm_community$list_extra$List_Extra$greedyGroupsOfWithStep, size, size, xs);
	});
var _elm_community$list_extra$List_Extra$groupsOfWithStep = F3(
	function (size, step, xs) {
		var okayArgs = (_elm_lang$core$Native_Utils.cmp(size, 0) > 0) && (_elm_lang$core$Native_Utils.cmp(step, 0) > 0);
		var xs_ = A2(_elm_lang$core$List$drop, step, xs);
		var group = A2(_elm_lang$core$List$take, size, xs);
		var okayLength = _elm_lang$core$Native_Utils.eq(
			size,
			_elm_lang$core$List$length(group));
		return (okayArgs && okayLength) ? {
			ctor: '::',
			_0: group,
			_1: A3(_elm_community$list_extra$List_Extra$groupsOfWithStep, size, step, xs_)
		} : {ctor: '[]'};
	});
var _elm_community$list_extra$List_Extra$groupsOf = F2(
	function (size, xs) {
		return A3(_elm_community$list_extra$List_Extra$groupsOfWithStep, size, size, xs);
	});
var _elm_community$list_extra$List_Extra$zip5 = _elm_lang$core$List$map5(
	F5(
		function (v0, v1, v2, v3, v4) {
			return {ctor: '_Tuple5', _0: v0, _1: v1, _2: v2, _3: v3, _4: v4};
		}));
var _elm_community$list_extra$List_Extra$zip4 = _elm_lang$core$List$map4(
	F4(
		function (v0, v1, v2, v3) {
			return {ctor: '_Tuple4', _0: v0, _1: v1, _2: v2, _3: v3};
		}));
var _elm_community$list_extra$List_Extra$zip3 = _elm_lang$core$List$map3(
	F3(
		function (v0, v1, v2) {
			return {ctor: '_Tuple3', _0: v0, _1: v1, _2: v2};
		}));
var _elm_community$list_extra$List_Extra$zip = _elm_lang$core$List$map2(
	F2(
		function (v0, v1) {
			return {ctor: '_Tuple2', _0: v0, _1: v1};
		}));
var _elm_community$list_extra$List_Extra$isPrefixOf = F2(
	function (prefix, xs) {
		var _p0 = {ctor: '_Tuple2', _0: prefix, _1: xs};
		if (_p0._0.ctor === '[]') {
			return true;
		} else {
			if (_p0._1.ctor === '[]') {
				return false;
			} else {
				return _elm_lang$core$Native_Utils.eq(_p0._0._0, _p0._1._0) && A2(_elm_community$list_extra$List_Extra$isPrefixOf, _p0._0._1, _p0._1._1);
			}
		}
	});
var _elm_community$list_extra$List_Extra$isSuffixOf = F2(
	function (suffix, xs) {
		return A2(
			_elm_community$list_extra$List_Extra$isPrefixOf,
			_elm_lang$core$List$reverse(suffix),
			_elm_lang$core$List$reverse(xs));
	});
var _elm_community$list_extra$List_Extra$selectSplit = function (xs) {
	var _p1 = xs;
	if (_p1.ctor === '[]') {
		return {ctor: '[]'};
	} else {
		var _p5 = _p1._1;
		var _p4 = _p1._0;
		return {
			ctor: '::',
			_0: {
				ctor: '_Tuple3',
				_0: {ctor: '[]'},
				_1: _p4,
				_2: _p5
			},
			_1: A2(
				_elm_lang$core$List$map,
				function (_p2) {
					var _p3 = _p2;
					return {
						ctor: '_Tuple3',
						_0: {ctor: '::', _0: _p4, _1: _p3._0},
						_1: _p3._1,
						_2: _p3._2
					};
				},
				_elm_community$list_extra$List_Extra$selectSplit(_p5))
		};
	}
};
var _elm_community$list_extra$List_Extra$select = function (xs) {
	var _p6 = xs;
	if (_p6.ctor === '[]') {
		return {ctor: '[]'};
	} else {
		var _p10 = _p6._1;
		var _p9 = _p6._0;
		return {
			ctor: '::',
			_0: {ctor: '_Tuple2', _0: _p9, _1: _p10},
			_1: A2(
				_elm_lang$core$List$map,
				function (_p7) {
					var _p8 = _p7;
					return {
						ctor: '_Tuple2',
						_0: _p8._0,
						_1: {ctor: '::', _0: _p9, _1: _p8._1}
					};
				},
				_elm_community$list_extra$List_Extra$select(_p10))
		};
	}
};
var _elm_community$list_extra$List_Extra$tailsHelp = F2(
	function (e, list) {
		var _p11 = list;
		if (_p11.ctor === '::') {
			var _p12 = _p11._0;
			return {
				ctor: '::',
				_0: {ctor: '::', _0: e, _1: _p12},
				_1: {ctor: '::', _0: _p12, _1: _p11._1}
			};
		} else {
			return {ctor: '[]'};
		}
	});
var _elm_community$list_extra$List_Extra$tails = A2(
	_elm_lang$core$List$foldr,
	_elm_community$list_extra$List_Extra$tailsHelp,
	{
		ctor: '::',
		_0: {ctor: '[]'},
		_1: {ctor: '[]'}
	});
var _elm_community$list_extra$List_Extra$isInfixOf = F2(
	function (infix, xs) {
		return A2(
			_elm_lang$core$List$any,
			_elm_community$list_extra$List_Extra$isPrefixOf(infix),
			_elm_community$list_extra$List_Extra$tails(xs));
	});
var _elm_community$list_extra$List_Extra$inits = A2(
	_elm_lang$core$List$foldr,
	F2(
		function (e, acc) {
			return {
				ctor: '::',
				_0: {ctor: '[]'},
				_1: A2(
					_elm_lang$core$List$map,
					F2(
						function (x, y) {
							return {ctor: '::', _0: x, _1: y};
						})(e),
					acc)
			};
		}),
	{
		ctor: '::',
		_0: {ctor: '[]'},
		_1: {ctor: '[]'}
	});
var _elm_community$list_extra$List_Extra$groupWhileTransitively = F2(
	function (cmp, xs_) {
		var _p13 = xs_;
		if (_p13.ctor === '[]') {
			return {ctor: '[]'};
		} else {
			if (_p13._1.ctor === '[]') {
				return {
					ctor: '::',
					_0: {
						ctor: '::',
						_0: _p13._0,
						_1: {ctor: '[]'}
					},
					_1: {ctor: '[]'}
				};
			} else {
				var _p15 = _p13._0;
				var _p14 = A2(_elm_community$list_extra$List_Extra$groupWhileTransitively, cmp, _p13._1);
				if (_p14.ctor === '::') {
					return A2(cmp, _p15, _p13._1._0) ? {
						ctor: '::',
						_0: {ctor: '::', _0: _p15, _1: _p14._0},
						_1: _p14._1
					} : {
						ctor: '::',
						_0: {
							ctor: '::',
							_0: _p15,
							_1: {ctor: '[]'}
						},
						_1: _p14
					};
				} else {
					return {ctor: '[]'};
				}
			}
		}
	});
var _elm_community$list_extra$List_Extra$stripPrefix = F2(
	function (prefix, xs) {
		var step = F2(
			function (e, m) {
				var _p16 = m;
				if (_p16.ctor === 'Nothing') {
					return _elm_lang$core$Maybe$Nothing;
				} else {
					if (_p16._0.ctor === '[]') {
						return _elm_lang$core$Maybe$Nothing;
					} else {
						return _elm_lang$core$Native_Utils.eq(e, _p16._0._0) ? _elm_lang$core$Maybe$Just(_p16._0._1) : _elm_lang$core$Maybe$Nothing;
					}
				}
			});
		return A3(
			_elm_lang$core$List$foldl,
			step,
			_elm_lang$core$Maybe$Just(xs),
			prefix);
	});
var _elm_community$list_extra$List_Extra$dropWhileRight = function (p) {
	return A2(
		_elm_lang$core$List$foldr,
		F2(
			function (x, xs) {
				return (p(x) && _elm_lang$core$List$isEmpty(xs)) ? {ctor: '[]'} : {ctor: '::', _0: x, _1: xs};
			}),
		{ctor: '[]'});
};
var _elm_community$list_extra$List_Extra$takeWhileRight = function (p) {
	var step = F2(
		function (x, _p17) {
			var _p18 = _p17;
			var _p19 = _p18._0;
			return (p(x) && _p18._1) ? {
				ctor: '_Tuple2',
				_0: {ctor: '::', _0: x, _1: _p19},
				_1: true
			} : {ctor: '_Tuple2', _0: _p19, _1: false};
		});
	return function (_p20) {
		return _elm_lang$core$Tuple$first(
			A3(
				_elm_lang$core$List$foldr,
				step,
				{
					ctor: '_Tuple2',
					_0: {ctor: '[]'},
					_1: true
				},
				_p20));
	};
};
var _elm_community$list_extra$List_Extra$splitAt = F2(
	function (n, xs) {
		return {
			ctor: '_Tuple2',
			_0: A2(_elm_lang$core$List$take, n, xs),
			_1: A2(_elm_lang$core$List$drop, n, xs)
		};
	});
var _elm_community$list_extra$List_Extra$groupsOfVarying_ = F3(
	function (listOflengths, list, accu) {
		groupsOfVarying_:
		while (true) {
			var _p21 = {ctor: '_Tuple2', _0: listOflengths, _1: list};
			if (((_p21.ctor === '_Tuple2') && (_p21._0.ctor === '::')) && (_p21._1.ctor === '::')) {
				var _p22 = A2(_elm_community$list_extra$List_Extra$splitAt, _p21._0._0, list);
				var head = _p22._0;
				var tail = _p22._1;
				var _v11 = _p21._0._1,
					_v12 = tail,
					_v13 = {ctor: '::', _0: head, _1: accu};
				listOflengths = _v11;
				list = _v12;
				accu = _v13;
				continue groupsOfVarying_;
			} else {
				return _elm_lang$core$List$reverse(accu);
			}
		}
	});
var _elm_community$list_extra$List_Extra$groupsOfVarying = F2(
	function (listOflengths, list) {
		return A3(
			_elm_community$list_extra$List_Extra$groupsOfVarying_,
			listOflengths,
			list,
			{ctor: '[]'});
	});
var _elm_community$list_extra$List_Extra$unfoldr = F2(
	function (f, seed) {
		var _p23 = f(seed);
		if (_p23.ctor === 'Nothing') {
			return {ctor: '[]'};
		} else {
			return {
				ctor: '::',
				_0: _p23._0._0,
				_1: A2(_elm_community$list_extra$List_Extra$unfoldr, f, _p23._0._1)
			};
		}
	});
var _elm_community$list_extra$List_Extra$scanr1 = F2(
	function (f, xs_) {
		var _p24 = xs_;
		if (_p24.ctor === '[]') {
			return {ctor: '[]'};
		} else {
			if (_p24._1.ctor === '[]') {
				return {
					ctor: '::',
					_0: _p24._0,
					_1: {ctor: '[]'}
				};
			} else {
				var _p25 = A2(_elm_community$list_extra$List_Extra$scanr1, f, _p24._1);
				if (_p25.ctor === '::') {
					return {
						ctor: '::',
						_0: A2(f, _p24._0, _p25._0),
						_1: _p25
					};
				} else {
					return {ctor: '[]'};
				}
			}
		}
	});
var _elm_community$list_extra$List_Extra$scanr = F3(
	function (f, acc, xs_) {
		var _p26 = xs_;
		if (_p26.ctor === '[]') {
			return {
				ctor: '::',
				_0: acc,
				_1: {ctor: '[]'}
			};
		} else {
			var _p27 = A3(_elm_community$list_extra$List_Extra$scanr, f, acc, _p26._1);
			if (_p27.ctor === '::') {
				return {
					ctor: '::',
					_0: A2(f, _p26._0, _p27._0),
					_1: _p27
				};
			} else {
				return {ctor: '[]'};
			}
		}
	});
var _elm_community$list_extra$List_Extra$scanl1 = F2(
	function (f, xs_) {
		var _p28 = xs_;
		if (_p28.ctor === '[]') {
			return {ctor: '[]'};
		} else {
			return A3(_elm_lang$core$List$scanl, f, _p28._0, _p28._1);
		}
	});
var _elm_community$list_extra$List_Extra$indexedFoldr = F3(
	function (func, acc, list) {
		var step = F2(
			function (x, _p29) {
				var _p30 = _p29;
				var _p31 = _p30._0;
				return {
					ctor: '_Tuple2',
					_0: _p31 - 1,
					_1: A3(func, _p31, x, _p30._1)
				};
			});
		return _elm_lang$core$Tuple$second(
			A3(
				_elm_lang$core$List$foldr,
				step,
				{
					ctor: '_Tuple2',
					_0: _elm_lang$core$List$length(list) - 1,
					_1: acc
				},
				list));
	});
var _elm_community$list_extra$List_Extra$indexedFoldl = F3(
	function (func, acc, list) {
		var step = F2(
			function (x, _p32) {
				var _p33 = _p32;
				var _p34 = _p33._0;
				return {
					ctor: '_Tuple2',
					_0: _p34 + 1,
					_1: A3(func, _p34, x, _p33._1)
				};
			});
		return _elm_lang$core$Tuple$second(
			A3(
				_elm_lang$core$List$foldl,
				step,
				{ctor: '_Tuple2', _0: 0, _1: acc},
				list));
	});
var _elm_community$list_extra$List_Extra$foldr1 = F2(
	function (f, xs) {
		var mf = F2(
			function (x, m) {
				return _elm_lang$core$Maybe$Just(
					function () {
						var _p35 = m;
						if (_p35.ctor === 'Nothing') {
							return x;
						} else {
							return A2(f, x, _p35._0);
						}
					}());
			});
		return A3(_elm_lang$core$List$foldr, mf, _elm_lang$core$Maybe$Nothing, xs);
	});
var _elm_community$list_extra$List_Extra$foldl1 = F2(
	function (f, xs) {
		var mf = F2(
			function (x, m) {
				return _elm_lang$core$Maybe$Just(
					function () {
						var _p36 = m;
						if (_p36.ctor === 'Nothing') {
							return x;
						} else {
							return A2(f, _p36._0, x);
						}
					}());
			});
		return A3(_elm_lang$core$List$foldl, mf, _elm_lang$core$Maybe$Nothing, xs);
	});
var _elm_community$list_extra$List_Extra$interweaveHelp = F3(
	function (l1, l2, acc) {
		interweaveHelp:
		while (true) {
			var _p37 = {ctor: '_Tuple2', _0: l1, _1: l2};
			_v24_1:
			do {
				if (_p37._0.ctor === '::') {
					if (_p37._1.ctor === '::') {
						var _v25 = _p37._0._1,
							_v26 = _p37._1._1,
							_v27 = A2(
							_elm_lang$core$Basics_ops['++'],
							acc,
							{
								ctor: '::',
								_0: _p37._0._0,
								_1: {
									ctor: '::',
									_0: _p37._1._0,
									_1: {ctor: '[]'}
								}
							});
						l1 = _v25;
						l2 = _v26;
						acc = _v27;
						continue interweaveHelp;
					} else {
						break _v24_1;
					}
				} else {
					if (_p37._1.ctor === '[]') {
						break _v24_1;
					} else {
						return A2(_elm_lang$core$Basics_ops['++'], acc, _p37._1);
					}
				}
			} while(false);
			return A2(_elm_lang$core$Basics_ops['++'], acc, _p37._0);
		}
	});
var _elm_community$list_extra$List_Extra$interweave = F2(
	function (l1, l2) {
		return A3(
			_elm_community$list_extra$List_Extra$interweaveHelp,
			l1,
			l2,
			{ctor: '[]'});
	});
var _elm_community$list_extra$List_Extra$permutations = function (xs_) {
	var _p38 = xs_;
	if (_p38.ctor === '[]') {
		return {
			ctor: '::',
			_0: {ctor: '[]'},
			_1: {ctor: '[]'}
		};
	} else {
		var f = function (_p39) {
			var _p40 = _p39;
			return A2(
				_elm_lang$core$List$map,
				F2(
					function (x, y) {
						return {ctor: '::', _0: x, _1: y};
					})(_p40._0),
				_elm_community$list_extra$List_Extra$permutations(_p40._1));
		};
		return A2(
			_elm_lang$core$List$concatMap,
			f,
			_elm_community$list_extra$List_Extra$select(_p38));
	}
};
var _elm_community$list_extra$List_Extra$isPermutationOf = F2(
	function (permut, xs) {
		return A2(
			_elm_lang$core$List$member,
			permut,
			_elm_community$list_extra$List_Extra$permutations(xs));
	});
var _elm_community$list_extra$List_Extra$subsequencesNonEmpty = function (xs) {
	var _p41 = xs;
	if (_p41.ctor === '[]') {
		return {ctor: '[]'};
	} else {
		var _p42 = _p41._0;
		var f = F2(
			function (ys, r) {
				return {
					ctor: '::',
					_0: ys,
					_1: {
						ctor: '::',
						_0: {ctor: '::', _0: _p42, _1: ys},
						_1: r
					}
				};
			});
		return {
			ctor: '::',
			_0: {
				ctor: '::',
				_0: _p42,
				_1: {ctor: '[]'}
			},
			_1: A3(
				_elm_lang$core$List$foldr,
				f,
				{ctor: '[]'},
				_elm_community$list_extra$List_Extra$subsequencesNonEmpty(_p41._1))
		};
	}
};
var _elm_community$list_extra$List_Extra$subsequences = function (xs) {
	return {
		ctor: '::',
		_0: {ctor: '[]'},
		_1: _elm_community$list_extra$List_Extra$subsequencesNonEmpty(xs)
	};
};
var _elm_community$list_extra$List_Extra$isSubsequenceOf = F2(
	function (subseq, xs) {
		return A2(
			_elm_lang$core$List$member,
			subseq,
			_elm_community$list_extra$List_Extra$subsequences(xs));
	});
var _elm_community$list_extra$List_Extra$transpose = function (ll) {
	transpose:
	while (true) {
		var _p43 = ll;
		if (_p43.ctor === '[]') {
			return {ctor: '[]'};
		} else {
			if (_p43._0.ctor === '[]') {
				var _v32 = _p43._1;
				ll = _v32;
				continue transpose;
			} else {
				var _p44 = _p43._1;
				var tails = A2(_elm_lang$core$List$filterMap, _elm_lang$core$List$tail, _p44);
				var heads = A2(_elm_lang$core$List$filterMap, _elm_lang$core$List$head, _p44);
				return {
					ctor: '::',
					_0: {ctor: '::', _0: _p43._0._0, _1: heads},
					_1: _elm_community$list_extra$List_Extra$transpose(
						{ctor: '::', _0: _p43._0._1, _1: tails})
				};
			}
		}
	}
};
var _elm_community$list_extra$List_Extra$intercalate = function (xs) {
	return function (_p45) {
		return _elm_lang$core$List$concat(
			A2(_elm_lang$core$List$intersperse, xs, _p45));
	};
};
var _elm_community$list_extra$List_Extra$filterNot = F2(
	function (pred, list) {
		return A2(
			_elm_lang$core$List$filter,
			function (_p46) {
				return !pred(_p46);
			},
			list);
	});
var _elm_community$list_extra$List_Extra$removeAt = F2(
	function (index, l) {
		if (_elm_lang$core$Native_Utils.cmp(index, 0) < 0) {
			return l;
		} else {
			var tail = _elm_lang$core$List$tail(
				A2(_elm_lang$core$List$drop, index, l));
			var head = A2(_elm_lang$core$List$take, index, l);
			var _p47 = tail;
			if (_p47.ctor === 'Nothing') {
				return l;
			} else {
				return A2(_elm_lang$core$List$append, head, _p47._0);
			}
		}
	});
var _elm_community$list_extra$List_Extra$stableSortWith = F2(
	function (pred, list) {
		var predWithIndex = F2(
			function (_p49, _p48) {
				var _p50 = _p49;
				var _p51 = _p48;
				var result = A2(pred, _p50._0, _p51._0);
				var _p52 = result;
				if (_p52.ctor === 'EQ') {
					return A2(_elm_lang$core$Basics$compare, _p50._1, _p51._1);
				} else {
					return result;
				}
			});
		var listWithIndex = A2(
			_elm_lang$core$List$indexedMap,
			F2(
				function (i, a) {
					return {ctor: '_Tuple2', _0: a, _1: i};
				}),
			list);
		return A2(
			_elm_lang$core$List$map,
			_elm_lang$core$Tuple$first,
			A2(_elm_lang$core$List$sortWith, predWithIndex, listWithIndex));
	});
var _elm_community$list_extra$List_Extra$setAt = F3(
	function (index, value, l) {
		if (_elm_lang$core$Native_Utils.cmp(index, 0) < 0) {
			return _elm_lang$core$Maybe$Nothing;
		} else {
			var tail = _elm_lang$core$List$tail(
				A2(_elm_lang$core$List$drop, index, l));
			var head = A2(_elm_lang$core$List$take, index, l);
			var _p53 = tail;
			if (_p53.ctor === 'Nothing') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				return _elm_lang$core$Maybe$Just(
					A2(
						_elm_lang$core$List$append,
						head,
						{ctor: '::', _0: value, _1: _p53._0}));
			}
		}
	});
var _elm_community$list_extra$List_Extra$remove = F2(
	function (x, xs) {
		var _p54 = xs;
		if (_p54.ctor === '[]') {
			return {ctor: '[]'};
		} else {
			var _p56 = _p54._1;
			var _p55 = _p54._0;
			return _elm_lang$core$Native_Utils.eq(x, _p55) ? _p56 : {
				ctor: '::',
				_0: _p55,
				_1: A2(_elm_community$list_extra$List_Extra$remove, x, _p56)
			};
		}
	});
var _elm_community$list_extra$List_Extra$updateIfIndex = F3(
	function (predicate, update, list) {
		return A2(
			_elm_lang$core$List$indexedMap,
			F2(
				function (i, x) {
					return predicate(i) ? update(x) : x;
				}),
			list);
	});
var _elm_community$list_extra$List_Extra$updateAt = F3(
	function (index, update, list) {
		return ((_elm_lang$core$Native_Utils.cmp(index, 0) < 0) || (_elm_lang$core$Native_Utils.cmp(
			index,
			_elm_lang$core$List$length(list)) > -1)) ? _elm_lang$core$Maybe$Nothing : _elm_lang$core$Maybe$Just(
			A3(
				_elm_community$list_extra$List_Extra$updateIfIndex,
				F2(
					function (x, y) {
						return _elm_lang$core$Native_Utils.eq(x, y);
					})(index),
				update,
				list));
	});
var _elm_community$list_extra$List_Extra$updateIf = F3(
	function (predicate, update, list) {
		return A2(
			_elm_lang$core$List$map,
			function (item) {
				return predicate(item) ? update(item) : item;
			},
			list);
	});
var _elm_community$list_extra$List_Extra$replaceIf = F3(
	function (predicate, replacement, list) {
		return A3(
			_elm_community$list_extra$List_Extra$updateIf,
			predicate,
			_elm_lang$core$Basics$always(replacement),
			list);
	});
var _elm_community$list_extra$List_Extra$findIndices = function (p) {
	return function (_p57) {
		return A2(
			_elm_lang$core$List$map,
			_elm_lang$core$Tuple$first,
			A2(
				_elm_lang$core$List$filter,
				function (_p58) {
					var _p59 = _p58;
					return p(_p59._1);
				},
				A2(
					_elm_lang$core$List$indexedMap,
					F2(
						function (v0, v1) {
							return {ctor: '_Tuple2', _0: v0, _1: v1};
						}),
					_p57)));
	};
};
var _elm_community$list_extra$List_Extra$findIndex = function (p) {
	return function (_p60) {
		return _elm_lang$core$List$head(
			A2(_elm_community$list_extra$List_Extra$findIndices, p, _p60));
	};
};
var _elm_community$list_extra$List_Extra$splitWhen = F2(
	function (predicate, list) {
		return A2(
			_elm_lang$core$Maybe$map,
			function (i) {
				return A2(_elm_community$list_extra$List_Extra$splitAt, i, list);
			},
			A2(_elm_community$list_extra$List_Extra$findIndex, predicate, list));
	});
var _elm_community$list_extra$List_Extra$elemIndices = function (x) {
	return _elm_community$list_extra$List_Extra$findIndices(
		F2(
			function (x, y) {
				return _elm_lang$core$Native_Utils.eq(x, y);
			})(x));
};
var _elm_community$list_extra$List_Extra$elemIndex = function (x) {
	return _elm_community$list_extra$List_Extra$findIndex(
		F2(
			function (x, y) {
				return _elm_lang$core$Native_Utils.eq(x, y);
			})(x));
};
var _elm_community$list_extra$List_Extra$find = F2(
	function (predicate, list) {
		find:
		while (true) {
			var _p61 = list;
			if (_p61.ctor === '[]') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				var _p62 = _p61._0;
				if (predicate(_p62)) {
					return _elm_lang$core$Maybe$Just(_p62);
				} else {
					var _v41 = predicate,
						_v42 = _p61._1;
					predicate = _v41;
					list = _v42;
					continue find;
				}
			}
		}
	});
var _elm_community$list_extra$List_Extra$notMember = function (x) {
	return function (_p63) {
		return !A2(_elm_lang$core$List$member, x, _p63);
	};
};
var _elm_community$list_extra$List_Extra$andThen = _elm_lang$core$List$concatMap;
var _elm_community$list_extra$List_Extra$lift2 = F3(
	function (f, la, lb) {
		return A2(
			_elm_community$list_extra$List_Extra$andThen,
			function (a) {
				return A2(
					_elm_community$list_extra$List_Extra$andThen,
					function (b) {
						return {
							ctor: '::',
							_0: A2(f, a, b),
							_1: {ctor: '[]'}
						};
					},
					lb);
			},
			la);
	});
var _elm_community$list_extra$List_Extra$lift3 = F4(
	function (f, la, lb, lc) {
		return A2(
			_elm_community$list_extra$List_Extra$andThen,
			function (a) {
				return A2(
					_elm_community$list_extra$List_Extra$andThen,
					function (b) {
						return A2(
							_elm_community$list_extra$List_Extra$andThen,
							function (c) {
								return {
									ctor: '::',
									_0: A3(f, a, b, c),
									_1: {ctor: '[]'}
								};
							},
							lc);
					},
					lb);
			},
			la);
	});
var _elm_community$list_extra$List_Extra$lift4 = F5(
	function (f, la, lb, lc, ld) {
		return A2(
			_elm_community$list_extra$List_Extra$andThen,
			function (a) {
				return A2(
					_elm_community$list_extra$List_Extra$andThen,
					function (b) {
						return A2(
							_elm_community$list_extra$List_Extra$andThen,
							function (c) {
								return A2(
									_elm_community$list_extra$List_Extra$andThen,
									function (d) {
										return {
											ctor: '::',
											_0: A4(f, a, b, c, d),
											_1: {ctor: '[]'}
										};
									},
									ld);
							},
							lc);
					},
					lb);
			},
			la);
	});
var _elm_community$list_extra$List_Extra$andMap = F2(
	function (l, fl) {
		return A3(
			_elm_lang$core$List$map2,
			F2(
				function (x, y) {
					return x(y);
				}),
			fl,
			l);
	});
var _elm_community$list_extra$List_Extra$uniqueHelp = F3(
	function (f, existing, remaining) {
		uniqueHelp:
		while (true) {
			var _p64 = remaining;
			if (_p64.ctor === '[]') {
				return {ctor: '[]'};
			} else {
				var _p66 = _p64._1;
				var _p65 = _p64._0;
				var computedFirst = f(_p65);
				if (A2(_elm_lang$core$Set$member, computedFirst, existing)) {
					var _v44 = f,
						_v45 = existing,
						_v46 = _p66;
					f = _v44;
					existing = _v45;
					remaining = _v46;
					continue uniqueHelp;
				} else {
					return {
						ctor: '::',
						_0: _p65,
						_1: A3(
							_elm_community$list_extra$List_Extra$uniqueHelp,
							f,
							A2(_elm_lang$core$Set$insert, computedFirst, existing),
							_p66)
					};
				}
			}
		}
	});
var _elm_community$list_extra$List_Extra$uniqueBy = F2(
	function (f, list) {
		return A3(_elm_community$list_extra$List_Extra$uniqueHelp, f, _elm_lang$core$Set$empty, list);
	});
var _elm_community$list_extra$List_Extra$allDifferentBy = F2(
	function (f, list) {
		return _elm_lang$core$Native_Utils.eq(
			_elm_lang$core$List$length(list),
			_elm_lang$core$List$length(
				A2(_elm_community$list_extra$List_Extra$uniqueBy, f, list)));
	});
var _elm_community$list_extra$List_Extra$allDifferent = function (list) {
	return A2(_elm_community$list_extra$List_Extra$allDifferentBy, _elm_lang$core$Basics$identity, list);
};
var _elm_community$list_extra$List_Extra$unique = function (list) {
	return A3(_elm_community$list_extra$List_Extra$uniqueHelp, _elm_lang$core$Basics$identity, _elm_lang$core$Set$empty, list);
};
var _elm_community$list_extra$List_Extra$dropWhile = F2(
	function (predicate, list) {
		dropWhile:
		while (true) {
			var _p67 = list;
			if (_p67.ctor === '[]') {
				return {ctor: '[]'};
			} else {
				if (predicate(_p67._0)) {
					var _v48 = predicate,
						_v49 = _p67._1;
					predicate = _v48;
					list = _v49;
					continue dropWhile;
				} else {
					return list;
				}
			}
		}
	});
var _elm_community$list_extra$List_Extra$takeWhile = function (predicate) {
	var takeWhileMemo = F2(
		function (memo, list) {
			takeWhileMemo:
			while (true) {
				var _p68 = list;
				if (_p68.ctor === '[]') {
					return _elm_lang$core$List$reverse(memo);
				} else {
					var _p69 = _p68._0;
					if (predicate(_p69)) {
						var _v51 = {ctor: '::', _0: _p69, _1: memo},
							_v52 = _p68._1;
						memo = _v51;
						list = _v52;
						continue takeWhileMemo;
					} else {
						return _elm_lang$core$List$reverse(memo);
					}
				}
			}
		});
	return takeWhileMemo(
		{ctor: '[]'});
};
var _elm_community$list_extra$List_Extra$span = F2(
	function (p, xs) {
		return {
			ctor: '_Tuple2',
			_0: A2(_elm_community$list_extra$List_Extra$takeWhile, p, xs),
			_1: A2(_elm_community$list_extra$List_Extra$dropWhile, p, xs)
		};
	});
var _elm_community$list_extra$List_Extra$break = function (p) {
	return _elm_community$list_extra$List_Extra$span(
		function (_p70) {
			return !p(_p70);
		});
};
var _elm_community$list_extra$List_Extra$groupWhile = F2(
	function (eq, xs_) {
		var _p71 = xs_;
		if (_p71.ctor === '[]') {
			return {ctor: '[]'};
		} else {
			var _p73 = _p71._0;
			var _p72 = A2(
				_elm_community$list_extra$List_Extra$span,
				eq(_p73),
				_p71._1);
			var ys = _p72._0;
			var zs = _p72._1;
			return {
				ctor: '::',
				_0: {ctor: '::', _0: _p73, _1: ys},
				_1: A2(_elm_community$list_extra$List_Extra$groupWhile, eq, zs)
			};
		}
	});
var _elm_community$list_extra$List_Extra$group = _elm_community$list_extra$List_Extra$groupWhile(
	F2(
		function (x, y) {
			return _elm_lang$core$Native_Utils.eq(x, y);
		}));
var _elm_community$list_extra$List_Extra$minimumBy = F2(
	function (f, ls) {
		var minBy = F2(
			function (x, _p74) {
				var _p75 = _p74;
				var _p76 = _p75._1;
				var fx = f(x);
				return (_elm_lang$core$Native_Utils.cmp(fx, _p76) < 0) ? {ctor: '_Tuple2', _0: x, _1: fx} : {ctor: '_Tuple2', _0: _p75._0, _1: _p76};
			});
		var _p77 = ls;
		if (_p77.ctor === '::') {
			if (_p77._1.ctor === '[]') {
				return _elm_lang$core$Maybe$Just(_p77._0);
			} else {
				var _p78 = _p77._0;
				return _elm_lang$core$Maybe$Just(
					_elm_lang$core$Tuple$first(
						A3(
							_elm_lang$core$List$foldl,
							minBy,
							{
								ctor: '_Tuple2',
								_0: _p78,
								_1: f(_p78)
							},
							_p77._1)));
			}
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_community$list_extra$List_Extra$maximumBy = F2(
	function (f, ls) {
		var maxBy = F2(
			function (x, _p79) {
				var _p80 = _p79;
				var _p81 = _p80._1;
				var fx = f(x);
				return (_elm_lang$core$Native_Utils.cmp(fx, _p81) > 0) ? {ctor: '_Tuple2', _0: x, _1: fx} : {ctor: '_Tuple2', _0: _p80._0, _1: _p81};
			});
		var _p82 = ls;
		if (_p82.ctor === '::') {
			if (_p82._1.ctor === '[]') {
				return _elm_lang$core$Maybe$Just(_p82._0);
			} else {
				var _p83 = _p82._0;
				return _elm_lang$core$Maybe$Just(
					_elm_lang$core$Tuple$first(
						A3(
							_elm_lang$core$List$foldl,
							maxBy,
							{
								ctor: '_Tuple2',
								_0: _p83,
								_1: f(_p83)
							},
							_p82._1)));
			}
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_community$list_extra$List_Extra$uncons = function (xs) {
	var _p84 = xs;
	if (_p84.ctor === '[]') {
		return _elm_lang$core$Maybe$Nothing;
	} else {
		return _elm_lang$core$Maybe$Just(
			{ctor: '_Tuple2', _0: _p84._0, _1: _p84._1});
	}
};
var _elm_community$list_extra$List_Extra$swapAt = F3(
	function (index1, index2, l) {
		swapAt:
		while (true) {
			if (_elm_lang$core$Native_Utils.eq(index1, index2)) {
				return _elm_lang$core$Maybe$Just(l);
			} else {
				if (_elm_lang$core$Native_Utils.cmp(index1, index2) > 0) {
					var _v59 = index2,
						_v60 = index1,
						_v61 = l;
					index1 = _v59;
					index2 = _v60;
					l = _v61;
					continue swapAt;
				} else {
					if (_elm_lang$core$Native_Utils.cmp(index1, 0) < 0) {
						return _elm_lang$core$Maybe$Nothing;
					} else {
						var _p85 = A2(_elm_community$list_extra$List_Extra$splitAt, index1, l);
						var part1 = _p85._0;
						var tail1 = _p85._1;
						var _p86 = A2(_elm_community$list_extra$List_Extra$splitAt, index2 - index1, tail1);
						var head2 = _p86._0;
						var tail2 = _p86._1;
						return A3(
							_elm_lang$core$Maybe$map2,
							F2(
								function (_p88, _p87) {
									var _p89 = _p88;
									var _p90 = _p87;
									return _elm_lang$core$List$concat(
										{
											ctor: '::',
											_0: part1,
											_1: {
												ctor: '::',
												_0: {ctor: '::', _0: _p90._0, _1: _p89._1},
												_1: {
													ctor: '::',
													_0: {ctor: '::', _0: _p89._0, _1: _p90._1},
													_1: {ctor: '[]'}
												}
											}
										});
								}),
							_elm_community$list_extra$List_Extra$uncons(head2),
							_elm_community$list_extra$List_Extra$uncons(tail2));
					}
				}
			}
		}
	});
var _elm_community$list_extra$List_Extra$iterate = F2(
	function (f, x) {
		var _p91 = f(x);
		if (_p91.ctor === 'Just') {
			return {
				ctor: '::',
				_0: x,
				_1: A2(_elm_community$list_extra$List_Extra$iterate, f, _p91._0)
			};
		} else {
			return {
				ctor: '::',
				_0: x,
				_1: {ctor: '[]'}
			};
		}
	});
var _elm_community$list_extra$List_Extra$getAt = F2(
	function (idx, xs) {
		return (_elm_lang$core$Native_Utils.cmp(idx, 0) < 0) ? _elm_lang$core$Maybe$Nothing : _elm_lang$core$List$head(
			A2(_elm_lang$core$List$drop, idx, xs));
	});
var _elm_community$list_extra$List_Extra_ops = _elm_community$list_extra$List_Extra_ops || {};
_elm_community$list_extra$List_Extra_ops['!!'] = _elm_lang$core$Basics$flip(_elm_community$list_extra$List_Extra$getAt);
var _elm_community$list_extra$List_Extra$init = function () {
	var maybe = F2(
		function (d, f) {
			return function (_p92) {
				return A2(
					_elm_lang$core$Maybe$withDefault,
					d,
					A2(_elm_lang$core$Maybe$map, f, _p92));
			};
		});
	return A2(
		_elm_lang$core$List$foldr,
		function (x) {
			return function (_p93) {
				return _elm_lang$core$Maybe$Just(
					A3(
						maybe,
						{ctor: '[]'},
						F2(
							function (x, y) {
								return {ctor: '::', _0: x, _1: y};
							})(x),
						_p93));
			};
		},
		_elm_lang$core$Maybe$Nothing);
}();
var _elm_community$list_extra$List_Extra$last = _elm_community$list_extra$List_Extra$foldl1(
	_elm_lang$core$Basics$flip(_elm_lang$core$Basics$always));

var _elm_community$maybe_extra$Maybe_Extra$foldrValues = F2(
	function (item, list) {
		var _p0 = item;
		if (_p0.ctor === 'Nothing') {
			return list;
		} else {
			return {ctor: '::', _0: _p0._0, _1: list};
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$values = A2(
	_elm_lang$core$List$foldr,
	_elm_community$maybe_extra$Maybe_Extra$foldrValues,
	{ctor: '[]'});
var _elm_community$maybe_extra$Maybe_Extra$filter = F2(
	function (f, m) {
		var _p1 = A2(_elm_lang$core$Maybe$map, f, m);
		if ((_p1.ctor === 'Just') && (_p1._0 === true)) {
			return m;
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$traverseArray = function (f) {
	var step = F2(
		function (e, acc) {
			var _p2 = f(e);
			if (_p2.ctor === 'Nothing') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				return A2(
					_elm_lang$core$Maybe$map,
					_elm_lang$core$Array$push(_p2._0),
					acc);
			}
		});
	return A2(
		_elm_lang$core$Array$foldl,
		step,
		_elm_lang$core$Maybe$Just(_elm_lang$core$Array$empty));
};
var _elm_community$maybe_extra$Maybe_Extra$combineArray = _elm_community$maybe_extra$Maybe_Extra$traverseArray(_elm_lang$core$Basics$identity);
var _elm_community$maybe_extra$Maybe_Extra$traverse = function (f) {
	var step = F2(
		function (e, acc) {
			var _p3 = f(e);
			if (_p3.ctor === 'Nothing') {
				return _elm_lang$core$Maybe$Nothing;
			} else {
				return A2(
					_elm_lang$core$Maybe$map,
					F2(
						function (x, y) {
							return {ctor: '::', _0: x, _1: y};
						})(_p3._0),
					acc);
			}
		});
	return A2(
		_elm_lang$core$List$foldr,
		step,
		_elm_lang$core$Maybe$Just(
			{ctor: '[]'}));
};
var _elm_community$maybe_extra$Maybe_Extra$combine = _elm_community$maybe_extra$Maybe_Extra$traverse(_elm_lang$core$Basics$identity);
var _elm_community$maybe_extra$Maybe_Extra$toArray = function (m) {
	var _p4 = m;
	if (_p4.ctor === 'Nothing') {
		return _elm_lang$core$Array$empty;
	} else {
		return A2(_elm_lang$core$Array$repeat, 1, _p4._0);
	}
};
var _elm_community$maybe_extra$Maybe_Extra$toList = function (m) {
	var _p5 = m;
	if (_p5.ctor === 'Nothing') {
		return {ctor: '[]'};
	} else {
		return {
			ctor: '::',
			_0: _p5._0,
			_1: {ctor: '[]'}
		};
	}
};
var _elm_community$maybe_extra$Maybe_Extra$orElse = F2(
	function (ma, mb) {
		var _p6 = mb;
		if (_p6.ctor === 'Nothing') {
			return ma;
		} else {
			return mb;
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$orElseLazy = F2(
	function (fma, mb) {
		var _p7 = mb;
		if (_p7.ctor === 'Nothing') {
			return fma(
				{ctor: '_Tuple0'});
		} else {
			return mb;
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$orLazy = F2(
	function (ma, fmb) {
		var _p8 = ma;
		if (_p8.ctor === 'Nothing') {
			return fmb(
				{ctor: '_Tuple0'});
		} else {
			return ma;
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$or = F2(
	function (ma, mb) {
		var _p9 = ma;
		if (_p9.ctor === 'Nothing') {
			return mb;
		} else {
			return ma;
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$prev = _elm_lang$core$Maybe$map2(_elm_lang$core$Basics$always);
var _elm_community$maybe_extra$Maybe_Extra$next = _elm_lang$core$Maybe$map2(
	_elm_lang$core$Basics$flip(_elm_lang$core$Basics$always));
var _elm_community$maybe_extra$Maybe_Extra$andMap = _elm_lang$core$Maybe$map2(
	F2(
		function (x, y) {
			return y(x);
		}));
var _elm_community$maybe_extra$Maybe_Extra$unpack = F3(
	function (d, f, m) {
		var _p10 = m;
		if (_p10.ctor === 'Nothing') {
			return d(
				{ctor: '_Tuple0'});
		} else {
			return f(_p10._0);
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$unwrap = F3(
	function (d, f, m) {
		var _p11 = m;
		if (_p11.ctor === 'Nothing') {
			return d;
		} else {
			return f(_p11._0);
		}
	});
var _elm_community$maybe_extra$Maybe_Extra$isJust = function (m) {
	var _p12 = m;
	if (_p12.ctor === 'Nothing') {
		return false;
	} else {
		return true;
	}
};
var _elm_community$maybe_extra$Maybe_Extra$isNothing = function (m) {
	var _p13 = m;
	if (_p13.ctor === 'Nothing') {
		return true;
	} else {
		return false;
	}
};
var _elm_community$maybe_extra$Maybe_Extra$join = function (mx) {
	var _p14 = mx;
	if (_p14.ctor === 'Just') {
		return _p14._0;
	} else {
		return _elm_lang$core$Maybe$Nothing;
	}
};
var _elm_community$maybe_extra$Maybe_Extra_ops = _elm_community$maybe_extra$Maybe_Extra_ops || {};
_elm_community$maybe_extra$Maybe_Extra_ops['?'] = F2(
	function (mx, x) {
		return A2(_elm_lang$core$Maybe$withDefault, x, mx);
	});

var _elm_community$random_extra$Random_Extra$andThen6 = F7(
	function (constructor, generatorA, generatorB, generatorC, generatorD, generatorE, generatorF) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							function (c) {
								return A2(
									_elm_lang$core$Random$andThen,
									function (d) {
										return A2(
											_elm_lang$core$Random$andThen,
											function (e) {
												return A2(
													_elm_lang$core$Random$andThen,
													function (f) {
														return A6(constructor, a, b, c, d, e, f);
													},
													generatorF);
											},
											generatorE);
									},
									generatorD);
							},
							generatorC);
					},
					generatorB);
			},
			generatorA);
	});
var _elm_community$random_extra$Random_Extra$andThen5 = F6(
	function (constructor, generatorA, generatorB, generatorC, generatorD, generatorE) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							function (c) {
								return A2(
									_elm_lang$core$Random$andThen,
									function (d) {
										return A2(
											_elm_lang$core$Random$andThen,
											function (e) {
												return A5(constructor, a, b, c, d, e);
											},
											generatorE);
									},
									generatorD);
							},
							generatorC);
					},
					generatorB);
			},
			generatorA);
	});
var _elm_community$random_extra$Random_Extra$andThen4 = F5(
	function (constructor, generatorA, generatorB, generatorC, generatorD) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							function (c) {
								return A2(
									_elm_lang$core$Random$andThen,
									function (d) {
										return A4(constructor, a, b, c, d);
									},
									generatorD);
							},
							generatorC);
					},
					generatorB);
			},
			generatorA);
	});
var _elm_community$random_extra$Random_Extra$andThen3 = F4(
	function (constructor, generatorA, generatorB, generatorC) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					function (b) {
						return A2(
							_elm_lang$core$Random$andThen,
							function (c) {
								return A3(constructor, a, b, c);
							},
							generatorC);
					},
					generatorB);
			},
			generatorA);
	});
var _elm_community$random_extra$Random_Extra$andThen2 = F3(
	function (constructor, generatorA, generatorB) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (a) {
				return A2(
					_elm_lang$core$Random$andThen,
					function (b) {
						return A2(constructor, a, b);
					},
					generatorB);
			},
			generatorA);
	});
var _elm_community$random_extra$Random_Extra$rangeLengthList = F3(
	function (minLength, maxLength, generator) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (len) {
				return A2(_elm_lang$core$Random$list, len, generator);
			},
			A2(_elm_lang$core$Random$int, minLength, maxLength));
	});
var _elm_community$random_extra$Random_Extra$result = F3(
	function (genBool, genErr, genVal) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (b) {
				return b ? A2(_elm_lang$core$Random$map, _elm_lang$core$Result$Ok, genVal) : A2(_elm_lang$core$Random$map, _elm_lang$core$Result$Err, genErr);
			},
			genBool);
	});
var _elm_community$random_extra$Random_Extra$sample = function () {
	var find = F2(
		function (k, ys) {
			find:
			while (true) {
				var _p0 = ys;
				if (_p0.ctor === '[]') {
					return _elm_lang$core$Maybe$Nothing;
				} else {
					if (_elm_lang$core$Native_Utils.eq(k, 0)) {
						return _elm_lang$core$Maybe$Just(_p0._0);
					} else {
						var _v1 = k - 1,
							_v2 = _p0._1;
						k = _v1;
						ys = _v2;
						continue find;
					}
				}
			}
		});
	return function (xs) {
		return A2(
			_elm_lang$core$Random$map,
			function (i) {
				return A2(find, i, xs);
			},
			A2(
				_elm_lang$core$Random$int,
				0,
				_elm_lang$core$List$length(xs) - 1));
	};
}();
var _elm_community$random_extra$Random_Extra$frequency = function (pairs) {
	var pick = F2(
		function (choices, n) {
			pick:
			while (true) {
				var _p1 = choices;
				if ((_p1.ctor === '::') && (_p1._0.ctor === '_Tuple2')) {
					var _p2 = _p1._0._0;
					if (_elm_lang$core$Native_Utils.cmp(n, _p2) < 1) {
						return _p1._0._1;
					} else {
						var _v4 = _p1._1,
							_v5 = n - _p2;
						choices = _v4;
						n = _v5;
						continue pick;
					}
				} else {
					return _elm_lang$core$Native_Utils.crashCase(
						'Random.Extra',
						{
							start: {line: 154, column: 13},
							end: {line: 162, column: 79}
						},
						_p1)('Empty list passed to Random.Extra.frequency!');
				}
			}
		});
	var total = _elm_lang$core$List$sum(
		A2(
			_elm_lang$core$List$map,
			function (_p4) {
				return _elm_lang$core$Basics$abs(
					_elm_lang$core$Tuple$first(_p4));
			},
			pairs));
	return A2(
		_elm_lang$core$Random$andThen,
		pick(pairs),
		A2(_elm_lang$core$Random$float, 0, total));
};
var _elm_community$random_extra$Random_Extra$choices = function (gens) {
	return _elm_community$random_extra$Random_Extra$frequency(
		A2(
			_elm_lang$core$List$map,
			function (g) {
				return {ctor: '_Tuple2', _0: 1, _1: g};
			},
			gens));
};
var _elm_community$random_extra$Random_Extra$choice = F2(
	function (x, y) {
		return A2(
			_elm_lang$core$Random$map,
			function (b) {
				return b ? x : y;
			},
			_elm_lang$core$Random$bool);
	});
var _elm_community$random_extra$Random_Extra$oneIn = function (n) {
	return A2(
		_elm_lang$core$Random$map,
		F2(
			function (x, y) {
				return _elm_lang$core$Native_Utils.eq(x, y);
			})(1),
		A2(_elm_lang$core$Random$int, 1, n));
};
var _elm_community$random_extra$Random_Extra$andMap = F2(
	function (generator, funcGenerator) {
		return A3(
			_elm_lang$core$Random$map2,
			F2(
				function (x, y) {
					return x(y);
				}),
			funcGenerator,
			generator);
	});
var _elm_community$random_extra$Random_Extra$map6 = F7(
	function (f, generatorA, generatorB, generatorC, generatorD, generatorE, generatorF) {
		return A2(
			_elm_community$random_extra$Random_Extra$andMap,
			generatorF,
			A6(_elm_lang$core$Random$map5, f, generatorA, generatorB, generatorC, generatorD, generatorE));
	});
var _elm_community$random_extra$Random_Extra$constant = function (value) {
	return A2(
		_elm_lang$core$Random$map,
		function (_p5) {
			return value;
		},
		_elm_lang$core$Random$bool);
};
var _elm_community$random_extra$Random_Extra$filter = F2(
	function (predicate, generator) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (a) {
				return predicate(a) ? _elm_community$random_extra$Random_Extra$constant(a) : A2(_elm_community$random_extra$Random_Extra$filter, predicate, generator);
			},
			generator);
	});
var _elm_community$random_extra$Random_Extra$combine = function (generators) {
	var _p6 = generators;
	if (_p6.ctor === '[]') {
		return _elm_community$random_extra$Random_Extra$constant(
			{ctor: '[]'});
	} else {
		return A3(
			_elm_lang$core$Random$map2,
			F2(
				function (x, y) {
					return {ctor: '::', _0: x, _1: y};
				}),
			_p6._0,
			_elm_community$random_extra$Random_Extra$combine(_p6._1));
	}
};
var _elm_community$random_extra$Random_Extra$maybe = F2(
	function (genBool, genA) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (b) {
				return b ? A2(_elm_lang$core$Random$map, _elm_lang$core$Maybe$Just, genA) : _elm_community$random_extra$Random_Extra$constant(_elm_lang$core$Maybe$Nothing);
			},
			genBool);
	});

var _elm_community$random_extra$Random_Char$char = F2(
	function (start, end) {
		return A2(
			_elm_lang$core$Random$map,
			_elm_lang$core$Char$fromCode,
			A2(_elm_lang$core$Random$int, start, end));
	});
var _elm_community$random_extra$Random_Char$upperCaseLatin = A2(_elm_community$random_extra$Random_Char$char, 65, 90);
var _elm_community$random_extra$Random_Char$lowerCaseLatin = A2(_elm_community$random_extra$Random_Char$char, 97, 122);
var _elm_community$random_extra$Random_Char$latin = _elm_community$random_extra$Random_Extra$choices(
	{
		ctor: '::',
		_0: _elm_community$random_extra$Random_Char$lowerCaseLatin,
		_1: {
			ctor: '::',
			_0: _elm_community$random_extra$Random_Char$upperCaseLatin,
			_1: {ctor: '[]'}
		}
	});
var _elm_community$random_extra$Random_Char$english = _elm_community$random_extra$Random_Char$latin;
var _elm_community$random_extra$Random_Char$ascii = A2(_elm_community$random_extra$Random_Char$char, 0, 127);
var _elm_community$random_extra$Random_Char$unicode = A2(_elm_community$random_extra$Random_Char$char, 0, 1114111);
var _elm_community$random_extra$Random_Char$basicLatin = A2(_elm_community$random_extra$Random_Char$char, 0, 127);
var _elm_community$random_extra$Random_Char$latin1Supplement = A2(_elm_community$random_extra$Random_Char$char, 128, 255);
var _elm_community$random_extra$Random_Char$latinExtendedA = A2(_elm_community$random_extra$Random_Char$char, 256, 383);
var _elm_community$random_extra$Random_Char$latinExtendedB = A2(_elm_community$random_extra$Random_Char$char, 384, 591);
var _elm_community$random_extra$Random_Char$ipaExtensions = A2(_elm_community$random_extra$Random_Char$char, 592, 687);
var _elm_community$random_extra$Random_Char$spacingModifier = A2(_elm_community$random_extra$Random_Char$char, 688, 767);
var _elm_community$random_extra$Random_Char$combiningDiacriticalMarks = A2(_elm_community$random_extra$Random_Char$char, 768, 879);
var _elm_community$random_extra$Random_Char$greekAndCoptic = A2(_elm_community$random_extra$Random_Char$char, 880, 1023);
var _elm_community$random_extra$Random_Char$cyrillic = A2(_elm_community$random_extra$Random_Char$char, 1024, 1279);
var _elm_community$random_extra$Random_Char$cyrillicSupplement = A2(_elm_community$random_extra$Random_Char$char, 1280, 1327);
var _elm_community$random_extra$Random_Char$armenian = A2(_elm_community$random_extra$Random_Char$char, 1328, 1423);
var _elm_community$random_extra$Random_Char$hebrew = A2(_elm_community$random_extra$Random_Char$char, 1424, 1535);
var _elm_community$random_extra$Random_Char$arabic = A2(_elm_community$random_extra$Random_Char$char, 1536, 1791);
var _elm_community$random_extra$Random_Char$syriac = A2(_elm_community$random_extra$Random_Char$char, 1792, 1871);
var _elm_community$random_extra$Random_Char$arabicSupplement = A2(_elm_community$random_extra$Random_Char$char, 1872, 1919);
var _elm_community$random_extra$Random_Char$thaana = A2(_elm_community$random_extra$Random_Char$char, 1920, 1983);
var _elm_community$random_extra$Random_Char$nko = A2(_elm_community$random_extra$Random_Char$char, 1984, 2047);
var _elm_community$random_extra$Random_Char$samaritan = A2(_elm_community$random_extra$Random_Char$char, 2048, 2111);
var _elm_community$random_extra$Random_Char$mandaic = A2(_elm_community$random_extra$Random_Char$char, 2112, 2143);
var _elm_community$random_extra$Random_Char$arabicExtendedA = A2(_elm_community$random_extra$Random_Char$char, 2208, 2303);
var _elm_community$random_extra$Random_Char$devanagari = A2(_elm_community$random_extra$Random_Char$char, 2304, 2431);
var _elm_community$random_extra$Random_Char$bengali = A2(_elm_community$random_extra$Random_Char$char, 2432, 2559);
var _elm_community$random_extra$Random_Char$gurmukhi = A2(_elm_community$random_extra$Random_Char$char, 2560, 2687);
var _elm_community$random_extra$Random_Char$gujarati = A2(_elm_community$random_extra$Random_Char$char, 2688, 2815);
var _elm_community$random_extra$Random_Char$oriya = A2(_elm_community$random_extra$Random_Char$char, 2816, 2943);
var _elm_community$random_extra$Random_Char$tamil = A2(_elm_community$random_extra$Random_Char$char, 2944, 3071);
var _elm_community$random_extra$Random_Char$telugu = A2(_elm_community$random_extra$Random_Char$char, 3072, 3199);
var _elm_community$random_extra$Random_Char$kannada = A2(_elm_community$random_extra$Random_Char$char, 3200, 3327);
var _elm_community$random_extra$Random_Char$malayalam = A2(_elm_community$random_extra$Random_Char$char, 3328, 3455);
var _elm_community$random_extra$Random_Char$sinhala = A2(_elm_community$random_extra$Random_Char$char, 3456, 3583);
var _elm_community$random_extra$Random_Char$thai = A2(_elm_community$random_extra$Random_Char$char, 3584, 3711);
var _elm_community$random_extra$Random_Char$lao = A2(_elm_community$random_extra$Random_Char$char, 3712, 3839);
var _elm_community$random_extra$Random_Char$tibetan = A2(_elm_community$random_extra$Random_Char$char, 3840, 4095);
var _elm_community$random_extra$Random_Char$myanmar = A2(_elm_community$random_extra$Random_Char$char, 4096, 4255);
var _elm_community$random_extra$Random_Char$georgian = A2(_elm_community$random_extra$Random_Char$char, 4256, 4351);
var _elm_community$random_extra$Random_Char$hangulJamo = A2(_elm_community$random_extra$Random_Char$char, 4352, 4607);
var _elm_community$random_extra$Random_Char$ethiopic = A2(_elm_community$random_extra$Random_Char$char, 4608, 4991);
var _elm_community$random_extra$Random_Char$ethiopicSupplement = A2(_elm_community$random_extra$Random_Char$char, 4992, 5023);
var _elm_community$random_extra$Random_Char$cherokee = A2(_elm_community$random_extra$Random_Char$char, 5024, 5119);
var _elm_community$random_extra$Random_Char$unifiedCanadianAboriginalSyllabic = A2(_elm_community$random_extra$Random_Char$char, 5120, 5759);
var _elm_community$random_extra$Random_Char$ogham = A2(_elm_community$random_extra$Random_Char$char, 5760, 5791);
var _elm_community$random_extra$Random_Char$runic = A2(_elm_community$random_extra$Random_Char$char, 5792, 5887);
var _elm_community$random_extra$Random_Char$tagalog = A2(_elm_community$random_extra$Random_Char$char, 5888, 5919);
var _elm_community$random_extra$Random_Char$hanunoo = A2(_elm_community$random_extra$Random_Char$char, 5920, 5951);
var _elm_community$random_extra$Random_Char$buhid = A2(_elm_community$random_extra$Random_Char$char, 5952, 5983);
var _elm_community$random_extra$Random_Char$tagbanwa = A2(_elm_community$random_extra$Random_Char$char, 5984, 6015);
var _elm_community$random_extra$Random_Char$khmer = A2(_elm_community$random_extra$Random_Char$char, 6016, 6143);
var _elm_community$random_extra$Random_Char$mongolian = A2(_elm_community$random_extra$Random_Char$char, 6144, 6319);
var _elm_community$random_extra$Random_Char$unifiedCanadianAboriginalSyllabicExtended = A2(_elm_community$random_extra$Random_Char$char, 6320, 6399);
var _elm_community$random_extra$Random_Char$limbu = A2(_elm_community$random_extra$Random_Char$char, 6400, 6479);
var _elm_community$random_extra$Random_Char$taiLe = A2(_elm_community$random_extra$Random_Char$char, 6480, 6527);
var _elm_community$random_extra$Random_Char$newTaiLue = A2(_elm_community$random_extra$Random_Char$char, 6528, 6623);
var _elm_community$random_extra$Random_Char$khmerSymbol = A2(_elm_community$random_extra$Random_Char$char, 6624, 6655);
var _elm_community$random_extra$Random_Char$buginese = A2(_elm_community$random_extra$Random_Char$char, 6656, 6687);
var _elm_community$random_extra$Random_Char$taiTham = A2(_elm_community$random_extra$Random_Char$char, 6688, 6831);
var _elm_community$random_extra$Random_Char$balinese = A2(_elm_community$random_extra$Random_Char$char, 6912, 7039);
var _elm_community$random_extra$Random_Char$sundanese = A2(_elm_community$random_extra$Random_Char$char, 7040, 7103);
var _elm_community$random_extra$Random_Char$batak = A2(_elm_community$random_extra$Random_Char$char, 7104, 7167);
var _elm_community$random_extra$Random_Char$lepcha = A2(_elm_community$random_extra$Random_Char$char, 7168, 7247);
var _elm_community$random_extra$Random_Char$olChiki = A2(_elm_community$random_extra$Random_Char$char, 7248, 7295);
var _elm_community$random_extra$Random_Char$sundaneseSupplement = A2(_elm_community$random_extra$Random_Char$char, 7360, 7375);
var _elm_community$random_extra$Random_Char$vedicExtensions = A2(_elm_community$random_extra$Random_Char$char, 7376, 7423);
var _elm_community$random_extra$Random_Char$phoneticExtensions = A2(_elm_community$random_extra$Random_Char$char, 7424, 7551);
var _elm_community$random_extra$Random_Char$phoneticExtensionsSupplement = A2(_elm_community$random_extra$Random_Char$char, 7552, 7615);
var _elm_community$random_extra$Random_Char$combiningDiacriticalMarksSupplement = A2(_elm_community$random_extra$Random_Char$char, 7616, 7679);
var _elm_community$random_extra$Random_Char$latinExtendedAdditional = A2(_elm_community$random_extra$Random_Char$char, 7680, 7935);
var _elm_community$random_extra$Random_Char$greekExtended = A2(_elm_community$random_extra$Random_Char$char, 7936, 8191);
var _elm_community$random_extra$Random_Char$generalPunctuation = A2(_elm_community$random_extra$Random_Char$char, 8192, 8303);
var _elm_community$random_extra$Random_Char$superscriptOrSubscript = A2(_elm_community$random_extra$Random_Char$char, 8304, 8351);
var _elm_community$random_extra$Random_Char$currencySymbol = A2(_elm_community$random_extra$Random_Char$char, 8352, 8399);
var _elm_community$random_extra$Random_Char$combiningDiacriticalMarksForSymbols = A2(_elm_community$random_extra$Random_Char$char, 8400, 8447);
var _elm_community$random_extra$Random_Char$letterlikeSymbol = A2(_elm_community$random_extra$Random_Char$char, 8448, 8527);
var _elm_community$random_extra$Random_Char$numberForm = A2(_elm_community$random_extra$Random_Char$char, 8528, 8591);
var _elm_community$random_extra$Random_Char$arrow = A2(_elm_community$random_extra$Random_Char$char, 8592, 8703);
var _elm_community$random_extra$Random_Char$mathematicalOperator = A2(_elm_community$random_extra$Random_Char$char, 8704, 8959);
var _elm_community$random_extra$Random_Char$miscellaneousTechnical = A2(_elm_community$random_extra$Random_Char$char, 8960, 9215);
var _elm_community$random_extra$Random_Char$controlPicture = A2(_elm_community$random_extra$Random_Char$char, 9216, 9279);
var _elm_community$random_extra$Random_Char$opticalCharacterRecognition = A2(_elm_community$random_extra$Random_Char$char, 9280, 9311);
var _elm_community$random_extra$Random_Char$enclosedAlphanumeric = A2(_elm_community$random_extra$Random_Char$char, 9312, 9471);
var _elm_community$random_extra$Random_Char$boxDrawing = A2(_elm_community$random_extra$Random_Char$char, 9472, 9599);
var _elm_community$random_extra$Random_Char$blockElement = A2(_elm_community$random_extra$Random_Char$char, 9600, 9631);
var _elm_community$random_extra$Random_Char$geometricShape = A2(_elm_community$random_extra$Random_Char$char, 9632, 9727);
var _elm_community$random_extra$Random_Char$miscellaneousSymbol = A2(_elm_community$random_extra$Random_Char$char, 9728, 9983);
var _elm_community$random_extra$Random_Char$dingbat = A2(_elm_community$random_extra$Random_Char$char, 9984, 10175);
var _elm_community$random_extra$Random_Char$miscellaneousMathematicalSymbolA = A2(_elm_community$random_extra$Random_Char$char, 10176, 10223);
var _elm_community$random_extra$Random_Char$supplementalArrowA = A2(_elm_community$random_extra$Random_Char$char, 10224, 10239);
var _elm_community$random_extra$Random_Char$braillePattern = A2(_elm_community$random_extra$Random_Char$char, 10240, 10495);
var _elm_community$random_extra$Random_Char$supplementalArrowB = A2(_elm_community$random_extra$Random_Char$char, 10496, 10623);
var _elm_community$random_extra$Random_Char$miscellaneousMathematicalSymbolB = A2(_elm_community$random_extra$Random_Char$char, 10624, 10751);
var _elm_community$random_extra$Random_Char$supplementalMathematicalOperator = A2(_elm_community$random_extra$Random_Char$char, 10752, 11007);
var _elm_community$random_extra$Random_Char$miscellaneousSymbolOrArrow = A2(_elm_community$random_extra$Random_Char$char, 11008, 11263);
var _elm_community$random_extra$Random_Char$glagolitic = A2(_elm_community$random_extra$Random_Char$char, 11264, 11359);
var _elm_community$random_extra$Random_Char$latinExtendedC = A2(_elm_community$random_extra$Random_Char$char, 11360, 11391);
var _elm_community$random_extra$Random_Char$coptic = A2(_elm_community$random_extra$Random_Char$char, 11392, 11519);
var _elm_community$random_extra$Random_Char$georgianSupplement = A2(_elm_community$random_extra$Random_Char$char, 11520, 11567);
var _elm_community$random_extra$Random_Char$tifinagh = A2(_elm_community$random_extra$Random_Char$char, 11568, 11647);
var _elm_community$random_extra$Random_Char$ethiopicExtended = A2(_elm_community$random_extra$Random_Char$char, 11648, 11743);
var _elm_community$random_extra$Random_Char$cyrillicExtendedA = A2(_elm_community$random_extra$Random_Char$char, 11744, 11775);
var _elm_community$random_extra$Random_Char$supplementalPunctuation = A2(_elm_community$random_extra$Random_Char$char, 11776, 11903);
var _elm_community$random_extra$Random_Char$cjkRadicalSupplement = A2(_elm_community$random_extra$Random_Char$char, 11904, 12031);
var _elm_community$random_extra$Random_Char$kangxiRadical = A2(_elm_community$random_extra$Random_Char$char, 12032, 12255);
var _elm_community$random_extra$Random_Char$ideographicDescription = A2(_elm_community$random_extra$Random_Char$char, 12272, 12287);
var _elm_community$random_extra$Random_Char$cjkSymbolOrPunctuation = A2(_elm_community$random_extra$Random_Char$char, 12288, 12351);
var _elm_community$random_extra$Random_Char$hiragana = A2(_elm_community$random_extra$Random_Char$char, 12352, 12447);
var _elm_community$random_extra$Random_Char$katakana = A2(_elm_community$random_extra$Random_Char$char, 12448, 12543);
var _elm_community$random_extra$Random_Char$bopomofo = A2(_elm_community$random_extra$Random_Char$char, 12544, 12591);
var _elm_community$random_extra$Random_Char$hangulCompatibilityJamo = A2(_elm_community$random_extra$Random_Char$char, 12592, 12687);
var _elm_community$random_extra$Random_Char$kanbun = A2(_elm_community$random_extra$Random_Char$char, 12688, 12703);
var _elm_community$random_extra$Random_Char$bopomofoExtended = A2(_elm_community$random_extra$Random_Char$char, 12704, 12735);
var _elm_community$random_extra$Random_Char$cjkStroke = A2(_elm_community$random_extra$Random_Char$char, 12736, 12783);
var _elm_community$random_extra$Random_Char$katakanaPhoneticExtension = A2(_elm_community$random_extra$Random_Char$char, 12784, 12799);
var _elm_community$random_extra$Random_Char$enclosedCJKLetterOrMonth = A2(_elm_community$random_extra$Random_Char$char, 12800, 13055);
var _elm_community$random_extra$Random_Char$cjkCompatibility = A2(_elm_community$random_extra$Random_Char$char, 13056, 13311);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionA = A2(_elm_community$random_extra$Random_Char$char, 13312, 19903);
var _elm_community$random_extra$Random_Char$yijingHexagramSymbol = A2(_elm_community$random_extra$Random_Char$char, 19904, 19967);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeograph = A2(_elm_community$random_extra$Random_Char$char, 19968, 40959);
var _elm_community$random_extra$Random_Char$yiSyllable = A2(_elm_community$random_extra$Random_Char$char, 40960, 42127);
var _elm_community$random_extra$Random_Char$yiRadical = A2(_elm_community$random_extra$Random_Char$char, 42128, 42191);
var _elm_community$random_extra$Random_Char$lisu = A2(_elm_community$random_extra$Random_Char$char, 42192, 42239);
var _elm_community$random_extra$Random_Char$vai = A2(_elm_community$random_extra$Random_Char$char, 42240, 42559);
var _elm_community$random_extra$Random_Char$cyrillicExtendedB = A2(_elm_community$random_extra$Random_Char$char, 42560, 42655);
var _elm_community$random_extra$Random_Char$bamum = A2(_elm_community$random_extra$Random_Char$char, 42656, 42751);
var _elm_community$random_extra$Random_Char$modifierToneLetter = A2(_elm_community$random_extra$Random_Char$char, 42752, 42783);
var _elm_community$random_extra$Random_Char$latinExtendedD = A2(_elm_community$random_extra$Random_Char$char, 42784, 43007);
var _elm_community$random_extra$Random_Char$sylotiNagri = A2(_elm_community$random_extra$Random_Char$char, 43008, 43055);
var _elm_community$random_extra$Random_Char$commonIndicNumberForm = A2(_elm_community$random_extra$Random_Char$char, 43056, 43071);
var _elm_community$random_extra$Random_Char$phagsPa = A2(_elm_community$random_extra$Random_Char$char, 43072, 43135);
var _elm_community$random_extra$Random_Char$saurashtra = A2(_elm_community$random_extra$Random_Char$char, 43136, 43231);
var _elm_community$random_extra$Random_Char$devanagariExtended = A2(_elm_community$random_extra$Random_Char$char, 43232, 43263);
var _elm_community$random_extra$Random_Char$kayahLi = A2(_elm_community$random_extra$Random_Char$char, 43264, 43311);
var _elm_community$random_extra$Random_Char$rejang = A2(_elm_community$random_extra$Random_Char$char, 43312, 43359);
var _elm_community$random_extra$Random_Char$hangulJamoExtendedA = A2(_elm_community$random_extra$Random_Char$char, 43360, 43391);
var _elm_community$random_extra$Random_Char$javanese = A2(_elm_community$random_extra$Random_Char$char, 43392, 43487);
var _elm_community$random_extra$Random_Char$cham = A2(_elm_community$random_extra$Random_Char$char, 43520, 43615);
var _elm_community$random_extra$Random_Char$myanmarExtendedA = A2(_elm_community$random_extra$Random_Char$char, 43616, 43647);
var _elm_community$random_extra$Random_Char$taiViet = A2(_elm_community$random_extra$Random_Char$char, 43648, 43743);
var _elm_community$random_extra$Random_Char$meeteiMayekExtension = A2(_elm_community$random_extra$Random_Char$char, 43744, 43775);
var _elm_community$random_extra$Random_Char$ethiopicExtendedA = A2(_elm_community$random_extra$Random_Char$char, 43776, 43823);
var _elm_community$random_extra$Random_Char$meeteiMayek = A2(_elm_community$random_extra$Random_Char$char, 43968, 44031);
var _elm_community$random_extra$Random_Char$hangulSyllable = A2(_elm_community$random_extra$Random_Char$char, 44032, 55215);
var _elm_community$random_extra$Random_Char$hangulJamoExtendedB = A2(_elm_community$random_extra$Random_Char$char, 55216, 55295);
var _elm_community$random_extra$Random_Char$highSurrogate = A2(_elm_community$random_extra$Random_Char$char, 55296, 56191);
var _elm_community$random_extra$Random_Char$highPrivateUseSurrogate = A2(_elm_community$random_extra$Random_Char$char, 56192, 56319);
var _elm_community$random_extra$Random_Char$lowSurrogate = A2(_elm_community$random_extra$Random_Char$char, 56320, 57343);
var _elm_community$random_extra$Random_Char$privateUseArea = A2(_elm_community$random_extra$Random_Char$char, 57344, 63743);
var _elm_community$random_extra$Random_Char$cjkCompatibilityIdeograph = A2(_elm_community$random_extra$Random_Char$char, 63744, 64255);
var _elm_community$random_extra$Random_Char$alphabeticPresentationForm = A2(_elm_community$random_extra$Random_Char$char, 64256, 64335);
var _elm_community$random_extra$Random_Char$arabicPresentationFormA = A2(_elm_community$random_extra$Random_Char$char, 64336, 65023);
var _elm_community$random_extra$Random_Char$variationSelector = A2(_elm_community$random_extra$Random_Char$char, 65024, 65039);
var _elm_community$random_extra$Random_Char$verticalForm = A2(_elm_community$random_extra$Random_Char$char, 65040, 65055);
var _elm_community$random_extra$Random_Char$combiningHalfMark = A2(_elm_community$random_extra$Random_Char$char, 65056, 65071);
var _elm_community$random_extra$Random_Char$cjkCompatibilityForm = A2(_elm_community$random_extra$Random_Char$char, 65072, 65103);
var _elm_community$random_extra$Random_Char$smallFormVariant = A2(_elm_community$random_extra$Random_Char$char, 65104, 65135);
var _elm_community$random_extra$Random_Char$arabicPresentationFormB = A2(_elm_community$random_extra$Random_Char$char, 65136, 65279);
var _elm_community$random_extra$Random_Char$halfwidthOrFullwidthForm = A2(_elm_community$random_extra$Random_Char$char, 65280, 65519);
var _elm_community$random_extra$Random_Char$special = A2(_elm_community$random_extra$Random_Char$char, 65520, 65535);
var _elm_community$random_extra$Random_Char$linearBSyllable = A2(_elm_community$random_extra$Random_Char$char, 65536, 65663);
var _elm_community$random_extra$Random_Char$linearBIdeogram = A2(_elm_community$random_extra$Random_Char$char, 65664, 65791);
var _elm_community$random_extra$Random_Char$aegeanNumber = A2(_elm_community$random_extra$Random_Char$char, 65792, 65855);
var _elm_community$random_extra$Random_Char$ancientGreekNumber = A2(_elm_community$random_extra$Random_Char$char, 65856, 65935);
var _elm_community$random_extra$Random_Char$ancientSymbol = A2(_elm_community$random_extra$Random_Char$char, 65936, 65999);
var _elm_community$random_extra$Random_Char$phaistosDisc = A2(_elm_community$random_extra$Random_Char$char, 66000, 66047);
var _elm_community$random_extra$Random_Char$lycian = A2(_elm_community$random_extra$Random_Char$char, 66176, 66207);
var _elm_community$random_extra$Random_Char$carian = A2(_elm_community$random_extra$Random_Char$char, 66208, 66271);
var _elm_community$random_extra$Random_Char$oldItalic = A2(_elm_community$random_extra$Random_Char$char, 66304, 66351);
var _elm_community$random_extra$Random_Char$gothic = A2(_elm_community$random_extra$Random_Char$char, 66352, 66383);
var _elm_community$random_extra$Random_Char$ugaritic = A2(_elm_community$random_extra$Random_Char$char, 66432, 66463);
var _elm_community$random_extra$Random_Char$oldPersian = A2(_elm_community$random_extra$Random_Char$char, 66464, 66527);
var _elm_community$random_extra$Random_Char$deseret = A2(_elm_community$random_extra$Random_Char$char, 66560, 66639);
var _elm_community$random_extra$Random_Char$shavian = A2(_elm_community$random_extra$Random_Char$char, 66640, 66687);
var _elm_community$random_extra$Random_Char$osmanya = A2(_elm_community$random_extra$Random_Char$char, 66688, 66735);
var _elm_community$random_extra$Random_Char$cypriotSyllable = A2(_elm_community$random_extra$Random_Char$char, 67584, 67647);
var _elm_community$random_extra$Random_Char$imperialAramaic = A2(_elm_community$random_extra$Random_Char$char, 67648, 67679);
var _elm_community$random_extra$Random_Char$phoenician = A2(_elm_community$random_extra$Random_Char$char, 67840, 67871);
var _elm_community$random_extra$Random_Char$lydian = A2(_elm_community$random_extra$Random_Char$char, 67872, 67903);
var _elm_community$random_extra$Random_Char$meroiticHieroglyph = A2(_elm_community$random_extra$Random_Char$char, 67968, 67999);
var _elm_community$random_extra$Random_Char$meroiticCursive = A2(_elm_community$random_extra$Random_Char$char, 68000, 68095);
var _elm_community$random_extra$Random_Char$kharoshthi = A2(_elm_community$random_extra$Random_Char$char, 68096, 68191);
var _elm_community$random_extra$Random_Char$oldSouthArabian = A2(_elm_community$random_extra$Random_Char$char, 68192, 68223);
var _elm_community$random_extra$Random_Char$avestan = A2(_elm_community$random_extra$Random_Char$char, 68352, 68415);
var _elm_community$random_extra$Random_Char$inscriptionalParthian = A2(_elm_community$random_extra$Random_Char$char, 68416, 68447);
var _elm_community$random_extra$Random_Char$inscriptionalPahlavi = A2(_elm_community$random_extra$Random_Char$char, 68448, 68479);
var _elm_community$random_extra$Random_Char$oldTurkic = A2(_elm_community$random_extra$Random_Char$char, 68608, 68687);
var _elm_community$random_extra$Random_Char$rumiNumericalSymbol = A2(_elm_community$random_extra$Random_Char$char, 69216, 69247);
var _elm_community$random_extra$Random_Char$brahmi = A2(_elm_community$random_extra$Random_Char$char, 69632, 69759);
var _elm_community$random_extra$Random_Char$kaithi = A2(_elm_community$random_extra$Random_Char$char, 69760, 69839);
var _elm_community$random_extra$Random_Char$soraSompeng = A2(_elm_community$random_extra$Random_Char$char, 69840, 69887);
var _elm_community$random_extra$Random_Char$chakma = A2(_elm_community$random_extra$Random_Char$char, 69888, 69967);
var _elm_community$random_extra$Random_Char$sharada = A2(_elm_community$random_extra$Random_Char$char, 70016, 70111);
var _elm_community$random_extra$Random_Char$takri = A2(_elm_community$random_extra$Random_Char$char, 71296, 71375);
var _elm_community$random_extra$Random_Char$cuneiform = A2(_elm_community$random_extra$Random_Char$char, 73728, 74751);
var _elm_community$random_extra$Random_Char$cuneiformNumberOrPunctuation = A2(_elm_community$random_extra$Random_Char$char, 74752, 74879);
var _elm_community$random_extra$Random_Char$egyptianHieroglyph = A2(_elm_community$random_extra$Random_Char$char, 77824, 78895);
var _elm_community$random_extra$Random_Char$bamumSupplement = A2(_elm_community$random_extra$Random_Char$char, 92160, 92735);
var _elm_community$random_extra$Random_Char$miao = A2(_elm_community$random_extra$Random_Char$char, 93952, 94111);
var _elm_community$random_extra$Random_Char$kanaSupplement = A2(_elm_community$random_extra$Random_Char$char, 110592, 110847);
var _elm_community$random_extra$Random_Char$byzantineMusicalSymbol = A2(_elm_community$random_extra$Random_Char$char, 118784, 119039);
var _elm_community$random_extra$Random_Char$musicalSymbol = A2(_elm_community$random_extra$Random_Char$char, 119040, 119295);
var _elm_community$random_extra$Random_Char$ancientGreekMusicalNotationSymbol = A2(_elm_community$random_extra$Random_Char$char, 119296, 119375);
var _elm_community$random_extra$Random_Char$taiXuanJingSymbol = A2(_elm_community$random_extra$Random_Char$char, 119552, 119647);
var _elm_community$random_extra$Random_Char$countingRodNumeral = A2(_elm_community$random_extra$Random_Char$char, 119648, 119679);
var _elm_community$random_extra$Random_Char$mathematicalAlphanumericSymbol = A2(_elm_community$random_extra$Random_Char$char, 119808, 120831);
var _elm_community$random_extra$Random_Char$arabicMathematicalAlphabeticSymbol = A2(_elm_community$random_extra$Random_Char$char, 126464, 126719);
var _elm_community$random_extra$Random_Char$mahjongTile = A2(_elm_community$random_extra$Random_Char$char, 126976, 127023);
var _elm_community$random_extra$Random_Char$dominoTile = A2(_elm_community$random_extra$Random_Char$char, 127024, 127135);
var _elm_community$random_extra$Random_Char$playingCard = A2(_elm_community$random_extra$Random_Char$char, 127136, 127231);
var _elm_community$random_extra$Random_Char$enclosedAlphanumericSupplement = A2(_elm_community$random_extra$Random_Char$char, 127232, 127487);
var _elm_community$random_extra$Random_Char$enclosedIdeographicSupplement = A2(_elm_community$random_extra$Random_Char$char, 127488, 127743);
var _elm_community$random_extra$Random_Char$miscellaneousSymbolOrPictograph = A2(_elm_community$random_extra$Random_Char$char, 127744, 128511);
var _elm_community$random_extra$Random_Char$emoticon = A2(_elm_community$random_extra$Random_Char$char, 128512, 128591);
var _elm_community$random_extra$Random_Char$transportOrMapSymbol = A2(_elm_community$random_extra$Random_Char$char, 128640, 128767);
var _elm_community$random_extra$Random_Char$alchemicalSymbol = A2(_elm_community$random_extra$Random_Char$char, 128768, 128895);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionB = A2(_elm_community$random_extra$Random_Char$char, 131072, 173791);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionC = A2(_elm_community$random_extra$Random_Char$char, 173824, 177983);
var _elm_community$random_extra$Random_Char$cjkUnifiedIdeographExtensionD = A2(_elm_community$random_extra$Random_Char$char, 177984, 178207);
var _elm_community$random_extra$Random_Char$cjkCompatibilityIdeographSupplement = A2(_elm_community$random_extra$Random_Char$char, 194560, 195103);
var _elm_community$random_extra$Random_Char$tag = A2(_elm_community$random_extra$Random_Char$char, 917504, 917631);
var _elm_community$random_extra$Random_Char$variationSelectorSupplement = A2(_elm_community$random_extra$Random_Char$char, 917760, 917999);
var _elm_community$random_extra$Random_Char$supplementaryPrivateUseAreaA = A2(_elm_community$random_extra$Random_Char$char, 983040, 1048575);
var _elm_community$random_extra$Random_Char$supplementaryPrivateUseAreaB = A2(_elm_community$random_extra$Random_Char$char, 1048576, 1114111);

var _elm_community$random_extra$Random_String$string = F2(
	function (stringLength, charGenerator) {
		return A2(
			_elm_lang$core$Random$map,
			_elm_lang$core$String$fromList,
			A2(_elm_lang$core$Random$list, stringLength, charGenerator));
	});
var _elm_community$random_extra$Random_String$rangeLengthString = F3(
	function (minLength, maxLength, charGenerator) {
		return A2(
			_elm_lang$core$Random$andThen,
			function (len) {
				return A2(_elm_community$random_extra$Random_String$string, len, charGenerator);
			},
			A2(_elm_lang$core$Random$int, minLength, maxLength));
	});

var _elm_community$result_extra$Result_Extra$merge = function (r) {
	var _p0 = r;
	if (_p0.ctor === 'Ok') {
		return _p0._0;
	} else {
		return _p0._0;
	}
};
var _elm_community$result_extra$Result_Extra$orElse = F2(
	function (ra, rb) {
		var _p1 = rb;
		if (_p1.ctor === 'Err') {
			return ra;
		} else {
			return rb;
		}
	});
var _elm_community$result_extra$Result_Extra$orElseLazy = F2(
	function (fra, rb) {
		var _p2 = rb;
		if (_p2.ctor === 'Err') {
			return fra(
				{ctor: '_Tuple0'});
		} else {
			return rb;
		}
	});
var _elm_community$result_extra$Result_Extra$orLazy = F2(
	function (ra, frb) {
		var _p3 = ra;
		if (_p3.ctor === 'Err') {
			return frb(
				{ctor: '_Tuple0'});
		} else {
			return ra;
		}
	});
var _elm_community$result_extra$Result_Extra$or = F2(
	function (ra, rb) {
		var _p4 = ra;
		if (_p4.ctor === 'Err') {
			return rb;
		} else {
			return ra;
		}
	});
var _elm_community$result_extra$Result_Extra$andMap = F2(
	function (ra, rb) {
		var _p5 = {ctor: '_Tuple2', _0: ra, _1: rb};
		if (_p5._1.ctor === 'Err') {
			return _elm_lang$core$Result$Err(_p5._1._0);
		} else {
			return A2(_elm_lang$core$Result$map, _p5._1._0, _p5._0);
		}
	});
var _elm_community$result_extra$Result_Extra$singleton = _elm_lang$core$Result$Ok;
var _elm_community$result_extra$Result_Extra$combine = A2(
	_elm_lang$core$List$foldr,
	_elm_lang$core$Result$map2(
		F2(
			function (x, y) {
				return {ctor: '::', _0: x, _1: y};
			})),
	_elm_lang$core$Result$Ok(
		{ctor: '[]'}));
var _elm_community$result_extra$Result_Extra$mapBoth = F3(
	function (errFunc, okFunc, result) {
		var _p6 = result;
		if (_p6.ctor === 'Ok') {
			return _elm_lang$core$Result$Ok(
				okFunc(_p6._0));
		} else {
			return _elm_lang$core$Result$Err(
				errFunc(_p6._0));
		}
	});
var _elm_community$result_extra$Result_Extra$unpack = F3(
	function (errFunc, okFunc, result) {
		var _p7 = result;
		if (_p7.ctor === 'Ok') {
			return okFunc(_p7._0);
		} else {
			return errFunc(_p7._0);
		}
	});
var _elm_community$result_extra$Result_Extra$unwrap = F3(
	function (defaultValue, okFunc, result) {
		var _p8 = result;
		if (_p8.ctor === 'Ok') {
			return okFunc(_p8._0);
		} else {
			return defaultValue;
		}
	});
var _elm_community$result_extra$Result_Extra$extract = F2(
	function (f, x) {
		var _p9 = x;
		if (_p9.ctor === 'Ok') {
			return _p9._0;
		} else {
			return f(_p9._0);
		}
	});
var _elm_community$result_extra$Result_Extra$isErr = function (x) {
	var _p10 = x;
	if (_p10.ctor === 'Ok') {
		return false;
	} else {
		return true;
	}
};
var _elm_community$result_extra$Result_Extra$isOk = function (x) {
	var _p11 = x;
	if (_p11.ctor === 'Ok') {
		return true;
	} else {
		return false;
	}
};

var _elm_lang$html$Html_Attributes$map = _elm_lang$virtual_dom$VirtualDom$mapProperty;
var _elm_lang$html$Html_Attributes$attribute = _elm_lang$virtual_dom$VirtualDom$attribute;
var _elm_lang$html$Html_Attributes$contextmenu = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'contextmenu', value);
};
var _elm_lang$html$Html_Attributes$draggable = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'draggable', value);
};
var _elm_lang$html$Html_Attributes$itemprop = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'itemprop', value);
};
var _elm_lang$html$Html_Attributes$tabindex = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'tabIndex',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$charset = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'charset', value);
};
var _elm_lang$html$Html_Attributes$height = function (value) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'height',
		_elm_lang$core$Basics$toString(value));
};
var _elm_lang$html$Html_Attributes$width = function (value) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'width',
		_elm_lang$core$Basics$toString(value));
};
var _elm_lang$html$Html_Attributes$formaction = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'formAction', value);
};
var _elm_lang$html$Html_Attributes$list = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'list', value);
};
var _elm_lang$html$Html_Attributes$minlength = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'minLength',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$maxlength = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'maxlength',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$size = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'size',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$form = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'form', value);
};
var _elm_lang$html$Html_Attributes$cols = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'cols',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$rows = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'rows',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$challenge = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'challenge', value);
};
var _elm_lang$html$Html_Attributes$media = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'media', value);
};
var _elm_lang$html$Html_Attributes$rel = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'rel', value);
};
var _elm_lang$html$Html_Attributes$datetime = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'datetime', value);
};
var _elm_lang$html$Html_Attributes$pubdate = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'pubdate', value);
};
var _elm_lang$html$Html_Attributes$colspan = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'colspan',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$rowspan = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$attribute,
		'rowspan',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$manifest = function (value) {
	return A2(_elm_lang$html$Html_Attributes$attribute, 'manifest', value);
};
var _elm_lang$html$Html_Attributes$property = _elm_lang$virtual_dom$VirtualDom$property;
var _elm_lang$html$Html_Attributes$stringProperty = F2(
	function (name, string) {
		return A2(
			_elm_lang$html$Html_Attributes$property,
			name,
			_elm_lang$core$Json_Encode$string(string));
	});
var _elm_lang$html$Html_Attributes$class = function (name) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'className', name);
};
var _elm_lang$html$Html_Attributes$id = function (name) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'id', name);
};
var _elm_lang$html$Html_Attributes$title = function (name) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'title', name);
};
var _elm_lang$html$Html_Attributes$accesskey = function ($char) {
	return A2(
		_elm_lang$html$Html_Attributes$stringProperty,
		'accessKey',
		_elm_lang$core$String$fromChar($char));
};
var _elm_lang$html$Html_Attributes$dir = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'dir', value);
};
var _elm_lang$html$Html_Attributes$dropzone = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'dropzone', value);
};
var _elm_lang$html$Html_Attributes$lang = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'lang', value);
};
var _elm_lang$html$Html_Attributes$content = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'content', value);
};
var _elm_lang$html$Html_Attributes$httpEquiv = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'httpEquiv', value);
};
var _elm_lang$html$Html_Attributes$language = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'language', value);
};
var _elm_lang$html$Html_Attributes$src = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'src', value);
};
var _elm_lang$html$Html_Attributes$alt = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'alt', value);
};
var _elm_lang$html$Html_Attributes$preload = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'preload', value);
};
var _elm_lang$html$Html_Attributes$poster = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'poster', value);
};
var _elm_lang$html$Html_Attributes$kind = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'kind', value);
};
var _elm_lang$html$Html_Attributes$srclang = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'srclang', value);
};
var _elm_lang$html$Html_Attributes$sandbox = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'sandbox', value);
};
var _elm_lang$html$Html_Attributes$srcdoc = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'srcdoc', value);
};
var _elm_lang$html$Html_Attributes$type_ = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'type', value);
};
var _elm_lang$html$Html_Attributes$value = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'value', value);
};
var _elm_lang$html$Html_Attributes$defaultValue = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'defaultValue', value);
};
var _elm_lang$html$Html_Attributes$placeholder = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'placeholder', value);
};
var _elm_lang$html$Html_Attributes$accept = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'accept', value);
};
var _elm_lang$html$Html_Attributes$acceptCharset = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'acceptCharset', value);
};
var _elm_lang$html$Html_Attributes$action = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'action', value);
};
var _elm_lang$html$Html_Attributes$autocomplete = function (bool) {
	return A2(
		_elm_lang$html$Html_Attributes$stringProperty,
		'autocomplete',
		bool ? 'on' : 'off');
};
var _elm_lang$html$Html_Attributes$enctype = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'enctype', value);
};
var _elm_lang$html$Html_Attributes$method = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'method', value);
};
var _elm_lang$html$Html_Attributes$name = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'name', value);
};
var _elm_lang$html$Html_Attributes$pattern = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'pattern', value);
};
var _elm_lang$html$Html_Attributes$for = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'htmlFor', value);
};
var _elm_lang$html$Html_Attributes$max = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'max', value);
};
var _elm_lang$html$Html_Attributes$min = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'min', value);
};
var _elm_lang$html$Html_Attributes$step = function (n) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'step', n);
};
var _elm_lang$html$Html_Attributes$wrap = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'wrap', value);
};
var _elm_lang$html$Html_Attributes$usemap = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'useMap', value);
};
var _elm_lang$html$Html_Attributes$shape = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'shape', value);
};
var _elm_lang$html$Html_Attributes$coords = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'coords', value);
};
var _elm_lang$html$Html_Attributes$keytype = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'keytype', value);
};
var _elm_lang$html$Html_Attributes$align = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'align', value);
};
var _elm_lang$html$Html_Attributes$cite = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'cite', value);
};
var _elm_lang$html$Html_Attributes$href = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'href', value);
};
var _elm_lang$html$Html_Attributes$target = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'target', value);
};
var _elm_lang$html$Html_Attributes$downloadAs = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'download', value);
};
var _elm_lang$html$Html_Attributes$hreflang = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'hreflang', value);
};
var _elm_lang$html$Html_Attributes$ping = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'ping', value);
};
var _elm_lang$html$Html_Attributes$start = function (n) {
	return A2(
		_elm_lang$html$Html_Attributes$stringProperty,
		'start',
		_elm_lang$core$Basics$toString(n));
};
var _elm_lang$html$Html_Attributes$headers = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'headers', value);
};
var _elm_lang$html$Html_Attributes$scope = function (value) {
	return A2(_elm_lang$html$Html_Attributes$stringProperty, 'scope', value);
};
var _elm_lang$html$Html_Attributes$boolProperty = F2(
	function (name, bool) {
		return A2(
			_elm_lang$html$Html_Attributes$property,
			name,
			_elm_lang$core$Json_Encode$bool(bool));
	});
var _elm_lang$html$Html_Attributes$hidden = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'hidden', bool);
};
var _elm_lang$html$Html_Attributes$contenteditable = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'contentEditable', bool);
};
var _elm_lang$html$Html_Attributes$spellcheck = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'spellcheck', bool);
};
var _elm_lang$html$Html_Attributes$async = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'async', bool);
};
var _elm_lang$html$Html_Attributes$defer = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'defer', bool);
};
var _elm_lang$html$Html_Attributes$scoped = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'scoped', bool);
};
var _elm_lang$html$Html_Attributes$autoplay = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'autoplay', bool);
};
var _elm_lang$html$Html_Attributes$controls = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'controls', bool);
};
var _elm_lang$html$Html_Attributes$loop = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'loop', bool);
};
var _elm_lang$html$Html_Attributes$default = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'default', bool);
};
var _elm_lang$html$Html_Attributes$seamless = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'seamless', bool);
};
var _elm_lang$html$Html_Attributes$checked = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'checked', bool);
};
var _elm_lang$html$Html_Attributes$selected = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'selected', bool);
};
var _elm_lang$html$Html_Attributes$autofocus = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'autofocus', bool);
};
var _elm_lang$html$Html_Attributes$disabled = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'disabled', bool);
};
var _elm_lang$html$Html_Attributes$multiple = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'multiple', bool);
};
var _elm_lang$html$Html_Attributes$novalidate = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'noValidate', bool);
};
var _elm_lang$html$Html_Attributes$readonly = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'readOnly', bool);
};
var _elm_lang$html$Html_Attributes$required = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'required', bool);
};
var _elm_lang$html$Html_Attributes$ismap = function (value) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'isMap', value);
};
var _elm_lang$html$Html_Attributes$download = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'download', bool);
};
var _elm_lang$html$Html_Attributes$reversed = function (bool) {
	return A2(_elm_lang$html$Html_Attributes$boolProperty, 'reversed', bool);
};
var _elm_lang$html$Html_Attributes$classList = function (list) {
	return _elm_lang$html$Html_Attributes$class(
		A2(
			_elm_lang$core$String$join,
			' ',
			A2(
				_elm_lang$core$List$map,
				_elm_lang$core$Tuple$first,
				A2(_elm_lang$core$List$filter, _elm_lang$core$Tuple$second, list))));
};
var _elm_lang$html$Html_Attributes$style = _elm_lang$virtual_dom$VirtualDom$style;

var _elm_lang$html$Html_Events$keyCode = A2(_elm_lang$core$Json_Decode$field, 'keyCode', _elm_lang$core$Json_Decode$int);
var _elm_lang$html$Html_Events$targetChecked = A2(
	_elm_lang$core$Json_Decode$at,
	{
		ctor: '::',
		_0: 'target',
		_1: {
			ctor: '::',
			_0: 'checked',
			_1: {ctor: '[]'}
		}
	},
	_elm_lang$core$Json_Decode$bool);
var _elm_lang$html$Html_Events$targetValue = A2(
	_elm_lang$core$Json_Decode$at,
	{
		ctor: '::',
		_0: 'target',
		_1: {
			ctor: '::',
			_0: 'value',
			_1: {ctor: '[]'}
		}
	},
	_elm_lang$core$Json_Decode$string);
var _elm_lang$html$Html_Events$defaultOptions = _elm_lang$virtual_dom$VirtualDom$defaultOptions;
var _elm_lang$html$Html_Events$onWithOptions = _elm_lang$virtual_dom$VirtualDom$onWithOptions;
var _elm_lang$html$Html_Events$on = _elm_lang$virtual_dom$VirtualDom$on;
var _elm_lang$html$Html_Events$onFocus = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'focus',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onBlur = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'blur',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onSubmitOptions = _elm_lang$core$Native_Utils.update(
	_elm_lang$html$Html_Events$defaultOptions,
	{preventDefault: true});
var _elm_lang$html$Html_Events$onSubmit = function (msg) {
	return A3(
		_elm_lang$html$Html_Events$onWithOptions,
		'submit',
		_elm_lang$html$Html_Events$onSubmitOptions,
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onCheck = function (tagger) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'change',
		A2(_elm_lang$core$Json_Decode$map, tagger, _elm_lang$html$Html_Events$targetChecked));
};
var _elm_lang$html$Html_Events$onInput = function (tagger) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'input',
		A2(_elm_lang$core$Json_Decode$map, tagger, _elm_lang$html$Html_Events$targetValue));
};
var _elm_lang$html$Html_Events$onMouseOut = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'mouseout',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onMouseOver = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'mouseover',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onMouseLeave = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'mouseleave',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onMouseEnter = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'mouseenter',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onMouseUp = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'mouseup',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onMouseDown = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'mousedown',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onDoubleClick = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'dblclick',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$onClick = function (msg) {
	return A2(
		_elm_lang$html$Html_Events$on,
		'click',
		_elm_lang$core$Json_Decode$succeed(msg));
};
var _elm_lang$html$Html_Events$Options = F2(
	function (a, b) {
		return {stopPropagation: a, preventDefault: b};
	});

var _elm_lang$lazy$Native_Lazy = function() {

function memoize(thunk)
{
    var value;
    var isForced = false;
    return function(tuple0) {
        if (!isForced) {
            value = thunk(tuple0);
            isForced = true;
        }
        return value;
    };
}

return {
    memoize: memoize
};

}();

var _elm_lang$lazy$Lazy$force = function (_p0) {
	var _p1 = _p0;
	return _p1._0(
		{ctor: '_Tuple0'});
};
var _elm_lang$lazy$Lazy$Lazy = function (a) {
	return {ctor: 'Lazy', _0: a};
};
var _elm_lang$lazy$Lazy$lazy = function (thunk) {
	return _elm_lang$lazy$Lazy$Lazy(
		_elm_lang$lazy$Native_Lazy.memoize(thunk));
};
var _elm_lang$lazy$Lazy$map = F2(
	function (f, a) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p2) {
				var _p3 = _p2;
				return f(
					_elm_lang$lazy$Lazy$force(a));
			});
	});
var _elm_lang$lazy$Lazy$map2 = F3(
	function (f, a, b) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p4) {
				var _p5 = _p4;
				return A2(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b));
			});
	});
var _elm_lang$lazy$Lazy$map3 = F4(
	function (f, a, b, c) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p6) {
				var _p7 = _p6;
				return A3(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b),
					_elm_lang$lazy$Lazy$force(c));
			});
	});
var _elm_lang$lazy$Lazy$map4 = F5(
	function (f, a, b, c, d) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p8) {
				var _p9 = _p8;
				return A4(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b),
					_elm_lang$lazy$Lazy$force(c),
					_elm_lang$lazy$Lazy$force(d));
			});
	});
var _elm_lang$lazy$Lazy$map5 = F6(
	function (f, a, b, c, d, e) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p10) {
				var _p11 = _p10;
				return A5(
					f,
					_elm_lang$lazy$Lazy$force(a),
					_elm_lang$lazy$Lazy$force(b),
					_elm_lang$lazy$Lazy$force(c),
					_elm_lang$lazy$Lazy$force(d),
					_elm_lang$lazy$Lazy$force(e));
			});
	});
var _elm_lang$lazy$Lazy$apply = F2(
	function (f, x) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p12) {
				var _p13 = _p12;
				return A2(
					_elm_lang$lazy$Lazy$force,
					f,
					_elm_lang$lazy$Lazy$force(x));
			});
	});
var _elm_lang$lazy$Lazy$andThen = F2(
	function (callback, a) {
		return _elm_lang$lazy$Lazy$lazy(
			function (_p14) {
				var _p15 = _p14;
				return _elm_lang$lazy$Lazy$force(
					callback(
						_elm_lang$lazy$Lazy$force(a)));
			});
	});

var _fredcy$elm_parseint$ParseInt$charFromInt = function (i) {
	return (_elm_lang$core$Native_Utils.cmp(i, 10) < 0) ? _elm_lang$core$Char$fromCode(
		i + _elm_lang$core$Char$toCode(
			_elm_lang$core$Native_Utils.chr('0'))) : ((_elm_lang$core$Native_Utils.cmp(i, 36) < 0) ? _elm_lang$core$Char$fromCode(
		(i - 10) + _elm_lang$core$Char$toCode(
			_elm_lang$core$Native_Utils.chr('A'))) : _elm_lang$core$Native_Utils.crash(
		'ParseInt',
		{
			start: {line: 158, column: 9},
			end: {line: 158, column: 20}
		})(
		_elm_lang$core$Basics$toString(i)));
};
var _fredcy$elm_parseint$ParseInt$toRadixUnsafe = F2(
	function (radix, i) {
		return (_elm_lang$core$Native_Utils.cmp(i, radix) < 0) ? _elm_lang$core$String$fromChar(
			_fredcy$elm_parseint$ParseInt$charFromInt(i)) : A2(
			_elm_lang$core$Basics_ops['++'],
			A2(_fredcy$elm_parseint$ParseInt$toRadixUnsafe, radix, (i / radix) | 0),
			_elm_lang$core$String$fromChar(
				_fredcy$elm_parseint$ParseInt$charFromInt(
					A2(_elm_lang$core$Basics_ops['%'], i, radix))));
	});
var _fredcy$elm_parseint$ParseInt$toOct = _fredcy$elm_parseint$ParseInt$toRadixUnsafe(8);
var _fredcy$elm_parseint$ParseInt$toHex = _fredcy$elm_parseint$ParseInt$toRadixUnsafe(16);
var _fredcy$elm_parseint$ParseInt$isBetween = F3(
	function (lower, upper, c) {
		var ci = _elm_lang$core$Char$toCode(c);
		return (_elm_lang$core$Native_Utils.cmp(
			_elm_lang$core$Char$toCode(lower),
			ci) < 1) && (_elm_lang$core$Native_Utils.cmp(
			ci,
			_elm_lang$core$Char$toCode(upper)) < 1);
	});
var _fredcy$elm_parseint$ParseInt$charOffset = F2(
	function (basis, c) {
		return _elm_lang$core$Char$toCode(c) - _elm_lang$core$Char$toCode(basis);
	});
var _fredcy$elm_parseint$ParseInt$InvalidRadix = function (a) {
	return {ctor: 'InvalidRadix', _0: a};
};
var _fredcy$elm_parseint$ParseInt$toRadix = F2(
	function (radix, i) {
		return ((_elm_lang$core$Native_Utils.cmp(2, radix) < 1) && (_elm_lang$core$Native_Utils.cmp(radix, 36) < 1)) ? ((_elm_lang$core$Native_Utils.cmp(i, 0) < 0) ? _elm_lang$core$Result$Ok(
			A2(
				_elm_lang$core$Basics_ops['++'],
				'-',
				A2(_fredcy$elm_parseint$ParseInt$toRadixUnsafe, radix, 0 - i))) : _elm_lang$core$Result$Ok(
			A2(_fredcy$elm_parseint$ParseInt$toRadixUnsafe, radix, i))) : _elm_lang$core$Result$Err(
			_fredcy$elm_parseint$ParseInt$InvalidRadix(radix));
	});
var _fredcy$elm_parseint$ParseInt$OutOfRange = function (a) {
	return {ctor: 'OutOfRange', _0: a};
};
var _fredcy$elm_parseint$ParseInt$InvalidChar = function (a) {
	return {ctor: 'InvalidChar', _0: a};
};
var _fredcy$elm_parseint$ParseInt$intFromChar = F2(
	function (radix, c) {
		var validInt = function (i) {
			return (_elm_lang$core$Native_Utils.cmp(i, radix) < 0) ? _elm_lang$core$Result$Ok(i) : _elm_lang$core$Result$Err(
				_fredcy$elm_parseint$ParseInt$OutOfRange(c));
		};
		var toInt = A3(
			_fredcy$elm_parseint$ParseInt$isBetween,
			_elm_lang$core$Native_Utils.chr('0'),
			_elm_lang$core$Native_Utils.chr('9'),
			c) ? _elm_lang$core$Result$Ok(
			A2(
				_fredcy$elm_parseint$ParseInt$charOffset,
				_elm_lang$core$Native_Utils.chr('0'),
				c)) : (A3(
			_fredcy$elm_parseint$ParseInt$isBetween,
			_elm_lang$core$Native_Utils.chr('a'),
			_elm_lang$core$Native_Utils.chr('z'),
			c) ? _elm_lang$core$Result$Ok(
			10 + A2(
				_fredcy$elm_parseint$ParseInt$charOffset,
				_elm_lang$core$Native_Utils.chr('a'),
				c)) : (A3(
			_fredcy$elm_parseint$ParseInt$isBetween,
			_elm_lang$core$Native_Utils.chr('A'),
			_elm_lang$core$Native_Utils.chr('Z'),
			c) ? _elm_lang$core$Result$Ok(
			10 + A2(
				_fredcy$elm_parseint$ParseInt$charOffset,
				_elm_lang$core$Native_Utils.chr('A'),
				c)) : _elm_lang$core$Result$Err(
			_fredcy$elm_parseint$ParseInt$InvalidChar(c))));
		return A2(_elm_lang$core$Result$andThen, validInt, toInt);
	});
var _fredcy$elm_parseint$ParseInt$parseIntR = F2(
	function (radix, rstring) {
		var _p0 = _elm_lang$core$String$uncons(rstring);
		if (_p0.ctor === 'Nothing') {
			return _elm_lang$core$Result$Ok(0);
		} else {
			return A2(
				_elm_lang$core$Result$andThen,
				function (ci) {
					return A2(
						_elm_lang$core$Result$andThen,
						function (ri) {
							return _elm_lang$core$Result$Ok(ci + (ri * radix));
						},
						A2(_fredcy$elm_parseint$ParseInt$parseIntR, radix, _p0._0._1));
				},
				A2(_fredcy$elm_parseint$ParseInt$intFromChar, radix, _p0._0._0));
		}
	});
var _fredcy$elm_parseint$ParseInt$parseIntRadix = F2(
	function (radix, string) {
		return ((_elm_lang$core$Native_Utils.cmp(2, radix) < 1) && (_elm_lang$core$Native_Utils.cmp(radix, 36) < 1)) ? A2(
			_fredcy$elm_parseint$ParseInt$parseIntR,
			radix,
			_elm_lang$core$String$reverse(string)) : _elm_lang$core$Result$Err(
			_fredcy$elm_parseint$ParseInt$InvalidRadix(radix));
	});
var _fredcy$elm_parseint$ParseInt$parseInt = _fredcy$elm_parseint$ParseInt$parseIntRadix(10);
var _fredcy$elm_parseint$ParseInt$parseIntOct = _fredcy$elm_parseint$ParseInt$parseIntRadix(8);
var _fredcy$elm_parseint$ParseInt$parseIntHex = _fredcy$elm_parseint$ParseInt$parseIntRadix(16);

var _eskimoblood$elm_color_extra$Color_Convert$xyzToColor = function (_p0) {
	var _p1 = _p0;
	var c = function (ch) {
		var ch_ = (_elm_lang$core$Native_Utils.cmp(ch, 3.1308e-3) > 0) ? ((1.055 * Math.pow(ch, 1 / 2.4)) - 5.5e-2) : (12.92 * ch);
		return _elm_lang$core$Basics$round(
			A3(_elm_lang$core$Basics$clamp, 0, 255, ch_ * 255));
	};
	var z_ = _p1.z / 100;
	var y_ = _p1.y / 100;
	var x_ = _p1.x / 100;
	var r = ((x_ * 3.2404542) + (y_ * -1.5371385)) + (z_ * -0.4986);
	var g = ((x_ * -0.969266) + (y_ * 1.8760108)) + (z_ * 4.1556e-2);
	var b = ((x_ * 5.56434e-2) + (y_ * -0.2040259)) + (z_ * 1.0572252);
	return A3(
		_elm_lang$core$Color$rgb,
		c(r),
		c(g),
		c(b));
};
var _eskimoblood$elm_color_extra$Color_Convert$labToXyz = function (_p2) {
	var _p3 = _p2;
	var y = (_p3.l + 16) / 116;
	var c = function (ch) {
		var ch_ = (ch * ch) * ch;
		return (_elm_lang$core$Native_Utils.cmp(ch_, 8.856e-3) > 0) ? ch_ : ((ch - (16 / 116)) / 7.787);
	};
	return {
		y: c(y) * 100,
		x: c(y + (_p3.a / 500)) * 95.047,
		z: c(y - (_p3.b / 200)) * 108.883
	};
};
var _eskimoblood$elm_color_extra$Color_Convert$labToColor = function (_p4) {
	return _eskimoblood$elm_color_extra$Color_Convert$xyzToColor(
		_eskimoblood$elm_color_extra$Color_Convert$labToXyz(_p4));
};
var _eskimoblood$elm_color_extra$Color_Convert$xyzToLab = function (_p5) {
	var _p6 = _p5;
	var c = function (ch) {
		return (_elm_lang$core$Native_Utils.cmp(ch, 8.856e-3) > 0) ? Math.pow(ch, 1 / 3) : ((7.787 * ch) + (16 / 116));
	};
	var x_ = c(_p6.x / 95.047);
	var y_ = c(_p6.y / 100);
	var z_ = c(_p6.z / 108.883);
	return {l: (116 * y_) - 16, a: 500 * (x_ - y_), b: 200 * (y_ - z_)};
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToXyz = function (cl) {
	var _p7 = _elm_lang$core$Color$toRgb(cl);
	var red = _p7.red;
	var green = _p7.green;
	var blue = _p7.blue;
	var c = function (ch) {
		var ch_ = _elm_lang$core$Basics$toFloat(ch) / 255;
		var ch__ = (_elm_lang$core$Native_Utils.cmp(ch_, 4.045e-2) > 0) ? Math.pow((ch_ + 5.5e-2) / 1.055, 2.4) : (ch_ / 12.92);
		return ch__ * 100;
	};
	var r = c(red);
	var g = c(green);
	var b = c(blue);
	return {x: ((r * 0.4124) + (g * 0.3576)) + (b * 0.1805), y: ((r * 0.2126) + (g * 0.7152)) + (b * 7.22e-2), z: ((r * 1.93e-2) + (g * 0.1192)) + (b * 0.9505)};
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToLab = function (_p8) {
	return _eskimoblood$elm_color_extra$Color_Convert$xyzToLab(
		_eskimoblood$elm_color_extra$Color_Convert$colorToXyz(_p8));
};
var _eskimoblood$elm_color_extra$Color_Convert$toRadix = function (n) {
	var getChr = function (c) {
		return (_elm_lang$core$Native_Utils.cmp(c, 10) < 0) ? _elm_lang$core$Basics$toString(c) : _elm_lang$core$String$fromChar(
			_elm_lang$core$Char$fromCode(87 + c));
	};
	return (_elm_lang$core$Native_Utils.cmp(n, 16) < 0) ? getChr(n) : A2(
		_elm_lang$core$Basics_ops['++'],
		_eskimoblood$elm_color_extra$Color_Convert$toRadix((n / 16) | 0),
		getChr(
			A2(_elm_lang$core$Basics_ops['%'], n, 16)));
};
var _eskimoblood$elm_color_extra$Color_Convert$toHex = function (_p9) {
	return A3(
		_elm_lang$core$String$padLeft,
		2,
		_elm_lang$core$Native_Utils.chr('0'),
		_eskimoblood$elm_color_extra$Color_Convert$toRadix(_p9));
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToHex = function (cl) {
	var _p10 = _elm_lang$core$Color$toRgb(cl);
	var red = _p10.red;
	var green = _p10.green;
	var blue = _p10.blue;
	return A2(
		_elm_lang$core$String$join,
		'',
		A2(
			F2(
				function (x, y) {
					return {ctor: '::', _0: x, _1: y};
				}),
			'#',
			A2(
				_elm_lang$core$List$map,
				_eskimoblood$elm_color_extra$Color_Convert$toHex,
				{
					ctor: '::',
					_0: red,
					_1: {
						ctor: '::',
						_0: green,
						_1: {
							ctor: '::',
							_0: blue,
							_1: {ctor: '[]'}
						}
					}
				})));
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToHexWithAlpha = function (color) {
	var _p11 = _elm_lang$core$Color$toRgb(color);
	var red = _p11.red;
	var green = _p11.green;
	var blue = _p11.blue;
	var alpha = _p11.alpha;
	return _elm_lang$core$Native_Utils.eq(alpha, 1) ? _eskimoblood$elm_color_extra$Color_Convert$colorToHex(color) : A2(
		_elm_lang$core$String$join,
		'',
		A2(
			F2(
				function (x, y) {
					return {ctor: '::', _0: x, _1: y};
				}),
			'#',
			A2(
				_elm_lang$core$List$map,
				_eskimoblood$elm_color_extra$Color_Convert$toHex,
				{
					ctor: '::',
					_0: red,
					_1: {
						ctor: '::',
						_0: green,
						_1: {
							ctor: '::',
							_0: blue,
							_1: {
								ctor: '::',
								_0: _elm_lang$core$Basics$round(alpha * 255),
								_1: {ctor: '[]'}
							}
						}
					}
				})));
};
var _eskimoblood$elm_color_extra$Color_Convert$roundToPlaces = F2(
	function (places, number) {
		var multiplier = _elm_lang$core$Basics$toFloat(
			Math.pow(10, places));
		return _elm_lang$core$Basics$toFloat(
			_elm_lang$core$Basics$round(number * multiplier)) / multiplier;
	});
var _eskimoblood$elm_color_extra$Color_Convert$hexToColor = function () {
	var pattern = A2(
		_elm_lang$core$Basics_ops['++'],
		'',
		A2(
			_elm_lang$core$Basics_ops['++'],
			'^',
			A2(
				_elm_lang$core$Basics_ops['++'],
				'#?',
				A2(
					_elm_lang$core$Basics_ops['++'],
					'(?:',
					A2(
						_elm_lang$core$Basics_ops['++'],
						'(?:([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2}))',
						A2(
							_elm_lang$core$Basics_ops['++'],
							'|',
							A2(
								_elm_lang$core$Basics_ops['++'],
								'(?:([a-f\\d])([a-f\\d])([a-f\\d]))',
								A2(
									_elm_lang$core$Basics_ops['++'],
									'|',
									A2(
										_elm_lang$core$Basics_ops['++'],
										'(?:([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2}))',
										A2(
											_elm_lang$core$Basics_ops['++'],
											'|',
											A2(
												_elm_lang$core$Basics_ops['++'],
												'(?:([a-f\\d])([a-f\\d])([a-f\\d])([a-f\\d]))',
												A2(_elm_lang$core$Basics_ops['++'], ')', '$'))))))))))));
	var extend = function (token) {
		var _p12 = _elm_lang$core$String$toList(token);
		if ((_p12.ctor === '::') && (_p12._1.ctor === '[]')) {
			var _p13 = _p12._0;
			return _elm_lang$core$String$fromList(
				{
					ctor: '::',
					_0: _p13,
					_1: {
						ctor: '::',
						_0: _p13,
						_1: {ctor: '[]'}
					}
				});
		} else {
			return token;
		}
	};
	return function (_p14) {
		return A2(
			_elm_lang$core$Result$andThen,
			function (colors) {
				var _p16 = A2(
					_elm_lang$core$List$map,
					function (_p15) {
						return _fredcy$elm_parseint$ParseInt$parseIntHex(
							extend(_p15));
					},
					colors);
				_v4_2:
				do {
					if ((((((_p16.ctor === '::') && (_p16._0.ctor === 'Ok')) && (_p16._1.ctor === '::')) && (_p16._1._0.ctor === 'Ok')) && (_p16._1._1.ctor === '::')) && (_p16._1._1._0.ctor === 'Ok')) {
						if (_p16._1._1._1.ctor === '::') {
							if ((_p16._1._1._1._0.ctor === 'Ok') && (_p16._1._1._1._1.ctor === '[]')) {
								return _elm_lang$core$Result$Ok(
									A4(
										_elm_lang$core$Color$rgba,
										_p16._0._0,
										_p16._1._0._0,
										_p16._1._1._0._0,
										A2(
											_eskimoblood$elm_color_extra$Color_Convert$roundToPlaces,
											2,
											_elm_lang$core$Basics$toFloat(_p16._1._1._1._0._0) / 255)));
							} else {
								break _v4_2;
							}
						} else {
							return _elm_lang$core$Result$Ok(
								A3(_elm_lang$core$Color$rgb, _p16._0._0, _p16._1._0._0, _p16._1._1._0._0));
						}
					} else {
						break _v4_2;
					}
				} while(false);
				return _elm_lang$core$Result$Err('Parsing ints from hex failed');
			},
			A2(
				_elm_lang$core$Result$fromMaybe,
				'Parsing hex regex failed',
				A2(
					_elm_lang$core$Maybe$map,
					_elm_lang$core$List$filterMap(_elm_lang$core$Basics$identity),
					A2(
						_elm_lang$core$Maybe$map,
						function (_) {
							return _.submatches;
						},
						_elm_lang$core$List$head(
							A3(
								_elm_lang$core$Regex$find,
								_elm_lang$core$Regex$AtMost(1),
								_elm_lang$core$Regex$regex(pattern),
								_elm_lang$core$String$toLower(_p14)))))));
	};
}();
var _eskimoblood$elm_color_extra$Color_Convert$cssColorString = F2(
	function (kind, values) {
		return A2(
			_elm_lang$core$Basics_ops['++'],
			kind,
			A2(
				_elm_lang$core$Basics_ops['++'],
				'(',
				A2(
					_elm_lang$core$Basics_ops['++'],
					A2(_elm_lang$core$String$join, ', ', values),
					')')));
	});
var _eskimoblood$elm_color_extra$Color_Convert$toPercentString = function (_p17) {
	return A3(
		_elm_lang$core$Basics$flip,
		F2(
			function (x, y) {
				return A2(_elm_lang$core$Basics_ops['++'], x, y);
			}),
		'%',
		_elm_lang$core$Basics$toString(
			_elm_lang$core$Basics$round(
				A2(
					F2(
						function (x, y) {
							return x * y;
						}),
					100,
					_p17))));
};
var _eskimoblood$elm_color_extra$Color_Convert$hueToString = function (_p18) {
	return _elm_lang$core$Basics$toString(
		_elm_lang$core$Basics$round(
			A3(
				_elm_lang$core$Basics$flip,
				F2(
					function (x, y) {
						return x / y;
					}),
				_elm_lang$core$Basics$pi,
				A2(
					F2(
						function (x, y) {
							return x * y;
						}),
					180,
					_p18))));
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToCssHsla = function (cl) {
	var _p19 = _elm_lang$core$Color$toHsl(cl);
	var hue = _p19.hue;
	var saturation = _p19.saturation;
	var lightness = _p19.lightness;
	var alpha = _p19.alpha;
	return A2(
		_eskimoblood$elm_color_extra$Color_Convert$cssColorString,
		'hsla',
		{
			ctor: '::',
			_0: _eskimoblood$elm_color_extra$Color_Convert$hueToString(hue),
			_1: {
				ctor: '::',
				_0: _eskimoblood$elm_color_extra$Color_Convert$toPercentString(saturation),
				_1: {
					ctor: '::',
					_0: _eskimoblood$elm_color_extra$Color_Convert$toPercentString(lightness),
					_1: {
						ctor: '::',
						_0: _elm_lang$core$Basics$toString(alpha),
						_1: {ctor: '[]'}
					}
				}
			}
		});
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToCssHsl = function (cl) {
	var _p20 = _elm_lang$core$Color$toHsl(cl);
	var hue = _p20.hue;
	var saturation = _p20.saturation;
	var lightness = _p20.lightness;
	var alpha = _p20.alpha;
	return A2(
		_eskimoblood$elm_color_extra$Color_Convert$cssColorString,
		'hsl',
		{
			ctor: '::',
			_0: _eskimoblood$elm_color_extra$Color_Convert$hueToString(hue),
			_1: {
				ctor: '::',
				_0: _eskimoblood$elm_color_extra$Color_Convert$toPercentString(saturation),
				_1: {
					ctor: '::',
					_0: _eskimoblood$elm_color_extra$Color_Convert$toPercentString(lightness),
					_1: {ctor: '[]'}
				}
			}
		});
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToCssRgba = function (cl) {
	var _p21 = _elm_lang$core$Color$toRgb(cl);
	var red = _p21.red;
	var green = _p21.green;
	var blue = _p21.blue;
	var alpha = _p21.alpha;
	return A2(
		_eskimoblood$elm_color_extra$Color_Convert$cssColorString,
		'rgba',
		{
			ctor: '::',
			_0: _elm_lang$core$Basics$toString(red),
			_1: {
				ctor: '::',
				_0: _elm_lang$core$Basics$toString(green),
				_1: {
					ctor: '::',
					_0: _elm_lang$core$Basics$toString(blue),
					_1: {
						ctor: '::',
						_0: _elm_lang$core$Basics$toString(alpha),
						_1: {ctor: '[]'}
					}
				}
			}
		});
};
var _eskimoblood$elm_color_extra$Color_Convert$colorToCssRgb = function (cl) {
	var _p22 = _elm_lang$core$Color$toRgb(cl);
	var red = _p22.red;
	var green = _p22.green;
	var blue = _p22.blue;
	var alpha = _p22.alpha;
	return A2(
		_eskimoblood$elm_color_extra$Color_Convert$cssColorString,
		'rgb',
		{
			ctor: '::',
			_0: _elm_lang$core$Basics$toString(red),
			_1: {
				ctor: '::',
				_0: _elm_lang$core$Basics$toString(green),
				_1: {
					ctor: '::',
					_0: _elm_lang$core$Basics$toString(blue),
					_1: {ctor: '[]'}
				}
			}
		});
};
var _eskimoblood$elm_color_extra$Color_Convert$XYZ = F3(
	function (a, b, c) {
		return {x: a, y: b, z: c};
	});
var _eskimoblood$elm_color_extra$Color_Convert$Lab = F3(
	function (a, b, c) {
		return {l: a, a: b, b: c};
	});

var _gilbertkennen$bigint$Constants$hexDigitMagnitude = 8;
var _gilbertkennen$bigint$Constants$maxDigitMagnitude = 7;
var _gilbertkennen$bigint$Constants$maxDigitValue = -1 + Math.pow(10, _gilbertkennen$bigint$Constants$maxDigitMagnitude);

var _rtfeldman$hex$Hex$toString = function (num) {
	return _elm_lang$core$String$fromList(
		(_elm_lang$core$Native_Utils.cmp(num, 0) < 0) ? {
			ctor: '::',
			_0: _elm_lang$core$Native_Utils.chr('-'),
			_1: A2(
				_rtfeldman$hex$Hex$unsafePositiveToDigits,
				{ctor: '[]'},
				_elm_lang$core$Basics$negate(num))
		} : A2(
			_rtfeldman$hex$Hex$unsafePositiveToDigits,
			{ctor: '[]'},
			num));
};
var _rtfeldman$hex$Hex$unsafePositiveToDigits = F2(
	function (digits, num) {
		unsafePositiveToDigits:
		while (true) {
			if (_elm_lang$core$Native_Utils.cmp(num, 16) < 0) {
				return {
					ctor: '::',
					_0: _rtfeldman$hex$Hex$unsafeToDigit(num),
					_1: digits
				};
			} else {
				var _v0 = {
					ctor: '::',
					_0: _rtfeldman$hex$Hex$unsafeToDigit(
						A2(_elm_lang$core$Basics_ops['%'], num, 16)),
					_1: digits
				},
					_v1 = (num / 16) | 0;
				digits = _v0;
				num = _v1;
				continue unsafePositiveToDigits;
			}
		}
	});
var _rtfeldman$hex$Hex$unsafeToDigit = function (num) {
	var _p0 = num;
	switch (_p0) {
		case 0:
			return _elm_lang$core$Native_Utils.chr('0');
		case 1:
			return _elm_lang$core$Native_Utils.chr('1');
		case 2:
			return _elm_lang$core$Native_Utils.chr('2');
		case 3:
			return _elm_lang$core$Native_Utils.chr('3');
		case 4:
			return _elm_lang$core$Native_Utils.chr('4');
		case 5:
			return _elm_lang$core$Native_Utils.chr('5');
		case 6:
			return _elm_lang$core$Native_Utils.chr('6');
		case 7:
			return _elm_lang$core$Native_Utils.chr('7');
		case 8:
			return _elm_lang$core$Native_Utils.chr('8');
		case 9:
			return _elm_lang$core$Native_Utils.chr('9');
		case 10:
			return _elm_lang$core$Native_Utils.chr('a');
		case 11:
			return _elm_lang$core$Native_Utils.chr('b');
		case 12:
			return _elm_lang$core$Native_Utils.chr('c');
		case 13:
			return _elm_lang$core$Native_Utils.chr('d');
		case 14:
			return _elm_lang$core$Native_Utils.chr('e');
		case 15:
			return _elm_lang$core$Native_Utils.chr('f');
		default:
			return _elm_lang$core$Native_Utils.crashCase(
				'Hex',
				{
					start: {line: 138, column: 5},
					end: {line: 188, column: 84}
				},
				_p0)(
				A2(
					_elm_lang$core$Basics_ops['++'],
					'Tried to convert ',
					A2(
						_elm_lang$core$Basics_ops['++'],
						_rtfeldman$hex$Hex$toString(num),
						' to hexadecimal.')));
	}
};
var _rtfeldman$hex$Hex$fromStringHelp = F3(
	function (position, chars, accumulated) {
		var _p2 = chars;
		if (_p2.ctor === '[]') {
			return _elm_lang$core$Result$Ok(accumulated);
		} else {
			var recurse = function (additional) {
				return A3(
					_rtfeldman$hex$Hex$fromStringHelp,
					position - 1,
					_p2._1,
					accumulated + (additional * Math.pow(16, position)));
			};
			var _p3 = _p2._0;
			switch (_p3.valueOf()) {
				case '0':
					return recurse(0);
				case '1':
					return recurse(1);
				case '2':
					return recurse(2);
				case '3':
					return recurse(3);
				case '4':
					return recurse(4);
				case '5':
					return recurse(5);
				case '6':
					return recurse(6);
				case '7':
					return recurse(7);
				case '8':
					return recurse(8);
				case '9':
					return recurse(9);
				case 'a':
					return recurse(10);
				case 'b':
					return recurse(11);
				case 'c':
					return recurse(12);
				case 'd':
					return recurse(13);
				case 'e':
					return recurse(14);
				case 'f':
					return recurse(15);
				default:
					return _elm_lang$core$Result$Err(
						A2(
							_elm_lang$core$Basics_ops['++'],
							_elm_lang$core$Basics$toString(_p3),
							' is not a valid hexadecimal character.'));
			}
		}
	});
var _rtfeldman$hex$Hex$fromString = function (str) {
	if (_elm_lang$core$String$isEmpty(str)) {
		return _elm_lang$core$Result$Err('Empty strings are not valid hexadecimal strings.');
	} else {
		var formatError = function (err) {
			return A2(
				_elm_lang$core$String$join,
				' ',
				{
					ctor: '::',
					_0: _elm_lang$core$Basics$toString(str),
					_1: {
						ctor: '::',
						_0: 'is not a valid hexadecimal string because',
						_1: {
							ctor: '::',
							_0: err,
							_1: {ctor: '[]'}
						}
					}
				});
		};
		var result = function () {
			if (A2(_elm_lang$core$String$startsWith, '-', str)) {
				var list = A2(
					_elm_lang$core$Maybe$withDefault,
					{ctor: '[]'},
					_elm_lang$core$List$tail(
						_elm_lang$core$String$toList(str)));
				return A2(
					_elm_lang$core$Result$map,
					_elm_lang$core$Basics$negate,
					A3(
						_rtfeldman$hex$Hex$fromStringHelp,
						_elm_lang$core$List$length(list) - 1,
						list,
						0));
			} else {
				return A3(
					_rtfeldman$hex$Hex$fromStringHelp,
					_elm_lang$core$String$length(str) - 1,
					_elm_lang$core$String$toList(str),
					0);
			}
		}();
		return A2(_elm_lang$core$Result$mapError, formatError, result);
	}
};

var _gilbertkennen$bigint$BigInt$sameSizeRaw = F2(
	function (xs, ys) {
		var _p0 = {ctor: '_Tuple2', _0: xs, _1: ys};
		if (_p0._0.ctor === '[]') {
			if (_p0._1.ctor === '[]') {
				return {ctor: '[]'};
			} else {
				return {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: 0, _1: _p0._1._0},
					_1: A2(
						_gilbertkennen$bigint$BigInt$sameSizeRaw,
						{ctor: '[]'},
						_p0._1._1)
				};
			}
		} else {
			if (_p0._1.ctor === '[]') {
				return {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: _p0._0._0, _1: 0},
					_1: A2(
						_gilbertkennen$bigint$BigInt$sameSizeRaw,
						_p0._0._1,
						{ctor: '[]'})
				};
			} else {
				return {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: _p0._0._0, _1: _p0._1._0},
					_1: A2(_gilbertkennen$bigint$BigInt$sameSizeRaw, _p0._0._1, _p0._1._1)
				};
			}
		}
	});
var _gilbertkennen$bigint$BigInt$reverseMagnitude = _elm_lang$core$List$map(_elm_lang$core$Basics$negate);
var _gilbertkennen$bigint$BigInt$isNegativeMagnitude = function (digits) {
	var _p1 = _elm_community$list_extra$List_Extra$last(digits);
	if (_p1.ctor === 'Nothing') {
		return false;
	} else {
		return _elm_lang$core$Native_Utils.cmp(_p1._0, 0) < 0;
	}
};
var _gilbertkennen$bigint$BigInt$dropZeroes = _elm_community$list_extra$List_Extra$dropWhileRight(
	F2(
		function (x, y) {
			return _elm_lang$core$Native_Utils.eq(x, y);
		})(0));
var _gilbertkennen$bigint$BigInt$repeatedly = F3(
	function (f, x, n) {
		return A3(
			_elm_lang$core$List$foldl,
			_elm_lang$core$Basics$always(f),
			x,
			A2(_elm_lang$core$List$range, 1, n));
	});
var _gilbertkennen$bigint$BigInt$maxDigitBits = _elm_lang$core$Basics$ceiling(
	A2(
		_elm_lang$core$Basics$logBase,
		2,
		_elm_lang$core$Basics$toFloat(_gilbertkennen$bigint$Constants$maxDigitValue)));
var _gilbertkennen$bigint$BigInt$isEven = function (num) {
	var even = function (i) {
		return _elm_lang$core$Native_Utils.eq(
			A2(_elm_lang$core$Basics_ops['%'], i, 2),
			0);
	};
	var _p2 = num;
	switch (_p2.ctor) {
		case 'Zer':
			return true;
		case 'Pos':
			return even(
				A2(
					_elm_lang$core$Maybe$withDefault,
					0,
					_elm_lang$core$List$head(_p2._0._0)));
		default:
			return even(
				A2(
					_elm_lang$core$Maybe$withDefault,
					0,
					_elm_lang$core$List$head(_p2._0._0)));
	}
};
var _gilbertkennen$bigint$BigInt$isOdd = function (num) {
	return !_gilbertkennen$bigint$BigInt$isEven(num);
};
var _gilbertkennen$bigint$BigInt$bigIntToInt_ = function (bigInt) {
	var _p3 = bigInt;
	_v3_3:
	do {
		switch (_p3.ctor) {
			case 'Zer':
				return 0;
			case 'Pos':
				if (_p3._0._0.ctor === '::') {
					if (_p3._0._0._1.ctor === '[]') {
						return _p3._0._0._0;
					} else {
						if (_p3._0._0._1._1.ctor === '[]') {
							return (_p3._0._0._1._0 * Math.pow(10, _gilbertkennen$bigint$Constants$maxDigitMagnitude)) + _p3._0._0._0;
						} else {
							break _v3_3;
						}
					}
				} else {
					break _v3_3;
				}
			default:
				break _v3_3;
		}
	} while(false);
	return _elm_lang$core$Native_Utils.crashCase(
		'BigInt',
		{
			start: {line: 528, column: 5},
			end: {line: 539, column: 82}
		},
		_p3)('No suitable shortcut conversion in hexMagnitudeToString');
};
var _gilbertkennen$bigint$BigInt$fillZeroes = function (_p5) {
	return A3(
		_elm_lang$core$String$padLeft,
		_gilbertkennen$bigint$Constants$maxDigitMagnitude,
		_elm_lang$core$Native_Utils.chr('0'),
		_elm_lang$core$Basics$toString(_p5));
};
var _gilbertkennen$bigint$BigInt$revMagnitudeToString = function (_p6) {
	var _p7 = _p6;
	var _p8 = _elm_lang$core$List$reverse(_p7._0);
	if (_p8.ctor === '[]') {
		return '0';
	} else {
		return _elm_lang$core$String$concat(
			{
				ctor: '::',
				_0: _elm_lang$core$Basics$toString(_p8._0),
				_1: A2(_elm_lang$core$List$map, _gilbertkennen$bigint$BigInt$fillZeroes, _p8._1)
			});
	}
};
var _gilbertkennen$bigint$BigInt$toString = function (bigInt) {
	var _p9 = bigInt;
	switch (_p9.ctor) {
		case 'Zer':
			return '0';
		case 'Pos':
			return _gilbertkennen$bigint$BigInt$revMagnitudeToString(_p9._0);
		default:
			return A2(
				_elm_lang$core$Basics_ops['++'],
				'-',
				_gilbertkennen$bigint$BigInt$revMagnitudeToString(_p9._0));
	}
};
var _gilbertkennen$bigint$BigInt$orderNegate = function (x) {
	var _p10 = x;
	switch (_p10.ctor) {
		case 'LT':
			return _elm_lang$core$Basics$GT;
		case 'EQ':
			return _elm_lang$core$Basics$EQ;
		default:
			return _elm_lang$core$Basics$LT;
	}
};
var _gilbertkennen$bigint$BigInt$compareMagnitude = F4(
	function (x, y, xs, ys) {
		compareMagnitude:
		while (true) {
			var _p11 = {ctor: '_Tuple2', _0: xs, _1: ys};
			if (_p11._0.ctor === '[]') {
				if (_p11._1.ctor === '[]') {
					return A2(_elm_lang$core$Basics$compare, x, y);
				} else {
					return _elm_lang$core$Basics$LT;
				}
			} else {
				if (_p11._1.ctor === '[]') {
					return _elm_lang$core$Basics$GT;
				} else {
					var _p15 = _p11._1._1;
					var _p14 = _p11._1._0;
					var _p13 = _p11._0._1;
					var _p12 = _p11._0._0;
					if (_elm_lang$core$Native_Utils.eq(_p12, _p14)) {
						var _v9 = x,
							_v10 = y,
							_v11 = _p13,
							_v12 = _p15;
						x = _v9;
						y = _v10;
						xs = _v11;
						ys = _v12;
						continue compareMagnitude;
					} else {
						var _v13 = _p12,
							_v14 = _p14,
							_v15 = _p13,
							_v16 = _p15;
						x = _v13;
						y = _v14;
						xs = _v15;
						ys = _v16;
						continue compareMagnitude;
					}
				}
			}
		}
	});
var _gilbertkennen$bigint$BigInt$compare = F2(
	function (int1, int2) {
		var _p16 = {ctor: '_Tuple2', _0: int1, _1: int2};
		switch (_p16._0.ctor) {
			case 'Pos':
				if (_p16._1.ctor === 'Pos') {
					return A4(_gilbertkennen$bigint$BigInt$compareMagnitude, 0, 0, _p16._0._0._0, _p16._1._0._0);
				} else {
					return _elm_lang$core$Basics$GT;
				}
			case 'Neg':
				if (_p16._1.ctor === 'Neg') {
					return _gilbertkennen$bigint$BigInt$orderNegate(
						A4(_gilbertkennen$bigint$BigInt$compareMagnitude, 0, 0, _p16._0._0._0, _p16._1._0._0));
				} else {
					return _elm_lang$core$Basics$LT;
				}
			default:
				switch (_p16._1.ctor) {
					case 'Pos':
						return _elm_lang$core$Basics$LT;
					case 'Zer':
						return _elm_lang$core$Basics$EQ;
					default:
						return _elm_lang$core$Basics$GT;
				}
		}
	});
var _gilbertkennen$bigint$BigInt$lt = F2(
	function (x, y) {
		return _elm_lang$core$Native_Utils.eq(
			A2(_gilbertkennen$bigint$BigInt$compare, x, y),
			_elm_lang$core$Basics$LT);
	});
var _gilbertkennen$bigint$BigInt$gte = F2(
	function (x, y) {
		return !A2(_gilbertkennen$bigint$BigInt$lt, x, y);
	});
var _gilbertkennen$bigint$BigInt$max = F2(
	function (x, y) {
		return A2(_gilbertkennen$bigint$BigInt$lt, x, y) ? y : x;
	});
var _gilbertkennen$bigint$BigInt$gt = F2(
	function (x, y) {
		return _elm_lang$core$Native_Utils.eq(
			A2(_gilbertkennen$bigint$BigInt$compare, x, y),
			_elm_lang$core$Basics$GT);
	});
var _gilbertkennen$bigint$BigInt$lte = F2(
	function (x, y) {
		return !A2(_gilbertkennen$bigint$BigInt$gt, x, y);
	});
var _gilbertkennen$bigint$BigInt$min = F2(
	function (x, y) {
		return A2(_gilbertkennen$bigint$BigInt$gt, x, y) ? y : x;
	});
var _gilbertkennen$bigint$BigInt$baseDigit = _gilbertkennen$bigint$Constants$maxDigitValue + 1;
var _gilbertkennen$bigint$BigInt$normaliseDigit = function (x) {
	return (_elm_lang$core$Native_Utils.cmp(x, 0) < 0) ? A2(
		_elm_lang$core$Tuple$mapFirst,
		F2(
			function (x, y) {
				return x + y;
			})(-1),
		_gilbertkennen$bigint$BigInt$normaliseDigit(x + _gilbertkennen$bigint$BigInt$baseDigit)) : {
		ctor: '_Tuple2',
		_0: (x / _gilbertkennen$bigint$BigInt$baseDigit) | 0,
		_1: A2(_elm_lang$core$Basics$rem, x, _gilbertkennen$bigint$BigInt$baseDigit)
	};
};
var _gilbertkennen$bigint$BigInt$normaliseDigitList = F2(
	function (carry, xs) {
		var _p17 = xs;
		if (_p17.ctor === '[]') {
			return {
				ctor: '::',
				_0: carry,
				_1: {ctor: '[]'}
			};
		} else {
			var _p18 = _gilbertkennen$bigint$BigInt$normaliseDigit(_p17._0 + carry);
			var newCarry = _p18._0;
			var x_ = _p18._1;
			return {
				ctor: '::',
				_0: x_,
				_1: A2(_gilbertkennen$bigint$BigInt$normaliseDigitList, newCarry, _p17._1)
			};
		}
	});
var _gilbertkennen$bigint$BigInt$digits = function (bigInt) {
	var _p19 = bigInt;
	switch (_p19.ctor) {
		case 'Zer':
			return {ctor: '[]'};
		case 'Pos':
			return _p19._0._0;
		default:
			return _p19._0._0;
	}
};
var _gilbertkennen$bigint$BigInt$Zero = {ctor: 'Zero'};
var _gilbertkennen$bigint$BigInt$Negative = {ctor: 'Negative'};
var _gilbertkennen$bigint$BigInt$Positive = {ctor: 'Positive'};
var _gilbertkennen$bigint$BigInt$signProduct = F2(
	function (x, y) {
		return (_elm_lang$core$Native_Utils.eq(x, _gilbertkennen$bigint$BigInt$Zero) || _elm_lang$core$Native_Utils.eq(y, _gilbertkennen$bigint$BigInt$Zero)) ? _gilbertkennen$bigint$BigInt$Zero : (_elm_lang$core$Native_Utils.eq(x, y) ? _gilbertkennen$bigint$BigInt$Positive : _gilbertkennen$bigint$BigInt$Negative);
	});
var _gilbertkennen$bigint$BigInt$signNegate = function (sign) {
	var _p20 = sign;
	switch (_p20.ctor) {
		case 'Positive':
			return _gilbertkennen$bigint$BigInt$Negative;
		case 'Negative':
			return _gilbertkennen$bigint$BigInt$Positive;
		default:
			return _gilbertkennen$bigint$BigInt$Zero;
	}
};
var _gilbertkennen$bigint$BigInt$signFromInt = function (x) {
	var _p21 = A2(_elm_lang$core$Basics$compare, x, 0);
	switch (_p21.ctor) {
		case 'LT':
			return _gilbertkennen$bigint$BigInt$Negative;
		case 'GT':
			return _gilbertkennen$bigint$BigInt$Positive;
		default:
			return _gilbertkennen$bigint$BigInt$Zero;
	}
};
var _gilbertkennen$bigint$BigInt$sign = function (bigInt) {
	var _p22 = bigInt;
	switch (_p22.ctor) {
		case 'Zer':
			return _gilbertkennen$bigint$BigInt$Zero;
		case 'Pos':
			return _gilbertkennen$bigint$BigInt$Positive;
		default:
			return _gilbertkennen$bigint$BigInt$Negative;
	}
};
var _gilbertkennen$bigint$BigInt$Zer = {ctor: 'Zer'};
var _gilbertkennen$bigint$BigInt$Neg = function (a) {
	return {ctor: 'Neg', _0: a};
};
var _gilbertkennen$bigint$BigInt$Pos = function (a) {
	return {ctor: 'Pos', _0: a};
};
var _gilbertkennen$bigint$BigInt$mkBigInt = F2(
	function (s, _p23) {
		var _p24 = _p23;
		var _p26 = _p24;
		if (_elm_lang$core$List$isEmpty(_p24._0)) {
			return _gilbertkennen$bigint$BigInt$Zer;
		} else {
			var _p25 = s;
			switch (_p25.ctor) {
				case 'Zero':
					return _gilbertkennen$bigint$BigInt$Zer;
				case 'Positive':
					return _gilbertkennen$bigint$BigInt$Pos(_p26);
				default:
					return _gilbertkennen$bigint$BigInt$Neg(_p26);
			}
		}
	});
var _gilbertkennen$bigint$BigInt$negate = function (bigInt) {
	var _p27 = bigInt;
	switch (_p27.ctor) {
		case 'Zer':
			return _gilbertkennen$bigint$BigInt$Zer;
		case 'Pos':
			return _gilbertkennen$bigint$BigInt$Neg(_p27._0);
		default:
			return _gilbertkennen$bigint$BigInt$Pos(_p27._0);
	}
};
var _gilbertkennen$bigint$BigInt$abs = function (bigInt) {
	var _p28 = bigInt;
	switch (_p28.ctor) {
		case 'Zer':
			return _gilbertkennen$bigint$BigInt$Zer;
		case 'Neg':
			return _gilbertkennen$bigint$BigInt$Pos(_p28._0);
		default:
			return _p28;
	}
};
var _gilbertkennen$bigint$BigInt$Magnitude = function (a) {
	return {ctor: 'Magnitude', _0: a};
};
var _gilbertkennen$bigint$BigInt$emptyZero = function (_p29) {
	var _p30 = _p29;
	var _p32 = _p30._0;
	var _p31 = A2(
		_elm_community$list_extra$List_Extra$dropWhile,
		F2(
			function (x, y) {
				return _elm_lang$core$Native_Utils.eq(x, y);
			})(0),
		_p32);
	if (_p31.ctor === '[]') {
		return _gilbertkennen$bigint$BigInt$Magnitude(
			{ctor: '[]'});
	} else {
		return _gilbertkennen$bigint$BigInt$Magnitude(_p32);
	}
};
var _gilbertkennen$bigint$BigInt$fromString_ = function (x) {
	return A2(
		_elm_lang$core$Maybe$map,
		function (_p33) {
			return _gilbertkennen$bigint$BigInt$emptyZero(
				_gilbertkennen$bigint$BigInt$Magnitude(_p33));
		},
		_elm_lang$core$Result$toMaybe(
			_elm_community$result_extra$Result_Extra$combine(
				A2(
					_elm_lang$core$List$map,
					function (_p34) {
						return _elm_lang$core$String$toInt(
							_elm_lang$core$String$fromList(
								_elm_lang$core$List$reverse(_p34)));
					},
					A2(
						_elm_community$list_extra$List_Extra$greedyGroupsOf,
						_gilbertkennen$bigint$Constants$maxDigitMagnitude,
						_elm_lang$core$List$reverse(x))))));
};
var _gilbertkennen$bigint$BigInt$magnitude = function (bigInt) {
	var _p35 = bigInt;
	switch (_p35.ctor) {
		case 'Zer':
			return _gilbertkennen$bigint$BigInt$Magnitude(
				{ctor: '[]'});
		case 'Pos':
			return _p35._0;
		default:
			return _p35._0;
	}
};
var _gilbertkennen$bigint$BigInt$normaliseMagnitude = function (_p36) {
	var _p37 = _p36;
	return _gilbertkennen$bigint$BigInt$Magnitude(
		_gilbertkennen$bigint$BigInt$dropZeroes(
			A2(_gilbertkennen$bigint$BigInt$normaliseDigitList, 0, _p37._0)));
};
var _gilbertkennen$bigint$BigInt$BigIntNotNormalised = F2(
	function (a, b) {
		return {ctor: 'BigIntNotNormalised', _0: a, _1: b};
	});
var _gilbertkennen$bigint$BigInt$MagnitudeNotNormalised = function (a) {
	return {ctor: 'MagnitudeNotNormalised', _0: a};
};
var _gilbertkennen$bigint$BigInt$mkBigIntNotNormalised = F2(
	function (s, digits) {
		return A2(
			_gilbertkennen$bigint$BigInt$BigIntNotNormalised,
			s,
			_gilbertkennen$bigint$BigInt$MagnitudeNotNormalised(digits));
	});
var _gilbertkennen$bigint$BigInt$normalise = function (_p38) {
	normalise:
	while (true) {
		var _p39 = _p38;
		var _p41 = _p39._0;
		var _p40 = _gilbertkennen$bigint$BigInt$normaliseMagnitude(_p39._1);
		var normalisedMag = _p40._0;
		if (_gilbertkennen$bigint$BigInt$isNegativeMagnitude(normalisedMag)) {
			var _v32 = A2(
				_gilbertkennen$bigint$BigInt$mkBigIntNotNormalised,
				_gilbertkennen$bigint$BigInt$signNegate(_p41),
				_gilbertkennen$bigint$BigInt$reverseMagnitude(normalisedMag));
			_p38 = _v32;
			continue normalise;
		} else {
			return A2(
				_gilbertkennen$bigint$BigInt$mkBigInt,
				_p41,
				_gilbertkennen$bigint$BigInt$Magnitude(normalisedMag));
		}
	}
};
var _gilbertkennen$bigint$BigInt$toPositiveSign = function (bigInt) {
	var _p42 = bigInt;
	switch (_p42.ctor) {
		case 'Zer':
			return A2(
				_gilbertkennen$bigint$BigInt$mkBigIntNotNormalised,
				_gilbertkennen$bigint$BigInt$Zero,
				{ctor: '[]'});
		case 'Neg':
			return A2(
				_gilbertkennen$bigint$BigInt$mkBigIntNotNormalised,
				_gilbertkennen$bigint$BigInt$Positive,
				_gilbertkennen$bigint$BigInt$reverseMagnitude(_p42._0._0));
		default:
			return A2(_gilbertkennen$bigint$BigInt$mkBigIntNotNormalised, _gilbertkennen$bigint$BigInt$Positive, _p42._0._0);
	}
};
var _gilbertkennen$bigint$BigInt$fromInt = function (x) {
	return _gilbertkennen$bigint$BigInt$normalise(
		A2(
			_gilbertkennen$bigint$BigInt$BigIntNotNormalised,
			_gilbertkennen$bigint$BigInt$signFromInt(x),
			_gilbertkennen$bigint$BigInt$MagnitudeNotNormalised(
				{
					ctor: '::',
					_0: _elm_lang$core$Basics$abs(x),
					_1: {ctor: '[]'}
				})));
};
var _gilbertkennen$bigint$BigInt$zero = _gilbertkennen$bigint$BigInt$fromInt(0);
var _gilbertkennen$bigint$BigInt$one = _gilbertkennen$bigint$BigInt$fromInt(1);
var _gilbertkennen$bigint$BigInt$two = _gilbertkennen$bigint$BigInt$fromInt(2);
var _gilbertkennen$bigint$BigInt$mulSingleDigit = F2(
	function (_p43, d) {
		var _p44 = _p43;
		return _gilbertkennen$bigint$BigInt$normaliseMagnitude(
			_gilbertkennen$bigint$BigInt$MagnitudeNotNormalised(
				A2(
					_elm_lang$core$List$map,
					F2(
						function (x, y) {
							return x * y;
						})(d),
					_p44._0)));
	});
var _gilbertkennen$bigint$BigInt$MagnitudePair = function (a) {
	return {ctor: 'MagnitudePair', _0: a};
};
var _gilbertkennen$bigint$BigInt$sameSizeNotNormalized = F2(
	function (_p46, _p45) {
		var _p47 = _p46;
		var _p48 = _p45;
		return _gilbertkennen$bigint$BigInt$MagnitudePair(
			A2(_gilbertkennen$bigint$BigInt$sameSizeRaw, _p47._0, _p48._0));
	});
var _gilbertkennen$bigint$BigInt$add = F2(
	function (a, b) {
		var _p49 = _gilbertkennen$bigint$BigInt$toPositiveSign(b);
		var mb = _p49._1;
		var _p50 = _gilbertkennen$bigint$BigInt$toPositiveSign(a);
		var ma = _p50._1;
		var _p51 = A2(_gilbertkennen$bigint$BigInt$sameSizeNotNormalized, ma, mb);
		var pairs = _p51._0;
		var added = A2(
			_elm_lang$core$List$map,
			_elm_lang$core$Basics$uncurry(
				F2(
					function (x, y) {
						return x + y;
					})),
			pairs);
		return _gilbertkennen$bigint$BigInt$normalise(
			A2(
				_gilbertkennen$bigint$BigInt$BigIntNotNormalised,
				_gilbertkennen$bigint$BigInt$Positive,
				_gilbertkennen$bigint$BigInt$MagnitudeNotNormalised(added)));
	});
var _gilbertkennen$bigint$BigInt$sub = F2(
	function (a, b) {
		return A2(
			_gilbertkennen$bigint$BigInt$add,
			a,
			_gilbertkennen$bigint$BigInt$negate(b));
	});
var _gilbertkennen$bigint$BigInt$mulMagnitudes = F2(
	function (_p53, _p52) {
		var _p54 = _p53;
		var _p55 = _p52;
		var _p58 = _p55._0;
		var _p56 = _p54._0;
		if (_p56.ctor === '[]') {
			return _gilbertkennen$bigint$BigInt$Magnitude(
				{ctor: '[]'});
		} else {
			if (_p56._1.ctor === '[]') {
				return A2(
					_gilbertkennen$bigint$BigInt$mulSingleDigit,
					_gilbertkennen$bigint$BigInt$Magnitude(_p58),
					_p56._0);
			} else {
				var _p57 = A2(
					_gilbertkennen$bigint$BigInt$mulMagnitudes,
					_gilbertkennen$bigint$BigInt$Magnitude(_p56._1),
					_gilbertkennen$bigint$BigInt$Magnitude(_p58));
				var rest = _p57._0;
				var accum = A2(
					_gilbertkennen$bigint$BigInt$mulSingleDigit,
					_gilbertkennen$bigint$BigInt$Magnitude(_p58),
					_p56._0);
				var bigInt = A2(
					_gilbertkennen$bigint$BigInt$add,
					A2(_gilbertkennen$bigint$BigInt$mkBigInt, _gilbertkennen$bigint$BigInt$Positive, accum),
					A2(
						_gilbertkennen$bigint$BigInt$mkBigInt,
						_gilbertkennen$bigint$BigInt$Positive,
						_gilbertkennen$bigint$BigInt$Magnitude(
							{ctor: '::', _0: 0, _1: rest})));
				return _gilbertkennen$bigint$BigInt$magnitude(bigInt);
			}
		}
	});
var _gilbertkennen$bigint$BigInt$mul = F2(
	function (int1, int2) {
		return A2(
			_gilbertkennen$bigint$BigInt$mkBigInt,
			A2(
				_gilbertkennen$bigint$BigInt$signProduct,
				_gilbertkennen$bigint$BigInt$sign(int1),
				_gilbertkennen$bigint$BigInt$sign(int2)),
			A2(
				_gilbertkennen$bigint$BigInt$mulMagnitudes,
				_gilbertkennen$bigint$BigInt$magnitude(int1),
				_gilbertkennen$bigint$BigInt$magnitude(int2)));
	});
var _gilbertkennen$bigint$BigInt$eightHexDigits = A2(
	_gilbertkennen$bigint$BigInt$mul,
	_gilbertkennen$bigint$BigInt$fromInt(2),
	_gilbertkennen$bigint$BigInt$fromInt(-2147483648));
var _gilbertkennen$bigint$BigInt$fromHexString_ = function (x) {
	return A2(
		_elm_lang$core$Maybe$map,
		function (_p59) {
			return A3(
				_elm_lang$core$List$foldl,
				F2(
					function (e, s) {
						return A2(
							_gilbertkennen$bigint$BigInt$add,
							_gilbertkennen$bigint$BigInt$fromInt(e),
							A2(_gilbertkennen$bigint$BigInt$mul, s, _gilbertkennen$bigint$BigInt$eightHexDigits));
					}),
				_gilbertkennen$bigint$BigInt$zero,
				_elm_lang$core$List$reverse(_p59));
		},
		_elm_lang$core$Result$toMaybe(
			_elm_community$result_extra$Result_Extra$combine(
				A2(
					_elm_lang$core$List$map,
					function (_p60) {
						return _rtfeldman$hex$Hex$fromString(
							_elm_lang$core$String$fromList(
								_elm_lang$core$List$reverse(_p60)));
					},
					A2(
						_elm_community$list_extra$List_Extra$greedyGroupsOf,
						_gilbertkennen$bigint$Constants$hexDigitMagnitude,
						_elm_lang$core$List$reverse(x))))));
};
var _gilbertkennen$bigint$BigInt$fromString = function (x) {
	var _p61 = _elm_lang$core$String$toList(x);
	_v40_5:
	do {
		if (_p61.ctor === '[]') {
			return _elm_lang$core$Maybe$Just(_gilbertkennen$bigint$BigInt$zero);
		} else {
			switch (_p61._0.valueOf()) {
				case '-':
					if ((((_p61._1.ctor === '::') && (_p61._1._0.valueOf() === '0')) && (_p61._1._1.ctor === '::')) && (_p61._1._1._0.valueOf() === 'x')) {
						return A2(
							_elm_lang$core$Maybe$map,
							_gilbertkennen$bigint$BigInt$mul(
								_gilbertkennen$bigint$BigInt$fromInt(-1)),
							_gilbertkennen$bigint$BigInt$fromHexString_(_p61._1._1._1));
					} else {
						return A2(
							_elm_lang$core$Maybe$map,
							_gilbertkennen$bigint$BigInt$mkBigInt(_gilbertkennen$bigint$BigInt$Negative),
							_gilbertkennen$bigint$BigInt$fromString_(_p61._1));
					}
				case '+':
					return A2(
						_elm_lang$core$Maybe$map,
						_gilbertkennen$bigint$BigInt$mkBigInt(_gilbertkennen$bigint$BigInt$Positive),
						_gilbertkennen$bigint$BigInt$fromString_(_p61._1));
				case '0':
					if ((_p61._1.ctor === '::') && (_p61._1._0.valueOf() === 'x')) {
						return _gilbertkennen$bigint$BigInt$fromHexString_(_p61._1._1);
					} else {
						break _v40_5;
					}
				default:
					break _v40_5;
			}
		}
	} while(false);
	return A2(
		_elm_lang$core$Maybe$map,
		_gilbertkennen$bigint$BigInt$mkBigInt(_gilbertkennen$bigint$BigInt$Positive),
		_gilbertkennen$bigint$BigInt$fromString_(_p61));
};
var _gilbertkennen$bigint$BigInt$square = function (num) {
	return A2(_gilbertkennen$bigint$BigInt$mul, num, num);
};
var _gilbertkennen$bigint$BigInt$padDigits = function (n) {
	return A3(
		_gilbertkennen$bigint$BigInt$repeatedly,
		_gilbertkennen$bigint$BigInt$mul(
			_gilbertkennen$bigint$BigInt$fromInt(_gilbertkennen$bigint$BigInt$baseDigit)),
		_gilbertkennen$bigint$BigInt$one,
		n);
};
var _gilbertkennen$bigint$BigInt$divmodDigit_ = F4(
	function (to_test, padding, num, den) {
		if (_elm_lang$core$Native_Utils.eq(to_test, 0)) {
			return {ctor: '_Tuple2', _0: _gilbertkennen$bigint$BigInt$zero, _1: num};
		} else {
			var x = _gilbertkennen$bigint$BigInt$fromInt(to_test);
			var candidate = A2(
				_gilbertkennen$bigint$BigInt$mul,
				A2(_gilbertkennen$bigint$BigInt$mul, x, den),
				padding);
			var _p62 = A2(_gilbertkennen$bigint$BigInt$lte, candidate, num) ? {
				ctor: '_Tuple2',
				_0: A2(_gilbertkennen$bigint$BigInt$mul, x, padding),
				_1: A2(_gilbertkennen$bigint$BigInt$sub, num, candidate)
			} : {ctor: '_Tuple2', _0: _gilbertkennen$bigint$BigInt$zero, _1: num};
			var newdiv = _p62._0;
			var newmod = _p62._1;
			var _p63 = A4(_gilbertkennen$bigint$BigInt$divmodDigit_, (to_test / 2) | 0, padding, newmod, den);
			var restdiv = _p63._0;
			var restmod = _p63._1;
			return {
				ctor: '_Tuple2',
				_0: A2(_gilbertkennen$bigint$BigInt$add, newdiv, restdiv),
				_1: restmod
			};
		}
	});
var _gilbertkennen$bigint$BigInt$divmodDigit = F3(
	function (padding, x, y) {
		return A4(
			_gilbertkennen$bigint$BigInt$divmodDigit_,
			Math.pow(2, _gilbertkennen$bigint$BigInt$maxDigitBits),
			padding,
			x,
			y);
	});
var _gilbertkennen$bigint$BigInt$divMod_ = F3(
	function (n, num, den) {
		if (_elm_lang$core$Native_Utils.eq(n, 0)) {
			return A3(
				_gilbertkennen$bigint$BigInt$divmodDigit,
				_gilbertkennen$bigint$BigInt$padDigits(n),
				num,
				den);
		} else {
			var _p64 = A3(
				_gilbertkennen$bigint$BigInt$divmodDigit,
				_gilbertkennen$bigint$BigInt$padDigits(n),
				num,
				den);
			var cdiv = _p64._0;
			var cmod = _p64._1;
			var _p65 = A3(_gilbertkennen$bigint$BigInt$divMod_, n - 1, cmod, den);
			var rdiv = _p65._0;
			var rmod = _p65._1;
			return {
				ctor: '_Tuple2',
				_0: A2(_gilbertkennen$bigint$BigInt$add, cdiv, rdiv),
				_1: rmod
			};
		}
	});
var _gilbertkennen$bigint$BigInt$divmod = F2(
	function (num, den) {
		if (_elm_lang$core$Native_Utils.eq(den, _gilbertkennen$bigint$BigInt$zero)) {
			return _elm_lang$core$Maybe$Nothing;
		} else {
			var cand_l = (_elm_lang$core$List$length(
				_gilbertkennen$bigint$BigInt$digits(num)) - _elm_lang$core$List$length(
				_gilbertkennen$bigint$BigInt$digits(den))) + 1;
			var _p66 = A3(
				_gilbertkennen$bigint$BigInt$divMod_,
				A2(_elm_lang$core$Basics$max, 0, cand_l),
				_gilbertkennen$bigint$BigInt$abs(num),
				_gilbertkennen$bigint$BigInt$abs(den));
			var d = _p66._0;
			var m = _p66._1;
			return _elm_lang$core$Maybe$Just(
				{
					ctor: '_Tuple2',
					_0: A2(
						_gilbertkennen$bigint$BigInt$mkBigInt,
						A2(
							_gilbertkennen$bigint$BigInt$signProduct,
							_gilbertkennen$bigint$BigInt$sign(num),
							_gilbertkennen$bigint$BigInt$sign(den)),
						_gilbertkennen$bigint$BigInt$magnitude(d)),
					_1: A2(
						_gilbertkennen$bigint$BigInt$mkBigInt,
						_gilbertkennen$bigint$BigInt$sign(num),
						_gilbertkennen$bigint$BigInt$magnitude(m))
				});
		}
	});
var _gilbertkennen$bigint$BigInt$hexMagnitudeToString = function (bigInt) {
	var _p67 = A2(_gilbertkennen$bigint$BigInt$divmod, bigInt, _gilbertkennen$bigint$BigInt$eightHexDigits);
	if (_p67.ctor === 'Nothing') {
		return _elm_lang$core$Native_Utils.crashCase(
			'BigInt',
			{
				start: {line: 544, column: 5},
				end: {line: 556, column: 79}
			},
			_p67)('Failure converting to hex string.');
	} else {
		var _p69 = _p67._0._0;
		var rString = _rtfeldman$hex$Hex$toString(
			_gilbertkennen$bigint$BigInt$bigIntToInt_(_p67._0._1));
		return _elm_lang$core$Native_Utils.eq(
			_p69,
			_gilbertkennen$bigint$BigInt$fromInt(0)) ? rString : A2(
			_elm_lang$core$Basics_ops['++'],
			_gilbertkennen$bigint$BigInt$hexMagnitudeToString(_p69),
			A3(
				_elm_lang$core$String$padLeft,
				8,
				_elm_lang$core$Native_Utils.chr('0'),
				rString));
	}
};
var _gilbertkennen$bigint$BigInt$toHexString = function (bigInt) {
	var _p70 = bigInt;
	switch (_p70.ctor) {
		case 'Zer':
			return '0';
		case 'Pos':
			var _p71 = _p70._0;
			return _elm_lang$core$Native_Utils.eq(
				_p71,
				_gilbertkennen$bigint$BigInt$Magnitude(
					{ctor: '[]'})) ? '0' : _gilbertkennen$bigint$BigInt$hexMagnitudeToString(
				_gilbertkennen$bigint$BigInt$Pos(_p71));
		default:
			return A2(
				_elm_lang$core$Basics_ops['++'],
				'-',
				_gilbertkennen$bigint$BigInt$toHexString(
					A2(
						_gilbertkennen$bigint$BigInt$mul,
						_gilbertkennen$bigint$BigInt$fromInt(-1),
						bigInt)));
	}
};
var _gilbertkennen$bigint$BigInt$div = F2(
	function (num, den) {
		return A2(
			_elm_lang$core$Maybe$withDefault,
			_gilbertkennen$bigint$BigInt$zero,
			A2(
				_elm_lang$core$Maybe$map,
				_elm_lang$core$Tuple$first,
				A2(_gilbertkennen$bigint$BigInt$divmod, num, den)));
	});
var _gilbertkennen$bigint$BigInt$powHelp = F3(
	function (work, num, exp) {
		powHelp:
		while (true) {
			var _p72 = exp;
			switch (_p72.ctor) {
				case 'Zer':
					return _gilbertkennen$bigint$BigInt$one;
				case 'Neg':
					return _gilbertkennen$bigint$BigInt$Zer;
				default:
					if (_elm_lang$core$Native_Utils.eq(exp, _gilbertkennen$bigint$BigInt$one)) {
						return A2(_gilbertkennen$bigint$BigInt$mul, work, num);
					} else {
						if (_gilbertkennen$bigint$BigInt$isEven(exp)) {
							var _v44 = work,
								_v45 = _gilbertkennen$bigint$BigInt$square(num),
								_v46 = A2(_gilbertkennen$bigint$BigInt$div, exp, _gilbertkennen$bigint$BigInt$two);
							work = _v44;
							num = _v45;
							exp = _v46;
							continue powHelp;
						} else {
							var _v47 = A2(_gilbertkennen$bigint$BigInt$mul, num, work),
								_v48 = _gilbertkennen$bigint$BigInt$square(num),
								_v49 = A2(
								_gilbertkennen$bigint$BigInt$div,
								A2(_gilbertkennen$bigint$BigInt$sub, exp, _gilbertkennen$bigint$BigInt$one),
								_gilbertkennen$bigint$BigInt$two);
							work = _v47;
							num = _v48;
							exp = _v49;
							continue powHelp;
						}
					}
			}
		}
	});
var _gilbertkennen$bigint$BigInt$pow = F2(
	function (base, exp) {
		return A3(_gilbertkennen$bigint$BigInt$powHelp, _gilbertkennen$bigint$BigInt$one, base, exp);
	});
var _gilbertkennen$bigint$BigInt$mod = F2(
	function (num, den) {
		var _p73 = A2(
			_elm_lang$core$Maybe$map,
			_elm_lang$core$Tuple$second,
			A2(_gilbertkennen$bigint$BigInt$divmod, num, den));
		if (_p73.ctor === 'Nothing') {
			return _elm_lang$core$Native_Utils.crashCase(
				'BigInt',
				{
					start: {line: 572, column: 5},
					end: {line: 577, column: 14}
				},
				_p73)('Cannot perform mod 0. Division by zero error.');
		} else {
			return _p73._0;
		}
	});

var _justgage$tachyons_elm$Tachyons$tachyons = {
	css: A3(
		_elm_lang$html$Html$node,
		'style',
		{ctor: '[]'},
		{
			ctor: '::',
			_0: _elm_lang$html$Html$text('\n/*! TACHYONS v4.8.1 | http://tachyons.io */\n/*! normalize.css v7.0.0 | MIT License | github.com/necolas/normalize.css */html{line-height:1.15;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0}article,aside,footer,header,nav,section{display:block}h1{font-size:2em;margin:.67em 0}figcaption,figure,main{display:block}figure{margin:1em 40px}hr{box-sizing:content-box;height:0;overflow:visible}pre{font-family:monospace,monospace;font-size:1em}a{background-color:transparent;-webkit-text-decoration-skip:objects}abbr[title]{border-bottom:none;text-decoration:underline;text-decoration:underline dotted}b,strong{font-weight:inherit;font-weight:bolder}code,kbd,samp{font-family:monospace,monospace;font-size:1em}dfn{font-style:italic}mark{background-color:#ff0;color:#000}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}audio,video{display:inline-block}audio:not([controls]){display:none;height:0}img{border-style:none}svg:not(:root){overflow:hidden}button,input,optgroup,select,textarea{font-family:sans-serif;font-size:100%;line-height:1.15;margin:0}button,input{overflow:visible}button,select{text-transform:none}/* 1 */ [type=reset],[type=submit],button,html [type=button]{-webkit-appearance:button}[type=button]::-moz-focus-inner,[type=reset]::-moz-focus-inner,[type=submit]::-moz-focus-inner,button::-moz-focus-inner{border-style:none;padding:0}[type=button]:-moz-focusring,[type=reset]:-moz-focusring,[type=submit]:-moz-focusring,button:-moz-focusring{outline:1px dotted ButtonText}fieldset{padding:.35em .75em .625em}legend{box-sizing:border-box;color:inherit;display:table;max-width:100%;padding:0;white-space:normal}progress{display:inline-block;vertical-align:baseline}textarea{overflow:auto}[type=checkbox],[type=radio]{box-sizing:border-box;padding:0}[type=number]::-webkit-inner-spin-button,[type=number]::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}[type=search]::-webkit-search-cancel-button,[type=search]::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}/* 1 */ menu,details{display:block}summary{display:list-item}canvas{display:inline-block}[hidden],template{display:none}.border-box,a,article,body,code,dd,div,dl,dt,fieldset,footer,form,h1,h2,h3,h4,h5,h6,header,html,input[type=email],input[type=number],input[type=password],input[type=tel],input[type=text],input[type=url],legend,li,main,ol,p,pre,section,table,td,textarea,th,tr,ul{box-sizing:border-box}.aspect-ratio{height:0;position:relative}.aspect-ratio--16x9{padding-bottom:56.25%}.aspect-ratio--9x16{padding-bottom:177.77%}.aspect-ratio--4x3{padding-bottom:75%}.aspect-ratio--3x4{padding-bottom:133.33%}.aspect-ratio--6x4{padding-bottom:66.6%}.aspect-ratio--4x6{padding-bottom:150%}.aspect-ratio--8x5{padding-bottom:62.5%}.aspect-ratio--5x8{padding-bottom:160%}.aspect-ratio--7x5{padding-bottom:71.42%}.aspect-ratio--5x7{padding-bottom:140%}.aspect-ratio--1x1{padding-bottom:100%}.aspect-ratio--object{position:absolute;top:0;right:0;bottom:0;left:0;width:100%;height:100%;z-index:100}img{max-width:100%}.cover{background-size:cover!important}.contain{background-size:contain!important}.bg-center{background-position:50%}.bg-center,.bg-top{background-repeat:no-repeat}.bg-top{background-position:top}.bg-right{background-position:100%}.bg-bottom,.bg-right{background-repeat:no-repeat}.bg-bottom{background-position:bottom}.bg-left{background-repeat:no-repeat;background-position:0}.outline{outline:1px solid}.outline-transparent{outline:1px solid transparent}.outline-0{outline:0}.ba{border-style:solid;border-width:1px}.bt{border-top-style:solid;border-top-width:1px}.br{border-right-style:solid;border-right-width:1px}.bb{border-bottom-style:solid;border-bottom-width:1px}.bl{border-left-style:solid;border-left-width:1px}.bn{border-style:none;border-width:0}.b--black{border-color:#000}.b--near-black{border-color:#111}.b--dark-gray{border-color:#333}.b--mid-gray{border-color:#555}.b--gray{border-color:#777}.b--silver{border-color:#999}.b--light-silver{border-color:#aaa}.b--moon-gray{border-color:#ccc}.b--light-gray{border-color:#eee}.b--near-white{border-color:#f4f4f4}.b--white{border-color:#fff}.b--white-90{border-color:hsla(0,0%,100%,.9)}.b--white-80{border-color:hsla(0,0%,100%,.8)}.b--white-70{border-color:hsla(0,0%,100%,.7)}.b--white-60{border-color:hsla(0,0%,100%,.6)}.b--white-50{border-color:hsla(0,0%,100%,.5)}.b--white-40{border-color:hsla(0,0%,100%,.4)}.b--white-30{border-color:hsla(0,0%,100%,.3)}.b--white-20{border-color:hsla(0,0%,100%,.2)}.b--white-10{border-color:hsla(0,0%,100%,.1)}.b--white-05{border-color:hsla(0,0%,100%,.05)}.b--white-025{border-color:hsla(0,0%,100%,.025)}.b--white-0125{border-color:hsla(0,0%,100%,.0125)}.b--black-90{border-color:rgba(0,0,0,.9)}.b--black-80{border-color:rgba(0,0,0,.8)}.b--black-70{border-color:rgba(0,0,0,.7)}.b--black-60{border-color:rgba(0,0,0,.6)}.b--black-50{border-color:rgba(0,0,0,.5)}.b--black-40{border-color:rgba(0,0,0,.4)}.b--black-30{border-color:rgba(0,0,0,.3)}.b--black-20{border-color:rgba(0,0,0,.2)}.b--black-10{border-color:rgba(0,0,0,.1)}.b--black-05{border-color:rgba(0,0,0,.05)}.b--black-025{border-color:rgba(0,0,0,.025)}.b--black-0125{border-color:rgba(0,0,0,.0125)}.b--dark-red{border-color:#e7040f}.b--red{border-color:#ff4136}.b--light-red{border-color:#ff725c}.b--orange{border-color:#ff6300}.b--gold{border-color:#ffb700}.b--yellow{border-color:gold}.b--light-yellow{border-color:#fbf1a9}.b--purple{border-color:#5e2ca5}.b--light-purple{border-color:#a463f2}.b--dark-pink{border-color:#d5008f}.b--hot-pink{border-color:#ff41b4}.b--pink{border-color:#ff80cc}.b--light-pink{border-color:#ffa3d7}.b--dark-green{border-color:#137752}.b--green{border-color:#19a974}.b--light-green{border-color:#9eebcf}.b--navy{border-color:#001b44}.b--dark-blue{border-color:#00449e}.b--blue{border-color:#357edd}.b--light-blue{border-color:#96ccff}.b--lightest-blue{border-color:#cdecff}.b--washed-blue{border-color:#f6fffe}.b--washed-green{border-color:#e8fdf5}.b--washed-yellow{border-color:#fffceb}.b--washed-red{border-color:#ffdfdf}.b--transparent{border-color:transparent}.b--inherit{border-color:inherit}.br0{border-radius:0}.br1{border-radius:.125rem}.br2{border-radius:.25rem}.br3{border-radius:.5rem}.br4{border-radius:1rem}.br-100{border-radius:100%}.br-pill{border-radius:9999px}.br--bottom{border-top-left-radius:0;border-top-right-radius:0}.br--top{border-bottom-right-radius:0}.br--right,.br--top{border-bottom-left-radius:0}.br--right{border-top-left-radius:0}.br--left{border-top-right-radius:0;border-bottom-right-radius:0}.b--dotted{border-style:dotted}.b--dashed{border-style:dashed}.b--solid{border-style:solid}.b--none{border-style:none}.bw0{border-width:0}.bw1{border-width:.125rem}.bw2{border-width:.25rem}.bw3{border-width:.5rem}.bw4{border-width:1rem}.bw5{border-width:2rem}.bt-0{border-top-width:0}.br-0{border-right-width:0}.bb-0{border-bottom-width:0}.bl-0{border-left-width:0}.shadow-1{box-shadow:0 0 4px 2px rgba(0,0,0,.2)}.shadow-2{box-shadow:0 0 8px 2px rgba(0,0,0,.2)}.shadow-3{box-shadow:2px 2px 4px 2px rgba(0,0,0,.2)}.shadow-4{box-shadow:2px 2px 8px 0 rgba(0,0,0,.2)}.shadow-5{box-shadow:4px 4px 8px 0 rgba(0,0,0,.2)}.pre{overflow-x:auto;overflow-y:hidden;overflow:scroll}.top-0{top:0}.right-0{right:0}.bottom-0{bottom:0}.left-0{left:0}.top-1{top:1rem}.right-1{right:1rem}.bottom-1{bottom:1rem}.left-1{left:1rem}.top-2{top:2rem}.right-2{right:2rem}.bottom-2{bottom:2rem}.left-2{left:2rem}.top--1{top:-1rem}.right--1{right:-1rem}.bottom--1{bottom:-1rem}.left--1{left:-1rem}.top--2{top:-2rem}.right--2{right:-2rem}.bottom--2{bottom:-2rem}.left--2{left:-2rem}.absolute--fill{top:0;right:0;bottom:0;left:0}.cf:after,.cf:before{content:\" \";display:table}.cf:after{clear:both}.cf{*zoom:1}.cl{clear:left}.cr{clear:right}.cb{clear:both}.cn{clear:none}.dn{display:none}.di{display:inline}.db{display:block}.dib{display:inline-block}.dit{display:inline-table}.dt{display:table}.dtc{display:table-cell}.dt-row{display:table-row}.dt-row-group{display:table-row-group}.dt-column{display:table-column}.dt-column-group{display:table-column-group}.dt--fixed{table-layout:fixed;width:100%}.flex{display:-webkit-box;display:-ms-flexbox;display:flex}.inline-flex{display:-webkit-inline-box;display:-ms-inline-flexbox;display:inline-flex}.flex-auto{-webkit-box-flex:1;-ms-flex:1 1 auto;flex:1 1 auto;min-width:0;min-height:0}.flex-none{-webkit-box-flex:0;-ms-flex:none;flex:none}.flex-column{-webkit-box-orient:vertical;-ms-flex-direction:column;flex-direction:column}.flex-column,.flex-row{-webkit-box-direction:normal}.flex-row{-webkit-box-orient:horizontal;-ms-flex-direction:row;flex-direction:row}.flex-wrap{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-nowrap{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-wrap-reverse{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-column-reverse{-webkit-box-orient:vertical;-webkit-box-direction:reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-row-reverse{-webkit-box-orient:horizontal;-webkit-box-direction:reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse}.items-start{-webkit-box-align:start;-ms-flex-align:start;align-items:flex-start}.items-end{-webkit-box-align:end;-ms-flex-align:end;align-items:flex-end}.items-center{-webkit-box-align:center;-ms-flex-align:center;align-items:center}.items-baseline{-webkit-box-align:baseline;-ms-flex-align:baseline;align-items:baseline}.items-stretch{-webkit-box-align:stretch;-ms-flex-align:stretch;align-items:stretch}.self-start{-ms-flex-item-align:start;align-self:flex-start}.self-end{-ms-flex-item-align:end;align-self:flex-end}.self-center{-ms-flex-item-align:center;-ms-grid-row-align:center;align-self:center}.self-baseline{-ms-flex-item-align:baseline;align-self:baseline}.self-stretch{-ms-flex-item-align:stretch;-ms-grid-row-align:stretch;align-self:stretch}.justify-start{-webkit-box-pack:start;-ms-flex-pack:start;justify-content:flex-start}.justify-end{-webkit-box-pack:end;-ms-flex-pack:end;justify-content:flex-end}.justify-center{-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center}.justify-between{-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between}.justify-around{-ms-flex-pack:distribute;justify-content:space-around}.content-start{-ms-flex-line-pack:start;align-content:flex-start}.content-end{-ms-flex-line-pack:end;align-content:flex-end}.content-center{-ms-flex-line-pack:center;align-content:center}.content-between{-ms-flex-line-pack:justify;align-content:space-between}.content-around{-ms-flex-line-pack:distribute;align-content:space-around}.content-stretch{-ms-flex-line-pack:stretch;align-content:stretch}.order-0{-webkit-box-ordinal-group:1;-ms-flex-order:0;order:0}.order-1{-webkit-box-ordinal-group:2;-ms-flex-order:1;order:1}.order-2{-webkit-box-ordinal-group:3;-ms-flex-order:2;order:2}.order-3{-webkit-box-ordinal-group:4;-ms-flex-order:3;order:3}.order-4{-webkit-box-ordinal-group:5;-ms-flex-order:4;order:4}.order-5{-webkit-box-ordinal-group:6;-ms-flex-order:5;order:5}.order-6{-webkit-box-ordinal-group:7;-ms-flex-order:6;order:6}.order-7{-webkit-box-ordinal-group:8;-ms-flex-order:7;order:7}.order-8{-webkit-box-ordinal-group:9;-ms-flex-order:8;order:8}.order-last{-webkit-box-ordinal-group:100000;-ms-flex-order:99999;order:99999}.fl{float:left}.fl,.fr{_display:inline}.fr{float:right}.fn{float:none}.sans-serif{font-family:-apple-system,BlinkMacSystemFont,avenir next,avenir,helvetica neue,helvetica,ubuntu,roboto,noto,segoe ui,arial,sans-serif}.serif{font-family:georgia,times,serif}.system-sans-serif{font-family:sans-serif}.system-serif{font-family:serif}.code,code{font-family:Consolas,monaco,monospace}.courier{font-family:Courier Next,courier,monospace}.helvetica{font-family:helvetica neue,helvetica,sans-serif}.avenir{font-family:avenir next,avenir,sans-serif}.athelas{font-family:athelas,georgia,serif}.georgia{font-family:georgia,serif}.times{font-family:times,serif}.bodoni{font-family:Bodoni MT,serif}.calisto{font-family:Calisto MT,serif}.garamond{font-family:garamond,serif}.baskerville{font-family:baskerville,serif}.i{font-style:italic}.fs-normal{font-style:normal}.normal{font-weight:400}.b{font-weight:700}.fw1{font-weight:100}.fw2{font-weight:200}.fw3{font-weight:300}.fw4{font-weight:400}.fw5{font-weight:500}.fw6{font-weight:600}.fw7{font-weight:700}.fw8{font-weight:800}.fw9{font-weight:900}.input-reset{-webkit-appearance:none;-moz-appearance:none}.button-reset::-moz-focus-inner,.input-reset::-moz-focus-inner{border:0;padding:0}.h1{height:1rem}.h2{height:2rem}.h3{height:4rem}.h4{height:8rem}.h5{height:16rem}.h-25{height:25%}.h-50{height:50%}.h-75{height:75%}.h-100{height:100%}.min-h-100{min-height:100%}.vh-25{height:25vh}.vh-50{height:50vh}.vh-75{height:75vh}.vh-100{height:100vh}.min-vh-100{min-height:100vh}.h-auto{height:auto}.h-inherit{height:inherit}.tracked{letter-spacing:.1em}.tracked-tight{letter-spacing:-.05em}.tracked-mega{letter-spacing:.25em}.lh-solid{line-height:1}.lh-title{line-height:1.25}.lh-copy{line-height:1.5}.link{text-decoration:none}.link,.link:active,.link:focus,.link:hover,.link:link,.link:visited{transition:color .15s ease-in}.link:focus{outline:1px dotted currentColor}.list{list-style-type:none}.mw-100{max-width:100%}.mw1{max-width:1rem}.mw2{max-width:2rem}.mw3{max-width:4rem}.mw4{max-width:8rem}.mw5{max-width:16rem}.mw6{max-width:32rem}.mw7{max-width:48rem}.mw8{max-width:64rem}.mw9{max-width:96rem}.mw-none{max-width:none}.w1{width:1rem}.w2{width:2rem}.w3{width:4rem}.w4{width:8rem}.w5{width:16rem}.w-10{width:10%}.w-20{width:20%}.w-25{width:25%}.w-30{width:30%}.w-33{width:33%}.w-34{width:34%}.w-40{width:40%}.w-50{width:50%}.w-60{width:60%}.w-70{width:70%}.w-75{width:75%}.w-80{width:80%}.w-90{width:90%}.w-100{width:100%}.w-third{width:33.33333%}.w-two-thirds{width:66.66667%}.w-auto{width:auto}.overflow-visible{overflow:visible}.overflow-hidden{overflow:hidden}.overflow-scroll{overflow:scroll}.overflow-auto{overflow:auto}.overflow-x-visible{overflow-x:visible}.overflow-x-hidden{overflow-x:hidden}.overflow-x-scroll{overflow-x:scroll}.overflow-x-auto{overflow-x:auto}.overflow-y-visible{overflow-y:visible}.overflow-y-hidden{overflow-y:hidden}.overflow-y-scroll{overflow-y:scroll}.overflow-y-auto{overflow-y:auto}.static{position:static}.relative{position:relative}.absolute{position:absolute}.fixed{position:fixed}.o-100{opacity:1}.o-90{opacity:.9}.o-80{opacity:.8}.o-70{opacity:.7}.o-60{opacity:.6}.o-50{opacity:.5}.o-40{opacity:.4}.o-30{opacity:.3}.o-20{opacity:.2}.o-10{opacity:.1}.o-05{opacity:.05}.o-025{opacity:.025}.o-0{opacity:0}.rotate-45{-webkit-transform:rotate(45deg);transform:rotate(45deg)}.rotate-90{-webkit-transform:rotate(90deg);transform:rotate(90deg)}.rotate-135{-webkit-transform:rotate(135deg);transform:rotate(135deg)}.rotate-180{-webkit-transform:rotate(180deg);transform:rotate(180deg)}.rotate-225{-webkit-transform:rotate(225deg);transform:rotate(225deg)}.rotate-270{-webkit-transform:rotate(270deg);transform:rotate(270deg)}.rotate-315{-webkit-transform:rotate(315deg);transform:rotate(315deg)}.black-90{color:rgba(0,0,0,.9)}.black-80{color:rgba(0,0,0,.8)}.black-70{color:rgba(0,0,0,.7)}.black-60{color:rgba(0,0,0,.6)}.black-50{color:rgba(0,0,0,.5)}.black-40{color:rgba(0,0,0,.4)}.black-30{color:rgba(0,0,0,.3)}.black-20{color:rgba(0,0,0,.2)}.black-10{color:rgba(0,0,0,.1)}.black-05{color:rgba(0,0,0,.05)}.white-90{color:hsla(0,0%,100%,.9)}.white-80{color:hsla(0,0%,100%,.8)}.white-70{color:hsla(0,0%,100%,.7)}.white-60{color:hsla(0,0%,100%,.6)}.white-50{color:hsla(0,0%,100%,.5)}.white-40{color:hsla(0,0%,100%,.4)}.white-30{color:hsla(0,0%,100%,.3)}.white-20{color:hsla(0,0%,100%,.2)}.white-10{color:hsla(0,0%,100%,.1)}.black{color:#000}.near-black{color:#111}.dark-gray{color:#333}.mid-gray{color:#555}.gray{color:#777}.silver{color:#999}.light-silver{color:#aaa}.moon-gray{color:#ccc}.light-gray{color:#eee}.near-white{color:#f4f4f4}.white{color:#fff}.dark-red{color:#e7040f}.red{color:#ff4136}.light-red{color:#ff725c}.orange{color:#ff6300}.gold{color:#ffb700}.yellow{color:gold}.light-yellow{color:#fbf1a9}.purple{color:#5e2ca5}.light-purple{color:#a463f2}.dark-pink{color:#d5008f}.hot-pink{color:#ff41b4}.pink{color:#ff80cc}.light-pink{color:#ffa3d7}.dark-green{color:#137752}.green{color:#19a974}.light-green{color:#9eebcf}.navy{color:#001b44}.dark-blue{color:#00449e}.blue{color:#357edd}.light-blue{color:#96ccff}.lightest-blue{color:#cdecff}.washed-blue{color:#f6fffe}.washed-green{color:#e8fdf5}.washed-yellow{color:#fffceb}.washed-red{color:#ffdfdf}.color-inherit{color:inherit}.bg-black-90{background-color:rgba(0,0,0,.9)}.bg-black-80{background-color:rgba(0,0,0,.8)}.bg-black-70{background-color:rgba(0,0,0,.7)}.bg-black-60{background-color:rgba(0,0,0,.6)}.bg-black-50{background-color:rgba(0,0,0,.5)}.bg-black-40{background-color:rgba(0,0,0,.4)}.bg-black-30{background-color:rgba(0,0,0,.3)}.bg-black-20{background-color:rgba(0,0,0,.2)}.bg-black-10{background-color:rgba(0,0,0,.1)}.bg-black-05{background-color:rgba(0,0,0,.05)}.bg-white-90{background-color:hsla(0,0%,100%,.9)}.bg-white-80{background-color:hsla(0,0%,100%,.8)}.bg-white-70{background-color:hsla(0,0%,100%,.7)}.bg-white-60{background-color:hsla(0,0%,100%,.6)}.bg-white-50{background-color:hsla(0,0%,100%,.5)}.bg-white-40{background-color:hsla(0,0%,100%,.4)}.bg-white-30{background-color:hsla(0,0%,100%,.3)}.bg-white-20{background-color:hsla(0,0%,100%,.2)}.bg-white-10{background-color:hsla(0,0%,100%,.1)}.bg-black{background-color:#000}.bg-near-black{background-color:#111}.bg-dark-gray{background-color:#333}.bg-mid-gray{background-color:#555}.bg-gray{background-color:#777}.bg-silver{background-color:#999}.bg-light-silver{background-color:#aaa}.bg-moon-gray{background-color:#ccc}.bg-light-gray{background-color:#eee}.bg-near-white{background-color:#f4f4f4}.bg-white{background-color:#fff}.bg-transparent{background-color:transparent}.bg-dark-red{background-color:#e7040f}.bg-red{background-color:#ff4136}.bg-light-red{background-color:#ff725c}.bg-orange{background-color:#ff6300}.bg-gold{background-color:#ffb700}.bg-yellow{background-color:gold}.bg-light-yellow{background-color:#fbf1a9}.bg-purple{background-color:#5e2ca5}.bg-light-purple{background-color:#a463f2}.bg-dark-pink{background-color:#d5008f}.bg-hot-pink{background-color:#ff41b4}.bg-pink{background-color:#ff80cc}.bg-light-pink{background-color:#ffa3d7}.bg-dark-green{background-color:#137752}.bg-green{background-color:#19a974}.bg-light-green{background-color:#9eebcf}.bg-navy{background-color:#001b44}.bg-dark-blue{background-color:#00449e}.bg-blue{background-color:#357edd}.bg-light-blue{background-color:#96ccff}.bg-lightest-blue{background-color:#cdecff}.bg-washed-blue{background-color:#f6fffe}.bg-washed-green{background-color:#e8fdf5}.bg-washed-yellow{background-color:#fffceb}.bg-washed-red{background-color:#ffdfdf}.bg-inherit{background-color:inherit}.hover-black:focus,.hover-black:hover{color:#000}.hover-near-black:focus,.hover-near-black:hover{color:#111}.hover-dark-gray:focus,.hover-dark-gray:hover{color:#333}.hover-mid-gray:focus,.hover-mid-gray:hover{color:#555}.hover-gray:focus,.hover-gray:hover{color:#777}.hover-silver:focus,.hover-silver:hover{color:#999}.hover-light-silver:focus,.hover-light-silver:hover{color:#aaa}.hover-moon-gray:focus,.hover-moon-gray:hover{color:#ccc}.hover-light-gray:focus,.hover-light-gray:hover{color:#eee}.hover-near-white:focus,.hover-near-white:hover{color:#f4f4f4}.hover-white:focus,.hover-white:hover{color:#fff}.hover-black-90:focus,.hover-black-90:hover{color:rgba(0,0,0,.9)}.hover-black-80:focus,.hover-black-80:hover{color:rgba(0,0,0,.8)}.hover-black-70:focus,.hover-black-70:hover{color:rgba(0,0,0,.7)}.hover-black-60:focus,.hover-black-60:hover{color:rgba(0,0,0,.6)}.hover-black-50:focus,.hover-black-50:hover{color:rgba(0,0,0,.5)}.hover-black-40:focus,.hover-black-40:hover{color:rgba(0,0,0,.4)}.hover-black-30:focus,.hover-black-30:hover{color:rgba(0,0,0,.3)}.hover-black-20:focus,.hover-black-20:hover{color:rgba(0,0,0,.2)}.hover-black-10:focus,.hover-black-10:hover{color:rgba(0,0,0,.1)}.hover-white-90:focus,.hover-white-90:hover{color:hsla(0,0%,100%,.9)}.hover-white-80:focus,.hover-white-80:hover{color:hsla(0,0%,100%,.8)}.hover-white-70:focus,.hover-white-70:hover{color:hsla(0,0%,100%,.7)}.hover-white-60:focus,.hover-white-60:hover{color:hsla(0,0%,100%,.6)}.hover-white-50:focus,.hover-white-50:hover{color:hsla(0,0%,100%,.5)}.hover-white-40:focus,.hover-white-40:hover{color:hsla(0,0%,100%,.4)}.hover-white-30:focus,.hover-white-30:hover{color:hsla(0,0%,100%,.3)}.hover-white-20:focus,.hover-white-20:hover{color:hsla(0,0%,100%,.2)}.hover-white-10:focus,.hover-white-10:hover{color:hsla(0,0%,100%,.1)}.hover-inherit:focus,.hover-inherit:hover{color:inherit}.hover-bg-black:focus,.hover-bg-black:hover{background-color:#000}.hover-bg-near-black:focus,.hover-bg-near-black:hover{background-color:#111}.hover-bg-dark-gray:focus,.hover-bg-dark-gray:hover{background-color:#333}.hover-bg-mid-gray:focus,.hover-bg-mid-gray:hover{background-color:#555}.hover-bg-gray:focus,.hover-bg-gray:hover{background-color:#777}.hover-bg-silver:focus,.hover-bg-silver:hover{background-color:#999}.hover-bg-light-silver:focus,.hover-bg-light-silver:hover{background-color:#aaa}.hover-bg-moon-gray:focus,.hover-bg-moon-gray:hover{background-color:#ccc}.hover-bg-light-gray:focus,.hover-bg-light-gray:hover{background-color:#eee}.hover-bg-near-white:focus,.hover-bg-near-white:hover{background-color:#f4f4f4}.hover-bg-white:focus,.hover-bg-white:hover{background-color:#fff}.hover-bg-transparent:focus,.hover-bg-transparent:hover{background-color:transparent}.hover-bg-black-90:focus,.hover-bg-black-90:hover{background-color:rgba(0,0,0,.9)}.hover-bg-black-80:focus,.hover-bg-black-80:hover{background-color:rgba(0,0,0,.8)}.hover-bg-black-70:focus,.hover-bg-black-70:hover{background-color:rgba(0,0,0,.7)}.hover-bg-black-60:focus,.hover-bg-black-60:hover{background-color:rgba(0,0,0,.6)}.hover-bg-black-50:focus,.hover-bg-black-50:hover{background-color:rgba(0,0,0,.5)}.hover-bg-black-40:focus,.hover-bg-black-40:hover{background-color:rgba(0,0,0,.4)}.hover-bg-black-30:focus,.hover-bg-black-30:hover{background-color:rgba(0,0,0,.3)}.hover-bg-black-20:focus,.hover-bg-black-20:hover{background-color:rgba(0,0,0,.2)}.hover-bg-black-10:focus,.hover-bg-black-10:hover{background-color:rgba(0,0,0,.1)}.hover-bg-white-90:focus,.hover-bg-white-90:hover{background-color:hsla(0,0%,100%,.9)}.hover-bg-white-80:focus,.hover-bg-white-80:hover{background-color:hsla(0,0%,100%,.8)}.hover-bg-white-70:focus,.hover-bg-white-70:hover{background-color:hsla(0,0%,100%,.7)}.hover-bg-white-60:focus,.hover-bg-white-60:hover{background-color:hsla(0,0%,100%,.6)}.hover-bg-white-50:focus,.hover-bg-white-50:hover{background-color:hsla(0,0%,100%,.5)}.hover-bg-white-40:focus,.hover-bg-white-40:hover{background-color:hsla(0,0%,100%,.4)}.hover-bg-white-30:focus,.hover-bg-white-30:hover{background-color:hsla(0,0%,100%,.3)}.hover-bg-white-20:focus,.hover-bg-white-20:hover{background-color:hsla(0,0%,100%,.2)}.hover-bg-white-10:focus,.hover-bg-white-10:hover{background-color:hsla(0,0%,100%,.1)}.hover-dark-red:focus,.hover-dark-red:hover{color:#e7040f}.hover-red:focus,.hover-red:hover{color:#ff4136}.hover-light-red:focus,.hover-light-red:hover{color:#ff725c}.hover-orange:focus,.hover-orange:hover{color:#ff6300}.hover-gold:focus,.hover-gold:hover{color:#ffb700}.hover-yellow:focus,.hover-yellow:hover{color:gold}.hover-light-yellow:focus,.hover-light-yellow:hover{color:#fbf1a9}.hover-purple:focus,.hover-purple:hover{color:#5e2ca5}.hover-light-purple:focus,.hover-light-purple:hover{color:#a463f2}.hover-dark-pink:focus,.hover-dark-pink:hover{color:#d5008f}.hover-hot-pink:focus,.hover-hot-pink:hover{color:#ff41b4}.hover-pink:focus,.hover-pink:hover{color:#ff80cc}.hover-light-pink:focus,.hover-light-pink:hover{color:#ffa3d7}.hover-dark-green:focus,.hover-dark-green:hover{color:#137752}.hover-green:focus,.hover-green:hover{color:#19a974}.hover-light-green:focus,.hover-light-green:hover{color:#9eebcf}.hover-navy:focus,.hover-navy:hover{color:#001b44}.hover-dark-blue:focus,.hover-dark-blue:hover{color:#00449e}.hover-blue:focus,.hover-blue:hover{color:#357edd}.hover-light-blue:focus,.hover-light-blue:hover{color:#96ccff}.hover-lightest-blue:focus,.hover-lightest-blue:hover{color:#cdecff}.hover-washed-blue:focus,.hover-washed-blue:hover{color:#f6fffe}.hover-washed-green:focus,.hover-washed-green:hover{color:#e8fdf5}.hover-washed-yellow:focus,.hover-washed-yellow:hover{color:#fffceb}.hover-washed-red:focus,.hover-washed-red:hover{color:#ffdfdf}.hover-bg-dark-red:focus,.hover-bg-dark-red:hover{background-color:#e7040f}.hover-bg-red:focus,.hover-bg-red:hover{background-color:#ff4136}.hover-bg-light-red:focus,.hover-bg-light-red:hover{background-color:#ff725c}.hover-bg-orange:focus,.hover-bg-orange:hover{background-color:#ff6300}.hover-bg-gold:focus,.hover-bg-gold:hover{background-color:#ffb700}.hover-bg-yellow:focus,.hover-bg-yellow:hover{background-color:gold}.hover-bg-light-yellow:focus,.hover-bg-light-yellow:hover{background-color:#fbf1a9}.hover-bg-purple:focus,.hover-bg-purple:hover{background-color:#5e2ca5}.hover-bg-light-purple:focus,.hover-bg-light-purple:hover{background-color:#a463f2}.hover-bg-dark-pink:focus,.hover-bg-dark-pink:hover{background-color:#d5008f}.hover-bg-hot-pink:focus,.hover-bg-hot-pink:hover{background-color:#ff41b4}.hover-bg-pink:focus,.hover-bg-pink:hover{background-color:#ff80cc}.hover-bg-light-pink:focus,.hover-bg-light-pink:hover{background-color:#ffa3d7}.hover-bg-dark-green:focus,.hover-bg-dark-green:hover{background-color:#137752}.hover-bg-green:focus,.hover-bg-green:hover{background-color:#19a974}.hover-bg-light-green:focus,.hover-bg-light-green:hover{background-color:#9eebcf}.hover-bg-navy:focus,.hover-bg-navy:hover{background-color:#001b44}.hover-bg-dark-blue:focus,.hover-bg-dark-blue:hover{background-color:#00449e}.hover-bg-blue:focus,.hover-bg-blue:hover{background-color:#357edd}.hover-bg-light-blue:focus,.hover-bg-light-blue:hover{background-color:#96ccff}.hover-bg-lightest-blue:focus,.hover-bg-lightest-blue:hover{background-color:#cdecff}.hover-bg-washed-blue:focus,.hover-bg-washed-blue:hover{background-color:#f6fffe}.hover-bg-washed-green:focus,.hover-bg-washed-green:hover{background-color:#e8fdf5}.hover-bg-washed-yellow:focus,.hover-bg-washed-yellow:hover{background-color:#fffceb}.hover-bg-washed-red:focus,.hover-bg-washed-red:hover{background-color:#ffdfdf}.hover-bg-inherit:focus,.hover-bg-inherit:hover{background-color:inherit}.pa0{padding:0}.pa1{padding:.25rem}.pa2{padding:.5rem}.pa3{padding:1rem}.pa4{padding:2rem}.pa5{padding:4rem}.pa6{padding:8rem}.pa7{padding:16rem}.pl0{padding-left:0}.pl1{padding-left:.25rem}.pl2{padding-left:.5rem}.pl3{padding-left:1rem}.pl4{padding-left:2rem}.pl5{padding-left:4rem}.pl6{padding-left:8rem}.pl7{padding-left:16rem}.pr0{padding-right:0}.pr1{padding-right:.25rem}.pr2{padding-right:.5rem}.pr3{padding-right:1rem}.pr4{padding-right:2rem}.pr5{padding-right:4rem}.pr6{padding-right:8rem}.pr7{padding-right:16rem}.pb0{padding-bottom:0}.pb1{padding-bottom:.25rem}.pb2{padding-bottom:.5rem}.pb3{padding-bottom:1rem}.pb4{padding-bottom:2rem}.pb5{padding-bottom:4rem}.pb6{padding-bottom:8rem}.pb7{padding-bottom:16rem}.pt0{padding-top:0}.pt1{padding-top:.25rem}.pt2{padding-top:.5rem}.pt3{padding-top:1rem}.pt4{padding-top:2rem}.pt5{padding-top:4rem}.pt6{padding-top:8rem}.pt7{padding-top:16rem}.pv0{padding-top:0;padding-bottom:0}.pv1{padding-top:.25rem;padding-bottom:.25rem}.pv2{padding-top:.5rem;padding-bottom:.5rem}.pv3{padding-top:1rem;padding-bottom:1rem}.pv4{padding-top:2rem;padding-bottom:2rem}.pv5{padding-top:4rem;padding-bottom:4rem}.pv6{padding-top:8rem;padding-bottom:8rem}.pv7{padding-top:16rem;padding-bottom:16rem}.ph0{padding-left:0;padding-right:0}.ph1{padding-left:.25rem;padding-right:.25rem}.ph2{padding-left:.5rem;padding-right:.5rem}.ph3{padding-left:1rem;padding-right:1rem}.ph4{padding-left:2rem;padding-right:2rem}.ph5{padding-left:4rem;padding-right:4rem}.ph6{padding-left:8rem;padding-right:8rem}.ph7{padding-left:16rem;padding-right:16rem}.ma0{margin:0}.ma1{margin:.25rem}.ma2{margin:.5rem}.ma3{margin:1rem}.ma4{margin:2rem}.ma5{margin:4rem}.ma6{margin:8rem}.ma7{margin:16rem}.ml0{margin-left:0}.ml1{margin-left:.25rem}.ml2{margin-left:.5rem}.ml3{margin-left:1rem}.ml4{margin-left:2rem}.ml5{margin-left:4rem}.ml6{margin-left:8rem}.ml7{margin-left:16rem}.mr0{margin-right:0}.mr1{margin-right:.25rem}.mr2{margin-right:.5rem}.mr3{margin-right:1rem}.mr4{margin-right:2rem}.mr5{margin-right:4rem}.mr6{margin-right:8rem}.mr7{margin-right:16rem}.mb0{margin-bottom:0}.mb1{margin-bottom:.25rem}.mb2{margin-bottom:.5rem}.mb3{margin-bottom:1rem}.mb4{margin-bottom:2rem}.mb5{margin-bottom:4rem}.mb6{margin-bottom:8rem}.mb7{margin-bottom:16rem}.mt0{margin-top:0}.mt1{margin-top:.25rem}.mt2{margin-top:.5rem}.mt3{margin-top:1rem}.mt4{margin-top:2rem}.mt5{margin-top:4rem}.mt6{margin-top:8rem}.mt7{margin-top:16rem}.mv0{margin-top:0;margin-bottom:0}.mv1{margin-top:.25rem;margin-bottom:.25rem}.mv2{margin-top:.5rem;margin-bottom:.5rem}.mv3{margin-top:1rem;margin-bottom:1rem}.mv4{margin-top:2rem;margin-bottom:2rem}.mv5{margin-top:4rem;margin-bottom:4rem}.mv6{margin-top:8rem;margin-bottom:8rem}.mv7{margin-top:16rem;margin-bottom:16rem}.mh0{margin-left:0;margin-right:0}.mh1{margin-left:.25rem;margin-right:.25rem}.mh2{margin-left:.5rem;margin-right:.5rem}.mh3{margin-left:1rem;margin-right:1rem}.mh4{margin-left:2rem;margin-right:2rem}.mh5{margin-left:4rem;margin-right:4rem}.mh6{margin-left:8rem;margin-right:8rem}.mh7{margin-left:16rem;margin-right:16rem}.na1{margin:-.25rem}.na2{margin:-.5rem}.na3{margin:-1rem}.na4{margin:-2rem}.na5{margin:-4rem}.na6{margin:-8rem}.na7{margin:-16rem}.nl1{margin-left:-.25rem}.nl2{margin-left:-.5rem}.nl3{margin-left:-1rem}.nl4{margin-left:-2rem}.nl5{margin-left:-4rem}.nl6{margin-left:-8rem}.nl7{margin-left:-16rem}.nr1{margin-right:-.25rem}.nr2{margin-right:-.5rem}.nr3{margin-right:-1rem}.nr4{margin-right:-2rem}.nr5{margin-right:-4rem}.nr6{margin-right:-8rem}.nr7{margin-right:-16rem}.nb1{margin-bottom:-.25rem}.nb2{margin-bottom:-.5rem}.nb3{margin-bottom:-1rem}.nb4{margin-bottom:-2rem}.nb5{margin-bottom:-4rem}.nb6{margin-bottom:-8rem}.nb7{margin-bottom:-16rem}.nt1{margin-top:-.25rem}.nt2{margin-top:-.5rem}.nt3{margin-top:-1rem}.nt4{margin-top:-2rem}.nt5{margin-top:-4rem}.nt6{margin-top:-8rem}.nt7{margin-top:-16rem}.collapse{border-collapse:collapse;border-spacing:0}.striped--light-silver:nth-child(odd){background-color:#aaa}.striped--moon-gray:nth-child(odd){background-color:#ccc}.striped--light-gray:nth-child(odd){background-color:#eee}.striped--near-white:nth-child(odd){background-color:#f4f4f4}.stripe-light:nth-child(odd){background-color:hsla(0,0%,100%,.1)}.stripe-dark:nth-child(odd){background-color:rgba(0,0,0,.1)}.strike{text-decoration:line-through}.underline{text-decoration:underline}.no-underline{text-decoration:none}.tl{text-align:left}.tr{text-align:right}.tc{text-align:center}.tj{text-align:justify}.ttc{text-transform:capitalize}.ttl{text-transform:lowercase}.ttu{text-transform:uppercase}.ttn{text-transform:none}.f-6,.f-headline{font-size:6rem}.f-5,.f-subheadline{font-size:5rem}.f1{font-size:3rem}.f2{font-size:2.25rem}.f3{font-size:1.5rem}.f4{font-size:1.25rem}.f5{font-size:1rem}.f6{font-size:.875rem}.f7{font-size:.75rem}.measure{max-width:30em}.measure-wide{max-width:34em}.measure-narrow{max-width:20em}.indent{text-indent:1em;margin-top:0;margin-bottom:0}.small-caps{font-variant:small-caps}.truncate{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.overflow-container{overflow-y:scroll}.center{margin-left:auto}.center,.mr-auto{margin-right:auto}.ml-auto{margin-left:auto}.clip{position:fixed!important;_position:absolute!important;clip:rect(1px 1px 1px 1px);clip:rect(1px,1px,1px,1px)}.ws-normal{white-space:normal}.nowrap{white-space:nowrap}.pre{white-space:pre}.v-base{vertical-align:baseline}.v-mid{vertical-align:middle}.v-top{vertical-align:top}.v-btm{vertical-align:bottom}.dim{opacity:1}.dim,.dim:focus,.dim:hover{transition:opacity .15s ease-in}.dim:focus,.dim:hover{opacity:.5}.dim:active{opacity:.8;transition:opacity .15s ease-out}.glow,.glow:focus,.glow:hover{transition:opacity .15s ease-in}.glow:focus,.glow:hover{opacity:1}.hide-child .child{opacity:0;transition:opacity .15s ease-in}.hide-child:active .child,.hide-child:focus .child,.hide-child:hover .child{opacity:1;transition:opacity .15s ease-in}.underline-hover:focus,.underline-hover:hover{text-decoration:underline}.grow{-moz-osx-font-smoothing:grayscale;-webkit-backface-visibility:hidden;backface-visibility:hidden;-webkit-transform:translateZ(0);transform:translateZ(0);transition:-webkit-transform .25s ease-out;transition:transform .25s ease-out;transition:transform .25s ease-out,-webkit-transform .25s ease-out}.grow:focus,.grow:hover{-webkit-transform:scale(1.05);transform:scale(1.05)}.grow:active{-webkit-transform:scale(.9);transform:scale(.9)}.grow-large{-moz-osx-font-smoothing:grayscale;-webkit-backface-visibility:hidden;backface-visibility:hidden;-webkit-transform:translateZ(0);transform:translateZ(0);transition:-webkit-transform .25s ease-in-out;transition:transform .25s ease-in-out;transition:transform .25s ease-in-out,-webkit-transform .25s ease-in-out}.grow-large:focus,.grow-large:hover{-webkit-transform:scale(1.2);transform:scale(1.2)}.grow-large:active{-webkit-transform:scale(.95);transform:scale(.95)}.pointer:hover,.shadow-hover{cursor:pointer}.shadow-hover{position:relative;transition:all .5s cubic-bezier(.165,.84,.44,1)}.shadow-hover:after{content:\"\";box-shadow:0 0 16px 2px rgba(0,0,0,.2);border-radius:inherit;opacity:0;position:absolute;top:0;left:0;width:100%;height:100%;z-index:-1;transition:opacity .5s cubic-bezier(.165,.84,.44,1)}.shadow-hover:focus:after,.shadow-hover:hover:after{opacity:1}.bg-animate,.bg-animate:focus,.bg-animate:hover{transition:background-color .15s ease-in-out}.z-0{z-index:0}.z-1{z-index:1}.z-2{z-index:2}.z-3{z-index:3}.z-4{z-index:4}.z-5{z-index:5}.z-999{z-index:999}.z-9999{z-index:9999}.z-max{z-index:2147483647}.z-inherit{z-index:inherit}.z-initial{z-index:auto}.z-unset{z-index:unset}.nested-copy-line-height ol,.nested-copy-line-height p,.nested-copy-line-height ul{line-height:1.5}.nested-headline-line-height h1,.nested-headline-line-height h2,.nested-headline-line-height h3,.nested-headline-line-height h4,.nested-headline-line-height h5,.nested-headline-line-height h6{line-height:1.25}.nested-list-reset ol,.nested-list-reset ul{padding-left:0;margin-left:0;list-style-type:none}.nested-copy-indent p+p{text-indent:1em;margin-top:0;margin-bottom:0}.nested-copy-seperator p+p{margin-top:1.5em}.nested-img img{width:100%;max-width:100%;display:block}.nested-links a{color:#357edd;transition:color .15s ease-in}.nested-links a:focus,.nested-links a:hover{color:#96ccff;transition:color .15s ease-in}.debug *{outline:1px solid gold}.debug-white *{outline:1px solid #fff}.debug-black *{outline:1px solid #000}.debug-grid{background:transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAAFElEQVR4AWPAC97/9x0eCsAEPgwAVLshdpENIxcAAAAASUVORK5CYII=) repeat 0 0}.debug-grid-16{background:transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMklEQVR4AWOgCLz/b0epAa6UGuBOqQHOQHLUgFEDnAbcBZ4UGwDOkiCnkIhdgNgNxAYAiYlD+8sEuo8AAAAASUVORK5CYII=) repeat 0 0}.debug-grid-8-solid{background:#fff url(data:image/gif;base64,R0lGODdhCAAIAPEAAADw/wDx/////wAAACwAAAAACAAIAAACDZQvgaeb/lxbAIKA8y0AOw==) repeat 0 0}.debug-grid-16-solid{background:#fff url(data:image/gif;base64,R0lGODdhEAAQAPEAAADw/wDx/xXy/////ywAAAAAEAAQAAACIZyPKckYDQFsb6ZqD85jZ2+BkwiRFKehhqQCQgDHcgwEBQA7) repeat 0 0}@media screen and (min-width:30em){.aspect-ratio-ns{height:0;position:relative}.aspect-ratio--16x9-ns{padding-bottom:56.25%}.aspect-ratio--9x16-ns{padding-bottom:177.77%}.aspect-ratio--4x3-ns{padding-bottom:75%}.aspect-ratio--3x4-ns{padding-bottom:133.33%}.aspect-ratio--6x4-ns{padding-bottom:66.6%}.aspect-ratio--4x6-ns{padding-bottom:150%}.aspect-ratio--8x5-ns{padding-bottom:62.5%}.aspect-ratio--5x8-ns{padding-bottom:160%}.aspect-ratio--7x5-ns{padding-bottom:71.42%}.aspect-ratio--5x7-ns{padding-bottom:140%}.aspect-ratio--1x1-ns{padding-bottom:100%}.aspect-ratio--object-ns{position:absolute;top:0;right:0;bottom:0;left:0;width:100%;height:100%;z-index:100}.cover-ns{background-size:cover!important}.contain-ns{background-size:contain!important}.bg-center-ns{background-position:50%}.bg-center-ns,.bg-top-ns{background-repeat:no-repeat}.bg-top-ns{background-position:top}.bg-right-ns{background-position:100%}.bg-bottom-ns,.bg-right-ns{background-repeat:no-repeat}.bg-bottom-ns{background-position:bottom}.bg-left-ns{background-repeat:no-repeat;background-position:0}.outline-ns{outline:1px solid}.outline-transparent-ns{outline:1px solid transparent}.outline-0-ns{outline:0}.ba-ns{border-style:solid;border-width:1px}.bt-ns{border-top-style:solid;border-top-width:1px}.br-ns{border-right-style:solid;border-right-width:1px}.bb-ns{border-bottom-style:solid;border-bottom-width:1px}.bl-ns{border-left-style:solid;border-left-width:1px}.bn-ns{border-style:none;border-width:0}.br0-ns{border-radius:0}.br1-ns{border-radius:.125rem}.br2-ns{border-radius:.25rem}.br3-ns{border-radius:.5rem}.br4-ns{border-radius:1rem}.br-100-ns{border-radius:100%}.br-pill-ns{border-radius:9999px}.br--bottom-ns{border-top-left-radius:0;border-top-right-radius:0}.br--top-ns{border-bottom-right-radius:0}.br--right-ns,.br--top-ns{border-bottom-left-radius:0}.br--right-ns{border-top-left-radius:0}.br--left-ns{border-top-right-radius:0;border-bottom-right-radius:0}.b--dotted-ns{border-style:dotted}.b--dashed-ns{border-style:dashed}.b--solid-ns{border-style:solid}.b--none-ns{border-style:none}.bw0-ns{border-width:0}.bw1-ns{border-width:.125rem}.bw2-ns{border-width:.25rem}.bw3-ns{border-width:.5rem}.bw4-ns{border-width:1rem}.bw5-ns{border-width:2rem}.bt-0-ns{border-top-width:0}.br-0-ns{border-right-width:0}.bb-0-ns{border-bottom-width:0}.bl-0-ns{border-left-width:0}.shadow-1-ns{box-shadow:0 0 4px 2px rgba(0,0,0,.2)}.shadow-2-ns{box-shadow:0 0 8px 2px rgba(0,0,0,.2)}.shadow-3-ns{box-shadow:2px 2px 4px 2px rgba(0,0,0,.2)}.shadow-4-ns{box-shadow:2px 2px 8px 0 rgba(0,0,0,.2)}.shadow-5-ns{box-shadow:4px 4px 8px 0 rgba(0,0,0,.2)}.top-0-ns{top:0}.left-0-ns{left:0}.right-0-ns{right:0}.bottom-0-ns{bottom:0}.top-1-ns{top:1rem}.left-1-ns{left:1rem}.right-1-ns{right:1rem}.bottom-1-ns{bottom:1rem}.top-2-ns{top:2rem}.left-2-ns{left:2rem}.right-2-ns{right:2rem}.bottom-2-ns{bottom:2rem}.top--1-ns{top:-1rem}.right--1-ns{right:-1rem}.bottom--1-ns{bottom:-1rem}.left--1-ns{left:-1rem}.top--2-ns{top:-2rem}.right--2-ns{right:-2rem}.bottom--2-ns{bottom:-2rem}.left--2-ns{left:-2rem}.absolute--fill-ns{top:0;right:0;bottom:0;left:0}.cl-ns{clear:left}.cr-ns{clear:right}.cb-ns{clear:both}.cn-ns{clear:none}.dn-ns{display:none}.di-ns{display:inline}.db-ns{display:block}.dib-ns{display:inline-block}.dit-ns{display:inline-table}.dt-ns{display:table}.dtc-ns{display:table-cell}.dt-row-ns{display:table-row}.dt-row-group-ns{display:table-row-group}.dt-column-ns{display:table-column}.dt-column-group-ns{display:table-column-group}.dt--fixed-ns{table-layout:fixed;width:100%}.flex-ns{display:-webkit-box;display:-ms-flexbox;display:flex}.inline-flex-ns{display:-webkit-inline-box;display:-ms-inline-flexbox;display:inline-flex}.flex-auto-ns{-webkit-box-flex:1;-ms-flex:1 1 auto;flex:1 1 auto;min-width:0;min-height:0}.flex-none-ns{-webkit-box-flex:0;-ms-flex:none;flex:none}.flex-column-ns{-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column}.flex-row-ns{-webkit-box-orient:horizontal;-webkit-box-direction:normal;-ms-flex-direction:row;flex-direction:row}.flex-wrap-ns{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-nowrap-ns{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-wrap-reverse-ns{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-column-reverse-ns{-webkit-box-orient:vertical;-webkit-box-direction:reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-row-reverse-ns{-webkit-box-orient:horizontal;-webkit-box-direction:reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse}.items-start-ns{-webkit-box-align:start;-ms-flex-align:start;align-items:flex-start}.items-end-ns{-webkit-box-align:end;-ms-flex-align:end;align-items:flex-end}.items-center-ns{-webkit-box-align:center;-ms-flex-align:center;align-items:center}.items-baseline-ns{-webkit-box-align:baseline;-ms-flex-align:baseline;align-items:baseline}.items-stretch-ns{-webkit-box-align:stretch;-ms-flex-align:stretch;align-items:stretch}.self-start-ns{-ms-flex-item-align:start;align-self:flex-start}.self-end-ns{-ms-flex-item-align:end;align-self:flex-end}.self-center-ns{-ms-flex-item-align:center;-ms-grid-row-align:center;align-self:center}.self-baseline-ns{-ms-flex-item-align:baseline;align-self:baseline}.self-stretch-ns{-ms-flex-item-align:stretch;-ms-grid-row-align:stretch;align-self:stretch}.justify-start-ns{-webkit-box-pack:start;-ms-flex-pack:start;justify-content:flex-start}.justify-end-ns{-webkit-box-pack:end;-ms-flex-pack:end;justify-content:flex-end}.justify-center-ns{-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center}.justify-between-ns{-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between}.justify-around-ns{-ms-flex-pack:distribute;justify-content:space-around}.content-start-ns{-ms-flex-line-pack:start;align-content:flex-start}.content-end-ns{-ms-flex-line-pack:end;align-content:flex-end}.content-center-ns{-ms-flex-line-pack:center;align-content:center}.content-between-ns{-ms-flex-line-pack:justify;align-content:space-between}.content-around-ns{-ms-flex-line-pack:distribute;align-content:space-around}.content-stretch-ns{-ms-flex-line-pack:stretch;align-content:stretch}.order-0-ns{-webkit-box-ordinal-group:1;-ms-flex-order:0;order:0}.order-1-ns{-webkit-box-ordinal-group:2;-ms-flex-order:1;order:1}.order-2-ns{-webkit-box-ordinal-group:3;-ms-flex-order:2;order:2}.order-3-ns{-webkit-box-ordinal-group:4;-ms-flex-order:3;order:3}.order-4-ns{-webkit-box-ordinal-group:5;-ms-flex-order:4;order:4}.order-5-ns{-webkit-box-ordinal-group:6;-ms-flex-order:5;order:5}.order-6-ns{-webkit-box-ordinal-group:7;-ms-flex-order:6;order:6}.order-7-ns{-webkit-box-ordinal-group:8;-ms-flex-order:7;order:7}.order-8-ns{-webkit-box-ordinal-group:9;-ms-flex-order:8;order:8}.order-last-ns{-webkit-box-ordinal-group:100000;-ms-flex-order:99999;order:99999}.fl-ns{float:left}.fl-ns,.fr-ns{display:inline}.fr-ns{float:right}.fn-ns{float:none}.i-ns{font-style:italic}.fs-normal-ns{font-style:normal}.normal-ns{font-weight:400}.b-ns{font-weight:700}.fw1-ns{font-weight:100}.fw2-ns{font-weight:200}.fw3-ns{font-weight:300}.fw4-ns{font-weight:400}.fw5-ns{font-weight:500}.fw6-ns{font-weight:600}.fw7-ns{font-weight:700}.fw8-ns{font-weight:800}.fw9-ns{font-weight:900}.h1-ns{height:1rem}.h2-ns{height:2rem}.h3-ns{height:4rem}.h4-ns{height:8rem}.h5-ns{height:16rem}.h-25-ns{height:25%}.h-50-ns{height:50%}.h-75-ns{height:75%}.h-100-ns{height:100%}.min-h-100-ns{min-height:100%}.vh-25-ns{height:25vh}.vh-50-ns{height:50vh}.vh-75-ns{height:75vh}.vh-100-ns{height:100vh}.min-vh-100-ns{min-height:100vh}.h-auto-ns{height:auto}.h-inherit-ns{height:inherit}.tracked-ns{letter-spacing:.1em}.tracked-tight-ns{letter-spacing:-.05em}.tracked-mega-ns{letter-spacing:.25em}.lh-solid-ns{line-height:1}.lh-title-ns{line-height:1.25}.lh-copy-ns{line-height:1.5}.mw-100-ns{max-width:100%}.mw1-ns{max-width:1rem}.mw2-ns{max-width:2rem}.mw3-ns{max-width:4rem}.mw4-ns{max-width:8rem}.mw5-ns{max-width:16rem}.mw6-ns{max-width:32rem}.mw7-ns{max-width:48rem}.mw8-ns{max-width:64rem}.mw9-ns{max-width:96rem}.mw-none-ns{max-width:none}.w1-ns{width:1rem}.w2-ns{width:2rem}.w3-ns{width:4rem}.w4-ns{width:8rem}.w5-ns{width:16rem}.w-10-ns{width:10%}.w-20-ns{width:20%}.w-25-ns{width:25%}.w-30-ns{width:30%}.w-33-ns{width:33%}.w-34-ns{width:34%}.w-40-ns{width:40%}.w-50-ns{width:50%}.w-60-ns{width:60%}.w-70-ns{width:70%}.w-75-ns{width:75%}.w-80-ns{width:80%}.w-90-ns{width:90%}.w-100-ns{width:100%}.w-third-ns{width:33.33333%}.w-two-thirds-ns{width:66.66667%}.w-auto-ns{width:auto}.overflow-visible-ns{overflow:visible}.overflow-hidden-ns{overflow:hidden}.overflow-scroll-ns{overflow:scroll}.overflow-auto-ns{overflow:auto}.overflow-x-visible-ns{overflow-x:visible}.overflow-x-hidden-ns{overflow-x:hidden}.overflow-x-scroll-ns{overflow-x:scroll}.overflow-x-auto-ns{overflow-x:auto}.overflow-y-visible-ns{overflow-y:visible}.overflow-y-hidden-ns{overflow-y:hidden}.overflow-y-scroll-ns{overflow-y:scroll}.overflow-y-auto-ns{overflow-y:auto}.static-ns{position:static}.relative-ns{position:relative}.absolute-ns{position:absolute}.fixed-ns{position:fixed}.rotate-45-ns{-webkit-transform:rotate(45deg);transform:rotate(45deg)}.rotate-90-ns{-webkit-transform:rotate(90deg);transform:rotate(90deg)}.rotate-135-ns{-webkit-transform:rotate(135deg);transform:rotate(135deg)}.rotate-180-ns{-webkit-transform:rotate(180deg);transform:rotate(180deg)}.rotate-225-ns{-webkit-transform:rotate(225deg);transform:rotate(225deg)}.rotate-270-ns{-webkit-transform:rotate(270deg);transform:rotate(270deg)}.rotate-315-ns{-webkit-transform:rotate(315deg);transform:rotate(315deg)}.pa0-ns{padding:0}.pa1-ns{padding:.25rem}.pa2-ns{padding:.5rem}.pa3-ns{padding:1rem}.pa4-ns{padding:2rem}.pa5-ns{padding:4rem}.pa6-ns{padding:8rem}.pa7-ns{padding:16rem}.pl0-ns{padding-left:0}.pl1-ns{padding-left:.25rem}.pl2-ns{padding-left:.5rem}.pl3-ns{padding-left:1rem}.pl4-ns{padding-left:2rem}.pl5-ns{padding-left:4rem}.pl6-ns{padding-left:8rem}.pl7-ns{padding-left:16rem}.pr0-ns{padding-right:0}.pr1-ns{padding-right:.25rem}.pr2-ns{padding-right:.5rem}.pr3-ns{padding-right:1rem}.pr4-ns{padding-right:2rem}.pr5-ns{padding-right:4rem}.pr6-ns{padding-right:8rem}.pr7-ns{padding-right:16rem}.pb0-ns{padding-bottom:0}.pb1-ns{padding-bottom:.25rem}.pb2-ns{padding-bottom:.5rem}.pb3-ns{padding-bottom:1rem}.pb4-ns{padding-bottom:2rem}.pb5-ns{padding-bottom:4rem}.pb6-ns{padding-bottom:8rem}.pb7-ns{padding-bottom:16rem}.pt0-ns{padding-top:0}.pt1-ns{padding-top:.25rem}.pt2-ns{padding-top:.5rem}.pt3-ns{padding-top:1rem}.pt4-ns{padding-top:2rem}.pt5-ns{padding-top:4rem}.pt6-ns{padding-top:8rem}.pt7-ns{padding-top:16rem}.pv0-ns{padding-top:0;padding-bottom:0}.pv1-ns{padding-top:.25rem;padding-bottom:.25rem}.pv2-ns{padding-top:.5rem;padding-bottom:.5rem}.pv3-ns{padding-top:1rem;padding-bottom:1rem}.pv4-ns{padding-top:2rem;padding-bottom:2rem}.pv5-ns{padding-top:4rem;padding-bottom:4rem}.pv6-ns{padding-top:8rem;padding-bottom:8rem}.pv7-ns{padding-top:16rem;padding-bottom:16rem}.ph0-ns{padding-left:0;padding-right:0}.ph1-ns{padding-left:.25rem;padding-right:.25rem}.ph2-ns{padding-left:.5rem;padding-right:.5rem}.ph3-ns{padding-left:1rem;padding-right:1rem}.ph4-ns{padding-left:2rem;padding-right:2rem}.ph5-ns{padding-left:4rem;padding-right:4rem}.ph6-ns{padding-left:8rem;padding-right:8rem}.ph7-ns{padding-left:16rem;padding-right:16rem}.ma0-ns{margin:0}.ma1-ns{margin:.25rem}.ma2-ns{margin:.5rem}.ma3-ns{margin:1rem}.ma4-ns{margin:2rem}.ma5-ns{margin:4rem}.ma6-ns{margin:8rem}.ma7-ns{margin:16rem}.ml0-ns{margin-left:0}.ml1-ns{margin-left:.25rem}.ml2-ns{margin-left:.5rem}.ml3-ns{margin-left:1rem}.ml4-ns{margin-left:2rem}.ml5-ns{margin-left:4rem}.ml6-ns{margin-left:8rem}.ml7-ns{margin-left:16rem}.mr0-ns{margin-right:0}.mr1-ns{margin-right:.25rem}.mr2-ns{margin-right:.5rem}.mr3-ns{margin-right:1rem}.mr4-ns{margin-right:2rem}.mr5-ns{margin-right:4rem}.mr6-ns{margin-right:8rem}.mr7-ns{margin-right:16rem}.mb0-ns{margin-bottom:0}.mb1-ns{margin-bottom:.25rem}.mb2-ns{margin-bottom:.5rem}.mb3-ns{margin-bottom:1rem}.mb4-ns{margin-bottom:2rem}.mb5-ns{margin-bottom:4rem}.mb6-ns{margin-bottom:8rem}.mb7-ns{margin-bottom:16rem}.mt0-ns{margin-top:0}.mt1-ns{margin-top:.25rem}.mt2-ns{margin-top:.5rem}.mt3-ns{margin-top:1rem}.mt4-ns{margin-top:2rem}.mt5-ns{margin-top:4rem}.mt6-ns{margin-top:8rem}.mt7-ns{margin-top:16rem}.mv0-ns{margin-top:0;margin-bottom:0}.mv1-ns{margin-top:.25rem;margin-bottom:.25rem}.mv2-ns{margin-top:.5rem;margin-bottom:.5rem}.mv3-ns{margin-top:1rem;margin-bottom:1rem}.mv4-ns{margin-top:2rem;margin-bottom:2rem}.mv5-ns{margin-top:4rem;margin-bottom:4rem}.mv6-ns{margin-top:8rem;margin-bottom:8rem}.mv7-ns{margin-top:16rem;margin-bottom:16rem}.mh0-ns{margin-left:0;margin-right:0}.mh1-ns{margin-left:.25rem;margin-right:.25rem}.mh2-ns{margin-left:.5rem;margin-right:.5rem}.mh3-ns{margin-left:1rem;margin-right:1rem}.mh4-ns{margin-left:2rem;margin-right:2rem}.mh5-ns{margin-left:4rem;margin-right:4rem}.mh6-ns{margin-left:8rem;margin-right:8rem}.mh7-ns{margin-left:16rem;margin-right:16rem}.na1-ns{margin:-.25rem}.na2-ns{margin:-.5rem}.na3-ns{margin:-1rem}.na4-ns{margin:-2rem}.na5-ns{margin:-4rem}.na6-ns{margin:-8rem}.na7-ns{margin:-16rem}.nl1-ns{margin-left:-.25rem}.nl2-ns{margin-left:-.5rem}.nl3-ns{margin-left:-1rem}.nl4-ns{margin-left:-2rem}.nl5-ns{margin-left:-4rem}.nl6-ns{margin-left:-8rem}.nl7-ns{margin-left:-16rem}.nr1-ns{margin-right:-.25rem}.nr2-ns{margin-right:-.5rem}.nr3-ns{margin-right:-1rem}.nr4-ns{margin-right:-2rem}.nr5-ns{margin-right:-4rem}.nr6-ns{margin-right:-8rem}.nr7-ns{margin-right:-16rem}.nb1-ns{margin-bottom:-.25rem}.nb2-ns{margin-bottom:-.5rem}.nb3-ns{margin-bottom:-1rem}.nb4-ns{margin-bottom:-2rem}.nb5-ns{margin-bottom:-4rem}.nb6-ns{margin-bottom:-8rem}.nb7-ns{margin-bottom:-16rem}.nt1-ns{margin-top:-.25rem}.nt2-ns{margin-top:-.5rem}.nt3-ns{margin-top:-1rem}.nt4-ns{margin-top:-2rem}.nt5-ns{margin-top:-4rem}.nt6-ns{margin-top:-8rem}.nt7-ns{margin-top:-16rem}.strike-ns{text-decoration:line-through}.underline-ns{text-decoration:underline}.no-underline-ns{text-decoration:none}.tl-ns{text-align:left}.tr-ns{text-align:right}.tc-ns{text-align:center}.tj-ns{text-align:justify}.ttc-ns{text-transform:capitalize}.ttl-ns{text-transform:lowercase}.ttu-ns{text-transform:uppercase}.ttn-ns{text-transform:none}.f-6-ns,.f-headline-ns{font-size:6rem}.f-5-ns,.f-subheadline-ns{font-size:5rem}.f1-ns{font-size:3rem}.f2-ns{font-size:2.25rem}.f3-ns{font-size:1.5rem}.f4-ns{font-size:1.25rem}.f5-ns{font-size:1rem}.f6-ns{font-size:.875rem}.f7-ns{font-size:.75rem}.measure-ns{max-width:30em}.measure-wide-ns{max-width:34em}.measure-narrow-ns{max-width:20em}.indent-ns{text-indent:1em;margin-top:0;margin-bottom:0}.small-caps-ns{font-variant:small-caps}.truncate-ns{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.center-ns{margin-left:auto}.center-ns,.mr-auto-ns{margin-right:auto}.ml-auto-ns{margin-left:auto}.clip-ns{position:fixed!important;position:absolute!important;clip:rect(1px 1px 1px 1px);clip:rect(1px,1px,1px,1px)}.ws-normal-ns{white-space:normal}.nowrap-ns{white-space:nowrap}.pre-ns{white-space:pre}.v-base-ns{vertical-align:baseline}.v-mid-ns{vertical-align:middle}.v-top-ns{vertical-align:top}.v-btm-ns{vertical-align:bottom}}@media screen and (min-width:30em) and (max-width:60em){.aspect-ratio-m{height:0;position:relative}.aspect-ratio--16x9-m{padding-bottom:56.25%}.aspect-ratio--9x16-m{padding-bottom:177.77%}.aspect-ratio--4x3-m{padding-bottom:75%}.aspect-ratio--3x4-m{padding-bottom:133.33%}.aspect-ratio--6x4-m{padding-bottom:66.6%}.aspect-ratio--4x6-m{padding-bottom:150%}.aspect-ratio--8x5-m{padding-bottom:62.5%}.aspect-ratio--5x8-m{padding-bottom:160%}.aspect-ratio--7x5-m{padding-bottom:71.42%}.aspect-ratio--5x7-m{padding-bottom:140%}.aspect-ratio--1x1-m{padding-bottom:100%}.aspect-ratio--object-m{position:absolute;top:0;right:0;bottom:0;left:0;width:100%;height:100%;z-index:100}.cover-m{background-size:cover!important}.contain-m{background-size:contain!important}.bg-center-m{background-position:50%}.bg-center-m,.bg-top-m{background-repeat:no-repeat}.bg-top-m{background-position:top}.bg-right-m{background-position:100%}.bg-bottom-m,.bg-right-m{background-repeat:no-repeat}.bg-bottom-m{background-position:bottom}.bg-left-m{background-repeat:no-repeat;background-position:0}.outline-m{outline:1px solid}.outline-transparent-m{outline:1px solid transparent}.outline-0-m{outline:0}.ba-m{border-style:solid;border-width:1px}.bt-m{border-top-style:solid;border-top-width:1px}.br-m{border-right-style:solid;border-right-width:1px}.bb-m{border-bottom-style:solid;border-bottom-width:1px}.bl-m{border-left-style:solid;border-left-width:1px}.bn-m{border-style:none;border-width:0}.br0-m{border-radius:0}.br1-m{border-radius:.125rem}.br2-m{border-radius:.25rem}.br3-m{border-radius:.5rem}.br4-m{border-radius:1rem}.br-100-m{border-radius:100%}.br-pill-m{border-radius:9999px}.br--bottom-m{border-top-left-radius:0;border-top-right-radius:0}.br--top-m{border-bottom-right-radius:0}.br--right-m,.br--top-m{border-bottom-left-radius:0}.br--right-m{border-top-left-radius:0}.br--left-m{border-top-right-radius:0;border-bottom-right-radius:0}.b--dotted-m{border-style:dotted}.b--dashed-m{border-style:dashed}.b--solid-m{border-style:solid}.b--none-m{border-style:none}.bw0-m{border-width:0}.bw1-m{border-width:.125rem}.bw2-m{border-width:.25rem}.bw3-m{border-width:.5rem}.bw4-m{border-width:1rem}.bw5-m{border-width:2rem}.bt-0-m{border-top-width:0}.br-0-m{border-right-width:0}.bb-0-m{border-bottom-width:0}.bl-0-m{border-left-width:0}.shadow-1-m{box-shadow:0 0 4px 2px rgba(0,0,0,.2)}.shadow-2-m{box-shadow:0 0 8px 2px rgba(0,0,0,.2)}.shadow-3-m{box-shadow:2px 2px 4px 2px rgba(0,0,0,.2)}.shadow-4-m{box-shadow:2px 2px 8px 0 rgba(0,0,0,.2)}.shadow-5-m{box-shadow:4px 4px 8px 0 rgba(0,0,0,.2)}.top-0-m{top:0}.left-0-m{left:0}.right-0-m{right:0}.bottom-0-m{bottom:0}.top-1-m{top:1rem}.left-1-m{left:1rem}.right-1-m{right:1rem}.bottom-1-m{bottom:1rem}.top-2-m{top:2rem}.left-2-m{left:2rem}.right-2-m{right:2rem}.bottom-2-m{bottom:2rem}.top--1-m{top:-1rem}.right--1-m{right:-1rem}.bottom--1-m{bottom:-1rem}.left--1-m{left:-1rem}.top--2-m{top:-2rem}.right--2-m{right:-2rem}.bottom--2-m{bottom:-2rem}.left--2-m{left:-2rem}.absolute--fill-m{top:0;right:0;bottom:0;left:0}.cl-m{clear:left}.cr-m{clear:right}.cb-m{clear:both}.cn-m{clear:none}.dn-m{display:none}.di-m{display:inline}.db-m{display:block}.dib-m{display:inline-block}.dit-m{display:inline-table}.dt-m{display:table}.dtc-m{display:table-cell}.dt-row-m{display:table-row}.dt-row-group-m{display:table-row-group}.dt-column-m{display:table-column}.dt-column-group-m{display:table-column-group}.dt--fixed-m{table-layout:fixed;width:100%}.flex-m{display:-webkit-box;display:-ms-flexbox;display:flex}.inline-flex-m{display:-webkit-inline-box;display:-ms-inline-flexbox;display:inline-flex}.flex-auto-m{-webkit-box-flex:1;-ms-flex:1 1 auto;flex:1 1 auto;min-width:0;min-height:0}.flex-none-m{-webkit-box-flex:0;-ms-flex:none;flex:none}.flex-column-m{-webkit-box-orient:vertical;-ms-flex-direction:column;flex-direction:column}.flex-column-m,.flex-row-m{-webkit-box-direction:normal}.flex-row-m{-webkit-box-orient:horizontal;-ms-flex-direction:row;flex-direction:row}.flex-wrap-m{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-nowrap-m{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-wrap-reverse-m{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-column-reverse-m{-webkit-box-orient:vertical;-webkit-box-direction:reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-row-reverse-m{-webkit-box-orient:horizontal;-webkit-box-direction:reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse}.items-start-m{-webkit-box-align:start;-ms-flex-align:start;align-items:flex-start}.items-end-m{-webkit-box-align:end;-ms-flex-align:end;align-items:flex-end}.items-center-m{-webkit-box-align:center;-ms-flex-align:center;align-items:center}.items-baseline-m{-webkit-box-align:baseline;-ms-flex-align:baseline;align-items:baseline}.items-stretch-m{-webkit-box-align:stretch;-ms-flex-align:stretch;align-items:stretch}.self-start-m{-ms-flex-item-align:start;align-self:flex-start}.self-end-m{-ms-flex-item-align:end;align-self:flex-end}.self-center-m{-ms-flex-item-align:center;-ms-grid-row-align:center;align-self:center}.self-baseline-m{-ms-flex-item-align:baseline;align-self:baseline}.self-stretch-m{-ms-flex-item-align:stretch;-ms-grid-row-align:stretch;align-self:stretch}.justify-start-m{-webkit-box-pack:start;-ms-flex-pack:start;justify-content:flex-start}.justify-end-m{-webkit-box-pack:end;-ms-flex-pack:end;justify-content:flex-end}.justify-center-m{-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center}.justify-between-m{-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between}.justify-around-m{-ms-flex-pack:distribute;justify-content:space-around}.content-start-m{-ms-flex-line-pack:start;align-content:flex-start}.content-end-m{-ms-flex-line-pack:end;align-content:flex-end}.content-center-m{-ms-flex-line-pack:center;align-content:center}.content-between-m{-ms-flex-line-pack:justify;align-content:space-between}.content-around-m{-ms-flex-line-pack:distribute;align-content:space-around}.content-stretch-m{-ms-flex-line-pack:stretch;align-content:stretch}.order-0-m{-webkit-box-ordinal-group:1;-ms-flex-order:0;order:0}.order-1-m{-webkit-box-ordinal-group:2;-ms-flex-order:1;order:1}.order-2-m{-webkit-box-ordinal-group:3;-ms-flex-order:2;order:2}.order-3-m{-webkit-box-ordinal-group:4;-ms-flex-order:3;order:3}.order-4-m{-webkit-box-ordinal-group:5;-ms-flex-order:4;order:4}.order-5-m{-webkit-box-ordinal-group:6;-ms-flex-order:5;order:5}.order-6-m{-webkit-box-ordinal-group:7;-ms-flex-order:6;order:6}.order-7-m{-webkit-box-ordinal-group:8;-ms-flex-order:7;order:7}.order-8-m{-webkit-box-ordinal-group:9;-ms-flex-order:8;order:8}.order-last-m{-webkit-box-ordinal-group:100000;-ms-flex-order:99999;order:99999}.fl-m{float:left}.fl-m,.fr-m{display:inline}.fr-m{float:right}.fn-m{float:none}.i-m{font-style:italic}.fs-normal-m{font-style:normal}.normal-m{font-weight:400}.b-m{font-weight:700}.fw1-m{font-weight:100}.fw2-m{font-weight:200}.fw3-m{font-weight:300}.fw4-m{font-weight:400}.fw5-m{font-weight:500}.fw6-m{font-weight:600}.fw7-m{font-weight:700}.fw8-m{font-weight:800}.fw9-m{font-weight:900}.h1-m{height:1rem}.h2-m{height:2rem}.h3-m{height:4rem}.h4-m{height:8rem}.h5-m{height:16rem}.h-25-m{height:25%}.h-50-m{height:50%}.h-75-m{height:75%}.h-100-m{height:100%}.min-h-100-m{min-height:100%}.vh-25-m{height:25vh}.vh-50-m{height:50vh}.vh-75-m{height:75vh}.vh-100-m{height:100vh}.min-vh-100-m{min-height:100vh}.h-auto-m{height:auto}.h-inherit-m{height:inherit}.tracked-m{letter-spacing:.1em}.tracked-tight-m{letter-spacing:-.05em}.tracked-mega-m{letter-spacing:.25em}.lh-solid-m{line-height:1}.lh-title-m{line-height:1.25}.lh-copy-m{line-height:1.5}.mw-100-m{max-width:100%}.mw1-m{max-width:1rem}.mw2-m{max-width:2rem}.mw3-m{max-width:4rem}.mw4-m{max-width:8rem}.mw5-m{max-width:16rem}.mw6-m{max-width:32rem}.mw7-m{max-width:48rem}.mw8-m{max-width:64rem}.mw9-m{max-width:96rem}.mw-none-m{max-width:none}.w1-m{width:1rem}.w2-m{width:2rem}.w3-m{width:4rem}.w4-m{width:8rem}.w5-m{width:16rem}.w-10-m{width:10%}.w-20-m{width:20%}.w-25-m{width:25%}.w-30-m{width:30%}.w-33-m{width:33%}.w-34-m{width:34%}.w-40-m{width:40%}.w-50-m{width:50%}.w-60-m{width:60%}.w-70-m{width:70%}.w-75-m{width:75%}.w-80-m{width:80%}.w-90-m{width:90%}.w-100-m{width:100%}.w-third-m{width:33.33333%}.w-two-thirds-m{width:66.66667%}.w-auto-m{width:auto}.overflow-visible-m{overflow:visible}.overflow-hidden-m{overflow:hidden}.overflow-scroll-m{overflow:scroll}.overflow-auto-m{overflow:auto}.overflow-x-visible-m{overflow-x:visible}.overflow-x-hidden-m{overflow-x:hidden}.overflow-x-scroll-m{overflow-x:scroll}.overflow-x-auto-m{overflow-x:auto}.overflow-y-visible-m{overflow-y:visible}.overflow-y-hidden-m{overflow-y:hidden}.overflow-y-scroll-m{overflow-y:scroll}.overflow-y-auto-m{overflow-y:auto}.static-m{position:static}.relative-m{position:relative}.absolute-m{position:absolute}.fixed-m{position:fixed}.rotate-45-m{-webkit-transform:rotate(45deg);transform:rotate(45deg)}.rotate-90-m{-webkit-transform:rotate(90deg);transform:rotate(90deg)}.rotate-135-m{-webkit-transform:rotate(135deg);transform:rotate(135deg)}.rotate-180-m{-webkit-transform:rotate(180deg);transform:rotate(180deg)}.rotate-225-m{-webkit-transform:rotate(225deg);transform:rotate(225deg)}.rotate-270-m{-webkit-transform:rotate(270deg);transform:rotate(270deg)}.rotate-315-m{-webkit-transform:rotate(315deg);transform:rotate(315deg)}.pa0-m{padding:0}.pa1-m{padding:.25rem}.pa2-m{padding:.5rem}.pa3-m{padding:1rem}.pa4-m{padding:2rem}.pa5-m{padding:4rem}.pa6-m{padding:8rem}.pa7-m{padding:16rem}.pl0-m{padding-left:0}.pl1-m{padding-left:.25rem}.pl2-m{padding-left:.5rem}.pl3-m{padding-left:1rem}.pl4-m{padding-left:2rem}.pl5-m{padding-left:4rem}.pl6-m{padding-left:8rem}.pl7-m{padding-left:16rem}.pr0-m{padding-right:0}.pr1-m{padding-right:.25rem}.pr2-m{padding-right:.5rem}.pr3-m{padding-right:1rem}.pr4-m{padding-right:2rem}.pr5-m{padding-right:4rem}.pr6-m{padding-right:8rem}.pr7-m{padding-right:16rem}.pb0-m{padding-bottom:0}.pb1-m{padding-bottom:.25rem}.pb2-m{padding-bottom:.5rem}.pb3-m{padding-bottom:1rem}.pb4-m{padding-bottom:2rem}.pb5-m{padding-bottom:4rem}.pb6-m{padding-bottom:8rem}.pb7-m{padding-bottom:16rem}.pt0-m{padding-top:0}.pt1-m{padding-top:.25rem}.pt2-m{padding-top:.5rem}.pt3-m{padding-top:1rem}.pt4-m{padding-top:2rem}.pt5-m{padding-top:4rem}.pt6-m{padding-top:8rem}.pt7-m{padding-top:16rem}.pv0-m{padding-top:0;padding-bottom:0}.pv1-m{padding-top:.25rem;padding-bottom:.25rem}.pv2-m{padding-top:.5rem;padding-bottom:.5rem}.pv3-m{padding-top:1rem;padding-bottom:1rem}.pv4-m{padding-top:2rem;padding-bottom:2rem}.pv5-m{padding-top:4rem;padding-bottom:4rem}.pv6-m{padding-top:8rem;padding-bottom:8rem}.pv7-m{padding-top:16rem;padding-bottom:16rem}.ph0-m{padding-left:0;padding-right:0}.ph1-m{padding-left:.25rem;padding-right:.25rem}.ph2-m{padding-left:.5rem;padding-right:.5rem}.ph3-m{padding-left:1rem;padding-right:1rem}.ph4-m{padding-left:2rem;padding-right:2rem}.ph5-m{padding-left:4rem;padding-right:4rem}.ph6-m{padding-left:8rem;padding-right:8rem}.ph7-m{padding-left:16rem;padding-right:16rem}.ma0-m{margin:0}.ma1-m{margin:.25rem}.ma2-m{margin:.5rem}.ma3-m{margin:1rem}.ma4-m{margin:2rem}.ma5-m{margin:4rem}.ma6-m{margin:8rem}.ma7-m{margin:16rem}.ml0-m{margin-left:0}.ml1-m{margin-left:.25rem}.ml2-m{margin-left:.5rem}.ml3-m{margin-left:1rem}.ml4-m{margin-left:2rem}.ml5-m{margin-left:4rem}.ml6-m{margin-left:8rem}.ml7-m{margin-left:16rem}.mr0-m{margin-right:0}.mr1-m{margin-right:.25rem}.mr2-m{margin-right:.5rem}.mr3-m{margin-right:1rem}.mr4-m{margin-right:2rem}.mr5-m{margin-right:4rem}.mr6-m{margin-right:8rem}.mr7-m{margin-right:16rem}.mb0-m{margin-bottom:0}.mb1-m{margin-bottom:.25rem}.mb2-m{margin-bottom:.5rem}.mb3-m{margin-bottom:1rem}.mb4-m{margin-bottom:2rem}.mb5-m{margin-bottom:4rem}.mb6-m{margin-bottom:8rem}.mb7-m{margin-bottom:16rem}.mt0-m{margin-top:0}.mt1-m{margin-top:.25rem}.mt2-m{margin-top:.5rem}.mt3-m{margin-top:1rem}.mt4-m{margin-top:2rem}.mt5-m{margin-top:4rem}.mt6-m{margin-top:8rem}.mt7-m{margin-top:16rem}.mv0-m{margin-top:0;margin-bottom:0}.mv1-m{margin-top:.25rem;margin-bottom:.25rem}.mv2-m{margin-top:.5rem;margin-bottom:.5rem}.mv3-m{margin-top:1rem;margin-bottom:1rem}.mv4-m{margin-top:2rem;margin-bottom:2rem}.mv5-m{margin-top:4rem;margin-bottom:4rem}.mv6-m{margin-top:8rem;margin-bottom:8rem}.mv7-m{margin-top:16rem;margin-bottom:16rem}.mh0-m{margin-left:0;margin-right:0}.mh1-m{margin-left:.25rem;margin-right:.25rem}.mh2-m{margin-left:.5rem;margin-right:.5rem}.mh3-m{margin-left:1rem;margin-right:1rem}.mh4-m{margin-left:2rem;margin-right:2rem}.mh5-m{margin-left:4rem;margin-right:4rem}.mh6-m{margin-left:8rem;margin-right:8rem}.mh7-m{margin-left:16rem;margin-right:16rem}.na1-m{margin:-.25rem}.na2-m{margin:-.5rem}.na3-m{margin:-1rem}.na4-m{margin:-2rem}.na5-m{margin:-4rem}.na6-m{margin:-8rem}.na7-m{margin:-16rem}.nl1-m{margin-left:-.25rem}.nl2-m{margin-left:-.5rem}.nl3-m{margin-left:-1rem}.nl4-m{margin-left:-2rem}.nl5-m{margin-left:-4rem}.nl6-m{margin-left:-8rem}.nl7-m{margin-left:-16rem}.nr1-m{margin-right:-.25rem}.nr2-m{margin-right:-.5rem}.nr3-m{margin-right:-1rem}.nr4-m{margin-right:-2rem}.nr5-m{margin-right:-4rem}.nr6-m{margin-right:-8rem}.nr7-m{margin-right:-16rem}.nb1-m{margin-bottom:-.25rem}.nb2-m{margin-bottom:-.5rem}.nb3-m{margin-bottom:-1rem}.nb4-m{margin-bottom:-2rem}.nb5-m{margin-bottom:-4rem}.nb6-m{margin-bottom:-8rem}.nb7-m{margin-bottom:-16rem}.nt1-m{margin-top:-.25rem}.nt2-m{margin-top:-.5rem}.nt3-m{margin-top:-1rem}.nt4-m{margin-top:-2rem}.nt5-m{margin-top:-4rem}.nt6-m{margin-top:-8rem}.nt7-m{margin-top:-16rem}.strike-m{text-decoration:line-through}.underline-m{text-decoration:underline}.no-underline-m{text-decoration:none}.tl-m{text-align:left}.tr-m{text-align:right}.tc-m{text-align:center}.tj-m{text-align:justify}.ttc-m{text-transform:capitalize}.ttl-m{text-transform:lowercase}.ttu-m{text-transform:uppercase}.ttn-m{text-transform:none}.f-6-m,.f-headline-m{font-size:6rem}.f-5-m,.f-subheadline-m{font-size:5rem}.f1-m{font-size:3rem}.f2-m{font-size:2.25rem}.f3-m{font-size:1.5rem}.f4-m{font-size:1.25rem}.f5-m{font-size:1rem}.f6-m{font-size:.875rem}.f7-m{font-size:.75rem}.measure-m{max-width:30em}.measure-wide-m{max-width:34em}.measure-narrow-m{max-width:20em}.indent-m{text-indent:1em;margin-top:0;margin-bottom:0}.small-caps-m{font-variant:small-caps}.truncate-m{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.center-m{margin-left:auto}.center-m,.mr-auto-m{margin-right:auto}.ml-auto-m{margin-left:auto}.clip-m{position:fixed!important;position:absolute!important;clip:rect(1px 1px 1px 1px);clip:rect(1px,1px,1px,1px)}.ws-normal-m{white-space:normal}.nowrap-m{white-space:nowrap}.pre-m{white-space:pre}.v-base-m{vertical-align:baseline}.v-mid-m{vertical-align:middle}.v-top-m{vertical-align:top}.v-btm-m{vertical-align:bottom}}@media screen and (min-width:60em){.aspect-ratio-l{height:0;position:relative}.aspect-ratio--16x9-l{padding-bottom:56.25%}.aspect-ratio--9x16-l{padding-bottom:177.77%}.aspect-ratio--4x3-l{padding-bottom:75%}.aspect-ratio--3x4-l{padding-bottom:133.33%}.aspect-ratio--6x4-l{padding-bottom:66.6%}.aspect-ratio--4x6-l{padding-bottom:150%}.aspect-ratio--8x5-l{padding-bottom:62.5%}.aspect-ratio--5x8-l{padding-bottom:160%}.aspect-ratio--7x5-l{padding-bottom:71.42%}.aspect-ratio--5x7-l{padding-bottom:140%}.aspect-ratio--1x1-l{padding-bottom:100%}.aspect-ratio--object-l{position:absolute;top:0;right:0;bottom:0;left:0;width:100%;height:100%;z-index:100}.cover-l{background-size:cover!important}.contain-l{background-size:contain!important}.bg-center-l{background-position:50%}.bg-center-l,.bg-top-l{background-repeat:no-repeat}.bg-top-l{background-position:top}.bg-right-l{background-position:100%}.bg-bottom-l,.bg-right-l{background-repeat:no-repeat}.bg-bottom-l{background-position:bottom}.bg-left-l{background-repeat:no-repeat;background-position:0}.outline-l{outline:1px solid}.outline-transparent-l{outline:1px solid transparent}.outline-0-l{outline:0}.ba-l{border-style:solid;border-width:1px}.bt-l{border-top-style:solid;border-top-width:1px}.br-l{border-right-style:solid;border-right-width:1px}.bb-l{border-bottom-style:solid;border-bottom-width:1px}.bl-l{border-left-style:solid;border-left-width:1px}.bn-l{border-style:none;border-width:0}.br0-l{border-radius:0}.br1-l{border-radius:.125rem}.br2-l{border-radius:.25rem}.br3-l{border-radius:.5rem}.br4-l{border-radius:1rem}.br-100-l{border-radius:100%}.br-pill-l{border-radius:9999px}.br--bottom-l{border-top-left-radius:0;border-top-right-radius:0}.br--top-l{border-bottom-right-radius:0}.br--right-l,.br--top-l{border-bottom-left-radius:0}.br--right-l{border-top-left-radius:0}.br--left-l{border-top-right-radius:0;border-bottom-right-radius:0}.b--dotted-l{border-style:dotted}.b--dashed-l{border-style:dashed}.b--solid-l{border-style:solid}.b--none-l{border-style:none}.bw0-l{border-width:0}.bw1-l{border-width:.125rem}.bw2-l{border-width:.25rem}.bw3-l{border-width:.5rem}.bw4-l{border-width:1rem}.bw5-l{border-width:2rem}.bt-0-l{border-top-width:0}.br-0-l{border-right-width:0}.bb-0-l{border-bottom-width:0}.bl-0-l{border-left-width:0}.shadow-1-l{box-shadow:0 0 4px 2px rgba(0,0,0,.2)}.shadow-2-l{box-shadow:0 0 8px 2px rgba(0,0,0,.2)}.shadow-3-l{box-shadow:2px 2px 4px 2px rgba(0,0,0,.2)}.shadow-4-l{box-shadow:2px 2px 8px 0 rgba(0,0,0,.2)}.shadow-5-l{box-shadow:4px 4px 8px 0 rgba(0,0,0,.2)}.top-0-l{top:0}.left-0-l{left:0}.right-0-l{right:0}.bottom-0-l{bottom:0}.top-1-l{top:1rem}.left-1-l{left:1rem}.right-1-l{right:1rem}.bottom-1-l{bottom:1rem}.top-2-l{top:2rem}.left-2-l{left:2rem}.right-2-l{right:2rem}.bottom-2-l{bottom:2rem}.top--1-l{top:-1rem}.right--1-l{right:-1rem}.bottom--1-l{bottom:-1rem}.left--1-l{left:-1rem}.top--2-l{top:-2rem}.right--2-l{right:-2rem}.bottom--2-l{bottom:-2rem}.left--2-l{left:-2rem}.absolute--fill-l{top:0;right:0;bottom:0;left:0}.cl-l{clear:left}.cr-l{clear:right}.cb-l{clear:both}.cn-l{clear:none}.dn-l{display:none}.di-l{display:inline}.db-l{display:block}.dib-l{display:inline-block}.dit-l{display:inline-table}.dt-l{display:table}.dtc-l{display:table-cell}.dt-row-l{display:table-row}.dt-row-group-l{display:table-row-group}.dt-column-l{display:table-column}.dt-column-group-l{display:table-column-group}.dt--fixed-l{table-layout:fixed;width:100%}.flex-l{display:-webkit-box;display:-ms-flexbox;display:flex}.inline-flex-l{display:-webkit-inline-box;display:-ms-inline-flexbox;display:inline-flex}.flex-auto-l{-webkit-box-flex:1;-ms-flex:1 1 auto;flex:1 1 auto;min-width:0;min-height:0}.flex-none-l{-webkit-box-flex:0;-ms-flex:none;flex:none}.flex-column-l{-webkit-box-orient:vertical;-ms-flex-direction:column;flex-direction:column}.flex-column-l,.flex-row-l{-webkit-box-direction:normal}.flex-row-l{-webkit-box-orient:horizontal;-ms-flex-direction:row;flex-direction:row}.flex-wrap-l{-ms-flex-wrap:wrap;flex-wrap:wrap}.flex-nowrap-l{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.flex-wrap-reverse-l{-ms-flex-wrap:wrap-reverse;flex-wrap:wrap-reverse}.flex-column-reverse-l{-webkit-box-orient:vertical;-webkit-box-direction:reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse}.flex-row-reverse-l{-webkit-box-orient:horizontal;-webkit-box-direction:reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse}.items-start-l{-webkit-box-align:start;-ms-flex-align:start;align-items:flex-start}.items-end-l{-webkit-box-align:end;-ms-flex-align:end;align-items:flex-end}.items-center-l{-webkit-box-align:center;-ms-flex-align:center;align-items:center}.items-baseline-l{-webkit-box-align:baseline;-ms-flex-align:baseline;align-items:baseline}.items-stretch-l{-webkit-box-align:stretch;-ms-flex-align:stretch;align-items:stretch}.self-start-l{-ms-flex-item-align:start;align-self:flex-start}.self-end-l{-ms-flex-item-align:end;align-self:flex-end}.self-center-l{-ms-flex-item-align:center;-ms-grid-row-align:center;align-self:center}.self-baseline-l{-ms-flex-item-align:baseline;align-self:baseline}.self-stretch-l{-ms-flex-item-align:stretch;-ms-grid-row-align:stretch;align-self:stretch}.justify-start-l{-webkit-box-pack:start;-ms-flex-pack:start;justify-content:flex-start}.justify-end-l{-webkit-box-pack:end;-ms-flex-pack:end;justify-content:flex-end}.justify-center-l{-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center}.justify-between-l{-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between}.justify-around-l{-ms-flex-pack:distribute;justify-content:space-around}.content-start-l{-ms-flex-line-pack:start;align-content:flex-start}.content-end-l{-ms-flex-line-pack:end;align-content:flex-end}.content-center-l{-ms-flex-line-pack:center;align-content:center}.content-between-l{-ms-flex-line-pack:justify;align-content:space-between}.content-around-l{-ms-flex-line-pack:distribute;align-content:space-around}.content-stretch-l{-ms-flex-line-pack:stretch;align-content:stretch}.order-0-l{-webkit-box-ordinal-group:1;-ms-flex-order:0;order:0}.order-1-l{-webkit-box-ordinal-group:2;-ms-flex-order:1;order:1}.order-2-l{-webkit-box-ordinal-group:3;-ms-flex-order:2;order:2}.order-3-l{-webkit-box-ordinal-group:4;-ms-flex-order:3;order:3}.order-4-l{-webkit-box-ordinal-group:5;-ms-flex-order:4;order:4}.order-5-l{-webkit-box-ordinal-group:6;-ms-flex-order:5;order:5}.order-6-l{-webkit-box-ordinal-group:7;-ms-flex-order:6;order:6}.order-7-l{-webkit-box-ordinal-group:8;-ms-flex-order:7;order:7}.order-8-l{-webkit-box-ordinal-group:9;-ms-flex-order:8;order:8}.order-last-l{-webkit-box-ordinal-group:100000;-ms-flex-order:99999;order:99999}.fl-l{float:left}.fl-l,.fr-l{display:inline}.fr-l{float:right}.fn-l{float:none}.i-l{font-style:italic}.fs-normal-l{font-style:normal}.normal-l{font-weight:400}.b-l{font-weight:700}.fw1-l{font-weight:100}.fw2-l{font-weight:200}.fw3-l{font-weight:300}.fw4-l{font-weight:400}.fw5-l{font-weight:500}.fw6-l{font-weight:600}.fw7-l{font-weight:700}.fw8-l{font-weight:800}.fw9-l{font-weight:900}.h1-l{height:1rem}.h2-l{height:2rem}.h3-l{height:4rem}.h4-l{height:8rem}.h5-l{height:16rem}.h-25-l{height:25%}.h-50-l{height:50%}.h-75-l{height:75%}.h-100-l{height:100%}.min-h-100-l{min-height:100%}.vh-25-l{height:25vh}.vh-50-l{height:50vh}.vh-75-l{height:75vh}.vh-100-l{height:100vh}.min-vh-100-l{min-height:100vh}.h-auto-l{height:auto}.h-inherit-l{height:inherit}.tracked-l{letter-spacing:.1em}.tracked-tight-l{letter-spacing:-.05em}.tracked-mega-l{letter-spacing:.25em}.lh-solid-l{line-height:1}.lh-title-l{line-height:1.25}.lh-copy-l{line-height:1.5}.mw-100-l{max-width:100%}.mw1-l{max-width:1rem}.mw2-l{max-width:2rem}.mw3-l{max-width:4rem}.mw4-l{max-width:8rem}.mw5-l{max-width:16rem}.mw6-l{max-width:32rem}.mw7-l{max-width:48rem}.mw8-l{max-width:64rem}.mw9-l{max-width:96rem}.mw-none-l{max-width:none}.w1-l{width:1rem}.w2-l{width:2rem}.w3-l{width:4rem}.w4-l{width:8rem}.w5-l{width:16rem}.w-10-l{width:10%}.w-20-l{width:20%}.w-25-l{width:25%}.w-30-l{width:30%}.w-33-l{width:33%}.w-34-l{width:34%}.w-40-l{width:40%}.w-50-l{width:50%}.w-60-l{width:60%}.w-70-l{width:70%}.w-75-l{width:75%}.w-80-l{width:80%}.w-90-l{width:90%}.w-100-l{width:100%}.w-third-l{width:33.33333%}.w-two-thirds-l{width:66.66667%}.w-auto-l{width:auto}.overflow-visible-l{overflow:visible}.overflow-hidden-l{overflow:hidden}.overflow-scroll-l{overflow:scroll}.overflow-auto-l{overflow:auto}.overflow-x-visible-l{overflow-x:visible}.overflow-x-hidden-l{overflow-x:hidden}.overflow-x-scroll-l{overflow-x:scroll}.overflow-x-auto-l{overflow-x:auto}.overflow-y-visible-l{overflow-y:visible}.overflow-y-hidden-l{overflow-y:hidden}.overflow-y-scroll-l{overflow-y:scroll}.overflow-y-auto-l{overflow-y:auto}.static-l{position:static}.relative-l{position:relative}.absolute-l{position:absolute}.fixed-l{position:fixed}.rotate-45-l{-webkit-transform:rotate(45deg);transform:rotate(45deg)}.rotate-90-l{-webkit-transform:rotate(90deg);transform:rotate(90deg)}.rotate-135-l{-webkit-transform:rotate(135deg);transform:rotate(135deg)}.rotate-180-l{-webkit-transform:rotate(180deg);transform:rotate(180deg)}.rotate-225-l{-webkit-transform:rotate(225deg);transform:rotate(225deg)}.rotate-270-l{-webkit-transform:rotate(270deg);transform:rotate(270deg)}.rotate-315-l{-webkit-transform:rotate(315deg);transform:rotate(315deg)}.pa0-l{padding:0}.pa1-l{padding:.25rem}.pa2-l{padding:.5rem}.pa3-l{padding:1rem}.pa4-l{padding:2rem}.pa5-l{padding:4rem}.pa6-l{padding:8rem}.pa7-l{padding:16rem}.pl0-l{padding-left:0}.pl1-l{padding-left:.25rem}.pl2-l{padding-left:.5rem}.pl3-l{padding-left:1rem}.pl4-l{padding-left:2rem}.pl5-l{padding-left:4rem}.pl6-l{padding-left:8rem}.pl7-l{padding-left:16rem}.pr0-l{padding-right:0}.pr1-l{padding-right:.25rem}.pr2-l{padding-right:.5rem}.pr3-l{padding-right:1rem}.pr4-l{padding-right:2rem}.pr5-l{padding-right:4rem}.pr6-l{padding-right:8rem}.pr7-l{padding-right:16rem}.pb0-l{padding-bottom:0}.pb1-l{padding-bottom:.25rem}.pb2-l{padding-bottom:.5rem}.pb3-l{padding-bottom:1rem}.pb4-l{padding-bottom:2rem}.pb5-l{padding-bottom:4rem}.pb6-l{padding-bottom:8rem}.pb7-l{padding-bottom:16rem}.pt0-l{padding-top:0}.pt1-l{padding-top:.25rem}.pt2-l{padding-top:.5rem}.pt3-l{padding-top:1rem}.pt4-l{padding-top:2rem}.pt5-l{padding-top:4rem}.pt6-l{padding-top:8rem}.pt7-l{padding-top:16rem}.pv0-l{padding-top:0;padding-bottom:0}.pv1-l{padding-top:.25rem;padding-bottom:.25rem}.pv2-l{padding-top:.5rem;padding-bottom:.5rem}.pv3-l{padding-top:1rem;padding-bottom:1rem}.pv4-l{padding-top:2rem;padding-bottom:2rem}.pv5-l{padding-top:4rem;padding-bottom:4rem}.pv6-l{padding-top:8rem;padding-bottom:8rem}.pv7-l{padding-top:16rem;padding-bottom:16rem}.ph0-l{padding-left:0;padding-right:0}.ph1-l{padding-left:.25rem;padding-right:.25rem}.ph2-l{padding-left:.5rem;padding-right:.5rem}.ph3-l{padding-left:1rem;padding-right:1rem}.ph4-l{padding-left:2rem;padding-right:2rem}.ph5-l{padding-left:4rem;padding-right:4rem}.ph6-l{padding-left:8rem;padding-right:8rem}.ph7-l{padding-left:16rem;padding-right:16rem}.ma0-l{margin:0}.ma1-l{margin:.25rem}.ma2-l{margin:.5rem}.ma3-l{margin:1rem}.ma4-l{margin:2rem}.ma5-l{margin:4rem}.ma6-l{margin:8rem}.ma7-l{margin:16rem}.ml0-l{margin-left:0}.ml1-l{margin-left:.25rem}.ml2-l{margin-left:.5rem}.ml3-l{margin-left:1rem}.ml4-l{margin-left:2rem}.ml5-l{margin-left:4rem}.ml6-l{margin-left:8rem}.ml7-l{margin-left:16rem}.mr0-l{margin-right:0}.mr1-l{margin-right:.25rem}.mr2-l{margin-right:.5rem}.mr3-l{margin-right:1rem}.mr4-l{margin-right:2rem}.mr5-l{margin-right:4rem}.mr6-l{margin-right:8rem}.mr7-l{margin-right:16rem}.mb0-l{margin-bottom:0}.mb1-l{margin-bottom:.25rem}.mb2-l{margin-bottom:.5rem}.mb3-l{margin-bottom:1rem}.mb4-l{margin-bottom:2rem}.mb5-l{margin-bottom:4rem}.mb6-l{margin-bottom:8rem}.mb7-l{margin-bottom:16rem}.mt0-l{margin-top:0}.mt1-l{margin-top:.25rem}.mt2-l{margin-top:.5rem}.mt3-l{margin-top:1rem}.mt4-l{margin-top:2rem}.mt5-l{margin-top:4rem}.mt6-l{margin-top:8rem}.mt7-l{margin-top:16rem}.mv0-l{margin-top:0;margin-bottom:0}.mv1-l{margin-top:.25rem;margin-bottom:.25rem}.mv2-l{margin-top:.5rem;margin-bottom:.5rem}.mv3-l{margin-top:1rem;margin-bottom:1rem}.mv4-l{margin-top:2rem;margin-bottom:2rem}.mv5-l{margin-top:4rem;margin-bottom:4rem}.mv6-l{margin-top:8rem;margin-bottom:8rem}.mv7-l{margin-top:16rem;margin-bottom:16rem}.mh0-l{margin-left:0;margin-right:0}.mh1-l{margin-left:.25rem;margin-right:.25rem}.mh2-l{margin-left:.5rem;margin-right:.5rem}.mh3-l{margin-left:1rem;margin-right:1rem}.mh4-l{margin-left:2rem;margin-right:2rem}.mh5-l{margin-left:4rem;margin-right:4rem}.mh6-l{margin-left:8rem;margin-right:8rem}.mh7-l{margin-left:16rem;margin-right:16rem}.na1-l{margin:-.25rem}.na2-l{margin:-.5rem}.na3-l{margin:-1rem}.na4-l{margin:-2rem}.na5-l{margin:-4rem}.na6-l{margin:-8rem}.na7-l{margin:-16rem}.nl1-l{margin-left:-.25rem}.nl2-l{margin-left:-.5rem}.nl3-l{margin-left:-1rem}.nl4-l{margin-left:-2rem}.nl5-l{margin-left:-4rem}.nl6-l{margin-left:-8rem}.nl7-l{margin-left:-16rem}.nr1-l{margin-right:-.25rem}.nr2-l{margin-right:-.5rem}.nr3-l{margin-right:-1rem}.nr4-l{margin-right:-2rem}.nr5-l{margin-right:-4rem}.nr6-l{margin-right:-8rem}.nr7-l{margin-right:-16rem}.nb1-l{margin-bottom:-.25rem}.nb2-l{margin-bottom:-.5rem}.nb3-l{margin-bottom:-1rem}.nb4-l{margin-bottom:-2rem}.nb5-l{margin-bottom:-4rem}.nb6-l{margin-bottom:-8rem}.nb7-l{margin-bottom:-16rem}.nt1-l{margin-top:-.25rem}.nt2-l{margin-top:-.5rem}.nt3-l{margin-top:-1rem}.nt4-l{margin-top:-2rem}.nt5-l{margin-top:-4rem}.nt6-l{margin-top:-8rem}.nt7-l{margin-top:-16rem}.strike-l{text-decoration:line-through}.underline-l{text-decoration:underline}.no-underline-l{text-decoration:none}.tl-l{text-align:left}.tr-l{text-align:right}.tc-l{text-align:center}.tj-l{text-align:justify}.ttc-l{text-transform:capitalize}.ttl-l{text-transform:lowercase}.ttu-l{text-transform:uppercase}.ttn-l{text-transform:none}.f-6-l,.f-headline-l{font-size:6rem}.f-5-l,.f-subheadline-l{font-size:5rem}.f1-l{font-size:3rem}.f2-l{font-size:2.25rem}.f3-l{font-size:1.5rem}.f4-l{font-size:1.25rem}.f5-l{font-size:1rem}.f6-l{font-size:.875rem}.f7-l{font-size:.75rem}.measure-l{max-width:30em}.measure-wide-l{max-width:34em}.measure-narrow-l{max-width:20em}.indent-l{text-indent:1em;margin-top:0;margin-bottom:0}.small-caps-l{font-variant:small-caps}.truncate-l{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}.center-l{margin-left:auto}.center-l,.mr-auto-l{margin-right:auto}.ml-auto-l{margin-left:auto}.clip-l{position:fixed!important;position:absolute!important;clip:rect(1px 1px 1px 1px);clip:rect(1px,1px,1px,1px)}.ws-normal-l{white-space:normal}.nowrap-l{white-space:nowrap}.pre-l{white-space:pre}.v-base-l{vertical-align:baseline}.v-mid-l{vertical-align:middle}.v-top-l{vertical-align:top}.v-btm-l{vertical-align:bottom}}\n            '),
			_1: {ctor: '[]'}
		})
};
var _justgage$tachyons_elm$Tachyons$classes = function (stringList) {
	return _elm_lang$html$Html_Attributes$class(
		A2(_elm_lang$core$String$join, ' ', stringList));
};

var _justgage$tachyons_elm$Tachyons_Classes$z_unset = 'z-unset';
var _justgage$tachyons_elm$Tachyons_Classes$z_max = 'z-max';
var _justgage$tachyons_elm$Tachyons_Classes$z_initial = 'z-initial';
var _justgage$tachyons_elm$Tachyons_Classes$z_inherit = 'z-inherit';
var _justgage$tachyons_elm$Tachyons_Classes$z_9999 = 'z-9999';
var _justgage$tachyons_elm$Tachyons_Classes$z_999 = 'z-999';
var _justgage$tachyons_elm$Tachyons_Classes$z_5 = 'z-5';
var _justgage$tachyons_elm$Tachyons_Classes$z_4 = 'z-4';
var _justgage$tachyons_elm$Tachyons_Classes$z_3 = 'z-3';
var _justgage$tachyons_elm$Tachyons_Classes$z_2 = 'z-2';
var _justgage$tachyons_elm$Tachyons_Classes$z_1 = 'z-1';
var _justgage$tachyons_elm$Tachyons_Classes$z_0 = 'z-0';
var _justgage$tachyons_elm$Tachyons_Classes$yellow = 'yellow';
var _justgage$tachyons_elm$Tachyons_Classes$ws_normal_ns = 'ws-normal-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ws_normal_m = 'ws-normal-m';
var _justgage$tachyons_elm$Tachyons_Classes$ws_normal_l = 'ws-normal-l';
var _justgage$tachyons_elm$Tachyons_Classes$ws_normal = 'ws-normal';
var _justgage$tachyons_elm$Tachyons_Classes$white_90 = 'white-90';
var _justgage$tachyons_elm$Tachyons_Classes$white_80 = 'white-80';
var _justgage$tachyons_elm$Tachyons_Classes$white_70 = 'white-70';
var _justgage$tachyons_elm$Tachyons_Classes$white_60 = 'white-60';
var _justgage$tachyons_elm$Tachyons_Classes$white_50 = 'white-50';
var _justgage$tachyons_elm$Tachyons_Classes$white_40 = 'white-40';
var _justgage$tachyons_elm$Tachyons_Classes$white_30 = 'white-30';
var _justgage$tachyons_elm$Tachyons_Classes$white_20 = 'white-20';
var _justgage$tachyons_elm$Tachyons_Classes$white_10 = 'white-10';
var _justgage$tachyons_elm$Tachyons_Classes$white = 'white';
var _justgage$tachyons_elm$Tachyons_Classes$washed_yellow = 'washed-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$washed_red = 'washed-red';
var _justgage$tachyons_elm$Tachyons_Classes$washed_green = 'washed-green';
var _justgage$tachyons_elm$Tachyons_Classes$washed_blue = 'washed-blue';
var _justgage$tachyons_elm$Tachyons_Classes$w5_ns = 'w5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w5_m = 'w5-m';
var _justgage$tachyons_elm$Tachyons_Classes$w5_l = 'w5-l';
var _justgage$tachyons_elm$Tachyons_Classes$w5 = 'w5';
var _justgage$tachyons_elm$Tachyons_Classes$w4_ns = 'w4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w4_m = 'w4-m';
var _justgage$tachyons_elm$Tachyons_Classes$w4_l = 'w4-l';
var _justgage$tachyons_elm$Tachyons_Classes$w4 = 'w4';
var _justgage$tachyons_elm$Tachyons_Classes$w3_ns = 'w3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w3_m = 'w3-m';
var _justgage$tachyons_elm$Tachyons_Classes$w3_l = 'w3-l';
var _justgage$tachyons_elm$Tachyons_Classes$w3 = 'w3';
var _justgage$tachyons_elm$Tachyons_Classes$w2_ns = 'w2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w2_m = 'w2-m';
var _justgage$tachyons_elm$Tachyons_Classes$w2_l = 'w2-l';
var _justgage$tachyons_elm$Tachyons_Classes$w2 = 'w2';
var _justgage$tachyons_elm$Tachyons_Classes$w1_ns = 'w1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w1_m = 'w1-m';
var _justgage$tachyons_elm$Tachyons_Classes$w1_l = 'w1-l';
var _justgage$tachyons_elm$Tachyons_Classes$w1 = 'w1';
var _justgage$tachyons_elm$Tachyons_Classes$w_two_thirds_ns = 'w-two-thirds-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_two_thirds_m = 'w-two-thirds-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_two_thirds_l = 'w-two-thirds-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_two_thirds = 'w-two-thirds';
var _justgage$tachyons_elm$Tachyons_Classes$w_third_ns = 'w-third-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_third_m = 'w-third-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_third_l = 'w-third-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_third = 'w-third';
var _justgage$tachyons_elm$Tachyons_Classes$w_auto_ns = 'w-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_auto_m = 'w-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_auto_l = 'w-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_auto = 'w-auto';
var _justgage$tachyons_elm$Tachyons_Classes$w_90_ns = 'w-90-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_90_m = 'w-90-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_90_l = 'w-90-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_90 = 'w-90';
var _justgage$tachyons_elm$Tachyons_Classes$w_80_ns = 'w-80-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_80_m = 'w-80-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_80_l = 'w-80-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_80 = 'w-80';
var _justgage$tachyons_elm$Tachyons_Classes$w_75_ns = 'w-75-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_75_m = 'w-75-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_75_l = 'w-75-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_75 = 'w-75';
var _justgage$tachyons_elm$Tachyons_Classes$w_70_ns = 'w-70-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_70_m = 'w-70-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_70_l = 'w-70-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_70 = 'w-70';
var _justgage$tachyons_elm$Tachyons_Classes$w_60_ns = 'w-60-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_60_m = 'w-60-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_60_l = 'w-60-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_60 = 'w-60';
var _justgage$tachyons_elm$Tachyons_Classes$w_50_ns = 'w-50-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_50_m = 'w-50-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_50_l = 'w-50-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_50 = 'w-50';
var _justgage$tachyons_elm$Tachyons_Classes$w_40_ns = 'w-40-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_40_m = 'w-40-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_40_l = 'w-40-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_40 = 'w-40';
var _justgage$tachyons_elm$Tachyons_Classes$w_34_ns = 'w-34-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_34_m = 'w-34-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_34_l = 'w-34-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_34 = 'w-34';
var _justgage$tachyons_elm$Tachyons_Classes$w_33_ns = 'w-33-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_33_m = 'w-33-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_33_l = 'w-33-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_33 = 'w-33';
var _justgage$tachyons_elm$Tachyons_Classes$w_30_ns = 'w-30-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_30_m = 'w-30-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_30_l = 'w-30-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_30 = 'w-30';
var _justgage$tachyons_elm$Tachyons_Classes$w_25_ns = 'w-25-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_25_m = 'w-25-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_25_l = 'w-25-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_25 = 'w-25';
var _justgage$tachyons_elm$Tachyons_Classes$w_20_ns = 'w-20-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_20_m = 'w-20-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_20_l = 'w-20-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_20 = 'w-20';
var _justgage$tachyons_elm$Tachyons_Classes$w_100_ns = 'w-100-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_100_m = 'w-100-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_100_l = 'w-100-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_100 = 'w-100';
var _justgage$tachyons_elm$Tachyons_Classes$w_10_ns = 'w-10-ns';
var _justgage$tachyons_elm$Tachyons_Classes$w_10_m = 'w-10-m';
var _justgage$tachyons_elm$Tachyons_Classes$w_10_l = 'w-10-l';
var _justgage$tachyons_elm$Tachyons_Classes$w_10 = 'w-10';
var _justgage$tachyons_elm$Tachyons_Classes$vh_75_ns = 'vh-75-ns';
var _justgage$tachyons_elm$Tachyons_Classes$vh_75_m = 'vh-75-m';
var _justgage$tachyons_elm$Tachyons_Classes$vh_75_l = 'vh-75-l';
var _justgage$tachyons_elm$Tachyons_Classes$vh_75 = 'vh-75';
var _justgage$tachyons_elm$Tachyons_Classes$vh_50_ns = 'vh-50-ns';
var _justgage$tachyons_elm$Tachyons_Classes$vh_50_m = 'vh-50-m';
var _justgage$tachyons_elm$Tachyons_Classes$vh_50_l = 'vh-50-l';
var _justgage$tachyons_elm$Tachyons_Classes$vh_50 = 'vh-50';
var _justgage$tachyons_elm$Tachyons_Classes$vh_25_ns = 'vh-25-ns';
var _justgage$tachyons_elm$Tachyons_Classes$vh_25_m = 'vh-25-m';
var _justgage$tachyons_elm$Tachyons_Classes$vh_25_l = 'vh-25-l';
var _justgage$tachyons_elm$Tachyons_Classes$vh_25 = 'vh-25';
var _justgage$tachyons_elm$Tachyons_Classes$vh_100_ns = 'vh-100-ns';
var _justgage$tachyons_elm$Tachyons_Classes$vh_100_m = 'vh-100-m';
var _justgage$tachyons_elm$Tachyons_Classes$vh_100_l = 'vh-100-l';
var _justgage$tachyons_elm$Tachyons_Classes$vh_100 = 'vh-100';
var _justgage$tachyons_elm$Tachyons_Classes$v_top_ns = 'v-top-ns';
var _justgage$tachyons_elm$Tachyons_Classes$v_top_m = 'v-top-m';
var _justgage$tachyons_elm$Tachyons_Classes$v_top_l = 'v-top-l';
var _justgage$tachyons_elm$Tachyons_Classes$v_top = 'v-top';
var _justgage$tachyons_elm$Tachyons_Classes$v_mid_ns = 'v-mid-ns';
var _justgage$tachyons_elm$Tachyons_Classes$v_mid_m = 'v-mid-m';
var _justgage$tachyons_elm$Tachyons_Classes$v_mid_l = 'v-mid-l';
var _justgage$tachyons_elm$Tachyons_Classes$v_mid = 'v-mid';
var _justgage$tachyons_elm$Tachyons_Classes$v_btm_ns = 'v-btm-ns';
var _justgage$tachyons_elm$Tachyons_Classes$v_btm_m = 'v-btm-m';
var _justgage$tachyons_elm$Tachyons_Classes$v_btm_l = 'v-btm-l';
var _justgage$tachyons_elm$Tachyons_Classes$v_btm = 'v-btm';
var _justgage$tachyons_elm$Tachyons_Classes$v_base_ns = 'v-base-ns';
var _justgage$tachyons_elm$Tachyons_Classes$v_base_m = 'v-base-m';
var _justgage$tachyons_elm$Tachyons_Classes$v_base_l = 'v-base-l';
var _justgage$tachyons_elm$Tachyons_Classes$v_base = 'v-base';
var _justgage$tachyons_elm$Tachyons_Classes$underline_ns = 'underline-ns';
var _justgage$tachyons_elm$Tachyons_Classes$underline_m = 'underline-m';
var _justgage$tachyons_elm$Tachyons_Classes$underline_l = 'underline-l';
var _justgage$tachyons_elm$Tachyons_Classes$underline_hover = 'underline-hover';
var _justgage$tachyons_elm$Tachyons_Classes$underline = 'underline';
var _justgage$tachyons_elm$Tachyons_Classes$ttu_ns = 'ttu-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ttu_m = 'ttu-m';
var _justgage$tachyons_elm$Tachyons_Classes$ttu_l = 'ttu-l';
var _justgage$tachyons_elm$Tachyons_Classes$ttu = 'ttu';
var _justgage$tachyons_elm$Tachyons_Classes$ttn_ns = 'ttn-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ttn_m = 'ttn-m';
var _justgage$tachyons_elm$Tachyons_Classes$ttn_l = 'ttn-l';
var _justgage$tachyons_elm$Tachyons_Classes$ttn = 'ttn';
var _justgage$tachyons_elm$Tachyons_Classes$ttl_ns = 'ttl-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ttl_m = 'ttl-m';
var _justgage$tachyons_elm$Tachyons_Classes$ttl_l = 'ttl-l';
var _justgage$tachyons_elm$Tachyons_Classes$ttl = 'ttl';
var _justgage$tachyons_elm$Tachyons_Classes$ttc_ns = 'ttc-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ttc_m = 'ttc-m';
var _justgage$tachyons_elm$Tachyons_Classes$ttc_l = 'ttc-l';
var _justgage$tachyons_elm$Tachyons_Classes$ttc = 'ttc';
var _justgage$tachyons_elm$Tachyons_Classes$truncate_ns = 'truncate-ns';
var _justgage$tachyons_elm$Tachyons_Classes$truncate_m = 'truncate-m';
var _justgage$tachyons_elm$Tachyons_Classes$truncate_l = 'truncate-l';
var _justgage$tachyons_elm$Tachyons_Classes$truncate = 'truncate';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_tight_ns = 'tracked-tight-ns';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_tight_m = 'tracked-tight-m';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_tight_l = 'tracked-tight-l';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_tight = 'tracked-tight';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_ns = 'tracked-ns';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_mega_ns = 'tracked-mega-ns';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_mega_m = 'tracked-mega-m';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_mega_l = 'tracked-mega-l';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_mega = 'tracked-mega';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_m = 'tracked-m';
var _justgage$tachyons_elm$Tachyons_Classes$tracked_l = 'tracked-l';
var _justgage$tachyons_elm$Tachyons_Classes$tracked = 'tracked';
var _justgage$tachyons_elm$Tachyons_Classes$tr_ns = 'tr-ns';
var _justgage$tachyons_elm$Tachyons_Classes$tr_m = 'tr-m';
var _justgage$tachyons_elm$Tachyons_Classes$tr_l = 'tr-l';
var _justgage$tachyons_elm$Tachyons_Classes$tr = 'tr';
var _justgage$tachyons_elm$Tachyons_Classes$top_2_ns = 'top-2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$top_2_m = 'top-2-m';
var _justgage$tachyons_elm$Tachyons_Classes$top_2_l = 'top-2-l';
var _justgage$tachyons_elm$Tachyons_Classes$top_2 = 'top-2';
var _justgage$tachyons_elm$Tachyons_Classes$top_1_ns = 'top-1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$top_1_m = 'top-1-m';
var _justgage$tachyons_elm$Tachyons_Classes$top_1_l = 'top-1-l';
var _justgage$tachyons_elm$Tachyons_Classes$top_1 = 'top-1';
var _justgage$tachyons_elm$Tachyons_Classes$top_0_ns = 'top-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$top_0_m = 'top-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$top_0_l = 'top-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$top_0 = 'top-0';
var _justgage$tachyons_elm$Tachyons_Classes$top__2_ns = 'top--2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$top__2_m = 'top--2-m';
var _justgage$tachyons_elm$Tachyons_Classes$top__2_l = 'top--2-l';
var _justgage$tachyons_elm$Tachyons_Classes$top__2 = 'top--2';
var _justgage$tachyons_elm$Tachyons_Classes$top__1_ns = 'top--1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$top__1_m = 'top--1-m';
var _justgage$tachyons_elm$Tachyons_Classes$top__1_l = 'top--1-l';
var _justgage$tachyons_elm$Tachyons_Classes$top__1 = 'top--1';
var _justgage$tachyons_elm$Tachyons_Classes$tl_ns = 'tl-ns';
var _justgage$tachyons_elm$Tachyons_Classes$tl_m = 'tl-m';
var _justgage$tachyons_elm$Tachyons_Classes$tl_l = 'tl-l';
var _justgage$tachyons_elm$Tachyons_Classes$tl = 'tl';
var _justgage$tachyons_elm$Tachyons_Classes$tj_ns = 'tj-ns';
var _justgage$tachyons_elm$Tachyons_Classes$tj_m = 'tj-m';
var _justgage$tachyons_elm$Tachyons_Classes$tj_l = 'tj-l';
var _justgage$tachyons_elm$Tachyons_Classes$tj = 'tj';
var _justgage$tachyons_elm$Tachyons_Classes$times = 'times';
var _justgage$tachyons_elm$Tachyons_Classes$tc_ns = 'tc-ns';
var _justgage$tachyons_elm$Tachyons_Classes$tc_m = 'tc-m';
var _justgage$tachyons_elm$Tachyons_Classes$tc_l = 'tc-l';
var _justgage$tachyons_elm$Tachyons_Classes$tc = 'tc';
var _justgage$tachyons_elm$Tachyons_Classes$system_serif = 'system-serif';
var _justgage$tachyons_elm$Tachyons_Classes$system_sans_serif = 'system-sans-serif';
var _justgage$tachyons_elm$Tachyons_Classes$striped__near_white = 'striped--near-white';
var _justgage$tachyons_elm$Tachyons_Classes$striped__moon_gray = 'striped--moon-gray';
var _justgage$tachyons_elm$Tachyons_Classes$striped__light_silver = 'striped--light-silver';
var _justgage$tachyons_elm$Tachyons_Classes$striped__light_gray = 'striped--light-gray';
var _justgage$tachyons_elm$Tachyons_Classes$stripe_light = 'stripe-light';
var _justgage$tachyons_elm$Tachyons_Classes$stripe_dark = 'stripe-dark';
var _justgage$tachyons_elm$Tachyons_Classes$strike_ns = 'strike-ns';
var _justgage$tachyons_elm$Tachyons_Classes$strike_m = 'strike-m';
var _justgage$tachyons_elm$Tachyons_Classes$strike_l = 'strike-l';
var _justgage$tachyons_elm$Tachyons_Classes$strike = 'strike';
var _justgage$tachyons_elm$Tachyons_Classes$static_ns = 'static-ns';
var _justgage$tachyons_elm$Tachyons_Classes$static_m = 'static-m';
var _justgage$tachyons_elm$Tachyons_Classes$static_l = 'static-l';
var _justgage$tachyons_elm$Tachyons_Classes$static = 'static';
var _justgage$tachyons_elm$Tachyons_Classes$small_caps_ns = 'small-caps-ns';
var _justgage$tachyons_elm$Tachyons_Classes$small_caps_m = 'small-caps-m';
var _justgage$tachyons_elm$Tachyons_Classes$small_caps_l = 'small-caps-l';
var _justgage$tachyons_elm$Tachyons_Classes$small_caps = 'small-caps';
var _justgage$tachyons_elm$Tachyons_Classes$silver = 'silver';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_hover = 'shadow-hover';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_5_ns = 'shadow-5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_5_m = 'shadow-5-m';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_5_l = 'shadow-5-l';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_5 = 'shadow-5';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_4_ns = 'shadow-4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_4_m = 'shadow-4-m';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_4_l = 'shadow-4-l';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_4 = 'shadow-4';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_3_ns = 'shadow-3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_3_m = 'shadow-3-m';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_3_l = 'shadow-3-l';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_3 = 'shadow-3';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_2_ns = 'shadow-2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_2_m = 'shadow-2-m';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_2_l = 'shadow-2-l';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_2 = 'shadow-2';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_1_ns = 'shadow-1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_1_m = 'shadow-1-m';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_1_l = 'shadow-1-l';
var _justgage$tachyons_elm$Tachyons_Classes$shadow_1 = 'shadow-1';
var _justgage$tachyons_elm$Tachyons_Classes$serif = 'serif';
var _justgage$tachyons_elm$Tachyons_Classes$self_stretch_ns = 'self-stretch-ns';
var _justgage$tachyons_elm$Tachyons_Classes$self_stretch_m = 'self-stretch-m';
var _justgage$tachyons_elm$Tachyons_Classes$self_stretch_l = 'self-stretch-l';
var _justgage$tachyons_elm$Tachyons_Classes$self_stretch = 'self-stretch';
var _justgage$tachyons_elm$Tachyons_Classes$self_start_ns = 'self-start-ns';
var _justgage$tachyons_elm$Tachyons_Classes$self_start_m = 'self-start-m';
var _justgage$tachyons_elm$Tachyons_Classes$self_start_l = 'self-start-l';
var _justgage$tachyons_elm$Tachyons_Classes$self_start = 'self-start';
var _justgage$tachyons_elm$Tachyons_Classes$self_end_ns = 'self-end-ns';
var _justgage$tachyons_elm$Tachyons_Classes$self_end_m = 'self-end-m';
var _justgage$tachyons_elm$Tachyons_Classes$self_end_l = 'self-end-l';
var _justgage$tachyons_elm$Tachyons_Classes$self_end = 'self-end';
var _justgage$tachyons_elm$Tachyons_Classes$self_center_ns = 'self-center-ns';
var _justgage$tachyons_elm$Tachyons_Classes$self_center_m = 'self-center-m';
var _justgage$tachyons_elm$Tachyons_Classes$self_center_l = 'self-center-l';
var _justgage$tachyons_elm$Tachyons_Classes$self_center = 'self-center';
var _justgage$tachyons_elm$Tachyons_Classes$self_baseline_ns = 'self-baseline-ns';
var _justgage$tachyons_elm$Tachyons_Classes$self_baseline_m = 'self-baseline-m';
var _justgage$tachyons_elm$Tachyons_Classes$self_baseline_l = 'self-baseline-l';
var _justgage$tachyons_elm$Tachyons_Classes$self_baseline = 'self-baseline';
var _justgage$tachyons_elm$Tachyons_Classes$sans_serif = 'sans-serif';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_90_ns = 'rotate-90-ns';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_90_m = 'rotate-90-m';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_90_l = 'rotate-90-l';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_90 = 'rotate-90';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_45_ns = 'rotate-45-ns';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_45_m = 'rotate-45-m';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_45_l = 'rotate-45-l';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_45 = 'rotate-45';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_315_ns = 'rotate-315-ns';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_315_m = 'rotate-315-m';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_315_l = 'rotate-315-l';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_315 = 'rotate-315';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_270_ns = 'rotate-270-ns';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_270_m = 'rotate-270-m';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_270_l = 'rotate-270-l';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_270 = 'rotate-270';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_225_ns = 'rotate-225-ns';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_225_m = 'rotate-225-m';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_225_l = 'rotate-225-l';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_225 = 'rotate-225';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_180_ns = 'rotate-180-ns';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_180_m = 'rotate-180-m';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_180_l = 'rotate-180-l';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_180 = 'rotate-180';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_135_ns = 'rotate-135-ns';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_135_m = 'rotate-135-m';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_135_l = 'rotate-135-l';
var _justgage$tachyons_elm$Tachyons_Classes$rotate_135 = 'rotate-135';
var _justgage$tachyons_elm$Tachyons_Classes$right_2_ns = 'right-2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$right_2_m = 'right-2-m';
var _justgage$tachyons_elm$Tachyons_Classes$right_2_l = 'right-2-l';
var _justgage$tachyons_elm$Tachyons_Classes$right_2 = 'right-2';
var _justgage$tachyons_elm$Tachyons_Classes$right_1_ns = 'right-1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$right_1_m = 'right-1-m';
var _justgage$tachyons_elm$Tachyons_Classes$right_1_l = 'right-1-l';
var _justgage$tachyons_elm$Tachyons_Classes$right_1 = 'right-1';
var _justgage$tachyons_elm$Tachyons_Classes$right_0_ns = 'right-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$right_0_m = 'right-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$right_0_l = 'right-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$right_0 = 'right-0';
var _justgage$tachyons_elm$Tachyons_Classes$right__2_ns = 'right--2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$right__2_m = 'right--2-m';
var _justgage$tachyons_elm$Tachyons_Classes$right__2_l = 'right--2-l';
var _justgage$tachyons_elm$Tachyons_Classes$right__2 = 'right--2';
var _justgage$tachyons_elm$Tachyons_Classes$right__1_ns = 'right--1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$right__1_m = 'right--1-m';
var _justgage$tachyons_elm$Tachyons_Classes$right__1_l = 'right--1-l';
var _justgage$tachyons_elm$Tachyons_Classes$right__1 = 'right--1';
var _justgage$tachyons_elm$Tachyons_Classes$relative_ns = 'relative-ns';
var _justgage$tachyons_elm$Tachyons_Classes$relative_m = 'relative-m';
var _justgage$tachyons_elm$Tachyons_Classes$relative_l = 'relative-l';
var _justgage$tachyons_elm$Tachyons_Classes$relative = 'relative';
var _justgage$tachyons_elm$Tachyons_Classes$red = 'red';
var _justgage$tachyons_elm$Tachyons_Classes$pv7_ns = 'pv7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv7_m = 'pv7-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv7_l = 'pv7-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv7 = 'pv7';
var _justgage$tachyons_elm$Tachyons_Classes$pv6_ns = 'pv6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv6_m = 'pv6-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv6_l = 'pv6-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv6 = 'pv6';
var _justgage$tachyons_elm$Tachyons_Classes$pv5_ns = 'pv5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv5_m = 'pv5-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv5_l = 'pv5-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv5 = 'pv5';
var _justgage$tachyons_elm$Tachyons_Classes$pv4_ns = 'pv4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv4_m = 'pv4-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv4_l = 'pv4-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv4 = 'pv4';
var _justgage$tachyons_elm$Tachyons_Classes$pv3_ns = 'pv3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv3_m = 'pv3-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv3_l = 'pv3-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv3 = 'pv3';
var _justgage$tachyons_elm$Tachyons_Classes$pv2_ns = 'pv2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv2_m = 'pv2-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv2_l = 'pv2-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv2 = 'pv2';
var _justgage$tachyons_elm$Tachyons_Classes$pv1_ns = 'pv1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv1_m = 'pv1-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv1_l = 'pv1-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv1 = 'pv1';
var _justgage$tachyons_elm$Tachyons_Classes$pv0_ns = 'pv0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pv0_m = 'pv0-m';
var _justgage$tachyons_elm$Tachyons_Classes$pv0_l = 'pv0-l';
var _justgage$tachyons_elm$Tachyons_Classes$pv0 = 'pv0';
var _justgage$tachyons_elm$Tachyons_Classes$purple = 'purple';
var _justgage$tachyons_elm$Tachyons_Classes$pt7_ns = 'pt7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt7_m = 'pt7-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt7_l = 'pt7-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt7 = 'pt7';
var _justgage$tachyons_elm$Tachyons_Classes$pt6_ns = 'pt6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt6_m = 'pt6-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt6_l = 'pt6-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt6 = 'pt6';
var _justgage$tachyons_elm$Tachyons_Classes$pt5_ns = 'pt5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt5_m = 'pt5-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt5_l = 'pt5-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt5 = 'pt5';
var _justgage$tachyons_elm$Tachyons_Classes$pt4_ns = 'pt4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt4_m = 'pt4-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt4_l = 'pt4-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt4 = 'pt4';
var _justgage$tachyons_elm$Tachyons_Classes$pt3_ns = 'pt3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt3_m = 'pt3-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt3_l = 'pt3-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt3 = 'pt3';
var _justgage$tachyons_elm$Tachyons_Classes$pt2_ns = 'pt2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt2_m = 'pt2-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt2_l = 'pt2-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt2 = 'pt2';
var _justgage$tachyons_elm$Tachyons_Classes$pt1_ns = 'pt1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt1_m = 'pt1-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt1_l = 'pt1-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt1 = 'pt1';
var _justgage$tachyons_elm$Tachyons_Classes$pt0_ns = 'pt0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pt0_m = 'pt0-m';
var _justgage$tachyons_elm$Tachyons_Classes$pt0_l = 'pt0-l';
var _justgage$tachyons_elm$Tachyons_Classes$pt0 = 'pt0';
var _justgage$tachyons_elm$Tachyons_Classes$pre_ns = 'pre-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pre_m = 'pre-m';
var _justgage$tachyons_elm$Tachyons_Classes$pre_l = 'pre-l';
var _justgage$tachyons_elm$Tachyons_Classes$pre = 'pre';
var _justgage$tachyons_elm$Tachyons_Classes$pr7_ns = 'pr7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr7_m = 'pr7-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr7_l = 'pr7-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr7 = 'pr7';
var _justgage$tachyons_elm$Tachyons_Classes$pr6_ns = 'pr6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr6_m = 'pr6-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr6_l = 'pr6-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr6 = 'pr6';
var _justgage$tachyons_elm$Tachyons_Classes$pr5_ns = 'pr5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr5_m = 'pr5-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr5_l = 'pr5-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr5 = 'pr5';
var _justgage$tachyons_elm$Tachyons_Classes$pr4_ns = 'pr4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr4_m = 'pr4-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr4_l = 'pr4-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr4 = 'pr4';
var _justgage$tachyons_elm$Tachyons_Classes$pr3_ns = 'pr3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr3_m = 'pr3-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr3_l = 'pr3-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr3 = 'pr3';
var _justgage$tachyons_elm$Tachyons_Classes$pr2_ns = 'pr2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr2_m = 'pr2-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr2_l = 'pr2-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr2 = 'pr2';
var _justgage$tachyons_elm$Tachyons_Classes$pr1_ns = 'pr1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr1_m = 'pr1-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr1_l = 'pr1-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr1 = 'pr1';
var _justgage$tachyons_elm$Tachyons_Classes$pr0_ns = 'pr0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pr0_m = 'pr0-m';
var _justgage$tachyons_elm$Tachyons_Classes$pr0_l = 'pr0-l';
var _justgage$tachyons_elm$Tachyons_Classes$pr0 = 'pr0';
var _justgage$tachyons_elm$Tachyons_Classes$pointer = 'pointer';
var _justgage$tachyons_elm$Tachyons_Classes$pl7_ns = 'pl7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl7_m = 'pl7-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl7_l = 'pl7-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl7 = 'pl7';
var _justgage$tachyons_elm$Tachyons_Classes$pl6_ns = 'pl6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl6_m = 'pl6-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl6_l = 'pl6-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl6 = 'pl6';
var _justgage$tachyons_elm$Tachyons_Classes$pl5_ns = 'pl5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl5_m = 'pl5-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl5_l = 'pl5-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl5 = 'pl5';
var _justgage$tachyons_elm$Tachyons_Classes$pl4_ns = 'pl4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl4_m = 'pl4-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl4_l = 'pl4-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl4 = 'pl4';
var _justgage$tachyons_elm$Tachyons_Classes$pl3_ns = 'pl3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl3_m = 'pl3-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl3_l = 'pl3-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl3 = 'pl3';
var _justgage$tachyons_elm$Tachyons_Classes$pl2_ns = 'pl2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl2_m = 'pl2-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl2_l = 'pl2-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl2 = 'pl2';
var _justgage$tachyons_elm$Tachyons_Classes$pl1_ns = 'pl1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl1_m = 'pl1-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl1_l = 'pl1-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl1 = 'pl1';
var _justgage$tachyons_elm$Tachyons_Classes$pl0_ns = 'pl0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pl0_m = 'pl0-m';
var _justgage$tachyons_elm$Tachyons_Classes$pl0_l = 'pl0-l';
var _justgage$tachyons_elm$Tachyons_Classes$pl0 = 'pl0';
var _justgage$tachyons_elm$Tachyons_Classes$pink = 'pink';
var _justgage$tachyons_elm$Tachyons_Classes$ph7_ns = 'ph7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph7_m = 'ph7-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph7_l = 'ph7-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph7 = 'ph7';
var _justgage$tachyons_elm$Tachyons_Classes$ph6_ns = 'ph6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph6_m = 'ph6-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph6_l = 'ph6-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph6 = 'ph6';
var _justgage$tachyons_elm$Tachyons_Classes$ph5_ns = 'ph5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph5_m = 'ph5-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph5_l = 'ph5-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph5 = 'ph5';
var _justgage$tachyons_elm$Tachyons_Classes$ph4_ns = 'ph4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph4_m = 'ph4-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph4_l = 'ph4-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph4 = 'ph4';
var _justgage$tachyons_elm$Tachyons_Classes$ph3_ns = 'ph3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph3_m = 'ph3-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph3_l = 'ph3-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph3 = 'ph3';
var _justgage$tachyons_elm$Tachyons_Classes$ph2_ns = 'ph2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph2_m = 'ph2-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph2_l = 'ph2-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph2 = 'ph2';
var _justgage$tachyons_elm$Tachyons_Classes$ph1_ns = 'ph1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph1_m = 'ph1-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph1_l = 'ph1-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph1 = 'ph1';
var _justgage$tachyons_elm$Tachyons_Classes$ph0_ns = 'ph0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ph0_m = 'ph0-m';
var _justgage$tachyons_elm$Tachyons_Classes$ph0_l = 'ph0-l';
var _justgage$tachyons_elm$Tachyons_Classes$ph0 = 'ph0';
var _justgage$tachyons_elm$Tachyons_Classes$pb7_ns = 'pb7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb7_m = 'pb7-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb7_l = 'pb7-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb7 = 'pb7';
var _justgage$tachyons_elm$Tachyons_Classes$pb6_ns = 'pb6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb6_m = 'pb6-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb6_l = 'pb6-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb6 = 'pb6';
var _justgage$tachyons_elm$Tachyons_Classes$pb5_ns = 'pb5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb5_m = 'pb5-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb5_l = 'pb5-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb5 = 'pb5';
var _justgage$tachyons_elm$Tachyons_Classes$pb4_ns = 'pb4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb4_m = 'pb4-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb4_l = 'pb4-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb4 = 'pb4';
var _justgage$tachyons_elm$Tachyons_Classes$pb3_ns = 'pb3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb3_m = 'pb3-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb3_l = 'pb3-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb3 = 'pb3';
var _justgage$tachyons_elm$Tachyons_Classes$pb2_ns = 'pb2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb2_m = 'pb2-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb2_l = 'pb2-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb2 = 'pb2';
var _justgage$tachyons_elm$Tachyons_Classes$pb1_ns = 'pb1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb1_m = 'pb1-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb1_l = 'pb1-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb1 = 'pb1';
var _justgage$tachyons_elm$Tachyons_Classes$pb0_ns = 'pb0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pb0_m = 'pb0-m';
var _justgage$tachyons_elm$Tachyons_Classes$pb0_l = 'pb0-l';
var _justgage$tachyons_elm$Tachyons_Classes$pb0 = 'pb0';
var _justgage$tachyons_elm$Tachyons_Classes$pa7_ns = 'pa7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa7_m = 'pa7-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa7_l = 'pa7-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa7 = 'pa7';
var _justgage$tachyons_elm$Tachyons_Classes$pa6_ns = 'pa6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa6_m = 'pa6-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa6_l = 'pa6-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa6 = 'pa6';
var _justgage$tachyons_elm$Tachyons_Classes$pa5_ns = 'pa5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa5_m = 'pa5-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa5_l = 'pa5-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa5 = 'pa5';
var _justgage$tachyons_elm$Tachyons_Classes$pa4_ns = 'pa4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa4_m = 'pa4-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa4_l = 'pa4-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa4 = 'pa4';
var _justgage$tachyons_elm$Tachyons_Classes$pa3_ns = 'pa3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa3_m = 'pa3-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa3_l = 'pa3-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa3 = 'pa3';
var _justgage$tachyons_elm$Tachyons_Classes$pa2_ns = 'pa2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa2_m = 'pa2-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa2_l = 'pa2-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa2 = 'pa2';
var _justgage$tachyons_elm$Tachyons_Classes$pa1_ns = 'pa1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa1_m = 'pa1-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa1_l = 'pa1-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa1 = 'pa1';
var _justgage$tachyons_elm$Tachyons_Classes$pa0_ns = 'pa0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$pa0_m = 'pa0-m';
var _justgage$tachyons_elm$Tachyons_Classes$pa0_l = 'pa0-l';
var _justgage$tachyons_elm$Tachyons_Classes$pa0 = 'pa0';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_visible_ns = 'overflow-y-visible-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_visible_m = 'overflow-y-visible-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_visible_l = 'overflow-y-visible-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_visible = 'overflow-y-visible';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_scroll_ns = 'overflow-y-scroll-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_scroll_m = 'overflow-y-scroll-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_scroll_l = 'overflow-y-scroll-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_scroll = 'overflow-y-scroll';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_hidden_ns = 'overflow-y-hidden-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_hidden_m = 'overflow-y-hidden-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_hidden_l = 'overflow-y-hidden-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_hidden = 'overflow-y-hidden';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_auto_ns = 'overflow-y-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_auto_m = 'overflow-y-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_auto_l = 'overflow-y-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_y_auto = 'overflow-y-auto';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_visible_ns = 'overflow-x-visible-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_visible_m = 'overflow-x-visible-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_visible_l = 'overflow-x-visible-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_visible = 'overflow-x-visible';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_scroll_ns = 'overflow-x-scroll-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_scroll_m = 'overflow-x-scroll-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_scroll_l = 'overflow-x-scroll-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_scroll = 'overflow-x-scroll';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_hidden_ns = 'overflow-x-hidden-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_hidden_m = 'overflow-x-hidden-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_hidden_l = 'overflow-x-hidden-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_hidden = 'overflow-x-hidden';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_auto_ns = 'overflow-x-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_auto_m = 'overflow-x-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_auto_l = 'overflow-x-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_x_auto = 'overflow-x-auto';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_visible_ns = 'overflow-visible-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_visible_m = 'overflow-visible-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_visible_l = 'overflow-visible-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_visible = 'overflow-visible';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_scroll_ns = 'overflow-scroll-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_scroll_m = 'overflow-scroll-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_scroll_l = 'overflow-scroll-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_scroll = 'overflow-scroll';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_hidden_ns = 'overflow-hidden-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_hidden_m = 'overflow-hidden-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_hidden_l = 'overflow-hidden-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_hidden = 'overflow-hidden';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_container = 'overflow-container';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_auto_ns = 'overflow-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_auto_m = 'overflow-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_auto_l = 'overflow-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$overflow_auto = 'overflow-auto';
var _justgage$tachyons_elm$Tachyons_Classes$outline_transparent_ns = 'outline-transparent-ns';
var _justgage$tachyons_elm$Tachyons_Classes$outline_transparent_m = 'outline-transparent-m';
var _justgage$tachyons_elm$Tachyons_Classes$outline_transparent_l = 'outline-transparent-l';
var _justgage$tachyons_elm$Tachyons_Classes$outline_transparent = 'outline-transparent';
var _justgage$tachyons_elm$Tachyons_Classes$outline_ns = 'outline-ns';
var _justgage$tachyons_elm$Tachyons_Classes$outline_m = 'outline-m';
var _justgage$tachyons_elm$Tachyons_Classes$outline_l = 'outline-l';
var _justgage$tachyons_elm$Tachyons_Classes$outline_0_ns = 'outline-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$outline_0_m = 'outline-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$outline_0_l = 'outline-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$outline_0 = 'outline-0';
var _justgage$tachyons_elm$Tachyons_Classes$outline = 'outline';
var _justgage$tachyons_elm$Tachyons_Classes$order_last_ns = 'order-last-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_last_m = 'order-last-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_last_l = 'order-last-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_last = 'order-last';
var _justgage$tachyons_elm$Tachyons_Classes$order_8_ns = 'order-8-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_8_m = 'order-8-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_8_l = 'order-8-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_8 = 'order-8';
var _justgage$tachyons_elm$Tachyons_Classes$order_7_ns = 'order-7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_7_m = 'order-7-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_7_l = 'order-7-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_7 = 'order-7';
var _justgage$tachyons_elm$Tachyons_Classes$order_6_ns = 'order-6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_6_m = 'order-6-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_6_l = 'order-6-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_6 = 'order-6';
var _justgage$tachyons_elm$Tachyons_Classes$order_5_ns = 'order-5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_5_m = 'order-5-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_5_l = 'order-5-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_5 = 'order-5';
var _justgage$tachyons_elm$Tachyons_Classes$order_4_ns = 'order-4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_4_m = 'order-4-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_4_l = 'order-4-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_4 = 'order-4';
var _justgage$tachyons_elm$Tachyons_Classes$order_3_ns = 'order-3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_3_m = 'order-3-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_3_l = 'order-3-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_3 = 'order-3';
var _justgage$tachyons_elm$Tachyons_Classes$order_2_ns = 'order-2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_2_m = 'order-2-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_2_l = 'order-2-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_2 = 'order-2';
var _justgage$tachyons_elm$Tachyons_Classes$order_1_ns = 'order-1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_1_m = 'order-1-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_1_l = 'order-1-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_1 = 'order-1';
var _justgage$tachyons_elm$Tachyons_Classes$order_0_ns = 'order-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$order_0_m = 'order-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$order_0_l = 'order-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$order_0 = 'order-0';
var _justgage$tachyons_elm$Tachyons_Classes$orange = 'orange';
var _justgage$tachyons_elm$Tachyons_Classes$o_90 = 'o-90';
var _justgage$tachyons_elm$Tachyons_Classes$o_80 = 'o-80';
var _justgage$tachyons_elm$Tachyons_Classes$o_70 = 'o-70';
var _justgage$tachyons_elm$Tachyons_Classes$o_60 = 'o-60';
var _justgage$tachyons_elm$Tachyons_Classes$o_50 = 'o-50';
var _justgage$tachyons_elm$Tachyons_Classes$o_40 = 'o-40';
var _justgage$tachyons_elm$Tachyons_Classes$o_30 = 'o-30';
var _justgage$tachyons_elm$Tachyons_Classes$o_20 = 'o-20';
var _justgage$tachyons_elm$Tachyons_Classes$o_100 = 'o-100';
var _justgage$tachyons_elm$Tachyons_Classes$o_10 = 'o-10';
var _justgage$tachyons_elm$Tachyons_Classes$o_05 = 'o-05';
var _justgage$tachyons_elm$Tachyons_Classes$o_025 = 'o-025';
var _justgage$tachyons_elm$Tachyons_Classes$o_0 = 'o-0';
var _justgage$tachyons_elm$Tachyons_Classes$nt7_ns = 'nt7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nt7_m = 'nt7-m';
var _justgage$tachyons_elm$Tachyons_Classes$nt7_l = 'nt7-l';
var _justgage$tachyons_elm$Tachyons_Classes$nt7 = 'nt7';
var _justgage$tachyons_elm$Tachyons_Classes$nt6_ns = 'nt6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nt6_m = 'nt6-m';
var _justgage$tachyons_elm$Tachyons_Classes$nt6_l = 'nt6-l';
var _justgage$tachyons_elm$Tachyons_Classes$nt6 = 'nt6';
var _justgage$tachyons_elm$Tachyons_Classes$nt5_ns = 'nt5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nt5_m = 'nt5-m';
var _justgage$tachyons_elm$Tachyons_Classes$nt5_l = 'nt5-l';
var _justgage$tachyons_elm$Tachyons_Classes$nt5 = 'nt5';
var _justgage$tachyons_elm$Tachyons_Classes$nt4_ns = 'nt4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nt4_m = 'nt4-m';
var _justgage$tachyons_elm$Tachyons_Classes$nt4_l = 'nt4-l';
var _justgage$tachyons_elm$Tachyons_Classes$nt4 = 'nt4';
var _justgage$tachyons_elm$Tachyons_Classes$nt3_ns = 'nt3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nt3_m = 'nt3-m';
var _justgage$tachyons_elm$Tachyons_Classes$nt3_l = 'nt3-l';
var _justgage$tachyons_elm$Tachyons_Classes$nt3 = 'nt3';
var _justgage$tachyons_elm$Tachyons_Classes$nt2_ns = 'nt2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nt2_m = 'nt2-m';
var _justgage$tachyons_elm$Tachyons_Classes$nt2_l = 'nt2-l';
var _justgage$tachyons_elm$Tachyons_Classes$nt2 = 'nt2';
var _justgage$tachyons_elm$Tachyons_Classes$nt1_ns = 'nt1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nt1_m = 'nt1-m';
var _justgage$tachyons_elm$Tachyons_Classes$nt1_l = 'nt1-l';
var _justgage$tachyons_elm$Tachyons_Classes$nt1 = 'nt1';
var _justgage$tachyons_elm$Tachyons_Classes$nr7_ns = 'nr7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nr7_m = 'nr7-m';
var _justgage$tachyons_elm$Tachyons_Classes$nr7_l = 'nr7-l';
var _justgage$tachyons_elm$Tachyons_Classes$nr7 = 'nr7';
var _justgage$tachyons_elm$Tachyons_Classes$nr6_ns = 'nr6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nr6_m = 'nr6-m';
var _justgage$tachyons_elm$Tachyons_Classes$nr6_l = 'nr6-l';
var _justgage$tachyons_elm$Tachyons_Classes$nr6 = 'nr6';
var _justgage$tachyons_elm$Tachyons_Classes$nr5_ns = 'nr5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nr5_m = 'nr5-m';
var _justgage$tachyons_elm$Tachyons_Classes$nr5_l = 'nr5-l';
var _justgage$tachyons_elm$Tachyons_Classes$nr5 = 'nr5';
var _justgage$tachyons_elm$Tachyons_Classes$nr4_ns = 'nr4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nr4_m = 'nr4-m';
var _justgage$tachyons_elm$Tachyons_Classes$nr4_l = 'nr4-l';
var _justgage$tachyons_elm$Tachyons_Classes$nr4 = 'nr4';
var _justgage$tachyons_elm$Tachyons_Classes$nr3_ns = 'nr3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nr3_m = 'nr3-m';
var _justgage$tachyons_elm$Tachyons_Classes$nr3_l = 'nr3-l';
var _justgage$tachyons_elm$Tachyons_Classes$nr3 = 'nr3';
var _justgage$tachyons_elm$Tachyons_Classes$nr2_ns = 'nr2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nr2_m = 'nr2-m';
var _justgage$tachyons_elm$Tachyons_Classes$nr2_l = 'nr2-l';
var _justgage$tachyons_elm$Tachyons_Classes$nr2 = 'nr2';
var _justgage$tachyons_elm$Tachyons_Classes$nr1_ns = 'nr1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nr1_m = 'nr1-m';
var _justgage$tachyons_elm$Tachyons_Classes$nr1_l = 'nr1-l';
var _justgage$tachyons_elm$Tachyons_Classes$nr1 = 'nr1';
var _justgage$tachyons_elm$Tachyons_Classes$nowrap_ns = 'nowrap-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nowrap_m = 'nowrap-m';
var _justgage$tachyons_elm$Tachyons_Classes$nowrap_l = 'nowrap-l';
var _justgage$tachyons_elm$Tachyons_Classes$nowrap = 'nowrap';
var _justgage$tachyons_elm$Tachyons_Classes$normal_ns = 'normal-ns';
var _justgage$tachyons_elm$Tachyons_Classes$normal_m = 'normal-m';
var _justgage$tachyons_elm$Tachyons_Classes$normal_l = 'normal-l';
var _justgage$tachyons_elm$Tachyons_Classes$normal = 'normal';
var _justgage$tachyons_elm$Tachyons_Classes$no_underline_ns = 'no-underline-ns';
var _justgage$tachyons_elm$Tachyons_Classes$no_underline_m = 'no-underline-m';
var _justgage$tachyons_elm$Tachyons_Classes$no_underline_l = 'no-underline-l';
var _justgage$tachyons_elm$Tachyons_Classes$no_underline = 'no-underline';
var _justgage$tachyons_elm$Tachyons_Classes$nl7_ns = 'nl7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nl7_m = 'nl7-m';
var _justgage$tachyons_elm$Tachyons_Classes$nl7_l = 'nl7-l';
var _justgage$tachyons_elm$Tachyons_Classes$nl7 = 'nl7';
var _justgage$tachyons_elm$Tachyons_Classes$nl6_ns = 'nl6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nl6_m = 'nl6-m';
var _justgage$tachyons_elm$Tachyons_Classes$nl6_l = 'nl6-l';
var _justgage$tachyons_elm$Tachyons_Classes$nl6 = 'nl6';
var _justgage$tachyons_elm$Tachyons_Classes$nl5_ns = 'nl5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nl5_m = 'nl5-m';
var _justgage$tachyons_elm$Tachyons_Classes$nl5_l = 'nl5-l';
var _justgage$tachyons_elm$Tachyons_Classes$nl5 = 'nl5';
var _justgage$tachyons_elm$Tachyons_Classes$nl4_ns = 'nl4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nl4_m = 'nl4-m';
var _justgage$tachyons_elm$Tachyons_Classes$nl4_l = 'nl4-l';
var _justgage$tachyons_elm$Tachyons_Classes$nl4 = 'nl4';
var _justgage$tachyons_elm$Tachyons_Classes$nl3_ns = 'nl3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nl3_m = 'nl3-m';
var _justgage$tachyons_elm$Tachyons_Classes$nl3_l = 'nl3-l';
var _justgage$tachyons_elm$Tachyons_Classes$nl3 = 'nl3';
var _justgage$tachyons_elm$Tachyons_Classes$nl2_ns = 'nl2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nl2_m = 'nl2-m';
var _justgage$tachyons_elm$Tachyons_Classes$nl2_l = 'nl2-l';
var _justgage$tachyons_elm$Tachyons_Classes$nl2 = 'nl2';
var _justgage$tachyons_elm$Tachyons_Classes$nl1_ns = 'nl1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nl1_m = 'nl1-m';
var _justgage$tachyons_elm$Tachyons_Classes$nl1_l = 'nl1-l';
var _justgage$tachyons_elm$Tachyons_Classes$nl1 = 'nl1';
var _justgage$tachyons_elm$Tachyons_Classes$nested_list_reset = 'nested-list-reset';
var _justgage$tachyons_elm$Tachyons_Classes$nested_links = 'nested-links';
var _justgage$tachyons_elm$Tachyons_Classes$nested_img = 'nested-img';
var _justgage$tachyons_elm$Tachyons_Classes$nested_headline_line_height = 'nested-headline-line-height';
var _justgage$tachyons_elm$Tachyons_Classes$nested_copy_seperator = 'nested-copy-seperator';
var _justgage$tachyons_elm$Tachyons_Classes$nested_copy_line_height = 'nested-copy-line-height';
var _justgage$tachyons_elm$Tachyons_Classes$nested_copy_indent = 'nested-copy-indent';
var _justgage$tachyons_elm$Tachyons_Classes$near_white = 'near-white';
var _justgage$tachyons_elm$Tachyons_Classes$near_black = 'near-black';
var _justgage$tachyons_elm$Tachyons_Classes$nb7_ns = 'nb7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nb7_m = 'nb7-m';
var _justgage$tachyons_elm$Tachyons_Classes$nb7_l = 'nb7-l';
var _justgage$tachyons_elm$Tachyons_Classes$nb7 = 'nb7';
var _justgage$tachyons_elm$Tachyons_Classes$nb6_ns = 'nb6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nb6_m = 'nb6-m';
var _justgage$tachyons_elm$Tachyons_Classes$nb6_l = 'nb6-l';
var _justgage$tachyons_elm$Tachyons_Classes$nb6 = 'nb6';
var _justgage$tachyons_elm$Tachyons_Classes$nb5_ns = 'nb5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nb5_m = 'nb5-m';
var _justgage$tachyons_elm$Tachyons_Classes$nb5_l = 'nb5-l';
var _justgage$tachyons_elm$Tachyons_Classes$nb5 = 'nb5';
var _justgage$tachyons_elm$Tachyons_Classes$nb4_ns = 'nb4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nb4_m = 'nb4-m';
var _justgage$tachyons_elm$Tachyons_Classes$nb4_l = 'nb4-l';
var _justgage$tachyons_elm$Tachyons_Classes$nb4 = 'nb4';
var _justgage$tachyons_elm$Tachyons_Classes$nb3_ns = 'nb3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nb3_m = 'nb3-m';
var _justgage$tachyons_elm$Tachyons_Classes$nb3_l = 'nb3-l';
var _justgage$tachyons_elm$Tachyons_Classes$nb3 = 'nb3';
var _justgage$tachyons_elm$Tachyons_Classes$nb2_ns = 'nb2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nb2_m = 'nb2-m';
var _justgage$tachyons_elm$Tachyons_Classes$nb2_l = 'nb2-l';
var _justgage$tachyons_elm$Tachyons_Classes$nb2 = 'nb2';
var _justgage$tachyons_elm$Tachyons_Classes$nb1_ns = 'nb1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$nb1_m = 'nb1-m';
var _justgage$tachyons_elm$Tachyons_Classes$nb1_l = 'nb1-l';
var _justgage$tachyons_elm$Tachyons_Classes$nb1 = 'nb1';
var _justgage$tachyons_elm$Tachyons_Classes$navy = 'navy';
var _justgage$tachyons_elm$Tachyons_Classes$na7_ns = 'na7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$na7_m = 'na7-m';
var _justgage$tachyons_elm$Tachyons_Classes$na7_l = 'na7-l';
var _justgage$tachyons_elm$Tachyons_Classes$na7 = 'na7';
var _justgage$tachyons_elm$Tachyons_Classes$na6_ns = 'na6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$na6_m = 'na6-m';
var _justgage$tachyons_elm$Tachyons_Classes$na6_l = 'na6-l';
var _justgage$tachyons_elm$Tachyons_Classes$na6 = 'na6';
var _justgage$tachyons_elm$Tachyons_Classes$na5_ns = 'na5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$na5_m = 'na5-m';
var _justgage$tachyons_elm$Tachyons_Classes$na5_l = 'na5-l';
var _justgage$tachyons_elm$Tachyons_Classes$na5 = 'na5';
var _justgage$tachyons_elm$Tachyons_Classes$na4_ns = 'na4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$na4_m = 'na4-m';
var _justgage$tachyons_elm$Tachyons_Classes$na4_l = 'na4-l';
var _justgage$tachyons_elm$Tachyons_Classes$na4 = 'na4';
var _justgage$tachyons_elm$Tachyons_Classes$na3_ns = 'na3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$na3_m = 'na3-m';
var _justgage$tachyons_elm$Tachyons_Classes$na3_l = 'na3-l';
var _justgage$tachyons_elm$Tachyons_Classes$na3 = 'na3';
var _justgage$tachyons_elm$Tachyons_Classes$na2_ns = 'na2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$na2_m = 'na2-m';
var _justgage$tachyons_elm$Tachyons_Classes$na2_l = 'na2-l';
var _justgage$tachyons_elm$Tachyons_Classes$na2 = 'na2';
var _justgage$tachyons_elm$Tachyons_Classes$na1_ns = 'na1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$na1_m = 'na1-m';
var _justgage$tachyons_elm$Tachyons_Classes$na1_l = 'na1-l';
var _justgage$tachyons_elm$Tachyons_Classes$na1 = 'na1';
var _justgage$tachyons_elm$Tachyons_Classes$mw9_ns = 'mw9-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw9_m = 'mw9-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw9_l = 'mw9-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw9 = 'mw9';
var _justgage$tachyons_elm$Tachyons_Classes$mw8_ns = 'mw8-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw8_m = 'mw8-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw8_l = 'mw8-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw8 = 'mw8';
var _justgage$tachyons_elm$Tachyons_Classes$mw7_ns = 'mw7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw7_m = 'mw7-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw7_l = 'mw7-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw7 = 'mw7';
var _justgage$tachyons_elm$Tachyons_Classes$mw6_ns = 'mw6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw6_m = 'mw6-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw6_l = 'mw6-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw6 = 'mw6';
var _justgage$tachyons_elm$Tachyons_Classes$mw5_ns = 'mw5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw5_m = 'mw5-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw5_l = 'mw5-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw5 = 'mw5';
var _justgage$tachyons_elm$Tachyons_Classes$mw4_ns = 'mw4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw4_m = 'mw4-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw4_l = 'mw4-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw4 = 'mw4';
var _justgage$tachyons_elm$Tachyons_Classes$mw3_ns = 'mw3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw3_m = 'mw3-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw3_l = 'mw3-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw3 = 'mw3';
var _justgage$tachyons_elm$Tachyons_Classes$mw2_ns = 'mw2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw2_m = 'mw2-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw2_l = 'mw2-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw2 = 'mw2';
var _justgage$tachyons_elm$Tachyons_Classes$mw1_ns = 'mw1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw1_m = 'mw1-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw1_l = 'mw1-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw1 = 'mw1';
var _justgage$tachyons_elm$Tachyons_Classes$mw_none_ns = 'mw-none-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw_none_m = 'mw-none-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw_none_l = 'mw-none-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw_none = 'mw-none';
var _justgage$tachyons_elm$Tachyons_Classes$mw_100_ns = 'mw-100-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mw_100_m = 'mw-100-m';
var _justgage$tachyons_elm$Tachyons_Classes$mw_100_l = 'mw-100-l';
var _justgage$tachyons_elm$Tachyons_Classes$mw_100 = 'mw-100';
var _justgage$tachyons_elm$Tachyons_Classes$mv7_ns = 'mv7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv7_m = 'mv7-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv7_l = 'mv7-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv7 = 'mv7';
var _justgage$tachyons_elm$Tachyons_Classes$mv6_ns = 'mv6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv6_m = 'mv6-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv6_l = 'mv6-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv6 = 'mv6';
var _justgage$tachyons_elm$Tachyons_Classes$mv5_ns = 'mv5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv5_m = 'mv5-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv5_l = 'mv5-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv5 = 'mv5';
var _justgage$tachyons_elm$Tachyons_Classes$mv4_ns = 'mv4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv4_m = 'mv4-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv4_l = 'mv4-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv4 = 'mv4';
var _justgage$tachyons_elm$Tachyons_Classes$mv3_ns = 'mv3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv3_m = 'mv3-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv3_l = 'mv3-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv3 = 'mv3';
var _justgage$tachyons_elm$Tachyons_Classes$mv2_ns = 'mv2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv2_m = 'mv2-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv2_l = 'mv2-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv2 = 'mv2';
var _justgage$tachyons_elm$Tachyons_Classes$mv1_ns = 'mv1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv1_m = 'mv1-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv1_l = 'mv1-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv1 = 'mv1';
var _justgage$tachyons_elm$Tachyons_Classes$mv0_ns = 'mv0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mv0_m = 'mv0-m';
var _justgage$tachyons_elm$Tachyons_Classes$mv0_l = 'mv0-l';
var _justgage$tachyons_elm$Tachyons_Classes$mv0 = 'mv0';
var _justgage$tachyons_elm$Tachyons_Classes$mt7_ns = 'mt7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt7_m = 'mt7-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt7_l = 'mt7-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt7 = 'mt7';
var _justgage$tachyons_elm$Tachyons_Classes$mt6_ns = 'mt6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt6_m = 'mt6-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt6_l = 'mt6-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt6 = 'mt6';
var _justgage$tachyons_elm$Tachyons_Classes$mt5_ns = 'mt5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt5_m = 'mt5-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt5_l = 'mt5-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt5 = 'mt5';
var _justgage$tachyons_elm$Tachyons_Classes$mt4_ns = 'mt4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt4_m = 'mt4-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt4_l = 'mt4-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt4 = 'mt4';
var _justgage$tachyons_elm$Tachyons_Classes$mt3_ns = 'mt3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt3_m = 'mt3-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt3_l = 'mt3-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt3 = 'mt3';
var _justgage$tachyons_elm$Tachyons_Classes$mt2_ns = 'mt2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt2_m = 'mt2-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt2_l = 'mt2-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt2 = 'mt2';
var _justgage$tachyons_elm$Tachyons_Classes$mt1_ns = 'mt1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt1_m = 'mt1-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt1_l = 'mt1-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt1 = 'mt1';
var _justgage$tachyons_elm$Tachyons_Classes$mt0_ns = 'mt0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mt0_m = 'mt0-m';
var _justgage$tachyons_elm$Tachyons_Classes$mt0_l = 'mt0-l';
var _justgage$tachyons_elm$Tachyons_Classes$mt0 = 'mt0';
var _justgage$tachyons_elm$Tachyons_Classes$mr7_ns = 'mr7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr7_m = 'mr7-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr7_l = 'mr7-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr7 = 'mr7';
var _justgage$tachyons_elm$Tachyons_Classes$mr6_ns = 'mr6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr6_m = 'mr6-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr6_l = 'mr6-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr6 = 'mr6';
var _justgage$tachyons_elm$Tachyons_Classes$mr5_ns = 'mr5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr5_m = 'mr5-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr5_l = 'mr5-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr5 = 'mr5';
var _justgage$tachyons_elm$Tachyons_Classes$mr4_ns = 'mr4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr4_m = 'mr4-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr4_l = 'mr4-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr4 = 'mr4';
var _justgage$tachyons_elm$Tachyons_Classes$mr3_ns = 'mr3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr3_m = 'mr3-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr3_l = 'mr3-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr3 = 'mr3';
var _justgage$tachyons_elm$Tachyons_Classes$mr2_ns = 'mr2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr2_m = 'mr2-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr2_l = 'mr2-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr2 = 'mr2';
var _justgage$tachyons_elm$Tachyons_Classes$mr1_ns = 'mr1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr1_m = 'mr1-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr1_l = 'mr1-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr1 = 'mr1';
var _justgage$tachyons_elm$Tachyons_Classes$mr0_ns = 'mr0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr0_m = 'mr0-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr0_l = 'mr0-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr0 = 'mr0';
var _justgage$tachyons_elm$Tachyons_Classes$mr_auto_ns = 'mr-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mr_auto_m = 'mr-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$mr_auto_l = 'mr-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$mr_auto = 'mr-auto';
var _justgage$tachyons_elm$Tachyons_Classes$moon_gray = 'moon-gray';
var _justgage$tachyons_elm$Tachyons_Classes$ml7_ns = 'ml7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml7_m = 'ml7-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml7_l = 'ml7-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml7 = 'ml7';
var _justgage$tachyons_elm$Tachyons_Classes$ml6_ns = 'ml6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml6_m = 'ml6-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml6_l = 'ml6-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml6 = 'ml6';
var _justgage$tachyons_elm$Tachyons_Classes$ml5_ns = 'ml5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml5_m = 'ml5-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml5_l = 'ml5-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml5 = 'ml5';
var _justgage$tachyons_elm$Tachyons_Classes$ml4_ns = 'ml4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml4_m = 'ml4-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml4_l = 'ml4-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml4 = 'ml4';
var _justgage$tachyons_elm$Tachyons_Classes$ml3_ns = 'ml3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml3_m = 'ml3-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml3_l = 'ml3-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml3 = 'ml3';
var _justgage$tachyons_elm$Tachyons_Classes$ml2_ns = 'ml2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml2_m = 'ml2-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml2_l = 'ml2-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml2 = 'ml2';
var _justgage$tachyons_elm$Tachyons_Classes$ml1_ns = 'ml1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml1_m = 'ml1-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml1_l = 'ml1-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml1 = 'ml1';
var _justgage$tachyons_elm$Tachyons_Classes$ml0_ns = 'ml0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml0_m = 'ml0-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml0_l = 'ml0-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml0 = 'ml0';
var _justgage$tachyons_elm$Tachyons_Classes$ml_auto_ns = 'ml-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ml_auto_m = 'ml-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$ml_auto_l = 'ml-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$ml_auto = 'ml-auto';
var _justgage$tachyons_elm$Tachyons_Classes$min_vh_100_ns = 'min-vh-100-ns';
var _justgage$tachyons_elm$Tachyons_Classes$min_vh_100_m = 'min-vh-100-m';
var _justgage$tachyons_elm$Tachyons_Classes$min_vh_100_l = 'min-vh-100-l';
var _justgage$tachyons_elm$Tachyons_Classes$min_vh_100 = 'min-vh-100';
var _justgage$tachyons_elm$Tachyons_Classes$min_h_100_ns = 'min-h-100-ns';
var _justgage$tachyons_elm$Tachyons_Classes$min_h_100_m = 'min-h-100-m';
var _justgage$tachyons_elm$Tachyons_Classes$min_h_100_l = 'min-h-100-l';
var _justgage$tachyons_elm$Tachyons_Classes$min_h_100 = 'min-h-100';
var _justgage$tachyons_elm$Tachyons_Classes$mid_gray = 'mid-gray';
var _justgage$tachyons_elm$Tachyons_Classes$mh7_ns = 'mh7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh7_m = 'mh7-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh7_l = 'mh7-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh7 = 'mh7';
var _justgage$tachyons_elm$Tachyons_Classes$mh6_ns = 'mh6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh6_m = 'mh6-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh6_l = 'mh6-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh6 = 'mh6';
var _justgage$tachyons_elm$Tachyons_Classes$mh5_ns = 'mh5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh5_m = 'mh5-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh5_l = 'mh5-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh5 = 'mh5';
var _justgage$tachyons_elm$Tachyons_Classes$mh4_ns = 'mh4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh4_m = 'mh4-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh4_l = 'mh4-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh4 = 'mh4';
var _justgage$tachyons_elm$Tachyons_Classes$mh3_ns = 'mh3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh3_m = 'mh3-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh3_l = 'mh3-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh3 = 'mh3';
var _justgage$tachyons_elm$Tachyons_Classes$mh2_ns = 'mh2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh2_m = 'mh2-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh2_l = 'mh2-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh2 = 'mh2';
var _justgage$tachyons_elm$Tachyons_Classes$mh1_ns = 'mh1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh1_m = 'mh1-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh1_l = 'mh1-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh1 = 'mh1';
var _justgage$tachyons_elm$Tachyons_Classes$mh0_ns = 'mh0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mh0_m = 'mh0-m';
var _justgage$tachyons_elm$Tachyons_Classes$mh0_l = 'mh0-l';
var _justgage$tachyons_elm$Tachyons_Classes$mh0 = 'mh0';
var _justgage$tachyons_elm$Tachyons_Classes$measure_wide_ns = 'measure-wide-ns';
var _justgage$tachyons_elm$Tachyons_Classes$measure_wide_m = 'measure-wide-m';
var _justgage$tachyons_elm$Tachyons_Classes$measure_wide_l = 'measure-wide-l';
var _justgage$tachyons_elm$Tachyons_Classes$measure_wide = 'measure-wide';
var _justgage$tachyons_elm$Tachyons_Classes$measure_ns = 'measure-ns';
var _justgage$tachyons_elm$Tachyons_Classes$measure_narrow_ns = 'measure-narrow-ns';
var _justgage$tachyons_elm$Tachyons_Classes$measure_narrow_m = 'measure-narrow-m';
var _justgage$tachyons_elm$Tachyons_Classes$measure_narrow_l = 'measure-narrow-l';
var _justgage$tachyons_elm$Tachyons_Classes$measure_narrow = 'measure-narrow';
var _justgage$tachyons_elm$Tachyons_Classes$measure_m = 'measure-m';
var _justgage$tachyons_elm$Tachyons_Classes$measure_l = 'measure-l';
var _justgage$tachyons_elm$Tachyons_Classes$measure = 'measure';
var _justgage$tachyons_elm$Tachyons_Classes$mb7_ns = 'mb7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb7_m = 'mb7-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb7_l = 'mb7-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb7 = 'mb7';
var _justgage$tachyons_elm$Tachyons_Classes$mb6_ns = 'mb6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb6_m = 'mb6-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb6_l = 'mb6-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb6 = 'mb6';
var _justgage$tachyons_elm$Tachyons_Classes$mb5_ns = 'mb5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb5_m = 'mb5-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb5_l = 'mb5-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb5 = 'mb5';
var _justgage$tachyons_elm$Tachyons_Classes$mb4_ns = 'mb4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb4_m = 'mb4-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb4_l = 'mb4-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb4 = 'mb4';
var _justgage$tachyons_elm$Tachyons_Classes$mb3_ns = 'mb3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb3_m = 'mb3-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb3_l = 'mb3-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb3 = 'mb3';
var _justgage$tachyons_elm$Tachyons_Classes$mb2_ns = 'mb2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb2_m = 'mb2-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb2_l = 'mb2-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb2 = 'mb2';
var _justgage$tachyons_elm$Tachyons_Classes$mb1_ns = 'mb1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb1_m = 'mb1-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb1_l = 'mb1-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb1 = 'mb1';
var _justgage$tachyons_elm$Tachyons_Classes$mb0_ns = 'mb0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$mb0_m = 'mb0-m';
var _justgage$tachyons_elm$Tachyons_Classes$mb0_l = 'mb0-l';
var _justgage$tachyons_elm$Tachyons_Classes$mb0 = 'mb0';
var _justgage$tachyons_elm$Tachyons_Classes$ma7_ns = 'ma7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma7_m = 'ma7-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma7_l = 'ma7-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma7 = 'ma7';
var _justgage$tachyons_elm$Tachyons_Classes$ma6_ns = 'ma6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma6_m = 'ma6-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma6_l = 'ma6-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma6 = 'ma6';
var _justgage$tachyons_elm$Tachyons_Classes$ma5_ns = 'ma5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma5_m = 'ma5-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma5_l = 'ma5-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma5 = 'ma5';
var _justgage$tachyons_elm$Tachyons_Classes$ma4_ns = 'ma4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma4_m = 'ma4-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma4_l = 'ma4-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma4 = 'ma4';
var _justgage$tachyons_elm$Tachyons_Classes$ma3_ns = 'ma3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma3_m = 'ma3-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma3_l = 'ma3-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma3 = 'ma3';
var _justgage$tachyons_elm$Tachyons_Classes$ma2_ns = 'ma2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma2_m = 'ma2-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma2_l = 'ma2-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma2 = 'ma2';
var _justgage$tachyons_elm$Tachyons_Classes$ma1_ns = 'ma1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma1_m = 'ma1-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma1_l = 'ma1-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma1 = 'ma1';
var _justgage$tachyons_elm$Tachyons_Classes$ma0_ns = 'ma0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ma0_m = 'ma0-m';
var _justgage$tachyons_elm$Tachyons_Classes$ma0_l = 'ma0-l';
var _justgage$tachyons_elm$Tachyons_Classes$ma0 = 'ma0';
var _justgage$tachyons_elm$Tachyons_Classes$list = 'list';
var _justgage$tachyons_elm$Tachyons_Classes$link = 'link';
var _justgage$tachyons_elm$Tachyons_Classes$lightest_blue = 'lightest-blue';
var _justgage$tachyons_elm$Tachyons_Classes$light_yellow = 'light-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$light_silver = 'light-silver';
var _justgage$tachyons_elm$Tachyons_Classes$light_red = 'light-red';
var _justgage$tachyons_elm$Tachyons_Classes$light_purple = 'light-purple';
var _justgage$tachyons_elm$Tachyons_Classes$light_pink = 'light-pink';
var _justgage$tachyons_elm$Tachyons_Classes$light_green = 'light-green';
var _justgage$tachyons_elm$Tachyons_Classes$light_gray = 'light-gray';
var _justgage$tachyons_elm$Tachyons_Classes$light_blue = 'light-blue';
var _justgage$tachyons_elm$Tachyons_Classes$lh_title_ns = 'lh-title-ns';
var _justgage$tachyons_elm$Tachyons_Classes$lh_title_m = 'lh-title-m';
var _justgage$tachyons_elm$Tachyons_Classes$lh_title_l = 'lh-title-l';
var _justgage$tachyons_elm$Tachyons_Classes$lh_title = 'lh-title';
var _justgage$tachyons_elm$Tachyons_Classes$lh_solid_ns = 'lh-solid-ns';
var _justgage$tachyons_elm$Tachyons_Classes$lh_solid_m = 'lh-solid-m';
var _justgage$tachyons_elm$Tachyons_Classes$lh_solid_l = 'lh-solid-l';
var _justgage$tachyons_elm$Tachyons_Classes$lh_solid = 'lh-solid';
var _justgage$tachyons_elm$Tachyons_Classes$lh_copy_ns = 'lh-copy-ns';
var _justgage$tachyons_elm$Tachyons_Classes$lh_copy_m = 'lh-copy-m';
var _justgage$tachyons_elm$Tachyons_Classes$lh_copy_l = 'lh-copy-l';
var _justgage$tachyons_elm$Tachyons_Classes$lh_copy = 'lh-copy';
var _justgage$tachyons_elm$Tachyons_Classes$left_2_ns = 'left-2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$left_2_m = 'left-2-m';
var _justgage$tachyons_elm$Tachyons_Classes$left_2_l = 'left-2-l';
var _justgage$tachyons_elm$Tachyons_Classes$left_2 = 'left-2';
var _justgage$tachyons_elm$Tachyons_Classes$left_1_ns = 'left-1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$left_1_m = 'left-1-m';
var _justgage$tachyons_elm$Tachyons_Classes$left_1_l = 'left-1-l';
var _justgage$tachyons_elm$Tachyons_Classes$left_1 = 'left-1';
var _justgage$tachyons_elm$Tachyons_Classes$left_0_ns = 'left-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$left_0_m = 'left-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$left_0_l = 'left-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$left_0 = 'left-0';
var _justgage$tachyons_elm$Tachyons_Classes$left__2_ns = 'left--2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$left__2_m = 'left--2-m';
var _justgage$tachyons_elm$Tachyons_Classes$left__2_l = 'left--2-l';
var _justgage$tachyons_elm$Tachyons_Classes$left__2 = 'left--2';
var _justgage$tachyons_elm$Tachyons_Classes$left__1_ns = 'left--1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$left__1_m = 'left--1-m';
var _justgage$tachyons_elm$Tachyons_Classes$left__1_l = 'left--1-l';
var _justgage$tachyons_elm$Tachyons_Classes$left__1 = 'left--1';
var _justgage$tachyons_elm$Tachyons_Classes$justify_start_ns = 'justify-start-ns';
var _justgage$tachyons_elm$Tachyons_Classes$justify_start_m = 'justify-start-m';
var _justgage$tachyons_elm$Tachyons_Classes$justify_start_l = 'justify-start-l';
var _justgage$tachyons_elm$Tachyons_Classes$justify_start = 'justify-start';
var _justgage$tachyons_elm$Tachyons_Classes$justify_end_ns = 'justify-end-ns';
var _justgage$tachyons_elm$Tachyons_Classes$justify_end_m = 'justify-end-m';
var _justgage$tachyons_elm$Tachyons_Classes$justify_end_l = 'justify-end-l';
var _justgage$tachyons_elm$Tachyons_Classes$justify_end = 'justify-end';
var _justgage$tachyons_elm$Tachyons_Classes$justify_center_ns = 'justify-center-ns';
var _justgage$tachyons_elm$Tachyons_Classes$justify_center_m = 'justify-center-m';
var _justgage$tachyons_elm$Tachyons_Classes$justify_center_l = 'justify-center-l';
var _justgage$tachyons_elm$Tachyons_Classes$justify_center = 'justify-center';
var _justgage$tachyons_elm$Tachyons_Classes$justify_between_ns = 'justify-between-ns';
var _justgage$tachyons_elm$Tachyons_Classes$justify_between_m = 'justify-between-m';
var _justgage$tachyons_elm$Tachyons_Classes$justify_between_l = 'justify-between-l';
var _justgage$tachyons_elm$Tachyons_Classes$justify_between = 'justify-between';
var _justgage$tachyons_elm$Tachyons_Classes$justify_around_ns = 'justify-around-ns';
var _justgage$tachyons_elm$Tachyons_Classes$justify_around_m = 'justify-around-m';
var _justgage$tachyons_elm$Tachyons_Classes$justify_around_l = 'justify-around-l';
var _justgage$tachyons_elm$Tachyons_Classes$justify_around = 'justify-around';
var _justgage$tachyons_elm$Tachyons_Classes$items_stretch_ns = 'items-stretch-ns';
var _justgage$tachyons_elm$Tachyons_Classes$items_stretch_m = 'items-stretch-m';
var _justgage$tachyons_elm$Tachyons_Classes$items_stretch_l = 'items-stretch-l';
var _justgage$tachyons_elm$Tachyons_Classes$items_stretch = 'items-stretch';
var _justgage$tachyons_elm$Tachyons_Classes$items_start_ns = 'items-start-ns';
var _justgage$tachyons_elm$Tachyons_Classes$items_start_m = 'items-start-m';
var _justgage$tachyons_elm$Tachyons_Classes$items_start_l = 'items-start-l';
var _justgage$tachyons_elm$Tachyons_Classes$items_start = 'items-start';
var _justgage$tachyons_elm$Tachyons_Classes$items_end_ns = 'items-end-ns';
var _justgage$tachyons_elm$Tachyons_Classes$items_end_m = 'items-end-m';
var _justgage$tachyons_elm$Tachyons_Classes$items_end_l = 'items-end-l';
var _justgage$tachyons_elm$Tachyons_Classes$items_end = 'items-end';
var _justgage$tachyons_elm$Tachyons_Classes$items_center_ns = 'items-center-ns';
var _justgage$tachyons_elm$Tachyons_Classes$items_center_m = 'items-center-m';
var _justgage$tachyons_elm$Tachyons_Classes$items_center_l = 'items-center-l';
var _justgage$tachyons_elm$Tachyons_Classes$items_center = 'items-center';
var _justgage$tachyons_elm$Tachyons_Classes$items_baseline_ns = 'items-baseline-ns';
var _justgage$tachyons_elm$Tachyons_Classes$items_baseline_m = 'items-baseline-m';
var _justgage$tachyons_elm$Tachyons_Classes$items_baseline_l = 'items-baseline-l';
var _justgage$tachyons_elm$Tachyons_Classes$items_baseline = 'items-baseline';
var _justgage$tachyons_elm$Tachyons_Classes$input_reset = 'input-reset';
var _justgage$tachyons_elm$Tachyons_Classes$inline_flex_ns = 'inline-flex-ns';
var _justgage$tachyons_elm$Tachyons_Classes$inline_flex_m = 'inline-flex-m';
var _justgage$tachyons_elm$Tachyons_Classes$inline_flex_l = 'inline-flex-l';
var _justgage$tachyons_elm$Tachyons_Classes$inline_flex = 'inline-flex';
var _justgage$tachyons_elm$Tachyons_Classes$indent_ns = 'indent-ns';
var _justgage$tachyons_elm$Tachyons_Classes$indent_m = 'indent-m';
var _justgage$tachyons_elm$Tachyons_Classes$indent_l = 'indent-l';
var _justgage$tachyons_elm$Tachyons_Classes$indent = 'indent';
var _justgage$tachyons_elm$Tachyons_Classes$i_ns = 'i-ns';
var _justgage$tachyons_elm$Tachyons_Classes$i_m = 'i-m';
var _justgage$tachyons_elm$Tachyons_Classes$i_l = 'i-l';
var _justgage$tachyons_elm$Tachyons_Classes$i = 'i';
var _justgage$tachyons_elm$Tachyons_Classes$hover_yellow = 'hover-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_90 = 'hover-white-90';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_80 = 'hover-white-80';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_70 = 'hover-white-70';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_60 = 'hover-white-60';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_50 = 'hover-white-50';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_40 = 'hover-white-40';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_30 = 'hover-white-30';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_20 = 'hover-white-20';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white_10 = 'hover-white-10';
var _justgage$tachyons_elm$Tachyons_Classes$hover_white = 'hover-white';
var _justgage$tachyons_elm$Tachyons_Classes$hover_washed_yellow = 'hover-washed-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$hover_washed_red = 'hover-washed-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_washed_green = 'hover-washed-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_washed_blue = 'hover-washed-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_silver = 'hover-silver';
var _justgage$tachyons_elm$Tachyons_Classes$hover_red = 'hover-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_purple = 'hover-purple';
var _justgage$tachyons_elm$Tachyons_Classes$hover_pink = 'hover-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_orange = 'hover-orange';
var _justgage$tachyons_elm$Tachyons_Classes$hover_near_white = 'hover-near-white';
var _justgage$tachyons_elm$Tachyons_Classes$hover_near_black = 'hover-near-black';
var _justgage$tachyons_elm$Tachyons_Classes$hover_navy = 'hover-navy';
var _justgage$tachyons_elm$Tachyons_Classes$hover_moon_gray = 'hover-moon-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_mid_gray = 'hover-mid-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_lightest_blue = 'hover-lightest-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_yellow = 'hover-light-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_silver = 'hover-light-silver';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_red = 'hover-light-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_purple = 'hover-light-purple';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_pink = 'hover-light-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_green = 'hover-light-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_gray = 'hover-light-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_light_blue = 'hover-light-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_inherit = 'hover-inherit';
var _justgage$tachyons_elm$Tachyons_Classes$hover_hot_pink = 'hover-hot-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_green = 'hover-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_gray = 'hover-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_gold = 'hover-gold';
var _justgage$tachyons_elm$Tachyons_Classes$hover_dark_red = 'hover-dark-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_dark_pink = 'hover-dark-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_dark_green = 'hover-dark-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_dark_gray = 'hover-dark-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_dark_blue = 'hover-dark-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_blue = 'hover-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_90 = 'hover-black-90';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_80 = 'hover-black-80';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_70 = 'hover-black-70';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_60 = 'hover-black-60';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_50 = 'hover-black-50';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_40 = 'hover-black-40';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_30 = 'hover-black-30';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_20 = 'hover-black-20';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black_10 = 'hover-black-10';
var _justgage$tachyons_elm$Tachyons_Classes$hover_black = 'hover-black';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_yellow = 'hover-bg-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_90 = 'hover-bg-white-90';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_80 = 'hover-bg-white-80';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_70 = 'hover-bg-white-70';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_60 = 'hover-bg-white-60';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_50 = 'hover-bg-white-50';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_40 = 'hover-bg-white-40';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_30 = 'hover-bg-white-30';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_20 = 'hover-bg-white-20';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white_10 = 'hover-bg-white-10';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_white = 'hover-bg-white';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_washed_yellow = 'hover-bg-washed-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_washed_red = 'hover-bg-washed-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_washed_green = 'hover-bg-washed-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_washed_blue = 'hover-bg-washed-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_transparent = 'hover-bg-transparent';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_silver = 'hover-bg-silver';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_red = 'hover-bg-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_purple = 'hover-bg-purple';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_pink = 'hover-bg-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_orange = 'hover-bg-orange';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_near_white = 'hover-bg-near-white';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_near_black = 'hover-bg-near-black';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_navy = 'hover-bg-navy';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_moon_gray = 'hover-bg-moon-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_mid_gray = 'hover-bg-mid-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_lightest_blue = 'hover-bg-lightest-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_yellow = 'hover-bg-light-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_silver = 'hover-bg-light-silver';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_red = 'hover-bg-light-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_purple = 'hover-bg-light-purple';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_pink = 'hover-bg-light-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green = 'hover-bg-light-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_gray = 'hover-bg-light-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_blue = 'hover-bg-light-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_inherit = 'hover-bg-inherit';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_hot_pink = 'hover-bg-hot-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_green = 'hover-bg-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_gray = 'hover-bg-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_gold = 'hover-bg-gold';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_dark_red = 'hover-bg-dark-red';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_dark_pink = 'hover-bg-dark-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_dark_green = 'hover-bg-dark-green';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_dark_gray = 'hover-bg-dark-gray';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_dark_blue = 'hover-bg-dark-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_blue = 'hover-bg-blue';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_90 = 'hover-bg-black-90';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_80 = 'hover-bg-black-80';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_70 = 'hover-bg-black-70';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_60 = 'hover-bg-black-60';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_50 = 'hover-bg-black-50';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_40 = 'hover-bg-black-40';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_30 = 'hover-bg-black-30';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_20 = 'hover-bg-black-20';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black_10 = 'hover-bg-black-10';
var _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black = 'hover-bg-black';
var _justgage$tachyons_elm$Tachyons_Classes$hot_pink = 'hot-pink';
var _justgage$tachyons_elm$Tachyons_Classes$hide_child = 'hide-child';
var _justgage$tachyons_elm$Tachyons_Classes$helvetica = 'helvetica';
var _justgage$tachyons_elm$Tachyons_Classes$h5_ns = 'h5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h5_m = 'h5-m';
var _justgage$tachyons_elm$Tachyons_Classes$h5_l = 'h5-l';
var _justgage$tachyons_elm$Tachyons_Classes$h5 = 'h5';
var _justgage$tachyons_elm$Tachyons_Classes$h4_ns = 'h4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h4_m = 'h4-m';
var _justgage$tachyons_elm$Tachyons_Classes$h4_l = 'h4-l';
var _justgage$tachyons_elm$Tachyons_Classes$h4 = 'h4';
var _justgage$tachyons_elm$Tachyons_Classes$h3_ns = 'h3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h3_m = 'h3-m';
var _justgage$tachyons_elm$Tachyons_Classes$h3_l = 'h3-l';
var _justgage$tachyons_elm$Tachyons_Classes$h3 = 'h3';
var _justgage$tachyons_elm$Tachyons_Classes$h2_ns = 'h2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h2_m = 'h2-m';
var _justgage$tachyons_elm$Tachyons_Classes$h2_l = 'h2-l';
var _justgage$tachyons_elm$Tachyons_Classes$h2 = 'h2';
var _justgage$tachyons_elm$Tachyons_Classes$h1_ns = 'h1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h1_m = 'h1-m';
var _justgage$tachyons_elm$Tachyons_Classes$h1_l = 'h1-l';
var _justgage$tachyons_elm$Tachyons_Classes$h1 = 'h1';
var _justgage$tachyons_elm$Tachyons_Classes$h_inherit_ns = 'h-inherit-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h_inherit_m = 'h-inherit-m';
var _justgage$tachyons_elm$Tachyons_Classes$h_inherit_l = 'h-inherit-l';
var _justgage$tachyons_elm$Tachyons_Classes$h_inherit = 'h-inherit';
var _justgage$tachyons_elm$Tachyons_Classes$h_auto_ns = 'h-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h_auto_m = 'h-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$h_auto_l = 'h-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$h_auto = 'h-auto';
var _justgage$tachyons_elm$Tachyons_Classes$h_75_ns = 'h-75-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h_75_m = 'h-75-m';
var _justgage$tachyons_elm$Tachyons_Classes$h_75_l = 'h-75-l';
var _justgage$tachyons_elm$Tachyons_Classes$h_75 = 'h-75';
var _justgage$tachyons_elm$Tachyons_Classes$h_50_ns = 'h-50-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h_50_m = 'h-50-m';
var _justgage$tachyons_elm$Tachyons_Classes$h_50_l = 'h-50-l';
var _justgage$tachyons_elm$Tachyons_Classes$h_50 = 'h-50';
var _justgage$tachyons_elm$Tachyons_Classes$h_25_ns = 'h-25-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h_25_m = 'h-25-m';
var _justgage$tachyons_elm$Tachyons_Classes$h_25_l = 'h-25-l';
var _justgage$tachyons_elm$Tachyons_Classes$h_25 = 'h-25';
var _justgage$tachyons_elm$Tachyons_Classes$h_100_ns = 'h-100-ns';
var _justgage$tachyons_elm$Tachyons_Classes$h_100_m = 'h-100-m';
var _justgage$tachyons_elm$Tachyons_Classes$h_100_l = 'h-100-l';
var _justgage$tachyons_elm$Tachyons_Classes$h_100 = 'h-100';
var _justgage$tachyons_elm$Tachyons_Classes$grow_large = 'grow-large';
var _justgage$tachyons_elm$Tachyons_Classes$grow = 'grow';
var _justgage$tachyons_elm$Tachyons_Classes$green = 'green';
var _justgage$tachyons_elm$Tachyons_Classes$gray = 'gray';
var _justgage$tachyons_elm$Tachyons_Classes$gold = 'gold';
var _justgage$tachyons_elm$Tachyons_Classes$glow = 'glow';
var _justgage$tachyons_elm$Tachyons_Classes$georgia = 'georgia';
var _justgage$tachyons_elm$Tachyons_Classes$garamond = 'garamond';
var _justgage$tachyons_elm$Tachyons_Classes$fw9_ns = 'fw9-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw9_m = 'fw9-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw9_l = 'fw9-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw9 = 'fw9';
var _justgage$tachyons_elm$Tachyons_Classes$fw8_ns = 'fw8-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw8_m = 'fw8-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw8_l = 'fw8-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw8 = 'fw8';
var _justgage$tachyons_elm$Tachyons_Classes$fw7_ns = 'fw7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw7_m = 'fw7-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw7_l = 'fw7-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw7 = 'fw7';
var _justgage$tachyons_elm$Tachyons_Classes$fw6_ns = 'fw6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw6_m = 'fw6-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw6_l = 'fw6-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw6 = 'fw6';
var _justgage$tachyons_elm$Tachyons_Classes$fw5_ns = 'fw5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw5_m = 'fw5-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw5_l = 'fw5-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw5 = 'fw5';
var _justgage$tachyons_elm$Tachyons_Classes$fw4_ns = 'fw4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw4_m = 'fw4-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw4_l = 'fw4-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw4 = 'fw4';
var _justgage$tachyons_elm$Tachyons_Classes$fw3_ns = 'fw3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw3_m = 'fw3-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw3_l = 'fw3-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw3 = 'fw3';
var _justgage$tachyons_elm$Tachyons_Classes$fw2_ns = 'fw2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw2_m = 'fw2-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw2_l = 'fw2-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw2 = 'fw2';
var _justgage$tachyons_elm$Tachyons_Classes$fw1_ns = 'fw1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fw1_m = 'fw1-m';
var _justgage$tachyons_elm$Tachyons_Classes$fw1_l = 'fw1-l';
var _justgage$tachyons_elm$Tachyons_Classes$fw1 = 'fw1';
var _justgage$tachyons_elm$Tachyons_Classes$fs_normal_ns = 'fs-normal-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fs_normal_m = 'fs-normal-m';
var _justgage$tachyons_elm$Tachyons_Classes$fs_normal_l = 'fs-normal-l';
var _justgage$tachyons_elm$Tachyons_Classes$fs_normal = 'fs-normal';
var _justgage$tachyons_elm$Tachyons_Classes$fr_ns = 'fr-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fr_m = 'fr-m';
var _justgage$tachyons_elm$Tachyons_Classes$fr_l = 'fr-l';
var _justgage$tachyons_elm$Tachyons_Classes$fr = 'fr';
var _justgage$tachyons_elm$Tachyons_Classes$fn_ns = 'fn-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fn_m = 'fn-m';
var _justgage$tachyons_elm$Tachyons_Classes$fn_l = 'fn-l';
var _justgage$tachyons_elm$Tachyons_Classes$fn = 'fn';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap_reverse_ns = 'flex-wrap-reverse-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap_reverse_m = 'flex-wrap-reverse-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap_reverse_l = 'flex-wrap-reverse-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap_reverse = 'flex-wrap-reverse';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap_ns = 'flex-wrap-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap_m = 'flex-wrap-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap_l = 'flex-wrap-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_wrap = 'flex-wrap';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row_reverse_ns = 'flex-row-reverse-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row_reverse_m = 'flex-row-reverse-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row_reverse_l = 'flex-row-reverse-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row_reverse = 'flex-row-reverse';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row_ns = 'flex-row-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row_m = 'flex-row-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row_l = 'flex-row-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_row = 'flex-row';
var _justgage$tachyons_elm$Tachyons_Classes$flex_ns = 'flex-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_nowrap_ns = 'flex-nowrap-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_nowrap_m = 'flex-nowrap-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_nowrap_l = 'flex-nowrap-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_nowrap = 'flex-nowrap';
var _justgage$tachyons_elm$Tachyons_Classes$flex_none_ns = 'flex-none-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_none_m = 'flex-none-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_none_l = 'flex-none-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_none = 'flex-none';
var _justgage$tachyons_elm$Tachyons_Classes$flex_m = 'flex-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_l = 'flex-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column_reverse_ns = 'flex-column-reverse-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column_reverse_m = 'flex-column-reverse-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column_reverse_l = 'flex-column-reverse-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column_reverse = 'flex-column-reverse';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column_ns = 'flex-column-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column_m = 'flex-column-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column_l = 'flex-column-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_column = 'flex-column';
var _justgage$tachyons_elm$Tachyons_Classes$flex_auto_ns = 'flex-auto-ns';
var _justgage$tachyons_elm$Tachyons_Classes$flex_auto_m = 'flex-auto-m';
var _justgage$tachyons_elm$Tachyons_Classes$flex_auto_l = 'flex-auto-l';
var _justgage$tachyons_elm$Tachyons_Classes$flex_auto = 'flex-auto';
var _justgage$tachyons_elm$Tachyons_Classes$flex = 'flex';
var _justgage$tachyons_elm$Tachyons_Classes$fl_ns = 'fl-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fl_m = 'fl-m';
var _justgage$tachyons_elm$Tachyons_Classes$fl_l = 'fl-l';
var _justgage$tachyons_elm$Tachyons_Classes$fl = 'fl';
var _justgage$tachyons_elm$Tachyons_Classes$fixed_ns = 'fixed-ns';
var _justgage$tachyons_elm$Tachyons_Classes$fixed_m = 'fixed-m';
var _justgage$tachyons_elm$Tachyons_Classes$fixed_l = 'fixed-l';
var _justgage$tachyons_elm$Tachyons_Classes$fixed = 'fixed';
var _justgage$tachyons_elm$Tachyons_Classes$f7_ns = 'f7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f7_m = 'f7-m';
var _justgage$tachyons_elm$Tachyons_Classes$f7_l = 'f7-l';
var _justgage$tachyons_elm$Tachyons_Classes$f7 = 'f7';
var _justgage$tachyons_elm$Tachyons_Classes$f6_ns = 'f6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f6_m = 'f6-m';
var _justgage$tachyons_elm$Tachyons_Classes$f6_l = 'f6-l';
var _justgage$tachyons_elm$Tachyons_Classes$f6 = 'f6';
var _justgage$tachyons_elm$Tachyons_Classes$f5_ns = 'f5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f5_m = 'f5-m';
var _justgage$tachyons_elm$Tachyons_Classes$f5_l = 'f5-l';
var _justgage$tachyons_elm$Tachyons_Classes$f5 = 'f5';
var _justgage$tachyons_elm$Tachyons_Classes$f4_ns = 'f4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f4_m = 'f4-m';
var _justgage$tachyons_elm$Tachyons_Classes$f4_l = 'f4-l';
var _justgage$tachyons_elm$Tachyons_Classes$f4 = 'f4';
var _justgage$tachyons_elm$Tachyons_Classes$f3_ns = 'f3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f3_m = 'f3-m';
var _justgage$tachyons_elm$Tachyons_Classes$f3_l = 'f3-l';
var _justgage$tachyons_elm$Tachyons_Classes$f3 = 'f3';
var _justgage$tachyons_elm$Tachyons_Classes$f2_ns = 'f2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f2_m = 'f2-m';
var _justgage$tachyons_elm$Tachyons_Classes$f2_l = 'f2-l';
var _justgage$tachyons_elm$Tachyons_Classes$f2 = 'f2';
var _justgage$tachyons_elm$Tachyons_Classes$f1_ns = 'f1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f1_m = 'f1-m';
var _justgage$tachyons_elm$Tachyons_Classes$f1_l = 'f1-l';
var _justgage$tachyons_elm$Tachyons_Classes$f1 = 'f1';
var _justgage$tachyons_elm$Tachyons_Classes$f_subheadline_ns = 'f-subheadline-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f_subheadline_m = 'f-subheadline-m';
var _justgage$tachyons_elm$Tachyons_Classes$f_subheadline_l = 'f-subheadline-l';
var _justgage$tachyons_elm$Tachyons_Classes$f_subheadline = 'f-subheadline';
var _justgage$tachyons_elm$Tachyons_Classes$f_headline_ns = 'f-headline-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f_headline_m = 'f-headline-m';
var _justgage$tachyons_elm$Tachyons_Classes$f_headline_l = 'f-headline-l';
var _justgage$tachyons_elm$Tachyons_Classes$f_headline = 'f-headline';
var _justgage$tachyons_elm$Tachyons_Classes$f_6_ns = 'f-6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f_6_m = 'f-6-m';
var _justgage$tachyons_elm$Tachyons_Classes$f_6_l = 'f-6-l';
var _justgage$tachyons_elm$Tachyons_Classes$f_6 = 'f-6';
var _justgage$tachyons_elm$Tachyons_Classes$f_5_ns = 'f-5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$f_5_m = 'f-5-m';
var _justgage$tachyons_elm$Tachyons_Classes$f_5_l = 'f-5-l';
var _justgage$tachyons_elm$Tachyons_Classes$f_5 = 'f-5';
var _justgage$tachyons_elm$Tachyons_Classes$dtc_ns = 'dtc-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dtc_m = 'dtc-m';
var _justgage$tachyons_elm$Tachyons_Classes$dtc_l = 'dtc-l';
var _justgage$tachyons_elm$Tachyons_Classes$dtc = 'dtc';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row_ns = 'dt-row-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row_m = 'dt-row-m';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row_l = 'dt-row-l';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row_group_ns = 'dt-row-group-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row_group_m = 'dt-row-group-m';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row_group_l = 'dt-row-group-l';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row_group = 'dt-row-group';
var _justgage$tachyons_elm$Tachyons_Classes$dt_row = 'dt-row';
var _justgage$tachyons_elm$Tachyons_Classes$dt_ns = 'dt-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dt_m = 'dt-m';
var _justgage$tachyons_elm$Tachyons_Classes$dt_l = 'dt-l';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column_ns = 'dt-column-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column_m = 'dt-column-m';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column_l = 'dt-column-l';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column_group_ns = 'dt-column-group-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column_group_m = 'dt-column-group-m';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column_group_l = 'dt-column-group-l';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column_group = 'dt-column-group';
var _justgage$tachyons_elm$Tachyons_Classes$dt_column = 'dt-column';
var _justgage$tachyons_elm$Tachyons_Classes$dt__fixed_ns = 'dt--fixed-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dt__fixed_m = 'dt--fixed-m';
var _justgage$tachyons_elm$Tachyons_Classes$dt__fixed_l = 'dt--fixed-l';
var _justgage$tachyons_elm$Tachyons_Classes$dt__fixed = 'dt--fixed';
var _justgage$tachyons_elm$Tachyons_Classes$dt = 'dt';
var _justgage$tachyons_elm$Tachyons_Classes$dn_ns = 'dn-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dn_m = 'dn-m';
var _justgage$tachyons_elm$Tachyons_Classes$dn_l = 'dn-l';
var _justgage$tachyons_elm$Tachyons_Classes$dn = 'dn';
var _justgage$tachyons_elm$Tachyons_Classes$dit_ns = 'dit-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dit_m = 'dit-m';
var _justgage$tachyons_elm$Tachyons_Classes$dit_l = 'dit-l';
var _justgage$tachyons_elm$Tachyons_Classes$dit = 'dit';
var _justgage$tachyons_elm$Tachyons_Classes$dim = 'dim';
var _justgage$tachyons_elm$Tachyons_Classes$dib_ns = 'dib-ns';
var _justgage$tachyons_elm$Tachyons_Classes$dib_m = 'dib-m';
var _justgage$tachyons_elm$Tachyons_Classes$dib_l = 'dib-l';
var _justgage$tachyons_elm$Tachyons_Classes$dib = 'dib';
var _justgage$tachyons_elm$Tachyons_Classes$di_ns = 'di-ns';
var _justgage$tachyons_elm$Tachyons_Classes$di_m = 'di-m';
var _justgage$tachyons_elm$Tachyons_Classes$di_l = 'di-l';
var _justgage$tachyons_elm$Tachyons_Classes$di = 'di';
var _justgage$tachyons_elm$Tachyons_Classes$debug_white = 'debug-white';
var _justgage$tachyons_elm$Tachyons_Classes$debug_grid_8_solid = 'debug-grid-8-solid';
var _justgage$tachyons_elm$Tachyons_Classes$debug_grid_16_solid = 'debug-grid-16-solid';
var _justgage$tachyons_elm$Tachyons_Classes$debug_grid_16 = 'debug-grid-16';
var _justgage$tachyons_elm$Tachyons_Classes$debug_grid = 'debug-grid';
var _justgage$tachyons_elm$Tachyons_Classes$debug_black = 'debug-black';
var _justgage$tachyons_elm$Tachyons_Classes$debug = 'debug';
var _justgage$tachyons_elm$Tachyons_Classes$db_ns = 'db-ns';
var _justgage$tachyons_elm$Tachyons_Classes$db_m = 'db-m';
var _justgage$tachyons_elm$Tachyons_Classes$db_l = 'db-l';
var _justgage$tachyons_elm$Tachyons_Classes$db = 'db';
var _justgage$tachyons_elm$Tachyons_Classes$dark_red = 'dark-red';
var _justgage$tachyons_elm$Tachyons_Classes$dark_pink = 'dark-pink';
var _justgage$tachyons_elm$Tachyons_Classes$dark_green = 'dark-green';
var _justgage$tachyons_elm$Tachyons_Classes$dark_gray = 'dark-gray';
var _justgage$tachyons_elm$Tachyons_Classes$dark_blue = 'dark-blue';
var _justgage$tachyons_elm$Tachyons_Classes$cr_ns = 'cr-ns';
var _justgage$tachyons_elm$Tachyons_Classes$cr_m = 'cr-m';
var _justgage$tachyons_elm$Tachyons_Classes$cr_l = 'cr-l';
var _justgage$tachyons_elm$Tachyons_Classes$cr = 'cr';
var _justgage$tachyons_elm$Tachyons_Classes$cover_ns = 'cover-ns';
var _justgage$tachyons_elm$Tachyons_Classes$cover_m = 'cover-m';
var _justgage$tachyons_elm$Tachyons_Classes$cover_l = 'cover-l';
var _justgage$tachyons_elm$Tachyons_Classes$cover = 'cover';
var _justgage$tachyons_elm$Tachyons_Classes$courier = 'courier';
var _justgage$tachyons_elm$Tachyons_Classes$content_stretch_ns = 'content-stretch-ns';
var _justgage$tachyons_elm$Tachyons_Classes$content_stretch_m = 'content-stretch-m';
var _justgage$tachyons_elm$Tachyons_Classes$content_stretch_l = 'content-stretch-l';
var _justgage$tachyons_elm$Tachyons_Classes$content_stretch = 'content-stretch';
var _justgage$tachyons_elm$Tachyons_Classes$content_start_ns = 'content-start-ns';
var _justgage$tachyons_elm$Tachyons_Classes$content_start_m = 'content-start-m';
var _justgage$tachyons_elm$Tachyons_Classes$content_start_l = 'content-start-l';
var _justgage$tachyons_elm$Tachyons_Classes$content_start = 'content-start';
var _justgage$tachyons_elm$Tachyons_Classes$content_end_ns = 'content-end-ns';
var _justgage$tachyons_elm$Tachyons_Classes$content_end_m = 'content-end-m';
var _justgage$tachyons_elm$Tachyons_Classes$content_end_l = 'content-end-l';
var _justgage$tachyons_elm$Tachyons_Classes$content_end = 'content-end';
var _justgage$tachyons_elm$Tachyons_Classes$content_center_ns = 'content-center-ns';
var _justgage$tachyons_elm$Tachyons_Classes$content_center_m = 'content-center-m';
var _justgage$tachyons_elm$Tachyons_Classes$content_center_l = 'content-center-l';
var _justgage$tachyons_elm$Tachyons_Classes$content_center = 'content-center';
var _justgage$tachyons_elm$Tachyons_Classes$content_between_ns = 'content-between-ns';
var _justgage$tachyons_elm$Tachyons_Classes$content_between_m = 'content-between-m';
var _justgage$tachyons_elm$Tachyons_Classes$content_between_l = 'content-between-l';
var _justgage$tachyons_elm$Tachyons_Classes$content_between = 'content-between';
var _justgage$tachyons_elm$Tachyons_Classes$content_around_ns = 'content-around-ns';
var _justgage$tachyons_elm$Tachyons_Classes$content_around_m = 'content-around-m';
var _justgage$tachyons_elm$Tachyons_Classes$content_around_l = 'content-around-l';
var _justgage$tachyons_elm$Tachyons_Classes$content_around = 'content-around';
var _justgage$tachyons_elm$Tachyons_Classes$contain_ns = 'contain-ns';
var _justgage$tachyons_elm$Tachyons_Classes$contain_m = 'contain-m';
var _justgage$tachyons_elm$Tachyons_Classes$contain_l = 'contain-l';
var _justgage$tachyons_elm$Tachyons_Classes$contain = 'contain';
var _justgage$tachyons_elm$Tachyons_Classes$color_inherit = 'color-inherit';
var _justgage$tachyons_elm$Tachyons_Classes$collapse = 'collapse';
var _justgage$tachyons_elm$Tachyons_Classes$code = 'code';
var _justgage$tachyons_elm$Tachyons_Classes$cn_ns = 'cn-ns';
var _justgage$tachyons_elm$Tachyons_Classes$cn_m = 'cn-m';
var _justgage$tachyons_elm$Tachyons_Classes$cn_l = 'cn-l';
var _justgage$tachyons_elm$Tachyons_Classes$cn = 'cn';
var _justgage$tachyons_elm$Tachyons_Classes$clip_ns = 'clip-ns';
var _justgage$tachyons_elm$Tachyons_Classes$clip_m = 'clip-m';
var _justgage$tachyons_elm$Tachyons_Classes$clip_l = 'clip-l';
var _justgage$tachyons_elm$Tachyons_Classes$clip = 'clip';
var _justgage$tachyons_elm$Tachyons_Classes$cl_ns = 'cl-ns';
var _justgage$tachyons_elm$Tachyons_Classes$cl_m = 'cl-m';
var _justgage$tachyons_elm$Tachyons_Classes$cl_l = 'cl-l';
var _justgage$tachyons_elm$Tachyons_Classes$cl = 'cl';
var _justgage$tachyons_elm$Tachyons_Classes$child = 'child';
var _justgage$tachyons_elm$Tachyons_Classes$cf = 'cf';
var _justgage$tachyons_elm$Tachyons_Classes$center_ns = 'center-ns';
var _justgage$tachyons_elm$Tachyons_Classes$center_m = 'center-m';
var _justgage$tachyons_elm$Tachyons_Classes$center_l = 'center-l';
var _justgage$tachyons_elm$Tachyons_Classes$center = 'center';
var _justgage$tachyons_elm$Tachyons_Classes$cb_ns = 'cb-ns';
var _justgage$tachyons_elm$Tachyons_Classes$cb_m = 'cb-m';
var _justgage$tachyons_elm$Tachyons_Classes$cb_l = 'cb-l';
var _justgage$tachyons_elm$Tachyons_Classes$cb = 'cb';
var _justgage$tachyons_elm$Tachyons_Classes$calisto = 'calisto';
var _justgage$tachyons_elm$Tachyons_Classes$bw5_ns = 'bw5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bw5_m = 'bw5-m';
var _justgage$tachyons_elm$Tachyons_Classes$bw5_l = 'bw5-l';
var _justgage$tachyons_elm$Tachyons_Classes$bw5 = 'bw5';
var _justgage$tachyons_elm$Tachyons_Classes$bw4_ns = 'bw4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bw4_m = 'bw4-m';
var _justgage$tachyons_elm$Tachyons_Classes$bw4_l = 'bw4-l';
var _justgage$tachyons_elm$Tachyons_Classes$bw4 = 'bw4';
var _justgage$tachyons_elm$Tachyons_Classes$bw3_ns = 'bw3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bw3_m = 'bw3-m';
var _justgage$tachyons_elm$Tachyons_Classes$bw3_l = 'bw3-l';
var _justgage$tachyons_elm$Tachyons_Classes$bw3 = 'bw3';
var _justgage$tachyons_elm$Tachyons_Classes$bw2_ns = 'bw2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bw2_m = 'bw2-m';
var _justgage$tachyons_elm$Tachyons_Classes$bw2_l = 'bw2-l';
var _justgage$tachyons_elm$Tachyons_Classes$bw2 = 'bw2';
var _justgage$tachyons_elm$Tachyons_Classes$bw1_ns = 'bw1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bw1_m = 'bw1-m';
var _justgage$tachyons_elm$Tachyons_Classes$bw1_l = 'bw1-l';
var _justgage$tachyons_elm$Tachyons_Classes$bw1 = 'bw1';
var _justgage$tachyons_elm$Tachyons_Classes$bw0_ns = 'bw0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bw0_m = 'bw0-m';
var _justgage$tachyons_elm$Tachyons_Classes$bw0_l = 'bw0-l';
var _justgage$tachyons_elm$Tachyons_Classes$bw0 = 'bw0';
var _justgage$tachyons_elm$Tachyons_Classes$button_reset = 'button-reset';
var _justgage$tachyons_elm$Tachyons_Classes$bt_ns = 'bt-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bt_m = 'bt-m';
var _justgage$tachyons_elm$Tachyons_Classes$bt_l = 'bt-l';
var _justgage$tachyons_elm$Tachyons_Classes$bt_0_ns = 'bt-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bt_0_m = 'bt-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$bt_0_l = 'bt-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$bt_0 = 'bt-0';
var _justgage$tachyons_elm$Tachyons_Classes$bt = 'bt';
var _justgage$tachyons_elm$Tachyons_Classes$br4_ns = 'br4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br4_m = 'br4-m';
var _justgage$tachyons_elm$Tachyons_Classes$br4_l = 'br4-l';
var _justgage$tachyons_elm$Tachyons_Classes$br4 = 'br4';
var _justgage$tachyons_elm$Tachyons_Classes$br3_ns = 'br3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br3_m = 'br3-m';
var _justgage$tachyons_elm$Tachyons_Classes$br3_l = 'br3-l';
var _justgage$tachyons_elm$Tachyons_Classes$br3 = 'br3';
var _justgage$tachyons_elm$Tachyons_Classes$br2_ns = 'br2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br2_m = 'br2-m';
var _justgage$tachyons_elm$Tachyons_Classes$br2_l = 'br2-l';
var _justgage$tachyons_elm$Tachyons_Classes$br2 = 'br2';
var _justgage$tachyons_elm$Tachyons_Classes$br1_ns = 'br1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br1_m = 'br1-m';
var _justgage$tachyons_elm$Tachyons_Classes$br1_l = 'br1-l';
var _justgage$tachyons_elm$Tachyons_Classes$br1 = 'br1';
var _justgage$tachyons_elm$Tachyons_Classes$br0_ns = 'br0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br0_m = 'br0-m';
var _justgage$tachyons_elm$Tachyons_Classes$br0_l = 'br0-l';
var _justgage$tachyons_elm$Tachyons_Classes$br0 = 'br0';
var _justgage$tachyons_elm$Tachyons_Classes$br_pill_ns = 'br-pill-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br_pill_m = 'br-pill-m';
var _justgage$tachyons_elm$Tachyons_Classes$br_pill_l = 'br-pill-l';
var _justgage$tachyons_elm$Tachyons_Classes$br_pill = 'br-pill';
var _justgage$tachyons_elm$Tachyons_Classes$br_ns = 'br-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br_m = 'br-m';
var _justgage$tachyons_elm$Tachyons_Classes$br_l = 'br-l';
var _justgage$tachyons_elm$Tachyons_Classes$br_100_ns = 'br-100-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br_100_m = 'br-100-m';
var _justgage$tachyons_elm$Tachyons_Classes$br_100_l = 'br-100-l';
var _justgage$tachyons_elm$Tachyons_Classes$br_100 = 'br-100';
var _justgage$tachyons_elm$Tachyons_Classes$br_0_ns = 'br-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br_0_m = 'br-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$br_0_l = 'br-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$br_0 = 'br-0';
var _justgage$tachyons_elm$Tachyons_Classes$br__top_ns = 'br--top-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br__top_m = 'br--top-m';
var _justgage$tachyons_elm$Tachyons_Classes$br__top_l = 'br--top-l';
var _justgage$tachyons_elm$Tachyons_Classes$br__top = 'br--top';
var _justgage$tachyons_elm$Tachyons_Classes$br__right_ns = 'br--right-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br__right_m = 'br--right-m';
var _justgage$tachyons_elm$Tachyons_Classes$br__right_l = 'br--right-l';
var _justgage$tachyons_elm$Tachyons_Classes$br__right = 'br--right';
var _justgage$tachyons_elm$Tachyons_Classes$br__left_ns = 'br--left-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br__left_m = 'br--left-m';
var _justgage$tachyons_elm$Tachyons_Classes$br__left_l = 'br--left-l';
var _justgage$tachyons_elm$Tachyons_Classes$br__left = 'br--left';
var _justgage$tachyons_elm$Tachyons_Classes$br__bottom_ns = 'br--bottom-ns';
var _justgage$tachyons_elm$Tachyons_Classes$br__bottom_m = 'br--bottom-m';
var _justgage$tachyons_elm$Tachyons_Classes$br__bottom_l = 'br--bottom-l';
var _justgage$tachyons_elm$Tachyons_Classes$br__bottom = 'br--bottom';
var _justgage$tachyons_elm$Tachyons_Classes$br = 'br';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_2_ns = 'bottom-2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_2_m = 'bottom-2-m';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_2_l = 'bottom-2-l';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_2 = 'bottom-2';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_1_ns = 'bottom-1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_1_m = 'bottom-1-m';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_1_l = 'bottom-1-l';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_1 = 'bottom-1';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_0_ns = 'bottom-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_0_m = 'bottom-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_0_l = 'bottom-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$bottom_0 = 'bottom-0';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__2_ns = 'bottom--2-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__2_m = 'bottom--2-m';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__2_l = 'bottom--2-l';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__2 = 'bottom--2';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__1_ns = 'bottom--1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__1_m = 'bottom--1-m';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__1_l = 'bottom--1-l';
var _justgage$tachyons_elm$Tachyons_Classes$bottom__1 = 'bottom--1';
var _justgage$tachyons_elm$Tachyons_Classes$border_box = 'border-box';
var _justgage$tachyons_elm$Tachyons_Classes$bodoni = 'bodoni';
var _justgage$tachyons_elm$Tachyons_Classes$bn_ns = 'bn-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bn_m = 'bn-m';
var _justgage$tachyons_elm$Tachyons_Classes$bn_l = 'bn-l';
var _justgage$tachyons_elm$Tachyons_Classes$bn = 'bn';
var _justgage$tachyons_elm$Tachyons_Classes$blue = 'blue';
var _justgage$tachyons_elm$Tachyons_Classes$black_90 = 'black-90';
var _justgage$tachyons_elm$Tachyons_Classes$black_80 = 'black-80';
var _justgage$tachyons_elm$Tachyons_Classes$black_70 = 'black-70';
var _justgage$tachyons_elm$Tachyons_Classes$black_60 = 'black-60';
var _justgage$tachyons_elm$Tachyons_Classes$black_50 = 'black-50';
var _justgage$tachyons_elm$Tachyons_Classes$black_40 = 'black-40';
var _justgage$tachyons_elm$Tachyons_Classes$black_30 = 'black-30';
var _justgage$tachyons_elm$Tachyons_Classes$black_20 = 'black-20';
var _justgage$tachyons_elm$Tachyons_Classes$black_10 = 'black-10';
var _justgage$tachyons_elm$Tachyons_Classes$black_05 = 'black-05';
var _justgage$tachyons_elm$Tachyons_Classes$black = 'black';
var _justgage$tachyons_elm$Tachyons_Classes$bl_ns = 'bl-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bl_m = 'bl-m';
var _justgage$tachyons_elm$Tachyons_Classes$bl_l = 'bl-l';
var _justgage$tachyons_elm$Tachyons_Classes$bl_0_ns = 'bl-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bl_0_m = 'bl-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$bl_0_l = 'bl-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$bl_0 = 'bl-0';
var _justgage$tachyons_elm$Tachyons_Classes$bl = 'bl';
var _justgage$tachyons_elm$Tachyons_Classes$bg_yellow = 'bg-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_90 = 'bg-white-90';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_80 = 'bg-white-80';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_70 = 'bg-white-70';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_60 = 'bg-white-60';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_50 = 'bg-white-50';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_40 = 'bg-white-40';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_30 = 'bg-white-30';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_20 = 'bg-white-20';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white_10 = 'bg-white-10';
var _justgage$tachyons_elm$Tachyons_Classes$bg_white = 'bg-white';
var _justgage$tachyons_elm$Tachyons_Classes$bg_washed_yellow = 'bg-washed-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$bg_washed_red = 'bg-washed-red';
var _justgage$tachyons_elm$Tachyons_Classes$bg_washed_green = 'bg-washed-green';
var _justgage$tachyons_elm$Tachyons_Classes$bg_washed_blue = 'bg-washed-blue';
var _justgage$tachyons_elm$Tachyons_Classes$bg_transparent = 'bg-transparent';
var _justgage$tachyons_elm$Tachyons_Classes$bg_top_ns = 'bg-top-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bg_top_m = 'bg-top-m';
var _justgage$tachyons_elm$Tachyons_Classes$bg_top_l = 'bg-top-l';
var _justgage$tachyons_elm$Tachyons_Classes$bg_top = 'bg-top';
var _justgage$tachyons_elm$Tachyons_Classes$bg_silver = 'bg-silver';
var _justgage$tachyons_elm$Tachyons_Classes$bg_right_ns = 'bg-right-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bg_right_m = 'bg-right-m';
var _justgage$tachyons_elm$Tachyons_Classes$bg_right_l = 'bg-right-l';
var _justgage$tachyons_elm$Tachyons_Classes$bg_right = 'bg-right';
var _justgage$tachyons_elm$Tachyons_Classes$bg_red = 'bg-red';
var _justgage$tachyons_elm$Tachyons_Classes$bg_purple = 'bg-purple';
var _justgage$tachyons_elm$Tachyons_Classes$bg_pink = 'bg-pink';
var _justgage$tachyons_elm$Tachyons_Classes$bg_orange = 'bg-orange';
var _justgage$tachyons_elm$Tachyons_Classes$bg_near_white = 'bg-near-white';
var _justgage$tachyons_elm$Tachyons_Classes$bg_near_black = 'bg-near-black';
var _justgage$tachyons_elm$Tachyons_Classes$bg_navy = 'bg-navy';
var _justgage$tachyons_elm$Tachyons_Classes$bg_moon_gray = 'bg-moon-gray';
var _justgage$tachyons_elm$Tachyons_Classes$bg_mid_gray = 'bg-mid-gray';
var _justgage$tachyons_elm$Tachyons_Classes$bg_lightest_blue = 'bg-lightest-blue';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_yellow = 'bg-light-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_silver = 'bg-light-silver';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_red = 'bg-light-red';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_purple = 'bg-light-purple';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_pink = 'bg-light-pink';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_green = 'bg-light-green';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_gray = 'bg-light-gray';
var _justgage$tachyons_elm$Tachyons_Classes$bg_light_blue = 'bg-light-blue';
var _justgage$tachyons_elm$Tachyons_Classes$bg_left_ns = 'bg-left-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bg_left_m = 'bg-left-m';
var _justgage$tachyons_elm$Tachyons_Classes$bg_left_l = 'bg-left-l';
var _justgage$tachyons_elm$Tachyons_Classes$bg_left = 'bg-left';
var _justgage$tachyons_elm$Tachyons_Classes$bg_inherit = 'bg-inherit';
var _justgage$tachyons_elm$Tachyons_Classes$bg_hot_pink = 'bg-hot-pink';
var _justgage$tachyons_elm$Tachyons_Classes$bg_green = 'bg-green';
var _justgage$tachyons_elm$Tachyons_Classes$bg_gray = 'bg-gray';
var _justgage$tachyons_elm$Tachyons_Classes$bg_gold = 'bg-gold';
var _justgage$tachyons_elm$Tachyons_Classes$bg_dark_red = 'bg-dark-red';
var _justgage$tachyons_elm$Tachyons_Classes$bg_dark_pink = 'bg-dark-pink';
var _justgage$tachyons_elm$Tachyons_Classes$bg_dark_green = 'bg-dark-green';
var _justgage$tachyons_elm$Tachyons_Classes$bg_dark_gray = 'bg-dark-gray';
var _justgage$tachyons_elm$Tachyons_Classes$bg_dark_blue = 'bg-dark-blue';
var _justgage$tachyons_elm$Tachyons_Classes$bg_center_ns = 'bg-center-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bg_center_m = 'bg-center-m';
var _justgage$tachyons_elm$Tachyons_Classes$bg_center_l = 'bg-center-l';
var _justgage$tachyons_elm$Tachyons_Classes$bg_center = 'bg-center';
var _justgage$tachyons_elm$Tachyons_Classes$bg_bottom_ns = 'bg-bottom-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bg_bottom_m = 'bg-bottom-m';
var _justgage$tachyons_elm$Tachyons_Classes$bg_bottom_l = 'bg-bottom-l';
var _justgage$tachyons_elm$Tachyons_Classes$bg_bottom = 'bg-bottom';
var _justgage$tachyons_elm$Tachyons_Classes$bg_blue = 'bg-blue';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_90 = 'bg-black-90';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_80 = 'bg-black-80';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_70 = 'bg-black-70';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_60 = 'bg-black-60';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_50 = 'bg-black-50';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_40 = 'bg-black-40';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_30 = 'bg-black-30';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_20 = 'bg-black-20';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_10 = 'bg-black-10';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black_05 = 'bg-black-05';
var _justgage$tachyons_elm$Tachyons_Classes$bg_black = 'bg-black';
var _justgage$tachyons_elm$Tachyons_Classes$bg_animate = 'bg-animate';
var _justgage$tachyons_elm$Tachyons_Classes$bb_ns = 'bb-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bb_m = 'bb-m';
var _justgage$tachyons_elm$Tachyons_Classes$bb_l = 'bb-l';
var _justgage$tachyons_elm$Tachyons_Classes$bb_0_ns = 'bb-0-ns';
var _justgage$tachyons_elm$Tachyons_Classes$bb_0_m = 'bb-0-m';
var _justgage$tachyons_elm$Tachyons_Classes$bb_0_l = 'bb-0-l';
var _justgage$tachyons_elm$Tachyons_Classes$bb_0 = 'bb-0';
var _justgage$tachyons_elm$Tachyons_Classes$bb = 'bb';
var _justgage$tachyons_elm$Tachyons_Classes$baskerville = 'baskerville';
var _justgage$tachyons_elm$Tachyons_Classes$ba_ns = 'ba-ns';
var _justgage$tachyons_elm$Tachyons_Classes$ba_m = 'ba-m';
var _justgage$tachyons_elm$Tachyons_Classes$ba_l = 'ba-l';
var _justgage$tachyons_elm$Tachyons_Classes$ba = 'ba';
var _justgage$tachyons_elm$Tachyons_Classes$b_ns = 'b-ns';
var _justgage$tachyons_elm$Tachyons_Classes$b_m = 'b-m';
var _justgage$tachyons_elm$Tachyons_Classes$b_l = 'b-l';
var _justgage$tachyons_elm$Tachyons_Classes$b__yellow = 'b--yellow';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_90 = 'b--white-90';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_80 = 'b--white-80';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_70 = 'b--white-70';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_60 = 'b--white-60';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_50 = 'b--white-50';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_40 = 'b--white-40';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_30 = 'b--white-30';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_20 = 'b--white-20';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_10 = 'b--white-10';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_05 = 'b--white-05';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_025 = 'b--white-025';
var _justgage$tachyons_elm$Tachyons_Classes$b__white_0125 = 'b--white-0125';
var _justgage$tachyons_elm$Tachyons_Classes$b__white = 'b--white';
var _justgage$tachyons_elm$Tachyons_Classes$b__washed_yellow = 'b--washed-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$b__washed_red = 'b--washed-red';
var _justgage$tachyons_elm$Tachyons_Classes$b__washed_green = 'b--washed-green';
var _justgage$tachyons_elm$Tachyons_Classes$b__washed_blue = 'b--washed-blue';
var _justgage$tachyons_elm$Tachyons_Classes$b__transparent = 'b--transparent';
var _justgage$tachyons_elm$Tachyons_Classes$b__solid_ns = 'b--solid-ns';
var _justgage$tachyons_elm$Tachyons_Classes$b__solid_m = 'b--solid-m';
var _justgage$tachyons_elm$Tachyons_Classes$b__solid_l = 'b--solid-l';
var _justgage$tachyons_elm$Tachyons_Classes$b__solid = 'b--solid';
var _justgage$tachyons_elm$Tachyons_Classes$b__silver = 'b--silver';
var _justgage$tachyons_elm$Tachyons_Classes$b__red = 'b--red';
var _justgage$tachyons_elm$Tachyons_Classes$b__purple = 'b--purple';
var _justgage$tachyons_elm$Tachyons_Classes$b__pink = 'b--pink';
var _justgage$tachyons_elm$Tachyons_Classes$b__orange = 'b--orange';
var _justgage$tachyons_elm$Tachyons_Classes$b__none_ns = 'b--none-ns';
var _justgage$tachyons_elm$Tachyons_Classes$b__none_m = 'b--none-m';
var _justgage$tachyons_elm$Tachyons_Classes$b__none_l = 'b--none-l';
var _justgage$tachyons_elm$Tachyons_Classes$b__none = 'b--none';
var _justgage$tachyons_elm$Tachyons_Classes$b__near_white = 'b--near-white';
var _justgage$tachyons_elm$Tachyons_Classes$b__near_black = 'b--near-black';
var _justgage$tachyons_elm$Tachyons_Classes$b__navy = 'b--navy';
var _justgage$tachyons_elm$Tachyons_Classes$b__moon_gray = 'b--moon-gray';
var _justgage$tachyons_elm$Tachyons_Classes$b__mid_gray = 'b--mid-gray';
var _justgage$tachyons_elm$Tachyons_Classes$b__lightest_blue = 'b--lightest-blue';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_yellow = 'b--light-yellow';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_silver = 'b--light-silver';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_red = 'b--light-red';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_purple = 'b--light-purple';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_pink = 'b--light-pink';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_green = 'b--light-green';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_gray = 'b--light-gray';
var _justgage$tachyons_elm$Tachyons_Classes$b__light_blue = 'b--light-blue';
var _justgage$tachyons_elm$Tachyons_Classes$b__inherit = 'b--inherit';
var _justgage$tachyons_elm$Tachyons_Classes$b__hot_pink = 'b--hot-pink';
var _justgage$tachyons_elm$Tachyons_Classes$b__green = 'b--green';
var _justgage$tachyons_elm$Tachyons_Classes$b__gray = 'b--gray';
var _justgage$tachyons_elm$Tachyons_Classes$b__gold = 'b--gold';
var _justgage$tachyons_elm$Tachyons_Classes$b__dotted_ns = 'b--dotted-ns';
var _justgage$tachyons_elm$Tachyons_Classes$b__dotted_m = 'b--dotted-m';
var _justgage$tachyons_elm$Tachyons_Classes$b__dotted_l = 'b--dotted-l';
var _justgage$tachyons_elm$Tachyons_Classes$b__dotted = 'b--dotted';
var _justgage$tachyons_elm$Tachyons_Classes$b__dashed_ns = 'b--dashed-ns';
var _justgage$tachyons_elm$Tachyons_Classes$b__dashed_m = 'b--dashed-m';
var _justgage$tachyons_elm$Tachyons_Classes$b__dashed_l = 'b--dashed-l';
var _justgage$tachyons_elm$Tachyons_Classes$b__dashed = 'b--dashed';
var _justgage$tachyons_elm$Tachyons_Classes$b__dark_red = 'b--dark-red';
var _justgage$tachyons_elm$Tachyons_Classes$b__dark_pink = 'b--dark-pink';
var _justgage$tachyons_elm$Tachyons_Classes$b__dark_green = 'b--dark-green';
var _justgage$tachyons_elm$Tachyons_Classes$b__dark_gray = 'b--dark-gray';
var _justgage$tachyons_elm$Tachyons_Classes$b__dark_blue = 'b--dark-blue';
var _justgage$tachyons_elm$Tachyons_Classes$b__blue = 'b--blue';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_90 = 'b--black-90';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_80 = 'b--black-80';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_70 = 'b--black-70';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_60 = 'b--black-60';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_50 = 'b--black-50';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_40 = 'b--black-40';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_30 = 'b--black-30';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_20 = 'b--black-20';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_10 = 'b--black-10';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_05 = 'b--black-05';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_025 = 'b--black-025';
var _justgage$tachyons_elm$Tachyons_Classes$b__black_0125 = 'b--black-0125';
var _justgage$tachyons_elm$Tachyons_Classes$b__black = 'b--black';
var _justgage$tachyons_elm$Tachyons_Classes$b = 'b';
var _justgage$tachyons_elm$Tachyons_Classes$avenir = 'avenir';
var _justgage$tachyons_elm$Tachyons_Classes$athelas = 'athelas';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio_ns = 'aspect-ratio-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio_m = 'aspect-ratio-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio_l = 'aspect-ratio-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__object_ns = 'aspect-ratio--object-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__object_m = 'aspect-ratio--object-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__object_l = 'aspect-ratio--object-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__object = 'aspect-ratio--object';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__9x16_ns = 'aspect-ratio--9x16-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__9x16_m = 'aspect-ratio--9x16-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__9x16_l = 'aspect-ratio--9x16-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__9x16 = 'aspect-ratio--9x16';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__8x5_ns = 'aspect-ratio--8x5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__8x5_m = 'aspect-ratio--8x5-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__8x5_l = 'aspect-ratio--8x5-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__8x5 = 'aspect-ratio--8x5';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__7x5_ns = 'aspect-ratio--7x5-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__7x5_m = 'aspect-ratio--7x5-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__7x5_l = 'aspect-ratio--7x5-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__7x5 = 'aspect-ratio--7x5';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__6x4_ns = 'aspect-ratio--6x4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__6x4_m = 'aspect-ratio--6x4-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__6x4_l = 'aspect-ratio--6x4-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__6x4 = 'aspect-ratio--6x4';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x8_ns = 'aspect-ratio--5x8-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x8_m = 'aspect-ratio--5x8-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x8_l = 'aspect-ratio--5x8-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x8 = 'aspect-ratio--5x8';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x7_ns = 'aspect-ratio--5x7-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x7_m = 'aspect-ratio--5x7-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x7_l = 'aspect-ratio--5x7-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__5x7 = 'aspect-ratio--5x7';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x6_ns = 'aspect-ratio--4x6-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x6_m = 'aspect-ratio--4x6-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x6_l = 'aspect-ratio--4x6-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x6 = 'aspect-ratio--4x6';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x3_ns = 'aspect-ratio--4x3-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x3_m = 'aspect-ratio--4x3-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x3_l = 'aspect-ratio--4x3-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__4x3 = 'aspect-ratio--4x3';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__3x4_ns = 'aspect-ratio--3x4-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__3x4_m = 'aspect-ratio--3x4-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__3x4_l = 'aspect-ratio--3x4-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__3x4 = 'aspect-ratio--3x4';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__1x1_ns = 'aspect-ratio--1x1-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__1x1_m = 'aspect-ratio--1x1-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__1x1_l = 'aspect-ratio--1x1-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__1x1 = 'aspect-ratio--1x1';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__16x9_ns = 'aspect-ratio--16x9-ns';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__16x9_m = 'aspect-ratio--16x9-m';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__16x9_l = 'aspect-ratio--16x9-l';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio__16x9 = 'aspect-ratio--16x9';
var _justgage$tachyons_elm$Tachyons_Classes$aspect_ratio = 'aspect-ratio';
var _justgage$tachyons_elm$Tachyons_Classes$absolute_ns = 'absolute-ns';
var _justgage$tachyons_elm$Tachyons_Classes$absolute_m = 'absolute-m';
var _justgage$tachyons_elm$Tachyons_Classes$absolute_l = 'absolute-l';
var _justgage$tachyons_elm$Tachyons_Classes$absolute__fill_ns = 'absolute--fill-ns';
var _justgage$tachyons_elm$Tachyons_Classes$absolute__fill_m = 'absolute--fill-m';
var _justgage$tachyons_elm$Tachyons_Classes$absolute__fill_l = 'absolute--fill-l';
var _justgage$tachyons_elm$Tachyons_Classes$absolute__fill = 'absolute--fill';
var _justgage$tachyons_elm$Tachyons_Classes$absolute = 'absolute';

var _lynn$elm_arithmetic$Arithmetic$primeFactors = function (n) {
	var go = F3(
		function (p, n, factors) {
			go:
			while (true) {
				if (_elm_lang$core$Native_Utils.cmp(p * p, n) > 0) {
					return A2(
						_elm_lang$core$Basics_ops['++'],
						_elm_lang$core$List$reverse(factors),
						{
							ctor: '::',
							_0: n,
							_1: {ctor: '[]'}
						});
				} else {
					if (_elm_lang$core$Native_Utils.eq(
						A2(_elm_lang$core$Basics_ops['%'], n, p),
						0)) {
						var _v0 = p,
							_v1 = (n / p) | 0,
							_v2 = {ctor: '::', _0: p, _1: factors};
						p = _v0;
						n = _v1;
						factors = _v2;
						continue go;
					} else {
						var _v3 = (p + 1) + A2(_elm_lang$core$Basics_ops['%'], p, 2),
							_v4 = n,
							_v5 = factors;
						p = _v3;
						n = _v4;
						factors = _v5;
						continue go;
					}
				}
			}
		});
	return (_elm_lang$core$Native_Utils.cmp(n, 1) < 1) ? {ctor: '[]'} : A3(
		go,
		2,
		n,
		{ctor: '[]'});
};
var _lynn$elm_arithmetic$Arithmetic$primeExponents = function () {
	var runLengthCons = F2(
		function (x, acc) {
			var _p0 = acc;
			if (_p0.ctor === '[]') {
				return {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: x, _1: 1},
					_1: {ctor: '[]'}
				};
			} else {
				var _p3 = _p0._0._0;
				var _p2 = _p0._1;
				var _p1 = _p0._0._1;
				return _elm_lang$core$Native_Utils.eq(x, _p3) ? {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: _p3, _1: _p1 + 1},
					_1: _p2
				} : {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: x, _1: 1},
					_1: {
						ctor: '::',
						_0: {ctor: '_Tuple2', _0: _p3, _1: _p1},
						_1: _p2
					}
				};
			}
		});
	return function (_p4) {
		return A3(
			_elm_lang$core$List$foldr,
			runLengthCons,
			{ctor: '[]'},
			_lynn$elm_arithmetic$Arithmetic$primeFactors(_p4));
	};
}();
var _lynn$elm_arithmetic$Arithmetic$shiftToOdd = function (n) {
	var f = F2(
		function (k, m) {
			f:
			while (true) {
				if (_elm_lang$core$Native_Utils.eq(
					A2(_elm_lang$core$Basics_ops['%'], m, 2),
					1)) {
					return {ctor: '_Tuple2', _0: k, _1: m};
				} else {
					var _v7 = k + 1,
						_v8 = (m / 2) | 0;
					k = _v7;
					m = _v8;
					continue f;
				}
			}
		});
	return A2(f, 0, n);
};
var _lynn$elm_arithmetic$Arithmetic$extendedGcd = F2(
	function (a, b) {
		var egcd = F6(
			function (n1, o1, n2, o2, r, s) {
				egcd:
				while (true) {
					if (_elm_lang$core$Native_Utils.eq(s, 0)) {
						return {ctor: '_Tuple3', _0: r, _1: o1, _2: o2};
					} else {
						var q = (r / s) | 0;
						var _v9 = o1 - (q * n1),
							_v10 = n1,
							_v11 = o2 - (q * n2),
							_v12 = n2,
							_v13 = s,
							_v14 = A2(_elm_lang$core$Basics$rem, r, s);
						n1 = _v9;
						o1 = _v10;
						n2 = _v11;
						o2 = _v12;
						r = _v13;
						s = _v14;
						continue egcd;
					}
				}
			});
		var _p5 = A6(
			egcd,
			0,
			1,
			1,
			0,
			_elm_lang$core$Basics$abs(a),
			_elm_lang$core$Basics$abs(b));
		var d = _p5._0;
		var x = _p5._1;
		var y = _p5._2;
		var u = (_elm_lang$core$Native_Utils.cmp(a, 0) < 0) ? _elm_lang$core$Basics$negate(x) : x;
		var v = (_elm_lang$core$Native_Utils.cmp(b, 0) < 0) ? _elm_lang$core$Basics$negate(y) : y;
		return {ctor: '_Tuple3', _0: d, _1: u, _2: v};
	});
var _lynn$elm_arithmetic$Arithmetic$modularInverse = F2(
	function (a, modulus) {
		var _p6 = A2(_lynn$elm_arithmetic$Arithmetic$extendedGcd, a, modulus);
		var d = _p6._0;
		var x = _p6._1;
		return _elm_lang$core$Native_Utils.eq(d, 1) ? _elm_lang$core$Maybe$Just(
			A2(_elm_lang$core$Basics_ops['%'], x, modulus)) : _elm_lang$core$Maybe$Nothing;
	});
var _lynn$elm_arithmetic$Arithmetic$chineseRemainder = function (equations) {
	var fromJustCons = F2(
		function (x, acc) {
			var _p7 = x;
			if (_p7.ctor === 'Just') {
				return A2(
					_elm_lang$core$Maybe$map,
					F2(
						function (x, y) {
							return {ctor: '::', _0: x, _1: y};
						})(_p7._0),
					acc);
			} else {
				return _elm_lang$core$Maybe$Nothing;
			}
		});
	var fromJustList = A2(
		_elm_lang$core$List$foldr,
		fromJustCons,
		_elm_lang$core$Maybe$Just(
			{ctor: '[]'}));
	var _p8 = _elm_lang$core$List$unzip(equations);
	var residues = _p8._0;
	var moduli = _p8._1;
	var m = _elm_lang$core$List$product(moduli);
	var v = A2(
		_elm_lang$core$List$map,
		function (x) {
			return (m / x) | 0;
		},
		moduli);
	var inverses = fromJustList(
		A3(_elm_lang$core$List$map2, _lynn$elm_arithmetic$Arithmetic$modularInverse, v, moduli));
	return A2(
		_elm_lang$core$Maybe$map,
		function (_p9) {
			return A3(
				_elm_lang$core$Basics$flip,
				F2(
					function (x, y) {
						return A2(_elm_lang$core$Basics_ops['%'], x, y);
					}),
				m,
				_elm_lang$core$List$sum(
					A3(
						_elm_lang$core$List$map2,
						F2(
							function (x, y) {
								return x * y;
							}),
						v,
						A3(
							_elm_lang$core$List$map2,
							F2(
								function (x, y) {
									return x * y;
								}),
							residues,
							_p9))));
		},
		fromJustList(
			A3(_elm_lang$core$List$map2, _lynn$elm_arithmetic$Arithmetic$modularInverse, v, moduli)));
};
var _lynn$elm_arithmetic$Arithmetic$totient = function (n) {
	var f = F2(
		function (p, n) {
			return ((n * (p - 1)) / p) | 0;
		});
	var n_ = _elm_lang$core$Basics$abs(n);
	return A3(
		_elm_lang$core$List$foldr,
		f,
		n_,
		A2(
			_elm_lang$core$List$map,
			_elm_lang$core$Tuple$first,
			_lynn$elm_arithmetic$Arithmetic$primeExponents(n_)));
};
var _lynn$elm_arithmetic$Arithmetic$gcd = F2(
	function (a, b) {
		var gcd_ = F2(
			function (a, b) {
				gcd_:
				while (true) {
					if (_elm_lang$core$Native_Utils.eq(b, 0)) {
						return a;
					} else {
						var _v16 = b,
							_v17 = A2(_elm_lang$core$Basics_ops['%'], a, b);
						a = _v16;
						b = _v17;
						continue gcd_;
					}
				}
			});
		return A2(
			gcd_,
			_elm_lang$core$Basics$abs(a),
			_elm_lang$core$Basics$abs(b));
	});
var _lynn$elm_arithmetic$Arithmetic$lcm = F2(
	function (a, b) {
		return _elm_lang$core$Basics$abs(
			((a / A2(_lynn$elm_arithmetic$Arithmetic$gcd, a, b)) | 0) * b);
	});
var _lynn$elm_arithmetic$Arithmetic$isCoprimeTo = F2(
	function (a, b) {
		return _elm_lang$core$Native_Utils.eq(
			A2(_lynn$elm_arithmetic$Arithmetic$gcd, a, b),
			1);
	});
var _lynn$elm_arithmetic$Arithmetic$divisorCount = function (_p10) {
	return _elm_lang$core$List$product(
		A2(
			_elm_lang$core$List$map,
			function (_p11) {
				var _p12 = _p11;
				return _p12._1 + 1;
			},
			_lynn$elm_arithmetic$Arithmetic$primeExponents(_p10)));
};
var _lynn$elm_arithmetic$Arithmetic$divisors = function () {
	var f = function (_p13) {
		var _p14 = _p13;
		return _elm_lang$core$List$concatMap(
			function (a) {
				return A2(
					_elm_lang$core$List$map,
					function (x) {
						return Math.pow(_p14._0, x) * a;
					},
					A2(_elm_lang$core$List$range, 0, _p14._1));
			});
	};
	return function (_p15) {
		return _elm_lang$core$List$sort(
			A3(
				_elm_lang$core$List$foldr,
				f,
				{
					ctor: '::',
					_0: 1,
					_1: {ctor: '[]'}
				},
				_lynn$elm_arithmetic$Arithmetic$primeExponents(_p15)));
	};
}();
var _lynn$elm_arithmetic$Arithmetic$properDivisors = function (n) {
	return A2(
		_elm_lang$core$List$filter,
		F2(
			function (x, y) {
				return !_elm_lang$core$Native_Utils.eq(x, y);
			})(n),
		_lynn$elm_arithmetic$Arithmetic$divisors(n));
};
var _lynn$elm_arithmetic$Arithmetic$isMultipleOf = F2(
	function (a, b) {
		return _elm_lang$core$Native_Utils.eq(
			A2(_elm_lang$core$Basics_ops['%'], a, b),
			0);
	});
var _lynn$elm_arithmetic$Arithmetic$divides = F2(
	function (a, b) {
		return _elm_lang$core$Native_Utils.eq(
			A2(_elm_lang$core$Basics_ops['%'], b, a),
			0);
	});
var _lynn$elm_arithmetic$Arithmetic$cubeRoot = function (n) {
	return Math.pow(n, 1 / 3);
};
var _lynn$elm_arithmetic$Arithmetic$intCubeRoot = function (_p16) {
	return _elm_lang$core$Basics$round(
		_lynn$elm_arithmetic$Arithmetic$cubeRoot(
			_elm_lang$core$Basics$toFloat(_p16)));
};
var _lynn$elm_arithmetic$Arithmetic$exactIntCubeRoot = function (n) {
	var s = _lynn$elm_arithmetic$Arithmetic$intCubeRoot(n);
	return _elm_lang$core$Native_Utils.eq(
		Math.pow(s, 3),
		n) ? _elm_lang$core$Maybe$Just(s) : _elm_lang$core$Maybe$Nothing;
};
var _lynn$elm_arithmetic$Arithmetic$isCube = function (n) {
	var r = A2(_elm_lang$core$Basics_ops['%'], n, 63);
	return (_elm_lang$core$Native_Utils.eq(r, 0) || (_elm_lang$core$Native_Utils.eq(r, 1) || (_elm_lang$core$Native_Utils.eq(r, 8) || (_elm_lang$core$Native_Utils.eq(r, 27) || (_elm_lang$core$Native_Utils.eq(r, 28) || (_elm_lang$core$Native_Utils.eq(r, 35) || (_elm_lang$core$Native_Utils.eq(r, 36) || (_elm_lang$core$Native_Utils.eq(r, 55) || _elm_lang$core$Native_Utils.eq(r, 62))))))))) && _elm_lang$core$Native_Utils.eq(
		Math.pow(
			_lynn$elm_arithmetic$Arithmetic$intCubeRoot(n),
			3),
		n);
};
var _lynn$elm_arithmetic$Arithmetic$intSquareRoot = function (_p17) {
	return _elm_lang$core$Basics$round(
		_elm_lang$core$Basics$sqrt(
			_elm_lang$core$Basics$toFloat(_p17)));
};
var _lynn$elm_arithmetic$Arithmetic$exactIntSquareRoot = function (n) {
	var s = _lynn$elm_arithmetic$Arithmetic$intSquareRoot(n);
	return _elm_lang$core$Native_Utils.eq(s * s, n) ? _elm_lang$core$Maybe$Just(s) : _elm_lang$core$Maybe$Nothing;
};
var _lynn$elm_arithmetic$Arithmetic$isSquare = function (n) {
	var r = A2(_elm_lang$core$Basics_ops['%'], n, 48);
	return (_elm_lang$core$Native_Utils.eq(r, 0) || (_elm_lang$core$Native_Utils.eq(r, 1) || (_elm_lang$core$Native_Utils.eq(r, 4) || (_elm_lang$core$Native_Utils.eq(r, 9) || (_elm_lang$core$Native_Utils.eq(r, 16) || (_elm_lang$core$Native_Utils.eq(r, 25) || (_elm_lang$core$Native_Utils.eq(r, 33) || _elm_lang$core$Native_Utils.eq(r, 36)))))))) && _elm_lang$core$Native_Utils.eq(
		Math.pow(
			_lynn$elm_arithmetic$Arithmetic$intSquareRoot(n),
			2),
		n);
};
var _lynn$elm_arithmetic$Arithmetic$primesBelow = function (n) {
	var trueIndices = function () {
		var g = F2(
			function (x, acc) {
				var _p18 = x;
				if (_p18.ctor === 'Just') {
					return {ctor: '::', _0: _p18._0, _1: acc};
				} else {
					return acc;
				}
			});
		var f = F2(
			function (i, pred) {
				return pred ? _elm_lang$core$Maybe$Just(i) : _elm_lang$core$Maybe$Nothing;
			});
		return function (_p19) {
			return A3(
				_elm_lang$core$Array$foldr,
				g,
				{ctor: '[]'},
				A2(_elm_lang$core$Array$indexedMap, f, _p19));
		};
	}();
	var sieve = F2(
		function (p, arr) {
			var mark = F4(
				function (i, p, n, arr) {
					mark:
					while (true) {
						if (_elm_lang$core$Native_Utils.cmp(i * p, n) > -1) {
							return arr;
						} else {
							var _v21 = i + 1,
								_v22 = p,
								_v23 = n,
								_v24 = A3(_elm_lang$core$Array$set, i * p, false, arr);
							i = _v21;
							p = _v22;
							n = _v23;
							arr = _v24;
							continue mark;
						}
					}
				});
			return _elm_lang$core$Native_Utils.eq(
				A2(_elm_lang$core$Array$get, p, arr),
				_elm_lang$core$Maybe$Just(true)) ? A4(mark, 2, p, n, arr) : arr;
		});
	var initial = A3(
		_elm_lang$core$Array$set,
		1,
		false,
		A3(
			_elm_lang$core$Array$set,
			0,
			false,
			A2(_elm_lang$core$Array$repeat, n, true)));
	var ps = {
		ctor: '::',
		_0: 2,
		_1: A2(
			_elm_lang$core$List$map,
			function (x) {
				return (2 * x) + 1;
			},
			A2(
				_elm_lang$core$List$range,
				1,
				(_lynn$elm_arithmetic$Arithmetic$intSquareRoot(n) / 2) | 0))
	};
	return trueIndices(
		A3(_elm_lang$core$List$foldr, sieve, initial, ps));
};
var _lynn$elm_arithmetic$Arithmetic$safeSquareRoot = function (n) {
	return (_elm_lang$core$Native_Utils.cmp(n, 0) < 0) ? _elm_lang$core$Maybe$Nothing : _elm_lang$core$Maybe$Just(
		_elm_lang$core$Basics$sqrt(n));
};
var _lynn$elm_arithmetic$Arithmetic$squareRoot = _elm_lang$core$Basics$sqrt;
var _lynn$elm_arithmetic$Arithmetic$fromBase = function (base) {
	return A2(
		_elm_lang$core$List$foldl,
		F2(
			function (x, acc) {
				return (acc * base) + x;
			}),
		0);
};
var _lynn$elm_arithmetic$Arithmetic$toBase = F2(
	function (base, n) {
		var go = F2(
			function (x, acc) {
				go:
				while (true) {
					if (_elm_lang$core$Native_Utils.cmp(x, 0) < 1) {
						return acc;
					} else {
						var _v25 = (x / base) | 0,
							_v26 = {
							ctor: '::',
							_0: A2(_elm_lang$core$Basics_ops['%'], x, base),
							_1: acc
						};
						x = _v25;
						acc = _v26;
						continue go;
					}
				}
			});
		var n_ = _elm_lang$core$Basics$abs(n);
		return A2(
			go,
			n_,
			{ctor: '[]'});
	});
var _lynn$elm_arithmetic$Arithmetic$isOdd = function (n) {
	return !_elm_lang$core$Native_Utils.eq(
		A2(_elm_lang$core$Basics_ops['%'], n, 2),
		0);
};
var _lynn$elm_arithmetic$Arithmetic$powerMod = F3(
	function (base, exponent, modulus) {
		var go = F3(
			function (b, e, r) {
				go:
				while (true) {
					if (_elm_lang$core$Native_Utils.eq(e, 0)) {
						return r;
					} else {
						var r_ = _lynn$elm_arithmetic$Arithmetic$isOdd(e) ? A2(_elm_lang$core$Basics_ops['%'], r * b, modulus) : r;
						var _v27 = A2(_elm_lang$core$Basics_ops['%'], b * b, modulus),
							_v28 = (e / 2) | 0,
							_v29 = r_;
						b = _v27;
						e = _v28;
						r = _v29;
						continue go;
					}
				}
			});
		return _elm_lang$core$Native_Utils.eq(modulus, 1) ? 0 : A3(
			go,
			A2(_elm_lang$core$Basics_ops['%'], base, modulus),
			exponent,
			1);
	});
var _lynn$elm_arithmetic$Arithmetic$millerRabin = F2(
	function (n, witnesses) {
		var check = F2(
			function (l, x) {
				if (_elm_lang$core$Native_Utils.cmp(l, 0) < 1) {
					return true;
				} else {
					var y = A3(_lynn$elm_arithmetic$Arithmetic$powerMod, x, 2, n);
					return _elm_lang$core$Native_Utils.eq(y, 1) || ((!_elm_lang$core$Native_Utils.eq(y, n - 1)) && A2(check, l - 1, y));
				}
			});
		var _p20 = _lynn$elm_arithmetic$Arithmetic$shiftToOdd(n - 1);
		var s = _p20._0;
		var d = _p20._1;
		var go = function (witnesses) {
			go:
			while (true) {
				var _p21 = witnesses;
				if (_p21.ctor === '[]') {
					return true;
				} else {
					var _p22 = _p21._1;
					var x = A3(_lynn$elm_arithmetic$Arithmetic$powerMod, _p21._0, d, n);
					if (_elm_lang$core$Native_Utils.eq(x, 1) || _elm_lang$core$Native_Utils.eq(x, n - 1)) {
						var _v31 = _p22;
						witnesses = _v31;
						continue go;
					} else {
						if (A2(check, s - 1, x)) {
							return false;
						} else {
							var _v32 = _p22;
							witnesses = _v32;
							continue go;
						}
					}
				}
			}
		};
		return go(witnesses);
	});
var _lynn$elm_arithmetic$Arithmetic$isPrime = function (n) {
	return (_elm_lang$core$Native_Utils.cmp(n, 13) < 0) ? (_elm_lang$core$Native_Utils.eq(n, 2) || (_elm_lang$core$Native_Utils.eq(n, 3) || (_elm_lang$core$Native_Utils.eq(n, 5) || (_elm_lang$core$Native_Utils.eq(n, 7) || _elm_lang$core$Native_Utils.eq(n, 11))))) : ((_elm_lang$core$Native_Utils.eq(
		A2(_elm_lang$core$Basics_ops['%'], n, 2),
		0) || (_elm_lang$core$Native_Utils.eq(
		A2(_elm_lang$core$Basics_ops['%'], n, 3),
		0) || _elm_lang$core$Native_Utils.eq(
		A2(_elm_lang$core$Basics_ops['%'], n, 5),
		0))) ? false : ((_elm_lang$core$Native_Utils.cmp(n, 1373653) < 0) ? A2(
		_lynn$elm_arithmetic$Arithmetic$millerRabin,
		n,
		{
			ctor: '::',
			_0: 2,
			_1: {
				ctor: '::',
				_0: 3,
				_1: {ctor: '[]'}
			}
		}) : A2(
		_lynn$elm_arithmetic$Arithmetic$millerRabin,
		n,
		{
			ctor: '::',
			_0: 2,
			_1: {
				ctor: '::',
				_0: 3,
				_1: {
					ctor: '::',
					_0: 5,
					_1: {
						ctor: '::',
						_0: 7,
						_1: {
							ctor: '::',
							_0: 11,
							_1: {ctor: '[]'}
						}
					}
				}
			}
		})));
};
var _lynn$elm_arithmetic$Arithmetic$isEven = function (n) {
	return _elm_lang$core$Native_Utils.eq(
		A2(_elm_lang$core$Basics_ops['%'], n, 2),
		0);
};

var _user$project$MusicNote$sorter = function (_p0) {
	var _p1 = _p0;
	return _p1._0._0;
};
var _user$project$MusicNote$mbSorter = function (mbNote) {
	return A3(_elm_community$maybe_extra$Maybe_Extra$unwrap, 0, _user$project$MusicNote$sorter, mbNote);
};
var _user$project$MusicNote$MidiNumber = function (a) {
	return {ctor: 'MidiNumber', _0: a};
};
var _user$project$MusicNote$MusicNote = function (a) {
	return {ctor: 'MusicNote', _0: a};
};
var _user$project$MusicNote$Freq = function (a) {
	return {ctor: 'Freq', _0: a};
};
var _user$project$MusicNote$notesList = {
	ctor: '::',
	_0: {
		ctor: '_Tuple2',
		_0: _user$project$MusicNote$MidiNumber(21),
		_1: {
			name: 'A0',
			freq: _user$project$MusicNote$Freq(27.5)
		}
	},
	_1: {
		ctor: '::',
		_0: {
			ctor: '_Tuple2',
			_0: _user$project$MusicNote$MidiNumber(22),
			_1: {
				name: 'A0#',
				freq: _user$project$MusicNote$Freq(29.135)
			}
		},
		_1: {
			ctor: '::',
			_0: {
				ctor: '_Tuple2',
				_0: _user$project$MusicNote$MidiNumber(23),
				_1: {
					name: 'B0',
					freq: _user$project$MusicNote$Freq(30.868)
				}
			},
			_1: {
				ctor: '::',
				_0: {
					ctor: '_Tuple2',
					_0: _user$project$MusicNote$MidiNumber(24),
					_1: {
						name: 'C1',
						freq: _user$project$MusicNote$Freq(32.703)
					}
				},
				_1: {
					ctor: '::',
					_0: {
						ctor: '_Tuple2',
						_0: _user$project$MusicNote$MidiNumber(25),
						_1: {
							name: 'C1#',
							freq: _user$project$MusicNote$Freq(34.648)
						}
					},
					_1: {
						ctor: '::',
						_0: {
							ctor: '_Tuple2',
							_0: _user$project$MusicNote$MidiNumber(26),
							_1: {
								name: 'D1',
								freq: _user$project$MusicNote$Freq(36.708)
							}
						},
						_1: {
							ctor: '::',
							_0: {
								ctor: '_Tuple2',
								_0: _user$project$MusicNote$MidiNumber(27),
								_1: {
									name: 'D1#',
									freq: _user$project$MusicNote$Freq(38.891)
								}
							},
							_1: {
								ctor: '::',
								_0: {
									ctor: '_Tuple2',
									_0: _user$project$MusicNote$MidiNumber(28),
									_1: {
										name: 'E1',
										freq: _user$project$MusicNote$Freq(41.203)
									}
								},
								_1: {
									ctor: '::',
									_0: {
										ctor: '_Tuple2',
										_0: _user$project$MusicNote$MidiNumber(29),
										_1: {
											name: 'F1',
											freq: _user$project$MusicNote$Freq(43.654)
										}
									},
									_1: {
										ctor: '::',
										_0: {
											ctor: '_Tuple2',
											_0: _user$project$MusicNote$MidiNumber(30),
											_1: {
												name: 'F1#',
												freq: _user$project$MusicNote$Freq(46.249)
											}
										},
										_1: {
											ctor: '::',
											_0: {
												ctor: '_Tuple2',
												_0: _user$project$MusicNote$MidiNumber(31),
												_1: {
													name: 'G1',
													freq: _user$project$MusicNote$Freq(48.999)
												}
											},
											_1: {
												ctor: '::',
												_0: {
													ctor: '_Tuple2',
													_0: _user$project$MusicNote$MidiNumber(32),
													_1: {
														name: 'G1#',
														freq: _user$project$MusicNote$Freq(51.913)
													}
												},
												_1: {
													ctor: '::',
													_0: {
														ctor: '_Tuple2',
														_0: _user$project$MusicNote$MidiNumber(33),
														_1: {
															name: 'A1',
															freq: _user$project$MusicNote$Freq(55.0)
														}
													},
													_1: {
														ctor: '::',
														_0: {
															ctor: '_Tuple2',
															_0: _user$project$MusicNote$MidiNumber(34),
															_1: {
																name: 'A1#',
																freq: _user$project$MusicNote$Freq(58.27)
															}
														},
														_1: {
															ctor: '::',
															_0: {
																ctor: '_Tuple2',
																_0: _user$project$MusicNote$MidiNumber(35),
																_1: {
																	name: 'B1',
																	freq: _user$project$MusicNote$Freq(61.735)
																}
															},
															_1: {
																ctor: '::',
																_0: {
																	ctor: '_Tuple2',
																	_0: _user$project$MusicNote$MidiNumber(36),
																	_1: {
																		name: 'C2',
																		freq: _user$project$MusicNote$Freq(65.406)
																	}
																},
																_1: {
																	ctor: '::',
																	_0: {
																		ctor: '_Tuple2',
																		_0: _user$project$MusicNote$MidiNumber(37),
																		_1: {
																			name: 'C2#',
																			freq: _user$project$MusicNote$Freq(69.296)
																		}
																	},
																	_1: {
																		ctor: '::',
																		_0: {
																			ctor: '_Tuple2',
																			_0: _user$project$MusicNote$MidiNumber(38),
																			_1: {
																				name: 'D2',
																				freq: _user$project$MusicNote$Freq(73.416)
																			}
																		},
																		_1: {
																			ctor: '::',
																			_0: {
																				ctor: '_Tuple2',
																				_0: _user$project$MusicNote$MidiNumber(39),
																				_1: {
																					name: 'D2#',
																					freq: _user$project$MusicNote$Freq(77.782)
																				}
																			},
																			_1: {
																				ctor: '::',
																				_0: {
																					ctor: '_Tuple2',
																					_0: _user$project$MusicNote$MidiNumber(40),
																					_1: {
																						name: 'E2',
																						freq: _user$project$MusicNote$Freq(82.407)
																					}
																				},
																				_1: {
																					ctor: '::',
																					_0: {
																						ctor: '_Tuple2',
																						_0: _user$project$MusicNote$MidiNumber(41),
																						_1: {
																							name: 'F2',
																							freq: _user$project$MusicNote$Freq(87.307)
																						}
																					},
																					_1: {
																						ctor: '::',
																						_0: {
																							ctor: '_Tuple2',
																							_0: _user$project$MusicNote$MidiNumber(42),
																							_1: {
																								name: 'F2#',
																								freq: _user$project$MusicNote$Freq(92.499)
																							}
																						},
																						_1: {
																							ctor: '::',
																							_0: {
																								ctor: '_Tuple2',
																								_0: _user$project$MusicNote$MidiNumber(43),
																								_1: {
																									name: 'G2',
																									freq: _user$project$MusicNote$Freq(97.999)
																								}
																							},
																							_1: {
																								ctor: '::',
																								_0: {
																									ctor: '_Tuple2',
																									_0: _user$project$MusicNote$MidiNumber(44),
																									_1: {
																										name: 'G2#',
																										freq: _user$project$MusicNote$Freq(103.83)
																									}
																								},
																								_1: {
																									ctor: '::',
																									_0: {
																										ctor: '_Tuple2',
																										_0: _user$project$MusicNote$MidiNumber(45),
																										_1: {
																											name: 'A2',
																											freq: _user$project$MusicNote$Freq(110.0)
																										}
																									},
																									_1: {
																										ctor: '::',
																										_0: {
																											ctor: '_Tuple2',
																											_0: _user$project$MusicNote$MidiNumber(46),
																											_1: {
																												name: 'A2#',
																												freq: _user$project$MusicNote$Freq(116.54)
																											}
																										},
																										_1: {
																											ctor: '::',
																											_0: {
																												ctor: '_Tuple2',
																												_0: _user$project$MusicNote$MidiNumber(47),
																												_1: {
																													name: 'B2',
																													freq: _user$project$MusicNote$Freq(123.47)
																												}
																											},
																											_1: {
																												ctor: '::',
																												_0: {
																													ctor: '_Tuple2',
																													_0: _user$project$MusicNote$MidiNumber(48),
																													_1: {
																														name: 'C3',
																														freq: _user$project$MusicNote$Freq(130.81)
																													}
																												},
																												_1: {
																													ctor: '::',
																													_0: {
																														ctor: '_Tuple2',
																														_0: _user$project$MusicNote$MidiNumber(49),
																														_1: {
																															name: 'C3#',
																															freq: _user$project$MusicNote$Freq(138.59)
																														}
																													},
																													_1: {
																														ctor: '::',
																														_0: {
																															ctor: '_Tuple2',
																															_0: _user$project$MusicNote$MidiNumber(50),
																															_1: {
																																name: 'D3',
																																freq: _user$project$MusicNote$Freq(146.83)
																															}
																														},
																														_1: {
																															ctor: '::',
																															_0: {
																																ctor: '_Tuple2',
																																_0: _user$project$MusicNote$MidiNumber(51),
																																_1: {
																																	name: 'D3#',
																																	freq: _user$project$MusicNote$Freq(155.56)
																																}
																															},
																															_1: {
																																ctor: '::',
																																_0: {
																																	ctor: '_Tuple2',
																																	_0: _user$project$MusicNote$MidiNumber(52),
																																	_1: {
																																		name: 'E3',
																																		freq: _user$project$MusicNote$Freq(164.81)
																																	}
																																},
																																_1: {
																																	ctor: '::',
																																	_0: {
																																		ctor: '_Tuple2',
																																		_0: _user$project$MusicNote$MidiNumber(53),
																																		_1: {
																																			name: 'F3',
																																			freq: _user$project$MusicNote$Freq(174.61)
																																		}
																																	},
																																	_1: {
																																		ctor: '::',
																																		_0: {
																																			ctor: '_Tuple2',
																																			_0: _user$project$MusicNote$MidiNumber(54),
																																			_1: {
																																				name: 'F3#',
																																				freq: _user$project$MusicNote$Freq(185.0)
																																			}
																																		},
																																		_1: {
																																			ctor: '::',
																																			_0: {
																																				ctor: '_Tuple2',
																																				_0: _user$project$MusicNote$MidiNumber(55),
																																				_1: {
																																					name: 'G3',
																																					freq: _user$project$MusicNote$Freq(196.0)
																																				}
																																			},
																																			_1: {
																																				ctor: '::',
																																				_0: {
																																					ctor: '_Tuple2',
																																					_0: _user$project$MusicNote$MidiNumber(56),
																																					_1: {
																																						name: 'G3#',
																																						freq: _user$project$MusicNote$Freq(207.65)
																																					}
																																				},
																																				_1: {
																																					ctor: '::',
																																					_0: {
																																						ctor: '_Tuple2',
																																						_0: _user$project$MusicNote$MidiNumber(57),
																																						_1: {
																																							name: 'A3',
																																							freq: _user$project$MusicNote$Freq(220.0)
																																						}
																																					},
																																					_1: {
																																						ctor: '::',
																																						_0: {
																																							ctor: '_Tuple2',
																																							_0: _user$project$MusicNote$MidiNumber(58),
																																							_1: {
																																								name: 'A3#',
																																								freq: _user$project$MusicNote$Freq(233.08)
																																							}
																																						},
																																						_1: {
																																							ctor: '::',
																																							_0: {
																																								ctor: '_Tuple2',
																																								_0: _user$project$MusicNote$MidiNumber(59),
																																								_1: {
																																									name: 'B3',
																																									freq: _user$project$MusicNote$Freq(246.94)
																																								}
																																							},
																																							_1: {
																																								ctor: '::',
																																								_0: {
																																									ctor: '_Tuple2',
																																									_0: _user$project$MusicNote$MidiNumber(60),
																																									_1: {
																																										name: 'C4',
																																										freq: _user$project$MusicNote$Freq(261.63)
																																									}
																																								},
																																								_1: {
																																									ctor: '::',
																																									_0: {
																																										ctor: '_Tuple2',
																																										_0: _user$project$MusicNote$MidiNumber(61),
																																										_1: {
																																											name: 'C4#',
																																											freq: _user$project$MusicNote$Freq(277.18)
																																										}
																																									},
																																									_1: {
																																										ctor: '::',
																																										_0: {
																																											ctor: '_Tuple2',
																																											_0: _user$project$MusicNote$MidiNumber(62),
																																											_1: {
																																												name: 'D4',
																																												freq: _user$project$MusicNote$Freq(293.67)
																																											}
																																										},
																																										_1: {
																																											ctor: '::',
																																											_0: {
																																												ctor: '_Tuple2',
																																												_0: _user$project$MusicNote$MidiNumber(63),
																																												_1: {
																																													name: 'D4#',
																																													freq: _user$project$MusicNote$Freq(311.13)
																																												}
																																											},
																																											_1: {
																																												ctor: '::',
																																												_0: {
																																													ctor: '_Tuple2',
																																													_0: _user$project$MusicNote$MidiNumber(64),
																																													_1: {
																																														name: 'E4',
																																														freq: _user$project$MusicNote$Freq(329.63)
																																													}
																																												},
																																												_1: {
																																													ctor: '::',
																																													_0: {
																																														ctor: '_Tuple2',
																																														_0: _user$project$MusicNote$MidiNumber(65),
																																														_1: {
																																															name: 'F4',
																																															freq: _user$project$MusicNote$Freq(349.23)
																																														}
																																													},
																																													_1: {
																																														ctor: '::',
																																														_0: {
																																															ctor: '_Tuple2',
																																															_0: _user$project$MusicNote$MidiNumber(66),
																																															_1: {
																																																name: 'F4#',
																																																freq: _user$project$MusicNote$Freq(369.99)
																																															}
																																														},
																																														_1: {
																																															ctor: '::',
																																															_0: {
																																																ctor: '_Tuple2',
																																																_0: _user$project$MusicNote$MidiNumber(67),
																																																_1: {
																																																	name: 'G4',
																																																	freq: _user$project$MusicNote$Freq(392.0)
																																																}
																																															},
																																															_1: {
																																																ctor: '::',
																																																_0: {
																																																	ctor: '_Tuple2',
																																																	_0: _user$project$MusicNote$MidiNumber(68),
																																																	_1: {
																																																		name: 'G4#',
																																																		freq: _user$project$MusicNote$Freq(415.3)
																																																	}
																																																},
																																																_1: {
																																																	ctor: '::',
																																																	_0: {
																																																		ctor: '_Tuple2',
																																																		_0: _user$project$MusicNote$MidiNumber(69),
																																																		_1: {
																																																			name: 'A4',
																																																			freq: _user$project$MusicNote$Freq(440.0)
																																																		}
																																																	},
																																																	_1: {
																																																		ctor: '::',
																																																		_0: {
																																																			ctor: '_Tuple2',
																																																			_0: _user$project$MusicNote$MidiNumber(70),
																																																			_1: {
																																																				name: 'A4#',
																																																				freq: _user$project$MusicNote$Freq(466.16)
																																																			}
																																																		},
																																																		_1: {
																																																			ctor: '::',
																																																			_0: {
																																																				ctor: '_Tuple2',
																																																				_0: _user$project$MusicNote$MidiNumber(71),
																																																				_1: {
																																																					name: 'B4',
																																																					freq: _user$project$MusicNote$Freq(493.88)
																																																				}
																																																			},
																																																			_1: {
																																																				ctor: '::',
																																																				_0: {
																																																					ctor: '_Tuple2',
																																																					_0: _user$project$MusicNote$MidiNumber(72),
																																																					_1: {
																																																						name: 'C5',
																																																						freq: _user$project$MusicNote$Freq(523.25)
																																																					}
																																																				},
																																																				_1: {
																																																					ctor: '::',
																																																					_0: {
																																																						ctor: '_Tuple2',
																																																						_0: _user$project$MusicNote$MidiNumber(73),
																																																						_1: {
																																																							name: 'C5#',
																																																							freq: _user$project$MusicNote$Freq(554.37)
																																																						}
																																																					},
																																																					_1: {
																																																						ctor: '::',
																																																						_0: {
																																																							ctor: '_Tuple2',
																																																							_0: _user$project$MusicNote$MidiNumber(74),
																																																							_1: {
																																																								name: 'D5',
																																																								freq: _user$project$MusicNote$Freq(587.33)
																																																							}
																																																						},
																																																						_1: {
																																																							ctor: '::',
																																																							_0: {
																																																								ctor: '_Tuple2',
																																																								_0: _user$project$MusicNote$MidiNumber(75),
																																																								_1: {
																																																									name: 'D5#',
																																																									freq: _user$project$MusicNote$Freq(622.25)
																																																								}
																																																							},
																																																							_1: {
																																																								ctor: '::',
																																																								_0: {
																																																									ctor: '_Tuple2',
																																																									_0: _user$project$MusicNote$MidiNumber(76),
																																																									_1: {
																																																										name: 'E5',
																																																										freq: _user$project$MusicNote$Freq(659.26)
																																																									}
																																																								},
																																																								_1: {
																																																									ctor: '::',
																																																									_0: {
																																																										ctor: '_Tuple2',
																																																										_0: _user$project$MusicNote$MidiNumber(77),
																																																										_1: {
																																																											name: 'F5',
																																																											freq: _user$project$MusicNote$Freq(698.46)
																																																										}
																																																									},
																																																									_1: {
																																																										ctor: '::',
																																																										_0: {
																																																											ctor: '_Tuple2',
																																																											_0: _user$project$MusicNote$MidiNumber(78),
																																																											_1: {
																																																												name: 'F5#',
																																																												freq: _user$project$MusicNote$Freq(739.99)
																																																											}
																																																										},
																																																										_1: {
																																																											ctor: '::',
																																																											_0: {
																																																												ctor: '_Tuple2',
																																																												_0: _user$project$MusicNote$MidiNumber(79),
																																																												_1: {
																																																													name: 'G5',
																																																													freq: _user$project$MusicNote$Freq(783.99)
																																																												}
																																																											},
																																																											_1: {
																																																												ctor: '::',
																																																												_0: {
																																																													ctor: '_Tuple2',
																																																													_0: _user$project$MusicNote$MidiNumber(80),
																																																													_1: {
																																																														name: 'G5#',
																																																														freq: _user$project$MusicNote$Freq(830.61)
																																																													}
																																																												},
																																																												_1: {
																																																													ctor: '::',
																																																													_0: {
																																																														ctor: '_Tuple2',
																																																														_0: _user$project$MusicNote$MidiNumber(81),
																																																														_1: {
																																																															name: 'A5',
																																																															freq: _user$project$MusicNote$Freq(880.0)
																																																														}
																																																													},
																																																													_1: {
																																																														ctor: '::',
																																																														_0: {
																																																															ctor: '_Tuple2',
																																																															_0: _user$project$MusicNote$MidiNumber(82),
																																																															_1: {
																																																																name: 'A5#',
																																																																freq: _user$project$MusicNote$Freq(932.33)
																																																															}
																																																														},
																																																														_1: {
																																																															ctor: '::',
																																																															_0: {
																																																																ctor: '_Tuple2',
																																																																_0: _user$project$MusicNote$MidiNumber(83),
																																																																_1: {
																																																																	name: 'B5',
																																																																	freq: _user$project$MusicNote$Freq(987.77)
																																																																}
																																																															},
																																																															_1: {
																																																																ctor: '::',
																																																																_0: {
																																																																	ctor: '_Tuple2',
																																																																	_0: _user$project$MusicNote$MidiNumber(84),
																																																																	_1: {
																																																																		name: 'C6',
																																																																		freq: _user$project$MusicNote$Freq(1046.5)
																																																																	}
																																																																},
																																																																_1: {
																																																																	ctor: '::',
																																																																	_0: {
																																																																		ctor: '_Tuple2',
																																																																		_0: _user$project$MusicNote$MidiNumber(85),
																																																																		_1: {
																																																																			name: 'C6#',
																																																																			freq: _user$project$MusicNote$Freq(1108.7)
																																																																		}
																																																																	},
																																																																	_1: {
																																																																		ctor: '::',
																																																																		_0: {
																																																																			ctor: '_Tuple2',
																																																																			_0: _user$project$MusicNote$MidiNumber(86),
																																																																			_1: {
																																																																				name: 'D6',
																																																																				freq: _user$project$MusicNote$Freq(1174.7)
																																																																			}
																																																																		},
																																																																		_1: {
																																																																			ctor: '::',
																																																																			_0: {
																																																																				ctor: '_Tuple2',
																																																																				_0: _user$project$MusicNote$MidiNumber(87),
																																																																				_1: {
																																																																					name: 'D6#',
																																																																					freq: _user$project$MusicNote$Freq(1244.5)
																																																																				}
																																																																			},
																																																																			_1: {
																																																																				ctor: '::',
																																																																				_0: {
																																																																					ctor: '_Tuple2',
																																																																					_0: _user$project$MusicNote$MidiNumber(88),
																																																																					_1: {
																																																																						name: 'E6',
																																																																						freq: _user$project$MusicNote$Freq(1318.5)
																																																																					}
																																																																				},
																																																																				_1: {
																																																																					ctor: '::',
																																																																					_0: {
																																																																						ctor: '_Tuple2',
																																																																						_0: _user$project$MusicNote$MidiNumber(89),
																																																																						_1: {
																																																																							name: 'F6',
																																																																							freq: _user$project$MusicNote$Freq(1396.9)
																																																																						}
																																																																					},
																																																																					_1: {
																																																																						ctor: '::',
																																																																						_0: {
																																																																							ctor: '_Tuple2',
																																																																							_0: _user$project$MusicNote$MidiNumber(90),
																																																																							_1: {
																																																																								name: 'F6#',
																																																																								freq: _user$project$MusicNote$Freq(1480.0)
																																																																							}
																																																																						},
																																																																						_1: {
																																																																							ctor: '::',
																																																																							_0: {
																																																																								ctor: '_Tuple2',
																																																																								_0: _user$project$MusicNote$MidiNumber(91),
																																																																								_1: {
																																																																									name: 'G6',
																																																																									freq: _user$project$MusicNote$Freq(1568.0)
																																																																								}
																																																																							},
																																																																							_1: {
																																																																								ctor: '::',
																																																																								_0: {
																																																																									ctor: '_Tuple2',
																																																																									_0: _user$project$MusicNote$MidiNumber(92),
																																																																									_1: {
																																																																										name: 'G6#',
																																																																										freq: _user$project$MusicNote$Freq(1661.2)
																																																																									}
																																																																								},
																																																																								_1: {
																																																																									ctor: '::',
																																																																									_0: {
																																																																										ctor: '_Tuple2',
																																																																										_0: _user$project$MusicNote$MidiNumber(93),
																																																																										_1: {
																																																																											name: 'A6',
																																																																											freq: _user$project$MusicNote$Freq(1760.0)
																																																																										}
																																																																									},
																																																																									_1: {
																																																																										ctor: '::',
																																																																										_0: {
																																																																											ctor: '_Tuple2',
																																																																											_0: _user$project$MusicNote$MidiNumber(94),
																																																																											_1: {
																																																																												name: 'A6#',
																																																																												freq: _user$project$MusicNote$Freq(1864.7)
																																																																											}
																																																																										},
																																																																										_1: {
																																																																											ctor: '::',
																																																																											_0: {
																																																																												ctor: '_Tuple2',
																																																																												_0: _user$project$MusicNote$MidiNumber(95),
																																																																												_1: {
																																																																													name: 'B6',
																																																																													freq: _user$project$MusicNote$Freq(1975.5)
																																																																												}
																																																																											},
																																																																											_1: {
																																																																												ctor: '::',
																																																																												_0: {
																																																																													ctor: '_Tuple2',
																																																																													_0: _user$project$MusicNote$MidiNumber(96),
																																																																													_1: {
																																																																														name: 'C7',
																																																																														freq: _user$project$MusicNote$Freq(2093.0)
																																																																													}
																																																																												},
																																																																												_1: {
																																																																													ctor: '::',
																																																																													_0: {
																																																																														ctor: '_Tuple2',
																																																																														_0: _user$project$MusicNote$MidiNumber(97),
																																																																														_1: {
																																																																															name: 'C7#',
																																																																															freq: _user$project$MusicNote$Freq(2217.5)
																																																																														}
																																																																													},
																																																																													_1: {
																																																																														ctor: '::',
																																																																														_0: {
																																																																															ctor: '_Tuple2',
																																																																															_0: _user$project$MusicNote$MidiNumber(98),
																																																																															_1: {
																																																																																name: 'D7',
																																																																																freq: _user$project$MusicNote$Freq(2349.3)
																																																																															}
																																																																														},
																																																																														_1: {
																																																																															ctor: '::',
																																																																															_0: {
																																																																																ctor: '_Tuple2',
																																																																																_0: _user$project$MusicNote$MidiNumber(99),
																																																																																_1: {
																																																																																	name: 'D7#',
																																																																																	freq: _user$project$MusicNote$Freq(2489.0)
																																																																																}
																																																																															},
																																																																															_1: {
																																																																																ctor: '::',
																																																																																_0: {
																																																																																	ctor: '_Tuple2',
																																																																																	_0: _user$project$MusicNote$MidiNumber(100),
																																																																																	_1: {
																																																																																		name: 'E7',
																																																																																		freq: _user$project$MusicNote$Freq(2637.0)
																																																																																	}
																																																																																},
																																																																																_1: {
																																																																																	ctor: '::',
																																																																																	_0: {
																																																																																		ctor: '_Tuple2',
																																																																																		_0: _user$project$MusicNote$MidiNumber(101),
																																																																																		_1: {
																																																																																			name: 'F7',
																																																																																			freq: _user$project$MusicNote$Freq(2793.0)
																																																																																		}
																																																																																	},
																																																																																	_1: {
																																																																																		ctor: '::',
																																																																																		_0: {
																																																																																			ctor: '_Tuple2',
																																																																																			_0: _user$project$MusicNote$MidiNumber(102),
																																																																																			_1: {
																																																																																				name: 'F7#',
																																																																																				freq: _user$project$MusicNote$Freq(2960.0)
																																																																																			}
																																																																																		},
																																																																																		_1: {
																																																																																			ctor: '::',
																																																																																			_0: {
																																																																																				ctor: '_Tuple2',
																																																																																				_0: _user$project$MusicNote$MidiNumber(103),
																																																																																				_1: {
																																																																																					name: 'G7',
																																																																																					freq: _user$project$MusicNote$Freq(3136.0)
																																																																																				}
																																																																																			},
																																																																																			_1: {
																																																																																				ctor: '::',
																																																																																				_0: {
																																																																																					ctor: '_Tuple2',
																																																																																					_0: _user$project$MusicNote$MidiNumber(104),
																																																																																					_1: {
																																																																																						name: 'G7#',
																																																																																						freq: _user$project$MusicNote$Freq(3322.4)
																																																																																					}
																																																																																				},
																																																																																				_1: {
																																																																																					ctor: '::',
																																																																																					_0: {
																																																																																						ctor: '_Tuple2',
																																																																																						_0: _user$project$MusicNote$MidiNumber(105),
																																																																																						_1: {
																																																																																							name: 'A7',
																																																																																							freq: _user$project$MusicNote$Freq(3520.0)
																																																																																						}
																																																																																					},
																																																																																					_1: {
																																																																																						ctor: '::',
																																																																																						_0: {
																																																																																							ctor: '_Tuple2',
																																																																																							_0: _user$project$MusicNote$MidiNumber(106),
																																																																																							_1: {
																																																																																								name: 'A7#',
																																																																																								freq: _user$project$MusicNote$Freq(3729.3)
																																																																																							}
																																																																																						},
																																																																																						_1: {
																																																																																							ctor: '::',
																																																																																							_0: {
																																																																																								ctor: '_Tuple2',
																																																																																								_0: _user$project$MusicNote$MidiNumber(107),
																																																																																								_1: {
																																																																																									name: 'B7',
																																																																																									freq: _user$project$MusicNote$Freq(3951.1)
																																																																																								}
																																																																																							},
																																																																																							_1: {
																																																																																								ctor: '::',
																																																																																								_0: {
																																																																																									ctor: '_Tuple2',
																																																																																									_0: _user$project$MusicNote$MidiNumber(108),
																																																																																									_1: {
																																																																																										name: 'C8',
																																																																																										freq: _user$project$MusicNote$Freq(4186.0)
																																																																																									}
																																																																																								},
																																																																																								_1: {ctor: '[]'}
																																																																																							}
																																																																																						}
																																																																																					}
																																																																																				}
																																																																																			}
																																																																																		}
																																																																																	}
																																																																																}
																																																																															}
																																																																														}
																																																																													}
																																																																												}
																																																																											}
																																																																										}
																																																																									}
																																																																								}
																																																																							}
																																																																						}
																																																																					}
																																																																				}
																																																																			}
																																																																		}
																																																																	}
																																																																}
																																																															}
																																																														}
																																																													}
																																																												}
																																																											}
																																																										}
																																																									}
																																																								}
																																																							}
																																																						}
																																																					}
																																																				}
																																																			}
																																																		}
																																																	}
																																																}
																																															}
																																														}
																																													}
																																												}
																																											}
																																										}
																																									}
																																								}
																																							}
																																						}
																																					}
																																				}
																																			}
																																		}
																																	}
																																}
																															}
																														}
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
};
var _user$project$MusicNote$notesDict = _eeue56$elm_all_dict$EveryDict$fromList(_user$project$MusicNote$notesList);
var _user$project$MusicNote$displayString = function (_p2) {
	var _p3 = _p2;
	return A2(
		_elm_lang$core$Maybe$map,
		function (_) {
			return _.name;
		},
		A2(_eeue56$elm_all_dict$EveryDict$get, _p3._0, _user$project$MusicNote$notesDict));
};
var _user$project$MusicNote$toFreq = function (_p4) {
	var _p5 = _p4;
	return A2(
		_elm_lang$core$Maybe$map,
		function (_) {
			return _.freq;
		},
		A2(_eeue56$elm_all_dict$EveryDict$get, _p5._0, _user$project$MusicNote$notesDict));
};
var _user$project$MusicNote$minMidiNumber = _elm_lang$core$Tuple$first(
	A2(
		_elm_lang$core$Maybe$withDefault,
		{
			ctor: '_Tuple2',
			_0: _user$project$MusicNote$MidiNumber(0),
			_1: {
				freq: _user$project$MusicNote$Freq(0.0),
				name: ''
			}
		},
		_elm_lang$core$List$head(_user$project$MusicNote$notesList)));
var _user$project$MusicNote$maxMidiNumber = _elm_lang$core$Tuple$first(
	A2(
		_elm_lang$core$Maybe$withDefault,
		{
			ctor: '_Tuple2',
			_0: _user$project$MusicNote$MidiNumber(0),
			_1: {
				freq: _user$project$MusicNote$Freq(0.0),
				name: ''
			}
		},
		_elm_community$list_extra$List_Extra$last(_user$project$MusicNote$notesList)));
var _user$project$MusicNote$isMidiNumberWithinRange = function (_p6) {
	var _p7 = _p6;
	var _p10 = _p7._0;
	var _p8 = _user$project$MusicNote$maxMidiNumber;
	var max = _p8._0;
	var _p9 = _user$project$MusicNote$minMidiNumber;
	var min = _p9._0;
	return (_elm_lang$core$Native_Utils.cmp(_p10, min) > -1) && (_elm_lang$core$Native_Utils.cmp(_p10, max) < 1);
};
var _user$project$MusicNote_ops = _user$project$MusicNote_ops || {};
_user$project$MusicNote_ops[':+:'] = F2(
	function (mbNote, delta) {
		var _p11 = mbNote;
		if (_p11.ctor === 'Just') {
			var result = _user$project$MusicNote$MidiNumber(_p11._0._0._0 + delta);
			return _user$project$MusicNote$isMidiNumberWithinRange(result) ? _elm_lang$core$Maybe$Just(
				_user$project$MusicNote$MusicNote(result)) : _elm_lang$core$Maybe$Nothing;
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	});
var _user$project$MusicNote_ops = _user$project$MusicNote_ops || {};
_user$project$MusicNote_ops[':-:'] = F2(
	function (mbNote, delta) {
		return A2(
			F2(
				function (x, y) {
					return A2(_user$project$MusicNote_ops[':+:'], x, y);
				}),
			mbNote,
			_elm_lang$core$Basics$negate(delta));
	});

var _user$project$AudioNote$AudioNote = F6(
	function (a, b, c, d, e, f) {
		return {freq: a, id: b, startOffset: c, duration: d, isHarmonize: e, isLast: f};
	});
var _user$project$AudioNote$audioNote = F6(
	function (mbNote, mbId, startOffsetMsec, durationMsec, isHarmonize, isLast) {
		var fn = function (_p0) {
			var _p1 = _p0;
			var duration = _elm_lang$core$Time$inSeconds(durationMsec);
			var startOffset = _elm_lang$core$Time$inSeconds(startOffsetMsec);
			var id = A3(_elm_community$maybe_extra$Maybe_Extra$unwrap, '', _danyx23$elm_uuid$Uuid$toString, mbId);
			return A6(_user$project$AudioNote$AudioNote, _p1._0, id, startOffset, duration, isHarmonize, isLast);
		};
		var mbFreq = A2(_elm_lang$core$Maybe$andThen, _user$project$MusicNote$toFreq, mbNote);
		return A2(_elm_lang$core$Maybe$map, fn, mbFreq);
	});

var _user$project$MaybeSafe$compare = F2(
	function (mbsC, mbsD) {
		var _p0 = {ctor: '_Tuple2', _0: mbsC, _1: mbsD};
		if (_p0._0.ctor === 'Safe') {
			if (_p0._1.ctor === 'Safe') {
				return A2(_elm_lang$core$Basics$compare, _p0._0._0, _p0._1._0);
			} else {
				return _elm_lang$core$Basics$LT;
			}
		} else {
			if (_p0._1.ctor === 'Unsafe') {
				return _elm_lang$core$Basics$EQ;
			} else {
				return _elm_lang$core$Basics$GT;
			}
		}
	});
var _user$project$MaybeSafe$unwrap = F3(
	function ($default, fn, mbsVal) {
		var _p1 = mbsVal;
		if (_p1.ctor === 'Unsafe') {
			return $default;
		} else {
			return fn(_p1._0);
		}
	});
var _user$project$MaybeSafe$withDefault = F2(
	function ($default, mbsA) {
		return A3(_user$project$MaybeSafe$unwrap, $default, _elm_lang$core$Basics$identity, mbsA);
	});
var _user$project$MaybeSafe$Safe = function (a) {
	return {ctor: 'Safe', _0: a};
};
var _user$project$MaybeSafe$Unsafe = {ctor: 'Unsafe'};
var _user$project$MaybeSafe$toMaybeSafe = F2(
	function (isSafe, a) {
		return isSafe(a) ? _user$project$MaybeSafe$Safe(a) : _user$project$MaybeSafe$Unsafe;
	});
var _user$project$MaybeSafe$toMaybeSafeInt = function ($int) {
	return A2(_user$project$MaybeSafe$toMaybeSafe, _elm_community$basics_extra$Basics_Extra$isSafeInteger, $int);
};
var _user$project$MaybeSafe$isUnsafe = function (mbsA) {
	return _elm_lang$core$Native_Utils.eq(mbsA, _user$project$MaybeSafe$Unsafe);
};
var _user$project$MaybeSafe$isSafe = function (mbsA) {
	return !_user$project$MaybeSafe$isUnsafe(mbsA);
};
var _user$project$MaybeSafe$toOnlySafe = F2(
	function (unusedDefault, list) {
		return A2(
			_elm_lang$core$List$map,
			_user$project$MaybeSafe$withDefault(unusedDefault),
			A2(_elm_lang$core$List$filter, _user$project$MaybeSafe$isSafe, list));
	});
var _user$project$MaybeSafe$toOnlySafeInt = function (list) {
	return A2(_user$project$MaybeSafe$toOnlySafe, 0, list);
};
var _user$project$MaybeSafe$sumMaybeSafeInt = function (list) {
	if (A2(_elm_lang$core$List$any, _user$project$MaybeSafe$isUnsafe, list)) {
		return _user$project$MaybeSafe$Unsafe;
	} else {
		var intermediateResults = A2(
			_elm_lang$core$List$map,
			_user$project$MaybeSafe$toMaybeSafeInt,
			A3(
				_elm_lang$core$List$scanl,
				F2(
					function (x, y) {
						return x + y;
					}),
				0,
				_user$project$MaybeSafe$toOnlySafeInt(list)));
		return A2(_elm_lang$core$List$any, _user$project$MaybeSafe$isUnsafe, intermediateResults) ? _user$project$MaybeSafe$Unsafe : A2(
			_elm_lang$core$Maybe$withDefault,
			_user$project$MaybeSafe$Safe(0),
			_elm_community$list_extra$List_Extra$last(intermediateResults));
	}
};
var _user$project$MaybeSafe$map = F2(
	function (fn, mbsA) {
		return A3(_user$project$MaybeSafe$unwrap, _user$project$MaybeSafe$Unsafe, fn, mbsA);
	});

var _user$project$UniversalConstants$unsafeString = 'unsafe';
var _user$project$UniversalConstants$nothingString = 'N/A';

var _user$project$MusicNotePlayer$toFreq = function (_p0) {
	var _p1 = _p0;
	return A2(_elm_lang$core$Maybe$andThen, _user$project$MusicNote$toFreq, _p1._0.mbNote);
};
var _user$project$MusicNotePlayer$toFreqString = function (x) {
	return A3(
		_elm_community$maybe_extra$Maybe_Extra$unwrap,
		_user$project$UniversalConstants$nothingString,
		function (_p2) {
			var _p3 = _p2;
			return A2(
				_elm_lang$core$Basics_ops['++'],
				_elm_lang$core$Basics$toString(_p3._0),
				' hz');
		},
		_user$project$MusicNotePlayer$toFreq(x));
};
var _user$project$MusicNotePlayer$isPlayable = function (_p4) {
	var _p5 = _p4;
	return _elm_community$maybe_extra$Maybe_Extra$isJust(_p5._0.mbNote);
};
var _user$project$MusicNotePlayer$sorter = function (_p6) {
	var _p7 = _p6;
	return _user$project$MusicNote$mbSorter(_p7._0.mbNote);
};
var _user$project$MusicNotePlayer$MusicNotePlayer = function (a) {
	return {ctor: 'MusicNotePlayer', _0: a};
};
var _user$project$MusicNotePlayer$idedOn = F2(
	function (mbId, note) {
		return _user$project$MusicNotePlayer$MusicNotePlayer(
			{
				mbNote: _elm_lang$core$Maybe$Just(note),
				isPlaying: false,
				mbId: mbId
			});
	});
var _user$project$MusicNotePlayer$on = function (note) {
	return A2(_user$project$MusicNotePlayer$idedOn, _elm_lang$core$Maybe$Nothing, note);
};

var _user$project$NodeTag$IntNodeVal = function (a) {
	return {ctor: 'IntNodeVal', _0: a};
};
var _user$project$NodeTag$BigIntNodeVal = function (a) {
	return {ctor: 'BigIntNodeVal', _0: a};
};
var _user$project$NodeTag$StringNodeVal = function (a) {
	return {ctor: 'StringNodeVal', _0: a};
};
var _user$project$NodeTag$BoolNodeVal = function (a) {
	return {ctor: 'BoolNodeVal', _0: a};
};
var _user$project$NodeTag$MusicNoteNodeVal = function (a) {
	return {ctor: 'MusicNoteNodeVal', _0: a};
};
var _user$project$NodeTag$NothingNodeVal = {ctor: 'NothingNodeVal'};
var _user$project$NodeTag$NothingVariety = function (a) {
	return {ctor: 'NothingVariety', _0: a};
};
var _user$project$NodeTag$MusicNoteVariety = function (a) {
	return {ctor: 'MusicNoteVariety', _0: a};
};
var _user$project$NodeTag$BoolVariety = function (a) {
	return {ctor: 'BoolVariety', _0: a};
};
var _user$project$NodeTag$StringVariety = function (a) {
	return {ctor: 'StringVariety', _0: a};
};
var _user$project$NodeTag$BigIntVariety = function (a) {
	return {ctor: 'BigIntVariety', _0: a};
};
var _user$project$NodeTag$IntVariety = function (a) {
	return {ctor: 'IntVariety', _0: a};
};

var _user$project$BTree$ordererBy = F3(
	function (fn, a1, a2) {
		return A2(
			_elm_lang$core$Basics$compare,
			fn(a1),
			fn(a2));
	});
var _user$project$BTree$foldBy = F4(
	function (order, fn, accumulator, bTree) {
		var _p0 = bTree;
		if (_p0.ctor === 'Empty') {
			return accumulator;
		} else {
			var _p4 = _p0._0;
			var _p3 = _p0._2;
			var _p2 = _p0._1;
			var _p1 = order;
			switch (_p1.ctor) {
				case 'InOrder':
					var resultLeft = A4(_user$project$BTree$foldBy, order, fn, accumulator, _p2);
					var resultEval = A2(fn, _p4, resultLeft);
					var resultRight = A4(_user$project$BTree$foldBy, order, fn, resultEval, _p3);
					return resultRight;
				case 'PreOrder':
					var resultEval = A2(fn, _p4, accumulator);
					var resultLeft = A4(_user$project$BTree$foldBy, order, fn, resultEval, _p2);
					var resultRight = A4(_user$project$BTree$foldBy, order, fn, resultLeft, _p3);
					return resultRight;
				default:
					var resultLeft = A4(_user$project$BTree$foldBy, order, fn, accumulator, _p2);
					var resultRight = A4(_user$project$BTree$foldBy, order, fn, resultLeft, _p3);
					var resultEval = A2(fn, _p4, resultRight);
					return resultEval;
			}
		}
	});
var _user$project$BTree$flattenUsingFoldBy = F2(
	function (order, bTree) {
		var seed = {ctor: '[]'};
		var fn = F2(
			function (a, list) {
				return A2(
					_elm_lang$core$Basics_ops['++'],
					list,
					{
						ctor: '::',
						_0: a,
						_1: {ctor: '[]'}
					});
			});
		return A4(_user$project$BTree$foldBy, order, fn, seed, bTree);
	});
var _user$project$BTree$flattenBy = F2(
	function (order, bTree) {
		var _p5 = bTree;
		if (_p5.ctor === 'Empty') {
			return {ctor: '[]'};
		} else {
			var _p9 = _p5._0;
			var _p8 = _p5._2;
			var _p7 = _p5._1;
			var _p6 = order;
			switch (_p6.ctor) {
				case 'InOrder':
					var resultRight = A2(_user$project$BTree$flattenBy, order, _p8);
					var resultLeft = A2(_user$project$BTree$flattenBy, order, _p7);
					return A2(
						_elm_lang$core$Basics_ops['++'],
						resultLeft,
						A2(
							_elm_lang$core$Basics_ops['++'],
							{
								ctor: '::',
								_0: _p9,
								_1: {ctor: '[]'}
							},
							resultRight));
				case 'PreOrder':
					var resultRight = A2(_user$project$BTree$flattenBy, order, _p8);
					var resultLeft = A2(_user$project$BTree$flattenBy, order, _p7);
					return A2(
						_elm_lang$core$Basics_ops['++'],
						{
							ctor: '::',
							_0: _p9,
							_1: {ctor: '[]'}
						},
						A2(_elm_lang$core$Basics_ops['++'], resultLeft, resultRight));
				default:
					var resultRight = A2(_user$project$BTree$flattenBy, order, _p8);
					var resultLeft = A2(_user$project$BTree$flattenBy, order, _p7);
					return A2(
						_elm_lang$core$Basics_ops['++'],
						resultLeft,
						A2(
							_elm_lang$core$Basics_ops['++'],
							resultRight,
							{
								ctor: '::',
								_0: _p9,
								_1: {ctor: '[]'}
							}));
			}
		}
	});
var _user$project$BTree$isElement = F2(
	function (a, bTree) {
		var _p10 = bTree;
		if (_p10.ctor === 'Empty') {
			return false;
		} else {
			return _elm_lang$core$Native_Utils.eq(_p10._0, a) ? true : (A2(_user$project$BTree$isElement, a, _p10._1) || A2(_user$project$BTree$isElement, a, _p10._2));
		}
	});
var _user$project$BTree$depth = function (bTree) {
	var _p11 = bTree;
	if (_p11.ctor === 'Empty') {
		return 0;
	} else {
		return 1 + A2(
			_elm_lang$core$Basics$max,
			_user$project$BTree$depth(_p11._1),
			_user$project$BTree$depth(_p11._2));
	}
};
var _user$project$BTree$Node = F3(
	function (a, b, c) {
		return {ctor: 'Node', _0: a, _1: b, _2: c};
	});
var _user$project$BTree$Empty = {ctor: 'Empty'};
var _user$project$BTree$singleton = function (v) {
	return A3(_user$project$BTree$Node, v, _user$project$BTree$Empty, _user$project$BTree$Empty);
};
var _user$project$BTree$insertWith_directed = F4(
	function (direction, fn, x, bTree) {
		var _p12 = bTree;
		if (_p12.ctor === 'Empty') {
			return _user$project$BTree$singleton(x);
		} else {
			var _p16 = _p12._0;
			var _p15 = _p12._2;
			var _p14 = _p12._1;
			var insertRight = function (unit) {
				return A3(
					_user$project$BTree$Node,
					_p16,
					_p14,
					A4(_user$project$BTree$insertWith_directed, direction, fn, x, _p15));
			};
			var insertLeft = function (unit) {
				return A3(
					_user$project$BTree$Node,
					_p16,
					A4(_user$project$BTree$insertWith_directed, direction, fn, x, _p14),
					_p15);
			};
			var order = A2(fn, x, _p16);
			var _p13 = {ctor: '_Tuple2', _0: order, _1: direction};
			if (_p13._1.ctor === 'Right') {
				switch (_p13._0.ctor) {
					case 'LT':
						return insertRight(
							{ctor: '_Tuple0'});
					case 'EQ':
						return insertLeft(
							{ctor: '_Tuple0'});
					default:
						return insertLeft(
							{ctor: '_Tuple0'});
				}
			} else {
				switch (_p13._0.ctor) {
					case 'LT':
						return insertLeft(
							{ctor: '_Tuple0'});
					case 'EQ':
						return insertRight(
							{ctor: '_Tuple0'});
					default:
						return insertRight(
							{ctor: '_Tuple0'});
				}
			}
		}
	});
var _user$project$BTree$insertAsIs_directed = F2(
	function (_p17, bTree) {
		var _p18 = _p17;
		var _p26 = _p18._0;
		var _p25 = _p18._1;
		var _p19 = bTree;
		if (_p19.ctor === 'Empty') {
			return _user$project$BTree$singleton(_p26);
		} else {
			var _p24 = _p19._0;
			var _p23 = _p19._2;
			var _p22 = _p19._1;
			var $continue = function (unit) {
				var _p20 = _p25;
				if (_p20.ctor === 'Right') {
					return A3(
						_user$project$BTree$Node,
						_p24,
						_p22,
						A2(
							_user$project$BTree$insertAsIs_directed,
							{ctor: '_Tuple2', _0: _p26, _1: _p25},
							_p23));
				} else {
					return A3(
						_user$project$BTree$Node,
						_p24,
						A2(
							_user$project$BTree$insertAsIs_directed,
							{ctor: '_Tuple2', _0: _p26, _1: _p25},
							_p22),
						_p23);
				}
			};
			var _p21 = {ctor: '_Tuple2', _0: _p22, _1: _p23};
			if (_p21._0.ctor === 'Empty') {
				if (_p21._1.ctor === 'Empty') {
					return $continue(
						{ctor: '_Tuple0'});
				} else {
					return A3(
						_user$project$BTree$Node,
						_p24,
						_user$project$BTree$singleton(_p26),
						_p23);
				}
			} else {
				if (_p21._1.ctor === 'Empty') {
					return A3(
						_user$project$BTree$Node,
						_p24,
						_p22,
						_user$project$BTree$singleton(_p26));
				} else {
					return $continue(
						{ctor: '_Tuple0'});
				}
			}
		}
	});
var _user$project$BTree$insertAsIsBy = F3(
	function (direction, x, bTree) {
		return A2(
			_user$project$BTree$insertAsIs_directed,
			{ctor: '_Tuple2', _0: x, _1: direction},
			bTree);
	});
var _user$project$BTree$map = F2(
	function (fn, bTree) {
		var _p27 = bTree;
		if (_p27.ctor === 'Empty') {
			return _user$project$BTree$Empty;
		} else {
			return A3(
				_user$project$BTree$Node,
				fn(_p27._0),
				A2(_user$project$BTree$map, fn, _p27._1),
				A2(_user$project$BTree$map, fn, _p27._2));
		}
	});
var _user$project$BTree$toNothingNodes = function (bTree) {
	return A2(
		_user$project$BTree$map,
		function (a) {
			return _user$project$NodeTag$NothingNodeVal;
		},
		bTree);
};
var _user$project$BTree$fromListAsIsBy = F2(
	function (direction, xs) {
		return A3(
			_elm_lang$core$List$foldl,
			_user$project$BTree$insertAsIsBy(direction),
			_user$project$BTree$Empty,
			xs);
	});
var _user$project$BTree$fromListAsIs_directed = function (xs) {
	return A3(_elm_lang$core$List$foldl, _user$project$BTree$insertAsIs_directed, _user$project$BTree$Empty, xs);
};
var _user$project$BTree$isEmpty = function (bTree) {
	return _elm_lang$core$Native_Utils.eq(bTree, _user$project$BTree$Empty);
};
var _user$project$BTree$toTreeDiagramTree = function (bTree) {
	var toTreeDiagramTreeOfNonEmpty = function (bTree) {
		var _p28 = bTree;
		if (_p28.ctor === 'Empty') {
			return A2(
				_brenden$elm_tree_diagram$TreeDiagram$node,
				_elm_lang$core$Maybe$Nothing,
				{ctor: '[]'});
		} else {
			var _p30 = _p28._2;
			var _p29 = _p28._1;
			var rightResult = _user$project$BTree$isEmpty(_p30) ? {ctor: '[]'} : {
				ctor: '::',
				_0: toTreeDiagramTreeOfNonEmpty(_p30),
				_1: {ctor: '[]'}
			};
			var leftResult = _user$project$BTree$isEmpty(_p29) ? {ctor: '[]'} : {
				ctor: '::',
				_0: toTreeDiagramTreeOfNonEmpty(_p29),
				_1: {ctor: '[]'}
			};
			var treeList = A2(_elm_lang$core$Basics_ops['++'], leftResult, rightResult);
			return A2(
				_brenden$elm_tree_diagram$TreeDiagram$node,
				_elm_lang$core$Maybe$Just(_p28._0),
				treeList);
		}
	};
	var _p31 = bTree;
	if (_p31.ctor === 'Empty') {
		return _elm_lang$core$Maybe$Nothing;
	} else {
		return _elm_lang$core$Maybe$Just(
			toTreeDiagramTreeOfNonEmpty(bTree));
	}
};
var _user$project$BTree$PostOrder = {ctor: 'PostOrder'};
var _user$project$BTree$PreOrder = {ctor: 'PreOrder'};
var _user$project$BTree$flatten = function (bTree) {
	return A2(_user$project$BTree$flattenBy, _user$project$BTree$PreOrder, bTree);
};
var _user$project$BTree$sumMaybeSafeInt = function (bTree) {
	return _user$project$MaybeSafe$sumMaybeSafeInt(
		_user$project$BTree$flatten(bTree));
};
var _user$project$BTree$sumInt = function (bTree) {
	return _user$project$BTree$sumMaybeSafeInt(
		A2(_user$project$BTree$map, _user$project$MaybeSafe$toMaybeSafeInt, bTree));
};
var _user$project$BTree$sumBigInt = function (bTree) {
	return A3(
		_elm_lang$core$List$foldl,
		_gilbertkennen$bigint$BigInt$add,
		_gilbertkennen$bigint$BigInt$fromInt(0),
		_user$project$BTree$flatten(bTree));
};
var _user$project$BTree$sumFloat = function (bTree) {
	return _elm_lang$core$List$sum(
		_user$project$BTree$flatten(bTree));
};
var _user$project$BTree$isAllSafe = function (bTree) {
	return A2(
		_elm_lang$core$List$all,
		_user$project$MaybeSafe$isSafe,
		_user$project$BTree$flatten(bTree));
};
var _user$project$BTree$sortWithTo = F3(
	function (fn, direction, bTree) {
		return A2(
			_user$project$BTree$fromListAsIsBy,
			direction,
			A2(
				_elm_lang$core$List$sortWith,
				fn,
				_user$project$BTree$flatten(bTree)));
	});
var _user$project$BTree$sortByTo = F3(
	function (fn, direction, bTree) {
		return A3(
			_user$project$BTree$sortWithTo,
			_user$project$BTree$ordererBy(fn),
			direction,
			bTree);
	});
var _user$project$BTree$sortTo = F2(
	function (direction, bTree) {
		return A3(_user$project$BTree$sortByTo, _elm_lang$core$Basics$identity, direction, bTree);
	});
var _user$project$BTree$isAllNothing = function (bTree) {
	return _elm_lang$core$List$isEmpty(
		_elm_community$maybe_extra$Maybe_Extra$values(
			_user$project$BTree$flatten(bTree)));
};
var _user$project$BTree$fold = F3(
	function (fn, accumulator, bTree) {
		return A4(_user$project$BTree$foldBy, _user$project$BTree$PreOrder, fn, accumulator, bTree);
	});
var _user$project$BTree$sumIntUsingFold = function (bTree) {
	var seed = _user$project$MaybeSafe$Safe(0);
	var fn = F2(
		function ($int, mbsInt) {
			return _user$project$MaybeSafe$sumMaybeSafeInt(
				{
					ctor: '::',
					_0: _user$project$MaybeSafe$toMaybeSafeInt($int),
					_1: {
						ctor: '::',
						_0: mbsInt,
						_1: {ctor: '[]'}
					}
				});
		});
	return A3(_user$project$BTree$fold, fn, seed, bTree);
};
var _user$project$BTree$sumFloatUsingFold = function (bTree) {
	var seed = 0.0;
	var fn = F2(
		function (x, y) {
			return x + y;
		});
	return A3(_user$project$BTree$fold, fn, seed, bTree);
};
var _user$project$BTree$sumString = function (bTree) {
	var seed = '';
	var fn = F2(
		function (x, y) {
			return A2(_elm_lang$core$Basics_ops['++'], x, y);
		});
	return A3(_user$project$BTree$fold, fn, seed, bTree);
};
var _user$project$BTree$isElementUsingFold = F2(
	function (a, bTree) {
		var seed = {a: a, isFound: false};
		var fn = F2(
			function (v, accumulator) {
				return accumulator.isFound ? accumulator : (_elm_lang$core$Native_Utils.eq(accumulator.a, v) ? _elm_lang$core$Native_Utils.update(
					accumulator,
					{isFound: true}) : accumulator);
			});
		return A3(_user$project$BTree$fold, fn, seed, bTree).isFound;
	});
var _user$project$BTree$flattenUsingFold = function (bTree) {
	return A2(_user$project$BTree$flattenUsingFoldBy, _user$project$BTree$PreOrder, bTree);
};
var _user$project$BTree$InOrder = {ctor: 'InOrder'};
var _user$project$BTree$traversalOrderOptions = {
	ctor: '::',
	_0: _user$project$BTree$InOrder,
	_1: {
		ctor: '::',
		_0: _user$project$BTree$PreOrder,
		_1: {
			ctor: '::',
			_0: _user$project$BTree$PostOrder,
			_1: {ctor: '[]'}
		}
	}
};
var _user$project$BTree$Left = {ctor: 'Left'};
var _user$project$BTree$sort = function (bTree) {
	return A2(_user$project$BTree$sortTo, _user$project$BTree$Left, bTree);
};
var _user$project$BTree$insertWith = F3(
	function (fn, x, bTree) {
		return A4(_user$project$BTree$insertWith_directed, _user$project$BTree$Left, fn, x, bTree);
	});
var _user$project$BTree$fromListWith = F2(
	function (fn, xs) {
		return A3(
			_elm_lang$core$List$foldl,
			_user$project$BTree$insertWith(fn),
			_user$project$BTree$Empty,
			xs);
	});
var _user$project$BTree$fromListBy = F2(
	function (fn, xs) {
		return A2(
			_user$project$BTree$fromListWith,
			_user$project$BTree$ordererBy(fn),
			xs);
	});
var _user$project$BTree$fromList = function (xs) {
	return A2(_user$project$BTree$fromListBy, _elm_lang$core$Basics$identity, xs);
};
var _user$project$BTree$fromIntList = function (ints) {
	return A2(
		_user$project$BTree$fromListWith,
		_user$project$MaybeSafe$compare,
		A2(_elm_lang$core$List$map, _user$project$MaybeSafe$toMaybeSafeInt, ints));
};
var _user$project$BTree$insertBy = F3(
	function (fn, x, bTree) {
		return A3(
			_user$project$BTree$insertWith,
			_user$project$BTree$ordererBy(fn),
			x,
			bTree);
	});
var _user$project$BTree$insert = F2(
	function (x, bTree) {
		return A3(_user$project$BTree$insertBy, _elm_lang$core$Basics$identity, x, bTree);
	});
var _user$project$BTree$insertAsIs_left = F2(
	function (x, bTree) {
		return A2(
			_user$project$BTree$insertAsIs_directed,
			{ctor: '_Tuple2', _0: x, _1: _user$project$BTree$Left},
			bTree);
	});
var _user$project$BTree$fromListAsIs_left = function (xs) {
	return A3(_elm_lang$core$List$foldl, _user$project$BTree$insertAsIs_left, _user$project$BTree$Empty, xs);
};
var _user$project$BTree$deDuplicateBy = F2(
	function (fn, bTree) {
		var potentialSet = _user$project$BTree$flatten(bTree);
		var set = A2(_elm_community$list_extra$List_Extra$uniqueBy, fn, potentialSet);
		return _elm_lang$core$Native_Utils.eq(potentialSet, set) ? bTree : _user$project$BTree$fromListAsIs_left(set);
	});
var _user$project$BTree$deDuplicate = function (bTree) {
	return A2(_user$project$BTree$deDuplicateBy, _elm_lang$core$Basics$identity, bTree);
};
var _user$project$BTree$Right = {ctor: 'Right'};
var _user$project$BTree$directionOptions = {
	ctor: '::',
	_0: _user$project$BTree$Right,
	_1: {
		ctor: '::',
		_0: _user$project$BTree$Left,
		_1: {ctor: '[]'}
	}
};
var _user$project$BTree$insertAsIs_right = F2(
	function (x, bTree) {
		return A2(
			_user$project$BTree$insertAsIs_directed,
			{ctor: '_Tuple2', _0: x, _1: _user$project$BTree$Right},
			bTree);
	});
var _user$project$BTree$fromListAsIs_right = function (xs) {
	return A3(_elm_lang$core$List$foldl, _user$project$BTree$insertAsIs_right, _user$project$BTree$Empty, xs);
};

var _user$project$Lib$isEvenBigInt = function (bigInt) {
	return _elm_lang$core$Native_Utils.eq(
		A2(
			_gilbertkennen$bigint$BigInt$compare,
			A2(
				_gilbertkennen$bigint$BigInt$mod,
				bigInt,
				_gilbertkennen$bigint$BigInt$fromInt(2)),
			_gilbertkennen$bigint$BigInt$fromInt(0)),
		_elm_lang$core$Basics$EQ);
};
var _user$project$Lib$isOddBigInt = function (bigInt) {
	return !_user$project$Lib$isEvenBigInt(bigInt);
};
var _user$project$Lib$raiseBigInt = F2(
	function (exp, bigInt) {
		var absExp = _elm_lang$core$Basics$abs(exp);
		return _elm_lang$core$Native_Utils.eq(absExp, 0) ? _gilbertkennen$bigint$BigInt$fromInt(1) : (_elm_lang$core$Native_Utils.eq(absExp, 1) ? bigInt : A3(
			_elm_lang$core$List$foldl,
			_gilbertkennen$bigint$BigInt$mul,
			bigInt,
			A2(_elm_lang$core$List$repeat, absExp - 1, bigInt)));
	});
var _user$project$Lib$digitCountBigInt = function (bigInt) {
	return _user$project$MaybeSafe$toMaybeSafeInt(
		_elm_lang$core$String$length(
			_gilbertkennen$bigint$BigInt$toString(
				_gilbertkennen$bigint$BigInt$abs(bigInt))));
};
var _user$project$Lib$digitCount = function (mbsInt) {
	var fn = function ($int) {
		return _elm_lang$core$Native_Utils.eq($int, 0) ? _user$project$MaybeSafe$Safe(1) : _user$project$MaybeSafe$toMaybeSafeInt(
			A2(
				F2(
					function (x, y) {
						return x + y;
					}),
				1,
				_elm_lang$core$Basics$floor(
					A2(
						_elm_lang$core$Basics$logBase,
						10,
						_elm_lang$core$Basics$toFloat(
							_elm_lang$core$Basics$abs($int))))));
	};
	return A2(_user$project$MaybeSafe$map, fn, mbsInt);
};
var _user$project$Lib$lazyUnwrap = F3(
	function (lazy, fn, mbA) {
		var _p0 = mbA;
		if (_p0.ctor === 'Just') {
			return fn(_p0._0);
		} else {
			return _elm_lang$lazy$Lazy$force(lazy);
		}
	});
var _user$project$Lib$BigIntVal = function (a) {
	return {ctor: 'BigIntVal', _0: a};
};
var _user$project$Lib$IntVal = function (a) {
	return {ctor: 'IntVal', _0: a};
};

var _user$project$NodeValueOperation$operateOnNothing = F2(
	function (operation, node) {
		return node;
	});
var _user$project$NodeValueOperation$operateOnMusicNote = F2(
	function (operation, node) {
		var _p0 = node;
		var params = _p0._0._0;
		var _p1 = operation;
		switch (_p1.ctor) {
			case 'Increment':
				return _user$project$NodeTag$MusicNoteNodeVal(
					_user$project$MusicNotePlayer$MusicNotePlayer(
						_elm_lang$core$Native_Utils.update(
							params,
							{
								mbNote: A2(
									_user$project$MusicNote_ops[':+:'],
									params.mbNote,
									_elm_lang$core$Basics$abs(_p1._0))
							})));
			case 'Decrement':
				return _user$project$NodeTag$MusicNoteNodeVal(
					_user$project$MusicNotePlayer$MusicNotePlayer(
						_elm_lang$core$Native_Utils.update(
							params,
							{
								mbNote: A2(
									_user$project$MusicNote_ops[':-:'],
									params.mbNote,
									_elm_lang$core$Basics$abs(_p1._0))
							})));
			default:
				return node;
		}
	});
var _user$project$NodeValueOperation$operateOnBool = F2(
	function (operation, node) {
		var _p2 = node;
		var mbBool = _p2._0;
		var _p3 = operation;
		switch (_p3.ctor) {
			case 'Increment':
				return _user$project$NodeTag$BoolNodeVal(
					A2(
						_elm_lang$core$Maybe$map,
						function (bool) {
							return _elm_lang$core$Native_Utils.eq(
								bool,
								_lynn$elm_arithmetic$Arithmetic$isEven(
									_elm_lang$core$Basics$abs(_p3._0)));
						},
						mbBool));
			case 'Decrement':
				return _user$project$NodeTag$BoolNodeVal(
					A2(
						_elm_lang$core$Maybe$map,
						function (bool) {
							return _elm_lang$core$Native_Utils.eq(
								bool,
								_lynn$elm_arithmetic$Arithmetic$isEven(
									_elm_lang$core$Basics$abs(_p3._0)));
						},
						mbBool));
			default:
				return node;
		}
	});
var _user$project$NodeValueOperation$operateOnString = F2(
	function (operation, node) {
		var _p4 = node;
		var string = _p4._0;
		var _p5 = operation;
		switch (_p5.ctor) {
			case 'Increment':
				return _user$project$NodeTag$StringNodeVal(
					A2(
						_elm_lang$core$Basics_ops['++'],
						string,
						_elm_lang$core$Basics$toString(
							_elm_lang$core$Basics$abs(_p5._0))));
			case 'Decrement':
				return _user$project$NodeTag$StringNodeVal(
					A2(
						_elm_lang$core$String$dropRight,
						_elm_lang$core$Basics$abs(_p5._0),
						string));
			default:
				return node;
		}
	});
var _user$project$NodeValueOperation$operateOnBigInt = F2(
	function (operation, node) {
		var _p6 = node;
		var bigInt = _p6._0;
		var _p7 = operation;
		switch (_p7.ctor) {
			case 'Increment':
				return _user$project$NodeTag$BigIntNodeVal(
					A2(
						_gilbertkennen$bigint$BigInt$add,
						bigInt,
						_gilbertkennen$bigint$BigInt$fromInt(
							_elm_lang$core$Basics$abs(_p7._0))));
			case 'Decrement':
				return _user$project$NodeTag$BigIntNodeVal(
					A2(
						_gilbertkennen$bigint$BigInt$sub,
						bigInt,
						_gilbertkennen$bigint$BigInt$fromInt(
							_elm_lang$core$Basics$abs(_p7._0))));
			default:
				return _user$project$NodeTag$BigIntNodeVal(
					A2(
						_user$project$Lib$raiseBigInt,
						_elm_lang$core$Basics$abs(_p7._0),
						bigInt));
		}
	});
var _user$project$NodeValueOperation$intOperation = F3(
	function (operation, operand, mbsInt) {
		var fn = function ($int) {
			return _user$project$MaybeSafe$toMaybeSafeInt(
				A2(operation, $int, operand));
		};
		return A2(_user$project$MaybeSafe$map, fn, mbsInt);
	});
var _user$project$NodeValueOperation$operateOnInt = F2(
	function (operation, node) {
		var _p8 = node;
		var mbsInt = _p8._0;
		var _p9 = operation;
		switch (_p9.ctor) {
			case 'Increment':
				return _user$project$NodeTag$IntNodeVal(
					A3(
						_user$project$NodeValueOperation$intOperation,
						F2(
							function (x, y) {
								return x + y;
							}),
						_elm_lang$core$Basics$abs(_p9._0),
						mbsInt));
			case 'Decrement':
				return _user$project$NodeTag$IntNodeVal(
					A3(
						_user$project$NodeValueOperation$intOperation,
						F2(
							function (x, y) {
								return x - y;
							}),
						_elm_lang$core$Basics$abs(_p9._0),
						mbsInt));
			default:
				return _user$project$NodeTag$IntNodeVal(
					A3(
						_user$project$NodeValueOperation$intOperation,
						F2(
							function (x, y) {
								return Math.pow(x, y);
							}),
						_elm_lang$core$Basics$abs(_p9._0),
						mbsInt));
		}
	});
var _user$project$NodeValueOperation$Raise = function (a) {
	return {ctor: 'Raise', _0: a};
};
var _user$project$NodeValueOperation$Decrement = function (a) {
	return {ctor: 'Decrement', _0: a};
};
var _user$project$NodeValueOperation$Increment = function (a) {
	return {ctor: 'Increment', _0: a};
};

var _user$project$TreePlayerParams$noteDurationFor = function (playSpeed) {
	var multiple = function () {
		var _p0 = playSpeed;
		switch (_p0.ctor) {
			case 'Fast':
				return 1;
			case 'Medium':
				return 2;
			default:
				return 3;
		}
	}();
	var increment = 250 * _elm_lang$core$Time$millisecond;
	return multiple * increment;
};
var _user$project$TreePlayerParams$TreePlayerParams = F3(
	function (a, b, c) {
		return {traversalOrder: a, playSpeed: b, gapDuration: c};
	});
var _user$project$TreePlayerParams$Slow = {ctor: 'Slow'};
var _user$project$TreePlayerParams$defaultTreePlayerParams = {traversalOrder: _user$project$BTree$InOrder, playSpeed: _user$project$TreePlayerParams$Slow, gapDuration: 250 * _elm_lang$core$Time$millisecond};
var _user$project$TreePlayerParams$Medium = {ctor: 'Medium'};
var _user$project$TreePlayerParams$Fast = {ctor: 'Fast'};
var _user$project$TreePlayerParams$playSpeedOptions = {
	ctor: '::',
	_0: _user$project$TreePlayerParams$Fast,
	_1: {
		ctor: '::',
		_0: _user$project$TreePlayerParams$Medium,
		_1: {
			ctor: '::',
			_0: _user$project$TreePlayerParams$Slow,
			_1: {ctor: '[]'}
		}
	}
};

var _user$project$BTreeUniform$displayString = function (bTreeUniform) {
	var _p0 = bTreeUniform;
	switch (_p0.ctor) {
		case 'UniformInt':
			return 'Int';
		case 'UniformBigInt':
			return 'Big-Int';
		case 'UniformString':
			return 'String';
		case 'UniformBool':
			return 'Bool';
		case 'UniformMusicNotePlayer':
			return 'Music-Note';
		default:
			return 'Not-Applicable';
	}
};
var _user$project$BTreeUniform$isAllNothing = function (bTreeUniform) {
	var _p1 = bTreeUniform;
	switch (_p1.ctor) {
		case 'UniformInt':
			return _user$project$BTree$isEmpty(_p1._0._0);
		case 'UniformBigInt':
			return _user$project$BTree$isEmpty(_p1._0._0);
		case 'UniformString':
			return _user$project$BTree$isEmpty(_p1._0._0);
		case 'UniformBool':
			return _user$project$BTree$isEmpty(_p1._0._0);
		case 'UniformMusicNotePlayer':
			var fn = function (_p2) {
				var _p3 = _p2;
				return _p3._0._0.mbNote;
			};
			return _user$project$BTree$isAllNothing(
				A2(_user$project$BTree$map, fn, _p1._0._1));
		default:
			return true;
	}
};
var _user$project$BTreeUniform$sumInt = function (bTreeUniform) {
	var _p4 = bTreeUniform;
	switch (_p4.ctor) {
		case 'UniformInt':
			return _elm_lang$core$Maybe$Just(
				_user$project$Lib$IntVal(
					_user$project$BTree$sumMaybeSafeInt(
						A2(
							_user$project$BTree$map,
							function (_p5) {
								var _p6 = _p5;
								return _p6._0;
							},
							_p4._0._0))));
		case 'UniformBigInt':
			return _elm_lang$core$Maybe$Just(
				_user$project$Lib$BigIntVal(
					_user$project$BTree$sumBigInt(
						A2(
							_user$project$BTree$map,
							function (_p7) {
								var _p8 = _p7;
								return _p8._0;
							},
							_p4._0._0))));
		case 'UniformString':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformBool':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformMusicNotePlayer':
			return _elm_lang$core$Maybe$Nothing;
		default:
			return _elm_lang$core$Maybe$Nothing;
	}
};
var _user$project$BTreeUniform$depth = function (bTreeUniform) {
	var _p9 = bTreeUniform;
	switch (_p9.ctor) {
		case 'UniformInt':
			return _user$project$BTree$depth(_p9._0._0);
		case 'UniformBigInt':
			return _user$project$BTree$depth(_p9._0._0);
		case 'UniformString':
			return _user$project$BTree$depth(_p9._0._0);
		case 'UniformBool':
			return _user$project$BTree$depth(_p9._0._0);
		case 'UniformMusicNotePlayer':
			return _user$project$BTree$depth(_p9._0._1);
		default:
			return _user$project$BTree$depth(_p9._0._0);
	}
};
var _user$project$BTreeUniform$toTaggedNodes = function (bTreeUniform) {
	var _p10 = bTreeUniform;
	switch (_p10.ctor) {
		case 'UniformInt':
			return A2(_user$project$BTree$map, _user$project$NodeTag$IntVariety, _p10._0._0);
		case 'UniformBigInt':
			return A2(_user$project$BTree$map, _user$project$NodeTag$BigIntVariety, _p10._0._0);
		case 'UniformString':
			return A2(_user$project$BTree$map, _user$project$NodeTag$StringVariety, _p10._0._0);
		case 'UniformBool':
			return A2(_user$project$BTree$map, _user$project$NodeTag$BoolVariety, _p10._0._0);
		case 'UniformMusicNotePlayer':
			return A2(_user$project$BTree$map, _user$project$NodeTag$MusicNoteVariety, _p10._0._1);
		default:
			return A2(_user$project$BTree$map, _user$project$NodeTag$NothingVariety, _p10._0._0);
	}
};
var _user$project$BTreeUniform$IntTree = function (a) {
	return {ctor: 'IntTree', _0: a};
};
var _user$project$BTreeUniform$intTreeFrom = function (bTreeUniform) {
	var mbRequested = function () {
		var _p11 = bTreeUniform;
		if (_p11.ctor === 'UniformInt') {
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$IntTree(_p11._0._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	}();
	return A2(
		_elm_lang$core$Maybe$withDefault,
		_user$project$BTreeUniform$IntTree(_user$project$BTree$Empty),
		mbRequested);
};
var _user$project$BTreeUniform$BigIntTree = function (a) {
	return {ctor: 'BigIntTree', _0: a};
};
var _user$project$BTreeUniform$bigIntTreeFrom = function (bTreeUniform) {
	var mbRequested = function () {
		var _p12 = bTreeUniform;
		if (_p12.ctor === 'UniformBigInt') {
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$BigIntTree(_p12._0._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	}();
	return A2(
		_elm_lang$core$Maybe$withDefault,
		_user$project$BTreeUniform$BigIntTree(_user$project$BTree$Empty),
		mbRequested);
};
var _user$project$BTreeUniform$StringTree = function (a) {
	return {ctor: 'StringTree', _0: a};
};
var _user$project$BTreeUniform$stringTreeFrom = function (bTreeUniform) {
	var mbRequested = function () {
		var _p13 = bTreeUniform;
		if (_p13.ctor === 'UniformString') {
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$StringTree(_p13._0._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	}();
	return A2(
		_elm_lang$core$Maybe$withDefault,
		_user$project$BTreeUniform$StringTree(_user$project$BTree$Empty),
		mbRequested);
};
var _user$project$BTreeUniform$BoolTree = function (a) {
	return {ctor: 'BoolTree', _0: a};
};
var _user$project$BTreeUniform$boolTreeFrom = function (bTreeUniform) {
	var mbRequested = function () {
		var _p14 = bTreeUniform;
		if (_p14.ctor === 'UniformBool') {
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$BoolTree(_p14._0._0));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	}();
	return A2(
		_elm_lang$core$Maybe$withDefault,
		_user$project$BTreeUniform$BoolTree(_user$project$BTree$Empty),
		mbRequested);
};
var _user$project$BTreeUniform$MusicNotePlayerTree = F2(
	function (a, b) {
		return {ctor: 'MusicNotePlayerTree', _0: a, _1: b};
	});
var _user$project$BTreeUniform$musicNotePlayerTreeFrom = function (bTreeUniform) {
	var mbRequested = function () {
		var _p15 = bTreeUniform;
		if (_p15.ctor === 'UniformMusicNotePlayer') {
			return _elm_lang$core$Maybe$Just(
				A2(_user$project$BTreeUniform$MusicNotePlayerTree, _p15._0._0, _p15._0._1));
		} else {
			return _elm_lang$core$Maybe$Nothing;
		}
	}();
	return A2(
		_elm_lang$core$Maybe$withDefault,
		A2(_user$project$BTreeUniform$MusicNotePlayerTree, _user$project$TreePlayerParams$defaultTreePlayerParams, _user$project$BTree$Empty),
		mbRequested);
};
var _user$project$BTreeUniform$transformTreePlayerParamsIn = F2(
	function (musicNotePlayerTree, fn) {
		var _p16 = musicNotePlayerTree;
		var params = _p16._0;
		var bTree = _p16._1;
		return A2(
			_user$project$BTreeUniform$MusicNotePlayerTree,
			fn(params),
			bTree);
	});
var _user$project$BTreeUniform$NothingTree = function (a) {
	return {ctor: 'NothingTree', _0: a};
};
var _user$project$BTreeUniform$UniformNothing = function (a) {
	return {ctor: 'UniformNothing', _0: a};
};
var _user$project$BTreeUniform$uniformNothingTreeFrom = function (bTree) {
	return _user$project$BTreeUniform$UniformNothing(
		_user$project$BTreeUniform$NothingTree(bTree));
};
var _user$project$BTreeUniform$toNothing = function (bTreeUniform) {
	var toBTreeNothing = function (bTree) {
		return _user$project$BTreeUniform$uniformNothingTreeFrom(
			_user$project$BTree$toNothingNodes(bTree));
	};
	var _p17 = bTreeUniform;
	switch (_p17.ctor) {
		case 'UniformInt':
			return toBTreeNothing(_p17._0._0);
		case 'UniformBigInt':
			return toBTreeNothing(_p17._0._0);
		case 'UniformString':
			return toBTreeNothing(_p17._0._0);
		case 'UniformBool':
			return toBTreeNothing(_p17._0._0);
		case 'UniformMusicNotePlayer':
			return toBTreeNothing(_p17._0._1);
		default:
			return bTreeUniform;
	}
};
var _user$project$BTreeUniform$UniformMusicNotePlayer = function (a) {
	return {ctor: 'UniformMusicNotePlayer', _0: a};
};
var _user$project$BTreeUniform$uniformMusicNotePlayerTreeFrom = F2(
	function (params, bTree) {
		return _user$project$BTreeUniform$UniformMusicNotePlayer(
			A2(_user$project$BTreeUniform$MusicNotePlayerTree, params, bTree));
	});
var _user$project$BTreeUniform$UniformBool = function (a) {
	return {ctor: 'UniformBool', _0: a};
};
var _user$project$BTreeUniform$uniformBoolTreeFrom = function (bTree) {
	return _user$project$BTreeUniform$UniformBool(
		_user$project$BTreeUniform$BoolTree(bTree));
};
var _user$project$BTreeUniform$toIsIntPrime = function (bTreeUniform) {
	var _p18 = bTreeUniform;
	switch (_p18.ctor) {
		case 'UniformInt':
			var fn = function (_p19) {
				var _p20 = _p19;
				return _user$project$NodeTag$BoolNodeVal(
					A3(
						_user$project$MaybeSafe$unwrap,
						_elm_lang$core$Maybe$Nothing,
						function ($int) {
							return _elm_lang$core$Maybe$Just(
								_lynn$elm_arithmetic$Arithmetic$isPrime($int));
						},
						_p20._0));
			};
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$uniformBoolTreeFrom(
					A2(_user$project$BTree$map, fn, _p18._0._0)));
		case 'UniformBigInt':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformString':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformBool':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformMusicNotePlayer':
			return _elm_lang$core$Maybe$Nothing;
		default:
			return _elm_lang$core$Maybe$Nothing;
	}
};
var _user$project$BTreeUniform$UniformString = function (a) {
	return {ctor: 'UniformString', _0: a};
};
var _user$project$BTreeUniform$uniformStringTreeFrom = function (bTree) {
	return _user$project$BTreeUniform$UniformString(
		_user$project$BTreeUniform$StringTree(bTree));
};
var _user$project$BTreeUniform$UniformBigInt = function (a) {
	return {ctor: 'UniformBigInt', _0: a};
};
var _user$project$BTreeUniform$uniformBigIntTreeFrom = function (bTree) {
	return _user$project$BTreeUniform$UniformBigInt(
		_user$project$BTreeUniform$BigIntTree(bTree));
};
var _user$project$BTreeUniform$UniformInt = function (a) {
	return {ctor: 'UniformInt', _0: a};
};
var _user$project$BTreeUniform$uniformIntTreeFrom = function (bTree) {
	return _user$project$BTreeUniform$UniformInt(
		_user$project$BTreeUniform$IntTree(bTree));
};
var _user$project$BTreeUniform$toLength = function (bTreeUniform) {
	var _p21 = bTreeUniform;
	switch (_p21.ctor) {
		case 'UniformInt':
			var fn = function (_p22) {
				var _p23 = _p22;
				return _user$project$NodeTag$IntNodeVal(
					_user$project$Lib$digitCount(_p23._0));
			};
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$uniformIntTreeFrom(
					A2(_user$project$BTree$map, fn, _p21._0._0)));
		case 'UniformBigInt':
			var fn = function (_p24) {
				var _p25 = _p24;
				return _user$project$NodeTag$IntNodeVal(
					_user$project$Lib$digitCountBigInt(_p25._0));
			};
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$uniformIntTreeFrom(
					A2(_user$project$BTree$map, fn, _p21._0._0)));
		case 'UniformString':
			var fn = function (_p26) {
				var _p27 = _p26;
				return _user$project$NodeTag$IntNodeVal(
					_user$project$MaybeSafe$toMaybeSafeInt(
						_elm_lang$core$String$length(_p27._0)));
			};
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$uniformIntTreeFrom(
					A2(_user$project$BTree$map, fn, _p21._0._0)));
		case 'UniformBool':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformMusicNotePlayer':
			var fn = function (_p28) {
				var _p29 = _p28;
				return _user$project$NodeTag$StringNodeVal(
					_user$project$MusicNotePlayer$toFreqString(_p29._0));
			};
			return _elm_lang$core$Maybe$Just(
				_user$project$BTreeUniform$uniformStringTreeFrom(
					A2(_user$project$BTree$map, fn, _p21._0._1)));
		default:
			return _elm_lang$core$Maybe$Nothing;
	}
};
var _user$project$BTreeUniform$nodeValOperate = F2(
	function (operation, bTreeUniform) {
		var _p30 = bTreeUniform;
		switch (_p30.ctor) {
			case 'UniformInt':
				return _user$project$BTreeUniform$uniformIntTreeFrom(
					A2(
						_user$project$BTree$map,
						_user$project$NodeValueOperation$operateOnInt(operation),
						_p30._0._0));
			case 'UniformBigInt':
				return _user$project$BTreeUniform$uniformBigIntTreeFrom(
					A2(
						_user$project$BTree$map,
						_user$project$NodeValueOperation$operateOnBigInt(operation),
						_p30._0._0));
			case 'UniformString':
				return _user$project$BTreeUniform$uniformStringTreeFrom(
					A2(
						_user$project$BTree$map,
						_user$project$NodeValueOperation$operateOnString(operation),
						_p30._0._0));
			case 'UniformBool':
				return _user$project$BTreeUniform$uniformBoolTreeFrom(
					A2(
						_user$project$BTree$map,
						_user$project$NodeValueOperation$operateOnBool(operation),
						_p30._0._0));
			case 'UniformMusicNotePlayer':
				return A2(
					_user$project$BTreeUniform$uniformMusicNotePlayerTreeFrom,
					_p30._0._0,
					A2(
						_user$project$BTree$map,
						_user$project$NodeValueOperation$operateOnMusicNote(operation),
						_p30._0._1));
			default:
				return _user$project$BTreeUniform$uniformNothingTreeFrom(
					A2(
						_user$project$BTree$map,
						_user$project$NodeValueOperation$operateOnNothing(operation),
						_p30._0._0));
		}
	});
var _user$project$BTreeUniform$sort = F2(
	function (direction, bTreeUniform) {
		var _p31 = bTreeUniform;
		switch (_p31.ctor) {
			case 'UniformInt':
				var fn = F2(
					function (_p33, _p32) {
						var _p34 = _p33;
						var _p35 = _p32;
						return A2(_user$project$MaybeSafe$compare, _p34._0, _p35._0);
					});
				return _user$project$BTreeUniform$uniformIntTreeFrom(
					A3(_user$project$BTree$sortWithTo, fn, direction, _p31._0._0));
			case 'UniformBigInt':
				var fn = F2(
					function (_p37, _p36) {
						var _p38 = _p37;
						var _p39 = _p36;
						return A2(_gilbertkennen$bigint$BigInt$compare, _p38._0, _p39._0);
					});
				return _user$project$BTreeUniform$uniformBigIntTreeFrom(
					A3(_user$project$BTree$sortWithTo, fn, direction, _p31._0._0));
			case 'UniformString':
				var fn = function (_p40) {
					var _p41 = _p40;
					return _p41._0;
				};
				return _user$project$BTreeUniform$uniformStringTreeFrom(
					A3(_user$project$BTree$sortByTo, fn, direction, _p31._0._0));
			case 'UniformBool':
				var fn = function (_p42) {
					var _p43 = _p42;
					return _elm_lang$core$Basics$toString(_p43._0);
				};
				return _user$project$BTreeUniform$uniformBoolTreeFrom(
					A3(_user$project$BTree$sortByTo, fn, direction, _p31._0._0));
			case 'UniformMusicNotePlayer':
				var fn = function (_p44) {
					var _p45 = _p44;
					return _user$project$MusicNotePlayer$sorter(_p45._0);
				};
				return A2(
					_user$project$BTreeUniform$uniformMusicNotePlayerTreeFrom,
					_p31._0._0,
					A3(_user$project$BTree$sortByTo, fn, direction, _p31._0._1));
			default:
				return bTreeUniform;
		}
	});
var _user$project$BTreeUniform$deDuplicate = function (bTreeUniform) {
	var _p46 = bTreeUniform;
	switch (_p46.ctor) {
		case 'UniformInt':
			var fn = function (_p47) {
				var _p48 = _p47;
				return _elm_lang$core$Basics$toString(_p48._0);
			};
			return _user$project$BTreeUniform$uniformIntTreeFrom(
				A2(_user$project$BTree$deDuplicateBy, fn, _p46._0._0));
		case 'UniformBigInt':
			var fn = function (_p49) {
				var _p50 = _p49;
				return _gilbertkennen$bigint$BigInt$toString(_p50._0);
			};
			return _user$project$BTreeUniform$uniformBigIntTreeFrom(
				A2(_user$project$BTree$deDuplicateBy, fn, _p46._0._0));
		case 'UniformString':
			var fn = function (_p51) {
				var _p52 = _p51;
				return _p52._0;
			};
			return _user$project$BTreeUniform$uniformStringTreeFrom(
				A2(_user$project$BTree$deDuplicateBy, fn, _p46._0._0));
		case 'UniformBool':
			var fn = function (_p53) {
				var _p54 = _p53;
				return _elm_lang$core$Basics$toString(_p54._0);
			};
			return _user$project$BTreeUniform$uniformBoolTreeFrom(
				A2(_user$project$BTree$deDuplicateBy, fn, _p46._0._0));
		case 'UniformMusicNotePlayer':
			var fn = function (_p55) {
				var _p56 = _p55;
				return _user$project$MusicNotePlayer$sorter(_p56._0);
			};
			return A2(
				_user$project$BTreeUniform$uniformMusicNotePlayerTreeFrom,
				_p46._0._0,
				A2(_user$project$BTree$deDuplicateBy, fn, _p46._0._1));
		default:
			return _user$project$BTreeUniform$uniformNothingTreeFrom(
				A2(_user$project$BTree$deDuplicateBy, _elm_lang$core$Basics$toString, _p46._0._0));
	}
};

var _user$project$BTreeVaried$displayString = function (_p0) {
	return 'Varied';
};
var _user$project$BTreeVaried$hasAnyIntNodes = function (_p1) {
	var _p2 = _p1;
	var isIntNode = function (nodeVariety) {
		var _p3 = nodeVariety;
		switch (_p3.ctor) {
			case 'IntVariety':
				return true;
			case 'BigIntVariety':
				return true;
			case 'StringVariety':
				return false;
			case 'BoolVariety':
				return false;
			case 'MusicNoteVariety':
				return false;
			default:
				return false;
		}
	};
	return A2(
		_elm_lang$core$List$any,
		isIntNode,
		_user$project$BTree$flatten(_p2._0));
};
var _user$project$BTreeVaried$BTreeVaried = function (a) {
	return {ctor: 'BTreeVaried', _0: a};
};
var _user$project$BTreeVaried$toLength = function (_p4) {
	var _p5 = _p4;
	var fn = function (nodeVariety) {
		var _p6 = nodeVariety;
		switch (_p6.ctor) {
			case 'IntVariety':
				return _user$project$NodeTag$IntVariety(
					_user$project$NodeTag$IntNodeVal(
						_user$project$Lib$digitCount(_p6._0._0)));
			case 'BigIntVariety':
				return _user$project$NodeTag$IntVariety(
					_user$project$NodeTag$IntNodeVal(
						_user$project$Lib$digitCountBigInt(_p6._0._0)));
			case 'StringVariety':
				return _user$project$NodeTag$IntVariety(
					_user$project$NodeTag$IntNodeVal(
						_user$project$MaybeSafe$toMaybeSafeInt(
							_elm_lang$core$String$length(_p6._0._0))));
			case 'BoolVariety':
				return _user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal);
			case 'MusicNoteVariety':
				return _user$project$NodeTag$StringVariety(
					_user$project$NodeTag$StringNodeVal(
						_user$project$MusicNotePlayer$toFreqString(_p6._0._0)));
			default:
				return _user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal);
		}
	};
	return _user$project$BTreeVaried$BTreeVaried(
		A2(_user$project$BTree$map, fn, _p5._0));
};
var _user$project$BTreeVaried$toIsIntPrime = function (_p7) {
	var _p8 = _p7;
	var fn = function (nodeVariety) {
		var _p9 = nodeVariety;
		switch (_p9.ctor) {
			case 'IntVariety':
				var fn = function ($int) {
					return _elm_lang$core$Maybe$Just(
						_lynn$elm_arithmetic$Arithmetic$isPrime($int));
				};
				return _user$project$NodeTag$BoolVariety(
					_user$project$NodeTag$BoolNodeVal(
						A3(_user$project$MaybeSafe$unwrap, _elm_lang$core$Maybe$Nothing, fn, _p9._0._0)));
			case 'BigIntVariety':
				return _user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal);
			case 'StringVariety':
				return _user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal);
			case 'BoolVariety':
				return _user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal);
			case 'MusicNoteVariety':
				return _user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal);
			default:
				return _user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal);
		}
	};
	return _user$project$BTreeVaried$BTreeVaried(
		A2(_user$project$BTree$map, fn, _p8._0));
};
var _user$project$BTreeVaried$nodeValOperate = F2(
	function (operation, _p10) {
		var _p11 = _p10;
		var fn = function (nodeVariety) {
			var _p12 = nodeVariety;
			switch (_p12.ctor) {
				case 'IntVariety':
					return _user$project$NodeTag$IntVariety(
						A2(_user$project$NodeValueOperation$operateOnInt, operation, _p12._0));
				case 'BigIntVariety':
					return _user$project$NodeTag$BigIntVariety(
						A2(_user$project$NodeValueOperation$operateOnBigInt, operation, _p12._0));
				case 'StringVariety':
					return _user$project$NodeTag$StringVariety(
						A2(_user$project$NodeValueOperation$operateOnString, operation, _p12._0));
				case 'BoolVariety':
					return _user$project$NodeTag$BoolVariety(
						A2(_user$project$NodeValueOperation$operateOnBool, operation, _p12._0));
				case 'MusicNoteVariety':
					return _user$project$NodeTag$MusicNoteVariety(
						A2(_user$project$NodeValueOperation$operateOnMusicNote, operation, _p12._0));
				default:
					return _user$project$NodeTag$NothingVariety(
						A2(_user$project$NodeValueOperation$operateOnNothing, operation, _p12._0));
			}
		};
		return _user$project$BTreeVaried$BTreeVaried(
			A2(_user$project$BTree$map, fn, _p11._0));
	});
var _user$project$BTreeVaried$deDuplicate = function (_p13) {
	var _p14 = _p13;
	var fn = function (nodeVariety) {
		var _p15 = nodeVariety;
		switch (_p15.ctor) {
			case 'IntVariety':
				return _elm_lang$core$Basics$toString(nodeVariety);
			case 'BigIntVariety':
				return _gilbertkennen$bigint$BigInt$toString(_p15._0._0);
			case 'StringVariety':
				return _elm_lang$core$Basics$toString(nodeVariety);
			case 'BoolVariety':
				return _elm_lang$core$Basics$toString(nodeVariety);
			case 'MusicNoteVariety':
				return A2(
					_elm_lang$core$Basics_ops['++'],
					'MusicNoteVariety ',
					_elm_lang$core$Basics$toString(
						_user$project$MusicNote$mbSorter(_p15._0._0._0.mbNote)));
			default:
				return _elm_lang$core$Basics$toString(nodeVariety);
		}
	};
	return _user$project$BTreeVaried$BTreeVaried(
		A2(_user$project$BTree$deDuplicateBy, fn, _p14._0));
};

var _user$project$TachyonsColor$hexString_black = '#000000';
var _user$project$TachyonsColor$tColorsWithHex = _elm_lang$core$Dict$fromList(
	{
		ctor: '::',
		_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$black, _1: _user$project$TachyonsColor$hexString_black},
		_1: {
			ctor: '::',
			_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$dark_blue, _1: '#00449E'},
			_1: {
				ctor: '::',
				_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$dark_green, _1: '#137752'},
				_1: {
					ctor: '::',
					_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$dark_red, _1: '#E7040F'},
					_1: {
						ctor: '::',
						_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$gray, _1: '#777777'},
						_1: {
							ctor: '::',
							_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$light_silver, _1: '#AAAAAA'},
							_1: {
								ctor: '::',
								_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$orange, _1: '#FF6300'},
								_1: {
									ctor: '::',
									_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$purple, _1: '#5E2CA5'},
									_1: {
										ctor: '::',
										_0: {ctor: '_Tuple2', _0: _justgage$tachyons_elm$Tachyons_Classes$white, _1: '#FFFFFF'},
										_1: {ctor: '[]'}
									}
								}
							}
						}
					}
				}
			}
		}
	});
var _user$project$TachyonsColor$mbHexToColor = function (mbHexString) {
	return A2(
		_elm_lang$core$Result$withDefault,
		_elm_lang$core$Color$black,
		_eskimoblood$elm_color_extra$Color_Convert$hexToColor(
			A2(_elm_lang$core$Maybe$withDefault, _user$project$TachyonsColor$hexString_black, mbHexString)));
};
var _user$project$TachyonsColor$tachyonsColorToColor = function (tColor) {
	return _user$project$TachyonsColor$mbHexToColor(
		A2(_elm_lang$core$Dict$get, tColor, _user$project$TachyonsColor$tColorsWithHex));
};

var _user$project$TreeType$Varied = function (a) {
	return {ctor: 'Varied', _0: a};
};
var _user$project$TreeType$Uniform = function (a) {
	return {ctor: 'Uniform', _0: a};
};

var _user$project$BTreeView$treeLineHighlightStyle = _elm_lang$core$Native_Utils.update(
	_evancz$elm_graphics$Collage$defaultLine,
	{width: 4});
var _user$project$BTreeView$treeThickLineStyle = _elm_lang$core$Native_Utils.update(
	_evancz$elm_graphics$Collage$defaultLine,
	{width: 3});
var _user$project$BTreeView$treeLineStyle = _elm_lang$core$Native_Utils.update(
	_evancz$elm_graphics$Collage$defaultLine,
	{width: 1});
var _user$project$BTreeView$treeNilStyle = _elm_lang$core$Native_Utils.update(
	_evancz$elm_graphics$Text$defaultStyle,
	{
		color: _user$project$TachyonsColor$tachyonsColorToColor(_justgage$tachyons_elm$Tachyons_Classes$white),
		height: _elm_lang$core$Maybe$Just(20)
	});
var _user$project$BTreeView$treeNodeStyle = _elm_lang$core$Native_Utils.update(
	_evancz$elm_graphics$Text$defaultStyle,
	{
		color: _user$project$TachyonsColor$tachyonsColorToColor(_justgage$tachyons_elm$Tachyons_Classes$white),
		bold: false,
		height: _elm_lang$core$Maybe$Just(15.0),
		typeface: {
			ctor: '::',
			_0: 'Times New Roman',
			_1: {
				ctor: '::',
				_0: 'serif',
				_1: {ctor: '[]'}
			}
		}
	});
var _user$project$BTreeView$drawEdge = function (_p0) {
	var _p1 = _p0;
	return _evancz$elm_graphics$Collage$group(
		{
			ctor: '::',
			_0: A2(
				_evancz$elm_graphics$Collage$traced,
				_user$project$BTreeView$treeLineStyle,
				A2(
					_evancz$elm_graphics$Collage$segment,
					{ctor: '_Tuple2', _0: 0, _1: 0},
					{ctor: '_Tuple2', _0: _p1._0, _1: _p1._1})),
			_1: {ctor: '[]'}
		});
};
var _user$project$BTreeView$unsafeColor = _justgage$tachyons_elm$Tachyons_Classes$dark_red;
var _user$project$BTreeView$intNodeOddColor = _justgage$tachyons_elm$Tachyons_Classes$orange;
var _user$project$BTreeView$intNodeEvenColor = _justgage$tachyons_elm$Tachyons_Classes$dark_green;
var _user$project$BTreeView$drawNode = function (mbNodeVariety) {
	var _p2 = mbNodeVariety;
	if (_p2.ctor === 'Just') {
		var _p3 = _p2._0;
		switch (_p3.ctor) {
			case 'IntVariety':
				var _p4 = _p3._0._0;
				if (_p4.ctor === 'Unsafe') {
					return _evancz$elm_graphics$Collage$group(
						{
							ctor: '::',
							_0: A2(
								_evancz$elm_graphics$Collage$filled,
								_user$project$TachyonsColor$tachyonsColorToColor(_user$project$BTreeView$unsafeColor),
								A2(_evancz$elm_graphics$Collage$rect, 55, 30)),
							_1: {
								ctor: '::',
								_0: A2(
									_evancz$elm_graphics$Collage$outlined,
									_user$project$BTreeView$treeLineStyle,
									A2(_evancz$elm_graphics$Collage$rect, 55, 30)),
								_1: {
									ctor: '::',
									_0: A2(
										_evancz$elm_graphics$Collage$moveY,
										4,
										_evancz$elm_graphics$Collage$text(
											A2(
												_evancz$elm_graphics$Text$style,
												_user$project$BTreeView$treeNodeStyle,
												_evancz$elm_graphics$Text$fromString(_user$project$UniversalConstants$unsafeString)))),
									_1: {ctor: '[]'}
								}
							}
						});
				} else {
					var _p5 = _p4._0;
					var colorizer = function ($int) {
						return _user$project$TachyonsColor$tachyonsColorToColor(
							_lynn$elm_arithmetic$Arithmetic$isEven($int) ? _user$project$BTreeView$intNodeEvenColor : _user$project$BTreeView$intNodeOddColor);
					};
					var height = 30;
					var intString = _elm_lang$core$Basics$toString(_p5);
					var stringLength = _elm_lang$core$String$length(intString);
					var width = _elm_lang$core$Basics$toFloat(30 + (10 * stringLength));
					return _evancz$elm_graphics$Collage$group(
						{
							ctor: '::',
							_0: A2(
								_evancz$elm_graphics$Collage$filled,
								colorizer(_p5),
								A2(_evancz$elm_graphics$Collage$oval, width, height)),
							_1: {
								ctor: '::',
								_0: A2(
									_evancz$elm_graphics$Collage$outlined,
									_user$project$BTreeView$treeLineStyle,
									A2(_evancz$elm_graphics$Collage$oval, width, height)),
								_1: {
									ctor: '::',
									_0: A2(
										_evancz$elm_graphics$Collage$moveY,
										4,
										_evancz$elm_graphics$Collage$text(
											A2(
												_evancz$elm_graphics$Text$style,
												_user$project$BTreeView$treeNodeStyle,
												_evancz$elm_graphics$Text$fromString(intString)))),
									_1: {ctor: '[]'}
								}
							}
						});
				}
			case 'BigIntVariety':
				var _p6 = _p3._0._0;
				var colorizer = function (i) {
					return _user$project$TachyonsColor$tachyonsColorToColor(
						_user$project$Lib$isEvenBigInt(i) ? _user$project$BTreeView$intNodeEvenColor : _user$project$BTreeView$intNodeOddColor);
				};
				var height = 30;
				var bigIntString = _gilbertkennen$bigint$BigInt$toString(_p6);
				var stringLength = _elm_lang$core$String$length(bigIntString);
				var width = _elm_lang$core$Basics$toFloat(30 + (10 * stringLength));
				return _evancz$elm_graphics$Collage$group(
					{
						ctor: '::',
						_0: A2(
							_evancz$elm_graphics$Collage$filled,
							colorizer(_p6),
							A2(_evancz$elm_graphics$Collage$oval, width, height)),
						_1: {
							ctor: '::',
							_0: A2(
								_evancz$elm_graphics$Collage$outlined,
								_user$project$BTreeView$treeThickLineStyle,
								A2(_evancz$elm_graphics$Collage$oval, width, height)),
							_1: {
								ctor: '::',
								_0: A2(
									_evancz$elm_graphics$Collage$moveY,
									4,
									_evancz$elm_graphics$Collage$text(
										A2(
											_evancz$elm_graphics$Text$style,
											_user$project$BTreeView$treeNodeStyle,
											_evancz$elm_graphics$Text$fromString(bigIntString)))),
								_1: {ctor: '[]'}
							}
						}
					});
			case 'StringVariety':
				var _p7 = _p3._0._0;
				var height = 30;
				var stringLength = _elm_lang$core$String$length(_p7);
				var width = _elm_lang$core$Basics$toFloat(
					10 * A2(_elm_lang$core$Basics$max, 3, stringLength));
				return _evancz$elm_graphics$Collage$group(
					{
						ctor: '::',
						_0: A2(
							_evancz$elm_graphics$Collage$filled,
							_user$project$TachyonsColor$tachyonsColorToColor(_justgage$tachyons_elm$Tachyons_Classes$dark_blue),
							A2(_evancz$elm_graphics$Collage$rect, width, height)),
						_1: {
							ctor: '::',
							_0: A2(
								_evancz$elm_graphics$Collage$outlined,
								_user$project$BTreeView$treeLineStyle,
								A2(_evancz$elm_graphics$Collage$rect, width, height)),
							_1: {
								ctor: '::',
								_0: A2(
									_evancz$elm_graphics$Collage$moveY,
									4,
									_evancz$elm_graphics$Collage$text(
										A2(
											_evancz$elm_graphics$Text$style,
											_user$project$BTreeView$treeNodeStyle,
											_evancz$elm_graphics$Text$fromString(_p7)))),
								_1: {ctor: '[]'}
							}
						}
					});
			case 'BoolVariety':
				var _p8 = _p3._0._0;
				if (_p8.ctor === 'Nothing') {
					return _user$project$BTreeView$drawNothingNode;
				} else {
					var _p9 = _p8._0;
					var colorizer = function (bool) {
						return bool ? _user$project$TachyonsColor$tachyonsColorToColor(_justgage$tachyons_elm$Tachyons_Classes$gray) : _user$project$TachyonsColor$tachyonsColorToColor(_justgage$tachyons_elm$Tachyons_Classes$black);
					};
					var displayString = function (bool) {
						return bool ? 'T' : 'F';
					};
					return _evancz$elm_graphics$Collage$group(
						{
							ctor: '::',
							_0: A2(
								_evancz$elm_graphics$Collage$filled,
								colorizer(_p9),
								A2(_evancz$elm_graphics$Collage$ngon, 6, 20)),
							_1: {
								ctor: '::',
								_0: A2(
									_evancz$elm_graphics$Collage$outlined,
									_user$project$BTreeView$treeLineStyle,
									A2(_evancz$elm_graphics$Collage$ngon, 6, 20)),
								_1: {
									ctor: '::',
									_0: A2(
										_evancz$elm_graphics$Collage$moveY,
										4,
										_evancz$elm_graphics$Collage$text(
											A2(
												_evancz$elm_graphics$Text$style,
												_user$project$BTreeView$treeNodeStyle,
												_evancz$elm_graphics$Text$fromString(
													displayString(_p9))))),
									_1: {ctor: '[]'}
								}
							}
						});
				}
			case 'MusicNoteVariety':
				var _p11 = _p3._0._0._0;
				var _p10 = _p11.mbNote;
				if (_p10.ctor === 'Just') {
					var outlineStyle = _p11.isPlaying ? _user$project$BTreeView$treeLineHighlightStyle : _user$project$BTreeView$treeLineStyle;
					return _evancz$elm_graphics$Collage$group(
						{
							ctor: '::',
							_0: A2(
								_evancz$elm_graphics$Collage$filled,
								_user$project$TachyonsColor$tachyonsColorToColor(_justgage$tachyons_elm$Tachyons_Classes$purple),
								A2(_evancz$elm_graphics$Collage$ngon, 5, 25)),
							_1: {
								ctor: '::',
								_0: A2(
									_evancz$elm_graphics$Collage$outlined,
									outlineStyle,
									A2(_evancz$elm_graphics$Collage$ngon, 5, 25)),
								_1: {
									ctor: '::',
									_0: A2(
										_evancz$elm_graphics$Collage$moveY,
										4,
										_evancz$elm_graphics$Collage$text(
											A2(
												_evancz$elm_graphics$Text$style,
												_user$project$BTreeView$treeNodeStyle,
												_evancz$elm_graphics$Text$fromString(
													A2(
														_elm_lang$core$Maybe$withDefault,
														'',
														_user$project$MusicNote$displayString(_p10._0)))))),
									_1: {ctor: '[]'}
								}
							}
						});
				} else {
					return _user$project$BTreeView$drawNothingNode;
				}
			default:
				return _evancz$elm_graphics$Collage$group(
					{
						ctor: '::',
						_0: A2(
							_evancz$elm_graphics$Collage$filled,
							_user$project$TachyonsColor$tachyonsColorToColor(_justgage$tachyons_elm$Tachyons_Classes$light_silver),
							A2(_evancz$elm_graphics$Collage$oval, 40, 40)),
						_1: {
							ctor: '::',
							_0: A2(
								_evancz$elm_graphics$Collage$outlined,
								_user$project$BTreeView$treeLineStyle,
								A2(_evancz$elm_graphics$Collage$oval, 40, 40)),
							_1: {
								ctor: '::',
								_0: A2(
									_evancz$elm_graphics$Collage$moveY,
									4,
									_evancz$elm_graphics$Collage$text(
										A2(
											_evancz$elm_graphics$Text$style,
											_user$project$BTreeView$treeNodeStyle,
											_evancz$elm_graphics$Text$fromString(_user$project$UniversalConstants$nothingString)))),
								_1: {ctor: '[]'}
							}
						}
					});
		}
	} else {
		return _evancz$elm_graphics$Collage$toForm(_evancz$elm_graphics$Element$empty);
	}
};
var _user$project$BTreeView$drawNothingNode = _user$project$BTreeView$drawNode(
	_elm_lang$core$Maybe$Just(
		_user$project$NodeTag$NothingVariety(_user$project$NodeTag$NothingNodeVal)));
var _user$project$BTreeView$nodeDisplayLength = function (nodeVariety) {
	var _p12 = nodeVariety;
	switch (_p12.ctor) {
		case 'IntVariety':
			var fn = function ($int) {
				var _p13 = _user$project$Lib$digitCount(
					_user$project$MaybeSafe$Safe($int));
				if (_p13.ctor === 'Unsafe') {
					return 0;
				} else {
					return _p13._0;
				}
			};
			return A3(_user$project$MaybeSafe$unwrap, 0, fn, _p12._0._0);
		case 'BigIntVariety':
			return A2(
				_user$project$MaybeSafe$withDefault,
				0,
				_user$project$Lib$digitCountBigInt(_p12._0._0));
		case 'StringVariety':
			return _elm_lang$core$String$length(_p12._0._0);
		case 'BoolVariety':
			return A3(
				_elm_community$maybe_extra$Maybe_Extra$unwrap,
				0,
				function (a) {
					return 1;
				},
				_p12._0._0);
		case 'MusicNoteVariety':
			var fn = function (note) {
				return _elm_lang$core$String$length(
					A2(
						_elm_lang$core$Maybe$withDefault,
						'',
						_user$project$MusicNote$displayString(note)));
			};
			return A3(_elm_community$maybe_extra$Maybe_Extra$unwrap, 0, fn, _p12._0._0._0.mbNote);
		default:
			return 0;
	}
};
var _user$project$BTreeView$maxNodeDisplayLength = function (bTree) {
	return A2(
		_elm_lang$core$Maybe$withDefault,
		0,
		_elm_lang$core$List$maximum(
			A2(
				_elm_lang$core$List$map,
				_user$project$BTreeView$nodeDisplayLength,
				_user$project$BTree$flatten(bTree))));
};
var _user$project$BTreeView$treeElement = F2(
	function (maxLength, mbTdTree) {
		var _p14 = mbTdTree;
		if (_p14.ctor === 'Nothing') {
			return _evancz$elm_graphics$Element$empty;
		} else {
			return A4(
				_brenden$elm_tree_diagram$TreeDiagram_Canvas$draw,
				_elm_lang$core$Native_Utils.update(
					_brenden$elm_tree_diagram$TreeDiagram$defaultTreeLayout,
					{
						padding: 100,
						siblingDistance: (_elm_lang$core$Native_Utils.cmp(maxLength, 13) < 0) ? 80 : 150,
						subtreeDistance: (_elm_lang$core$Native_Utils.cmp(maxLength, 13) < 0) ? 150 : 200
					}),
				_user$project$BTreeView$drawNode,
				_user$project$BTreeView$drawEdge,
				_p14._0);
		}
	});
var _user$project$BTreeView$bTreeDiagram = function (treeType) {
	var tree = function () {
		var _p15 = treeType;
		if (_p15.ctor === 'Uniform') {
			return _user$project$BTreeUniform$toTaggedNodes(_p15._0);
		} else {
			return _p15._0._0;
		}
	}();
	return _evancz$elm_graphics$Element$toHtml(
		A2(
			_user$project$BTreeView$treeElement,
			_user$project$BTreeView$maxNodeDisplayLength(tree),
			_user$project$BTree$toTreeDiagramTree(tree)));
};

var _user$project$IntView$BothView = {ctor: 'BothView'};
var _user$project$IntView$BigIntView = {ctor: 'BigIntView'};
var _user$project$IntView$IntView = {ctor: 'IntView'};

var _user$project$TreeRandomInsertStyle$Left = {ctor: 'Left'};
var _user$project$TreeRandomInsertStyle$Right = {ctor: 'Right'};
var _user$project$TreeRandomInsertStyle$Random = {ctor: 'Random'};
var _user$project$TreeRandomInsertStyle$treeRandomInsertStyleOptions = {
	ctor: '::',
	_0: _user$project$TreeRandomInsertStyle$Random,
	_1: {
		ctor: '::',
		_0: _user$project$TreeRandomInsertStyle$Right,
		_1: {
			ctor: '::',
			_0: _user$project$TreeRandomInsertStyle$Left,
			_1: {ctor: '[]'}
		}
	}
};

var _user$project$Ptrian$toNormalString = function (x) {
	return A2(
		_elm_lang$core$String$join,
		' ',
		A2(
			_elm_lang$core$List$map,
			_elm_lang$core$Basics$toString,
			_elm_lang$core$List$concat(x)));
};
var _user$project$Ptrian$ptrian = function (depth) {
	var f = F2(
		function (level, acc) {
			var rowlen = level;
			var formula = function (k) {
				if (_elm_lang$core$Native_Utils.eq(k, 1) || _elm_lang$core$Native_Utils.eq(k, rowlen)) {
					return 1;
				} else {
					var priorRow = A2(
						_elm_lang$core$Maybe$withDefault,
						{ctor: '[]'},
						_elm_community$list_extra$List_Extra$last(acc));
					var upLeft = A2(
						_elm_lang$core$Maybe$withDefault,
						0,
						A2(_elm_community$list_extra$List_Extra$getAt, k - 2, priorRow));
					var upTop = A2(
						_elm_lang$core$Maybe$withDefault,
						0,
						A2(_elm_community$list_extra$List_Extra$getAt, k - 1, priorRow));
					return upLeft + upTop;
				}
			};
			var row = A2(
				_elm_lang$core$List$map,
				formula,
				A2(_elm_lang$core$List$range, 1, rowlen));
			return A2(
				_elm_lang$core$Basics_ops['++'],
				acc,
				{
					ctor: '::',
					_0: row,
					_1: {ctor: '[]'}
				});
		});
	return A3(
		_elm_lang$core$List$foldl,
		f,
		{ctor: '[]'},
		A2(_elm_lang$core$List$range, 1, depth));
};

var _user$project$Model$Model = function (a) {
	return function (b) {
		return function (c) {
			return function (d) {
				return function (e) {
					return function (f) {
						return function (g) {
							return function (h) {
								return function (i) {
									return function (j) {
										return function (k) {
											return function (l) {
												return function (m) {
													return function (n) {
														return function (o) {
															return function (p) {
																return function (q) {
																	return function (r) {
																		return function (s) {
																			return function (t) {
																				return function (u) {
																					return function (v) {
																						return function (w) {
																							return function (x) {
																								return function (y) {
																									return {intTree: a, bigIntTree: b, stringTree: c, boolTree: d, initialMusicNoteTree: e, musicNoteTree: f, variedTree: g, intTreeMorph: h, bigIntTreeMorph: i, stringTreeMorph: j, boolTreeMorph: k, musicNoteTreeMorph: l, variedTreeCache: m, masterPlaySpeed: n, masterTraversalOrder: o, delta: p, exponent: q, isHarmonize: r, isPlayNotes: s, isTreeMorphing: t, directionForSort: u, treeRandomInsertStyle: v, intView: w, uuidSeed: x, pTriangleDepth: y};
																								};
																							};
																						};
																					};
																				};
																			};
																		};
																	};
																};
															};
														};
													};
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
};

var _user$project$Msg$PTriangleDepth = function (a) {
	return {ctor: 'PTriangleDepth', _0: a};
};
var _user$project$Msg$Reset = {ctor: 'Reset'};
var _user$project$Msg$ToggleHarmonize = {ctor: 'ToggleHarmonize'};
var _user$project$Msg$SwitchToIntView = function (a) {
	return {ctor: 'SwitchToIntView', _0: a};
};
var _user$project$Msg$DonePlayNotes = function (a) {
	return {ctor: 'DonePlayNotes', _0: a};
};
var _user$project$Msg$DonePlayNote = function (a) {
	return {ctor: 'DonePlayNote', _0: a};
};
var _user$project$Msg$StartPlayNote = function (a) {
	return {ctor: 'StartPlayNote', _0: a};
};
var _user$project$Msg$ChangeTreeRandomInsertStyle = function (a) {
	return {ctor: 'ChangeTreeRandomInsertStyle', _0: a};
};
var _user$project$Msg$ChangeSortDirection = function (a) {
	return {ctor: 'ChangeSortDirection', _0: a};
};
var _user$project$Msg$ChangeTraversalOrder = function (a) {
	return {ctor: 'ChangeTraversalOrder', _0: a};
};
var _user$project$Msg$ChangePlaySpeed = function (a) {
	return {ctor: 'ChangePlaySpeed', _0: a};
};
var _user$project$Msg$TogglePlayNotes = {ctor: 'TogglePlayNotes'};
var _user$project$Msg$StopShowIsIntPrime = {ctor: 'StopShowIsIntPrime'};
var _user$project$Msg$StartShowIsIntPrime = {ctor: 'StartShowIsIntPrime'};
var _user$project$Msg$StopShowLength = {ctor: 'StopShowLength'};
var _user$project$Msg$StartShowLength = {ctor: 'StartShowLength'};
var _user$project$Msg$ReceiveRandomExponent = function (a) {
	return {ctor: 'ReceiveRandomExponent', _0: a};
};
var _user$project$Msg$ReceiveRandomDelta = function (a) {
	return {ctor: 'ReceiveRandomDelta', _0: a};
};
var _user$project$Msg$RequestRandomScalars = {ctor: 'RequestRandomScalars'};
var _user$project$Msg$ReceiveRandomTuplesOfNodeVariety_Direction = function (a) {
	return {ctor: 'ReceiveRandomTuplesOfNodeVariety_Direction', _0: a};
};
var _user$project$Msg$ReceiveRandomTuplesOfBoolNode_Direction = function (a) {
	return {ctor: 'ReceiveRandomTuplesOfBoolNode_Direction', _0: a};
};
var _user$project$Msg$ReceiveRandomTuplesOfStringNode_Direction = function (a) {
	return {ctor: 'ReceiveRandomTuplesOfStringNode_Direction', _0: a};
};
var _user$project$Msg$ReceiveRandomTuplesOfBigIntNode_Direction = function (a) {
	return {ctor: 'ReceiveRandomTuplesOfBigIntNode_Direction', _0: a};
};
var _user$project$Msg$ReceiveRandomTuplesOfIntNode_Direction = function (a) {
	return {ctor: 'ReceiveRandomTuplesOfIntNode_Direction', _0: a};
};
var _user$project$Msg$ReceiveRandomTuplesOfMusicNote_Direction = function (a) {
	return {ctor: 'ReceiveRandomTuplesOfMusicNote_Direction', _0: a};
};
var _user$project$Msg$ReceiveRandomNodeVarieties = function (a) {
	return {ctor: 'ReceiveRandomNodeVarieties', _0: a};
};
var _user$project$Msg$ReceiveRandomBoolNodes = function (a) {
	return {ctor: 'ReceiveRandomBoolNodes', _0: a};
};
var _user$project$Msg$ReceiveRandomStringNodes = function (a) {
	return {ctor: 'ReceiveRandomStringNodes', _0: a};
};
var _user$project$Msg$ReceiveRandomBigIntNodes = function (a) {
	return {ctor: 'ReceiveRandomBigIntNodes', _0: a};
};
var _user$project$Msg$ReceiveRandomIntNodes = function (a) {
	return {ctor: 'ReceiveRandomIntNodes', _0: a};
};
var _user$project$Msg$ReceiveRandomTreeMusicNotes = function (a) {
	return {ctor: 'ReceiveRandomTreeMusicNotes', _0: a};
};
var _user$project$Msg$RequestRandomTrees = {ctor: 'RequestRandomTrees'};
var _user$project$Msg$Exponent = function (a) {
	return {ctor: 'Exponent', _0: a};
};
var _user$project$Msg$Delta = function (a) {
	return {ctor: 'Delta', _0: a};
};
var _user$project$Msg$RemoveDuplicates = {ctor: 'RemoveDuplicates'};
var _user$project$Msg$SortUniformTrees = {ctor: 'SortUniformTrees'};
var _user$project$Msg$NodeValueOperate = function (a) {
	return {ctor: 'NodeValueOperate', _0: a};
};

var _user$project$TreeCard$viewTreeCard = F6(
	function (cardWidth, title, status, mbLegend, mbBgColor, diagram) {
		var tachyonsPartialWidth = function () {
			var _p0 = cardWidth;
			if (_p0.ctor === 'Full') {
				return _justgage$tachyons_elm$Tachyons_Classes$w_20_l;
			} else {
				return _justgage$tachyons_elm$Tachyons_Classes$w_10_l;
			}
		}();
		var articleTachyons = A2(
			_elm_lang$core$Basics_ops['++'],
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons_Classes$fl,
				_1: {
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons_Classes$w_100,
					_1: {
						ctor: '::',
						_0: tachyonsPartialWidth,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$br2,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$ba,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$b__black_10,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$center,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$overflow_x_scroll,
											_1: {ctor: '[]'}
										}
									}
								}
							}
						}
					}
				}
			},
			A3(
				_elm_community$maybe_extra$Maybe_Extra$unwrap,
				{ctor: '[]'},
				_elm_lang$core$List$singleton,
				mbBgColor));
		return A2(
			_elm_lang$html$Html$article,
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons$classes(articleTachyons),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$div,
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons$classes(
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$tc,
								_1: {ctor: '[]'}
							}),
						_1: {ctor: '[]'}
					},
					{
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$h1,
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons$classes(
									{
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$f4,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$mb2,
											_1: {
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$pt1,
												_1: {
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$black,
													_1: {ctor: '[]'}
												}
											}
										}
									}),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: _elm_lang$html$Html$text(title),
								_1: {ctor: '[]'}
							}),
						_1: {
							ctor: '::',
							_0: status,
							_1: {
								ctor: '::',
								_0: A2(
									_elm_lang$html$Html$article,
									{
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons$classes(
											{
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$mt0,
												_1: {
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$pl2,
													_1: {ctor: '[]'}
												}
											}),
										_1: {ctor: '[]'}
									},
									{
										ctor: '::',
										_0: diagram,
										_1: {ctor: '[]'}
									}),
								_1: {
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$article,
										{
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons$classes(
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$center,
													_1: {ctor: '[]'}
												}),
											_1: {ctor: '[]'}
										},
										{
											ctor: '::',
											_0: A2(
												_elm_lang$core$Maybe$withDefault,
												A2(
													_elm_lang$html$Html$span,
													{ctor: '[]'},
													{ctor: '[]'}),
												mbLegend),
											_1: {ctor: '[]'}
										}),
									_1: {ctor: '[]'}
								}
							}
						}
					}),
				_1: {ctor: '[]'}
			});
	});
var _user$project$TreeCard$bTreeIntCardLegend = A2(
	_elm_lang$html$Html$article,
	{
		ctor: '::',
		_0: _justgage$tachyons_elm$Tachyons$classes(
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons_Classes$i,
				_1: {
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons_Classes$b,
					_1: {
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$tc,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$center,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$f5,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$pa1,
									_1: {ctor: '[]'}
								}
							}
						}
					}
				}
			}),
		_1: {ctor: '[]'}
	},
	{
		ctor: '::',
		_0: A2(
			_elm_lang$html$Html$span,
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons$classes(
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$black,
						_1: {ctor: '[]'}
					}),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: _elm_lang$html$Html$text('Legend: '),
				_1: {ctor: '[]'}
			}),
		_1: {
			ctor: '::',
			_0: A2(
				_elm_lang$html$Html$span,
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons$classes(
						{
							ctor: '::',
							_0: _user$project$BTreeView$intNodeEvenColor,
							_1: {ctor: '[]'}
						}),
					_1: {ctor: '[]'}
				},
				{
					ctor: '::',
					_0: _elm_lang$html$Html$text('Even '),
					_1: {ctor: '[]'}
				}),
			_1: {
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$span,
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons$classes(
							{
								ctor: '::',
								_0: _user$project$BTreeView$intNodeOddColor,
								_1: {ctor: '[]'}
							}),
						_1: {ctor: '[]'}
					},
					{
						ctor: '::',
						_0: _elm_lang$html$Html$text('Odd'),
						_1: {ctor: '[]'}
					}),
				_1: {ctor: '[]'}
			}
		}
	});
var _user$project$TreeCard$bTreeVariedLegend = function (bTreeVaried) {
	return _user$project$BTreeVaried$hasAnyIntNodes(bTreeVaried) ? _elm_lang$core$Maybe$Just(_user$project$TreeCard$bTreeIntCardLegend) : _elm_lang$core$Maybe$Nothing;
};
var _user$project$TreeCard$bTreeBigIntCardLegend = _user$project$TreeCard$bTreeIntCardLegend;
var _user$project$TreeCard$bTreeUniformLegend = function (bTreeUniform) {
	var _p1 = bTreeUniform;
	switch (_p1.ctor) {
		case 'UniformInt':
			return _elm_lang$core$Maybe$Just(_user$project$TreeCard$bTreeIntCardLegend);
		case 'UniformBigInt':
			return _elm_lang$core$Maybe$Just(_user$project$TreeCard$bTreeBigIntCardLegend);
		case 'UniformString':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformBool':
			return _elm_lang$core$Maybe$Nothing;
		case 'UniformMusicNotePlayer':
			return _elm_lang$core$Maybe$Nothing;
		default:
			return _elm_lang$core$Maybe$Nothing;
	}
};
var _user$project$TreeCard$depthStatus = function (depth) {
	return A2(
		_elm_lang$core$Basics_ops['++'],
		'depth ',
		_elm_lang$core$Basics$toString(depth));
};
var _user$project$TreeCard$treeStatus = F2(
	function (depth, mbIxSum) {
		var sumDisplay = function () {
			var okSum = function (string) {
				return A2(
					_elm_lang$html$Html$span,
					{ctor: '[]'},
					{
						ctor: '::',
						_0: _elm_lang$html$Html$text(string),
						_1: {ctor: '[]'}
					});
			};
			var result = function (ixSum) {
				var _p2 = ixSum;
				if (_p2.ctor === 'IntVal') {
					return A3(
						_user$project$MaybeSafe$unwrap,
						A2(
							_elm_lang$html$Html$span,
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons$classes(
									{
										ctor: '::',
										_0: _user$project$BTreeView$unsafeColor,
										_1: {ctor: '[]'}
									}),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: _elm_lang$html$Html$text('unsafe'),
								_1: {ctor: '[]'}
							}),
						function (sum) {
							return okSum(
								_elm_lang$core$Basics$toString(sum));
						},
						_p2._0);
				} else {
					return okSum(
						_gilbertkennen$bigint$BigInt$toString(_p2._0));
				}
			};
			return A3(
				_elm_community$maybe_extra$Maybe_Extra$unwrap,
				{
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$span,
						{ctor: '[]'},
						{ctor: '[]'}),
					_1: {ctor: '[]'}
				},
				function (ixSum) {
					return {
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$span,
							{ctor: '[]'},
							{
								ctor: '::',
								_0: _elm_lang$html$Html$text('; sum '),
								_1: {ctor: '[]'}
							}),
						_1: {
							ctor: '::',
							_0: result(ixSum),
							_1: {ctor: '[]'}
						}
					};
				},
				mbIxSum);
		}();
		return A2(
			_elm_lang$html$Html$article,
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons$classes(
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$f5,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$fw4,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$mt0,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$black,
									_1: {ctor: '[]'}
								}
							}
						}
					}),
				_1: {ctor: '[]'}
			},
			A2(
				_elm_lang$core$Basics_ops['++'],
				{
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$span,
						{ctor: '[]'},
						{
							ctor: '::',
							_0: _elm_lang$html$Html$text(
								_user$project$TreeCard$depthStatus(depth)),
							_1: {ctor: '[]'}
						}),
					_1: {ctor: '[]'}
				},
				sumDisplay));
	});
var _user$project$TreeCard$bTreeUniformStatus = function (bTreeUniform) {
	var mbIntFlex = _user$project$BTreeUniform$sumInt(bTreeUniform);
	var depth = _user$project$BTreeUniform$depth(bTreeUniform);
	return A2(_user$project$TreeCard$treeStatus, depth, mbIntFlex);
};
var _user$project$TreeCard$bTreeVariedStatus = function (_p3) {
	var _p4 = _p3;
	var mbMbsSum = _elm_lang$core$Maybe$Nothing;
	var depth = _user$project$BTree$depth(_p4._0);
	return A2(_user$project$TreeCard$treeStatus, depth, mbMbsSum);
};
var _user$project$TreeCard$viewVariedTreeCard = F2(
	function (cardWidth, bTreeVaried) {
		var diagram = _user$project$BTreeView$bTreeDiagram(
			_user$project$TreeType$Varied(bTreeVaried));
		var mbBgColor = _elm_lang$core$Maybe$Just(_justgage$tachyons_elm$Tachyons_Classes$bg_black_05);
		var mbLegend = _user$project$TreeCard$bTreeVariedLegend(bTreeVaried);
		var status = _user$project$TreeCard$bTreeVariedStatus(bTreeVaried);
		var title = _user$project$BTreeVaried$displayString(bTreeVaried);
		return A6(_user$project$TreeCard$viewTreeCard, cardWidth, title, status, mbLegend, mbBgColor, diagram);
	});
var _user$project$TreeCard$viewUniformTreeCard = F2(
	function (cardWidth, bTreeUniform) {
		var diagram = _user$project$BTreeView$bTreeDiagram(
			_user$project$TreeType$Uniform(bTreeUniform));
		var mbBgColor = _elm_lang$core$Maybe$Nothing;
		var mbLegend = _user$project$TreeCard$bTreeUniformLegend(bTreeUniform);
		var status = _user$project$TreeCard$bTreeUniformStatus(bTreeUniform);
		var title = _user$project$BTreeUniform$displayString(bTreeUniform);
		return A6(_user$project$TreeCard$viewTreeCard, cardWidth, title, status, mbLegend, mbBgColor, diagram);
	});
var _user$project$TreeCard$uniformMusicNoteTreeOfInterest = function (model) {
	return model.isTreeMorphing ? model.musicNoteTreeMorph : _user$project$BTreeUniform$UniformMusicNotePlayer(model.musicNoteTree);
};
var _user$project$TreeCard$uniformBoolTreeOfInterest = function (model) {
	return model.isTreeMorphing ? model.boolTreeMorph : _user$project$BTreeUniform$UniformBool(model.boolTree);
};
var _user$project$TreeCard$uniformStringTreeOfInterest = function (model) {
	return model.isTreeMorphing ? model.stringTreeMorph : _user$project$BTreeUniform$UniformString(model.stringTree);
};
var _user$project$TreeCard$uniformBigIntTreeOfInterest = function (model) {
	return model.isTreeMorphing ? model.bigIntTreeMorph : _user$project$BTreeUniform$UniformBigInt(model.bigIntTree);
};
var _user$project$TreeCard$uniformIntTreeOfInterest = function (model) {
	return model.isTreeMorphing ? model.intTreeMorph : _user$project$BTreeUniform$UniformInt(model.intTree);
};
var _user$project$TreeCard$Half = {ctor: 'Half'};
var _user$project$TreeCard$Full = {ctor: 'Full'};
var _user$project$TreeCard$intTreeCards = function (model) {
	var cardWidth = function () {
		var _p5 = model.intView;
		if (_p5.ctor === 'BothView') {
			return _user$project$TreeCard$Half;
		} else {
			return _user$project$TreeCard$Full;
		}
	}();
	var uniformIntTreesOfInterest = function () {
		var _p6 = model.intView;
		switch (_p6.ctor) {
			case 'IntView':
				return {
					ctor: '::',
					_0: _user$project$TreeCard$uniformIntTreeOfInterest(model),
					_1: {ctor: '[]'}
				};
			case 'BigIntView':
				return {
					ctor: '::',
					_0: _user$project$TreeCard$uniformBigIntTreeOfInterest(model),
					_1: {ctor: '[]'}
				};
			default:
				return {
					ctor: '::',
					_0: _user$project$TreeCard$uniformIntTreeOfInterest(model),
					_1: {
						ctor: '::',
						_0: _user$project$TreeCard$uniformBigIntTreeOfInterest(model),
						_1: {ctor: '[]'}
					}
				};
		}
	}();
	return A2(
		_elm_lang$core$List$map,
		function (tree) {
			return A2(_user$project$TreeCard$viewUniformTreeCard, cardWidth, tree);
		},
		uniformIntTreesOfInterest);
};
var _user$project$TreeCard$viewTrees = function (model) {
	var cardWidth = _user$project$TreeCard$Full;
	var cards = _elm_lang$core$List$concat(
		{
			ctor: '::',
			_0: {
				ctor: '::',
				_0: A2(
					_user$project$TreeCard$viewUniformTreeCard,
					cardWidth,
					_user$project$TreeCard$uniformMusicNoteTreeOfInterest(model)),
				_1: {ctor: '[]'}
			},
			_1: {
				ctor: '::',
				_0: _user$project$TreeCard$intTreeCards(model),
				_1: {
					ctor: '::',
					_0: {
						ctor: '::',
						_0: A2(
							_user$project$TreeCard$viewUniformTreeCard,
							cardWidth,
							_user$project$TreeCard$uniformStringTreeOfInterest(model)),
						_1: {
							ctor: '::',
							_0: A2(
								_user$project$TreeCard$viewUniformTreeCard,
								cardWidth,
								_user$project$TreeCard$uniformBoolTreeOfInterest(model)),
							_1: {
								ctor: '::',
								_0: A2(_user$project$TreeCard$viewVariedTreeCard, cardWidth, model.variedTree),
								_1: {ctor: '[]'}
							}
						}
					},
					_1: {ctor: '[]'}
				}
			}
		});
	return A2(
		_elm_lang$html$Html$section,
		{
			ctor: '::',
			_0: _justgage$tachyons_elm$Tachyons$classes(
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons_Classes$cf,
					_1: {ctor: '[]'}
				}),
			_1: {ctor: '[]'}
		},
		cards);
};

var _user$project$Dashboard$viewPtrian = function (model) {
	return {
		ctor: '::',
		_0: A2(
			_elm_lang$html$Html$span,
			{ctor: '[]'},
			{
				ctor: '::',
				_0: _elm_lang$html$Html$text('Ptriangle depth: '),
				_1: {
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$input,
						{
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons$classes(
								{
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$f4,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$w3,
										_1: {ctor: '[]'}
									}
								}),
							_1: {
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$type_('number'),
								_1: {
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$min('1'),
									_1: {
										ctor: '::',
										_0: _elm_lang$html$Html_Attributes$value(
											_elm_lang$core$Basics$toString(model.pTriangleDepth)),
										_1: {
											ctor: '::',
											_0: _elm_lang$html$Html_Events$onInput(_user$project$Msg$PTriangleDepth),
											_1: {ctor: '[]'}
										}
									}
								}
							}
						},
						{ctor: '[]'}),
					_1: {
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$label,
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons$classes(
									{
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$pa2,
										_1: {ctor: '[]'}
									}),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: _elm_lang$html$Html$text(
									_user$project$Ptrian$toNormalString(
										_user$project$Ptrian$ptrian(model.pTriangleDepth))),
								_1: {ctor: '[]'}
							}),
						_1: {ctor: '[]'}
					}
				}
			}),
		_1: {ctor: '[]'}
	};
};
var _user$project$Dashboard$viewHarmonyChoice = function (model) {
	return {
		ctor: '::',
		_0: A2(
			_elm_lang$html$Html$span,
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons$classes(
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$ph2,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$pv2,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$mt2,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$mb2,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$f6,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$ba,
											_1: {
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$br2,
												_1: {ctor: '[]'}
											}
										}
									}
								}
							}
						}
					}),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$label,
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons$classes(
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$pa2,
								_1: {ctor: '[]'}
							}),
						_1: {ctor: '[]'}
					},
					{
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$input,
							{
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$type_('checkbox'),
								_1: {
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$checked(model.isHarmonize),
									_1: {
										ctor: '::',
										_0: _elm_lang$html$Html_Events$onClick(_user$project$Msg$ToggleHarmonize),
										_1: {
											ctor: '::',
											_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
											_1: {ctor: '[]'}
										}
									}
								}
							},
							{ctor: '[]'}),
						_1: {
							ctor: '::',
							_0: _elm_lang$html$Html$text('Harmony'),
							_1: {ctor: '[]'}
						}
					}),
				_1: {ctor: '[]'}
			}),
		_1: {ctor: '[]'}
	};
};
var _user$project$Dashboard$radioIntView = F2(
	function (intView, model) {
		var labelFor = function (intView) {
			var _p0 = intView;
			switch (_p0.ctor) {
				case 'IntView':
					return 'Int';
				case 'BigIntView':
					return 'BigInt';
				default:
					return 'Both';
			}
		};
		return A2(
			_elm_lang$html$Html$label,
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons$classes(
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$pa2,
						_1: {ctor: '[]'}
					}),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$input,
					{
						ctor: '::',
						_0: _elm_lang$html$Html_Attributes$type_('radio'),
						_1: {
							ctor: '::',
							_0: _elm_lang$html$Html_Attributes$checked(
								_elm_lang$core$Native_Utils.eq(model.intView, intView)),
							_1: {
								ctor: '::',
								_0: _elm_lang$html$Html_Events$onClick(
									_user$project$Msg$SwitchToIntView(intView)),
								_1: {ctor: '[]'}
							}
						}
					},
					{ctor: '[]'}),
				_1: {
					ctor: '::',
					_0: _elm_lang$html$Html$text(
						labelFor(intView)),
					_1: {ctor: '[]'}
				}
			});
	});
var _user$project$Dashboard$viewIntTreeChoice = function (model) {
	return {
		ctor: '::',
		_0: A2(
			_elm_lang$html$Html$span,
			{
				ctor: '::',
				_0: _justgage$tachyons_elm$Tachyons$classes(
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$ph2,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$pv2,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$mt2,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$mb2,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$f6,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$ba,
											_1: {
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$br2,
												_1: {ctor: '[]'}
											}
										}
									}
								}
							}
						}
					}),
				_1: {ctor: '[]'}
			},
			{
				ctor: '::',
				_0: A2(_user$project$Dashboard$radioIntView, _user$project$IntView$IntView, model),
				_1: {
					ctor: '::',
					_0: A2(_user$project$Dashboard$radioIntView, _user$project$IntView$BigIntView, model),
					_1: {
						ctor: '::',
						_0: A2(_user$project$Dashboard$radioIntView, _user$project$IntView$BothView, model),
						_1: {ctor: '[]'}
					}
				}
			}),
		_1: {ctor: '[]'}
	};
};
var _user$project$Dashboard$viewInputs = function (model) {
	return {
		ctor: '::',
		_0: A2(
			_elm_lang$html$Html$span,
			{ctor: '[]'},
			{
				ctor: '::',
				_0: _elm_lang$html$Html$text('Delta: '),
				_1: {
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$input,
						{
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons$classes(
								{
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$f4,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$w3,
										_1: {ctor: '[]'}
									}
								}),
							_1: {
								ctor: '::',
								_0: _elm_lang$html$Html_Attributes$type_('number'),
								_1: {
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$min('1'),
									_1: {
										ctor: '::',
										_0: _elm_lang$html$Html_Attributes$value(
											_elm_lang$core$Basics$toString(model.delta)),
										_1: {
											ctor: '::',
											_0: _elm_lang$html$Html_Events$onInput(_user$project$Msg$Delta),
											_1: {ctor: '[]'}
										}
									}
								}
							}
						},
						{ctor: '[]'}),
					_1: {ctor: '[]'}
				}
			}),
		_1: {
			ctor: '::',
			_0: A2(
				_elm_lang$html$Html$span,
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons$classes(
						{
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$pl3,
							_1: {ctor: '[]'}
						}),
					_1: {ctor: '[]'}
				},
				{
					ctor: '::',
					_0: _elm_lang$html$Html$text('Exp: '),
					_1: {
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$input,
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons$classes(
									{
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$f4,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$w3,
											_1: {ctor: '[]'}
										}
									}),
								_1: {
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$type_('number'),
									_1: {
										ctor: '::',
										_0: _elm_lang$html$Html_Attributes$min('1'),
										_1: {
											ctor: '::',
											_0: _elm_lang$html$Html_Attributes$value(
												_elm_lang$core$Basics$toString(model.exponent)),
											_1: {
												ctor: '::',
												_0: _elm_lang$html$Html_Events$onInput(_user$project$Msg$Exponent),
												_1: {ctor: '[]'}
											}
										}
									}
								}
							},
							{ctor: '[]'}),
						_1: {ctor: '[]'}
					}
				}),
			_1: {ctor: '[]'}
		}
	};
};
var _user$project$Dashboard$isEnablePlayNotesWidgetry = function (model) {
	return (!model.isPlayNotes) && (!_user$project$BTreeUniform$isAllNothing(
		_user$project$BTreeUniform$UniformMusicNotePlayer(model.musicNoteTree)));
};
var _user$project$Dashboard$directionDecoder = function (value) {
	var _p1 = _elm_lang$core$String$toLower(value);
	switch (_p1) {
		case 'right':
			return _elm_lang$core$Json_Decode$succeed(_user$project$BTree$Right);
		case 'left':
			return _elm_lang$core$Json_Decode$succeed(_user$project$BTree$Left);
		default:
			return _elm_lang$core$Json_Decode$fail('Invalid Direction');
	}
};
var _user$project$Dashboard$onSortDirectionChange = A2(
	_elm_lang$html$Html_Events$on,
	'change',
	A2(
		_elm_lang$core$Json_Decode$map,
		_user$project$Msg$ChangeSortDirection,
		A2(_elm_lang$core$Json_Decode$andThen, _user$project$Dashboard$directionDecoder, _elm_lang$html$Html_Events$targetValue)));
var _user$project$Dashboard$playSpeedDecoder = function (value) {
	var _p2 = _elm_lang$core$String$toLower(value);
	switch (_p2) {
		case 'fast':
			return _elm_lang$core$Json_Decode$succeed(_user$project$TreePlayerParams$Fast);
		case 'medium':
			return _elm_lang$core$Json_Decode$succeed(_user$project$TreePlayerParams$Medium);
		case 'slow':
			return _elm_lang$core$Json_Decode$succeed(_user$project$TreePlayerParams$Slow);
		default:
			return _elm_lang$core$Json_Decode$fail('Invalid PlaySpeed');
	}
};
var _user$project$Dashboard$onPlaySpeedChange = A2(
	_elm_lang$html$Html_Events$on,
	'change',
	A2(
		_elm_lang$core$Json_Decode$map,
		_user$project$Msg$ChangePlaySpeed,
		A2(_elm_lang$core$Json_Decode$andThen, _user$project$Dashboard$playSpeedDecoder, _elm_lang$html$Html_Events$targetValue)));
var _user$project$Dashboard$traversalOrderDecoder = function (value) {
	var _p3 = _elm_lang$core$String$toLower(value);
	switch (_p3) {
		case 'inorder':
			return _elm_lang$core$Json_Decode$succeed(_user$project$BTree$InOrder);
		case 'preorder':
			return _elm_lang$core$Json_Decode$succeed(_user$project$BTree$PreOrder);
		case 'postorder':
			return _elm_lang$core$Json_Decode$succeed(_user$project$BTree$PostOrder);
		default:
			return _elm_lang$core$Json_Decode$fail('Invalid TraversalOrder');
	}
};
var _user$project$Dashboard$onTraversalOrderChange = A2(
	_elm_lang$html$Html_Events$on,
	'change',
	A2(
		_elm_lang$core$Json_Decode$map,
		_user$project$Msg$ChangeTraversalOrder,
		A2(_elm_lang$core$Json_Decode$andThen, _user$project$Dashboard$traversalOrderDecoder, _elm_lang$html$Html_Events$targetValue)));
var _user$project$Dashboard$InsertStyle_MenuOption = F2(
	function (a, b) {
		return {display: a, style: b};
	});
var _user$project$Dashboard$insertStyle_MenuOptions = {
	ctor: '::',
	_0: A2(_user$project$Dashboard$InsertStyle_MenuOption, 'Insert Random L/R', _user$project$TreeRandomInsertStyle$Random),
	_1: {
		ctor: '::',
		_0: A2(_user$project$Dashboard$InsertStyle_MenuOption, 'Insert Right', _user$project$TreeRandomInsertStyle$Right),
		_1: {
			ctor: '::',
			_0: A2(_user$project$Dashboard$InsertStyle_MenuOption, 'Insert Left', _user$project$TreeRandomInsertStyle$Left),
			_1: {ctor: '[]'}
		}
	}
};
var _user$project$Dashboard$insertStylesDict = function () {
	var fn = function (obj) {
		return {ctor: '_Tuple2', _0: obj.display, _1: obj.style};
	};
	return _elm_lang$core$Dict$fromList(
		A2(_elm_lang$core$List$map, fn, _user$project$Dashboard$insertStyle_MenuOptions));
}();
var _user$project$Dashboard$treeRandomInsertStyleDecoder = function (value) {
	return A2(
		_elm_lang$core$Maybe$withDefault,
		_elm_lang$core$Json_Decode$fail('Invalid TreeRandomInsertStyle'),
		A2(
			_elm_lang$core$Maybe$map,
			_elm_lang$core$Json_Decode$succeed,
			A2(_elm_lang$core$Dict$get, value, _user$project$Dashboard$insertStylesDict)));
};
var _user$project$Dashboard$onTreeRandomInsertStyleChange = A2(
	_elm_lang$html$Html_Events$on,
	'change',
	A2(
		_elm_lang$core$Json_Decode$map,
		_user$project$Msg$ChangeTreeRandomInsertStyle,
		A2(_elm_lang$core$Json_Decode$andThen, _user$project$Dashboard$treeRandomInsertStyleDecoder, _elm_lang$html$Html_Events$targetValue)));
var _user$project$Dashboard$insertStyleDisplayFor = function (style) {
	return function (_) {
		return _.display;
	}(
		A2(
			_elm_lang$core$Maybe$withDefault,
			A2(_user$project$Dashboard$InsertStyle_MenuOption, 'should never get here', _user$project$TreeRandomInsertStyle$Random),
			_elm_lang$core$List$head(
				A2(
					_elm_lang$core$List$filter,
					function (menuOption) {
						return _elm_lang$core$Native_Utils.eq(menuOption.style, style);
					},
					_user$project$Dashboard$insertStyle_MenuOptions))));
};
var _user$project$Dashboard$viewDashboardWithTreesUnderneath = function (model) {
	var playButtonDisplay = model.isPlayNotes ? 'Stop' : 'Play';
	return A2(
		_elm_lang$html$Html$section,
		{
			ctor: '::',
			_0: _justgage$tachyons_elm$Tachyons$classes(
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons_Classes$fixed,
					_1: {
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$w_100,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$f3,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$z_max,
								_1: {ctor: '[]'}
							}
						}
					}
				}),
			_1: {ctor: '[]'}
		},
		{
			ctor: '::',
			_0: A2(
				_elm_lang$html$Html$section,
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons$classes(
						{
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$pa1,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$bg_washed_yellow,
								_1: {ctor: '[]'}
							}
						}),
					_1: {ctor: '[]'}
				},
				{
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$span,
						{
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons$classes(
								{
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$mh2,
									_1: {ctor: '[]'}
								}),
							_1: {ctor: '[]'}
						},
						{
							ctor: '::',
							_0: A2(
								_elm_lang$html$Html$div,
								{
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons$classes(
										{
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$relative,
											_1: {
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$dib,
												_1: {ctor: '[]'}
											}
										}),
									_1: {ctor: '[]'}
								},
								{
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$button,
										{
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons$classes(
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
													_1: {ctor: '[]'}
												}),
											_1: {
												ctor: '::',
												_0: _elm_lang$html$Html_Events$onClick(_user$project$Msg$TogglePlayNotes),
												_1: {
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$disabled(
														_user$project$BTreeUniform$isAllNothing(
															_user$project$BTreeUniform$UniformMusicNotePlayer(model.musicNoteTree))),
													_1: {ctor: '[]'}
												}
											}
										},
										{
											ctor: '::',
											_0: _elm_lang$html$Html$text(playButtonDisplay),
											_1: {ctor: '[]'}
										}),
									_1: {
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$select,
											{
												ctor: '::',
												_0: _user$project$Dashboard$onTraversalOrderChange,
												_1: {
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
													_1: {ctor: '[]'}
												}
											},
											A2(
												_elm_lang$core$List$map,
												function (order) {
													var isSelected = _elm_lang$core$Native_Utils.eq(model.masterTraversalOrder, order);
													return A2(
														_elm_lang$html$Html$option,
														{
															ctor: '::',
															_0: _elm_lang$html$Html_Attributes$selected(isSelected),
															_1: {ctor: '[]'}
														},
														{
															ctor: '::',
															_0: _elm_lang$html$Html$text(
																_elm_lang$core$Basics$toString(order)),
															_1: {ctor: '[]'}
														});
												},
												_user$project$BTree$traversalOrderOptions)),
										_1: {
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$select,
												{
													ctor: '::',
													_0: _user$project$Dashboard$onPlaySpeedChange,
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
														_1: {ctor: '[]'}
													}
												},
												A2(
													_elm_lang$core$List$map,
													function (speed) {
														var isSelected = _elm_lang$core$Native_Utils.eq(model.masterPlaySpeed, speed);
														return A2(
															_elm_lang$html$Html$option,
															{
																ctor: '::',
																_0: _elm_lang$html$Html_Attributes$selected(isSelected),
																_1: {ctor: '[]'}
															},
															{
																ctor: '::',
																_0: _elm_lang$html$Html$text(
																	_elm_lang$core$Basics$toString(speed)),
																_1: {ctor: '[]'}
															});
													},
													_user$project$TreePlayerParams$playSpeedOptions)),
											_1: {ctor: '[]'}
										}
									}
								}),
							_1: {ctor: '[]'}
						}),
					_1: {
						ctor: '::',
						_0: A2(
							_elm_lang$html$Html$span,
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons$classes(
									{
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$mh2,
										_1: {ctor: '[]'}
									}),
								_1: {ctor: '[]'}
							},
							{
								ctor: '::',
								_0: A2(
									_elm_lang$html$Html$button,
									{
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons$classes(
											{
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
												_1: {
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
													_1: {ctor: '[]'}
												}
											}),
										_1: {
											ctor: '::',
											_0: _elm_lang$html$Html_Events$onClick(
												_user$project$Msg$NodeValueOperate(
													_user$project$NodeValueOperation$Increment(model.delta))),
											_1: {
												ctor: '::',
												_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
												_1: {ctor: '[]'}
											}
										}
									},
									{
										ctor: '::',
										_0: _elm_lang$html$Html$text('+ Delta'),
										_1: {ctor: '[]'}
									}),
								_1: {
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$button,
										{
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons$classes(
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
													_1: {
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
														_1: {ctor: '[]'}
													}
												}),
											_1: {
												ctor: '::',
												_0: _elm_lang$html$Html_Events$onClick(
													_user$project$Msg$NodeValueOperate(
														_user$project$NodeValueOperation$Decrement(model.delta))),
												_1: {
													ctor: '::',
													_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
													_1: {ctor: '[]'}
												}
											}
										},
										{
											ctor: '::',
											_0: _elm_lang$html$Html$text('- Delta'),
											_1: {ctor: '[]'}
										}),
									_1: {
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$button,
											{
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons$classes(
													{
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
														_1: {
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
															_1: {ctor: '[]'}
														}
													}),
												_1: {
													ctor: '::',
													_0: _elm_lang$html$Html_Events$onClick(
														_user$project$Msg$NodeValueOperate(
															_user$project$NodeValueOperation$Raise(model.exponent))),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
														_1: {ctor: '[]'}
													}
												}
											},
											{
												ctor: '::',
												_0: _elm_lang$html$Html$text('^ Exp'),
												_1: {ctor: '[]'}
											}),
										_1: {ctor: '[]'}
									}
								}
							}),
						_1: {
							ctor: '::',
							_0: A2(
								_elm_lang$html$Html$span,
								{
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons$classes(
										{
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$mh2,
											_1: {ctor: '[]'}
										}),
									_1: {ctor: '[]'}
								},
								{
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$div,
										{
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons$classes(
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$relative,
													_1: {
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons_Classes$dib,
														_1: {ctor: '[]'}
													}
												}),
											_1: {ctor: '[]'}
										},
										{
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$button,
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons$classes(
														{
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
															_1: {ctor: '[]'}
														}),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
														_1: {
															ctor: '::',
															_0: _elm_lang$html$Html_Events$onClick(_user$project$Msg$SortUniformTrees),
															_1: {ctor: '[]'}
														}
													}
												},
												{
													ctor: '::',
													_0: _elm_lang$html$Html$text('Sort'),
													_1: {ctor: '[]'}
												}),
											_1: {
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$select,
													{
														ctor: '::',
														_0: _user$project$Dashboard$onSortDirectionChange,
														_1: {
															ctor: '::',
															_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
															_1: {ctor: '[]'}
														}
													},
													A2(
														_elm_lang$core$List$map,
														function (direction) {
															var isSelected = _elm_lang$core$Native_Utils.eq(model.directionForSort, direction);
															return A2(
																_elm_lang$html$Html$option,
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html_Attributes$selected(isSelected),
																	_1: {ctor: '[]'}
																},
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html$text(
																		_elm_lang$core$Basics$toString(direction)),
																	_1: {ctor: '[]'}
																});
														},
														_user$project$BTree$directionOptions)),
												_1: {ctor: '[]'}
											}
										}),
									_1: {ctor: '[]'}
								}),
							_1: {
								ctor: '::',
								_0: A2(
									_elm_lang$html$Html$span,
									{
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons$classes(
											{
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$mh2,
												_1: {ctor: '[]'}
											}),
										_1: {ctor: '[]'}
									},
									{
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$button,
											{
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons$classes(
													{
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
														_1: {
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
															_1: {ctor: '[]'}
														}
													}),
												_1: {
													ctor: '::',
													_0: _elm_lang$html$Html_Events$onClick(_user$project$Msg$RemoveDuplicates),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
														_1: {ctor: '[]'}
													}
												}
											},
											{
												ctor: '::',
												_0: _elm_lang$html$Html$text('Dedup'),
												_1: {ctor: '[]'}
											}),
										_1: {ctor: '[]'}
									}),
								_1: {
									ctor: '::',
									_0: A2(
										_elm_lang$html$Html$span,
										{
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons$classes(
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$mh2,
													_1: {ctor: '[]'}
												}),
											_1: {ctor: '[]'}
										},
										{
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$button,
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons$classes(
														{
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
															_1: {
																ctor: '::',
																_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
																_1: {ctor: '[]'}
															}
														}),
													_1: {
														ctor: '::',
														_0: _elm_lang$html$Html_Events$onMouseDown(_user$project$Msg$StartShowIsIntPrime),
														_1: {
															ctor: '::',
															_0: _elm_lang$html$Html_Events$onMouseUp(_user$project$Msg$StopShowIsIntPrime),
															_1: {
																ctor: '::',
																_0: _elm_lang$html$Html_Events$onMouseLeave(_user$project$Msg$StopShowIsIntPrime),
																_1: {ctor: '[]'}
															}
														}
													}
												},
												{
													ctor: '::',
													_0: _elm_lang$html$Html$text('Prime?'),
													_1: {ctor: '[]'}
												}),
											_1: {
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$button,
													{
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons$classes(
															{
																ctor: '::',
																_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
																_1: {
																	ctor: '::',
																	_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
																	_1: {ctor: '[]'}
																}
															}),
														_1: {
															ctor: '::',
															_0: _elm_lang$html$Html_Events$onMouseDown(_user$project$Msg$StartShowLength),
															_1: {
																ctor: '::',
																_0: _elm_lang$html$Html_Events$onMouseUp(_user$project$Msg$StopShowLength),
																_1: {
																	ctor: '::',
																	_0: _elm_lang$html$Html_Events$onMouseLeave(_user$project$Msg$StopShowLength),
																	_1: {ctor: '[]'}
																}
															}
														}
													},
													{
														ctor: '::',
														_0: _elm_lang$html$Html$text('Length'),
														_1: {ctor: '[]'}
													}),
												_1: {ctor: '[]'}
											}
										}),
									_1: {
										ctor: '::',
										_0: A2(
											_elm_lang$html$Html$span,
											{
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons$classes(
													{
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons_Classes$mh2,
														_1: {ctor: '[]'}
													}),
												_1: {ctor: '[]'}
											},
											{
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$div,
													{
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons$classes(
															{
																ctor: '::',
																_0: _justgage$tachyons_elm$Tachyons_Classes$relative,
																_1: {
																	ctor: '::',
																	_0: _justgage$tachyons_elm$Tachyons_Classes$dib,
																	_1: {ctor: '[]'}
																}
															}),
														_1: {ctor: '[]'}
													},
													{
														ctor: '::',
														_0: A2(
															_elm_lang$html$Html$button,
															{
																ctor: '::',
																_0: _justgage$tachyons_elm$Tachyons$classes(
																	{
																		ctor: '::',
																		_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
																		_1: {ctor: '[]'}
																	}),
																_1: {
																	ctor: '::',
																	_0: _elm_lang$html$Html_Events$onClick(_user$project$Msg$RequestRandomTrees),
																	_1: {ctor: '[]'}
																}
															},
															{
																ctor: '::',
																_0: _elm_lang$html$Html$text('Random Trees'),
																_1: {ctor: '[]'}
															}),
														_1: {
															ctor: '::',
															_0: A2(
																_elm_lang$html$Html$select,
																{
																	ctor: '::',
																	_0: _user$project$Dashboard$onTreeRandomInsertStyleChange,
																	_1: {
																		ctor: '::',
																		_0: _elm_lang$html$Html_Attributes$disabled(model.isPlayNotes),
																		_1: {ctor: '[]'}
																	}
																},
																A2(
																	_elm_lang$core$List$map,
																	function (style) {
																		return A2(
																			_elm_lang$html$Html$option,
																			{
																				ctor: '::',
																				_0: _elm_lang$html$Html_Attributes$selected(
																					_elm_lang$core$Native_Utils.eq(model.treeRandomInsertStyle, style)),
																				_1: {ctor: '[]'}
																			},
																			{
																				ctor: '::',
																				_0: _elm_lang$html$Html$text(
																					_user$project$Dashboard$insertStyleDisplayFor(style)),
																				_1: {ctor: '[]'}
																			});
																	},
																	_user$project$TreeRandomInsertStyle$treeRandomInsertStyleOptions)),
															_1: {ctor: '[]'}
														}
													}),
												_1: {
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$button,
														{
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons$classes(
																{
																	ctor: '::',
																	_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
																	_1: {
																		ctor: '::',
																		_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
																		_1: {ctor: '[]'}
																	}
																}),
															_1: {
																ctor: '::',
																_0: _elm_lang$html$Html_Events$onClick(_user$project$Msg$RequestRandomScalars),
																_1: {ctor: '[]'}
															}
														},
														{
															ctor: '::',
															_0: _elm_lang$html$Html$text('Random Scalars'),
															_1: {ctor: '[]'}
														}),
													_1: {ctor: '[]'}
												}
											}),
										_1: {
											ctor: '::',
											_0: A2(
												_elm_lang$html$Html$span,
												{
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons$classes(
														{
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons_Classes$pl4,
															_1: {ctor: '[]'}
														}),
													_1: {ctor: '[]'}
												},
												_user$project$Dashboard$viewInputs(model)),
											_1: {
												ctor: '::',
												_0: A2(
													_elm_lang$html$Html$span,
													{
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons$classes(
															{
																ctor: '::',
																_0: _justgage$tachyons_elm$Tachyons_Classes$pl4,
																_1: {ctor: '[]'}
															}),
														_1: {ctor: '[]'}
													},
													_user$project$Dashboard$viewIntTreeChoice(model)),
												_1: {
													ctor: '::',
													_0: A2(
														_elm_lang$html$Html$span,
														{
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons$classes(
																{
																	ctor: '::',
																	_0: _justgage$tachyons_elm$Tachyons_Classes$pl4,
																	_1: {ctor: '[]'}
																}),
															_1: {ctor: '[]'}
														},
														_user$project$Dashboard$viewHarmonyChoice(model)),
													_1: {
														ctor: '::',
														_0: A2(
															_elm_lang$html$Html$span,
															{
																ctor: '::',
																_0: _justgage$tachyons_elm$Tachyons$classes(
																	{
																		ctor: '::',
																		_0: _justgage$tachyons_elm$Tachyons_Classes$pl4,
																		_1: {ctor: '[]'}
																	}),
																_1: {ctor: '[]'}
															},
															_user$project$Dashboard$viewPtrian(model)),
														_1: {
															ctor: '::',
															_0: A2(
																_elm_lang$html$Html$button,
																{
																	ctor: '::',
																	_0: _justgage$tachyons_elm$Tachyons$classes(
																		{
																			ctor: '::',
																			_0: _justgage$tachyons_elm$Tachyons_Classes$fr,
																			_1: {
																				ctor: '::',
																				_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_yellow,
																				_1: {
																					ctor: '::',
																					_0: _justgage$tachyons_elm$Tachyons_Classes$mv1,
																					_1: {
																						ctor: '::',
																						_0: _justgage$tachyons_elm$Tachyons_Classes$mr2,
																						_1: {ctor: '[]'}
																					}
																				}
																			}
																		}),
																	_1: {
																		ctor: '::',
																		_0: _elm_lang$html$Html_Events$onClick(_user$project$Msg$Reset),
																		_1: {ctor: '[]'}
																	}
																},
																{
																	ctor: '::',
																	_0: _elm_lang$html$Html$text('Reset'),
																	_1: {ctor: '[]'}
																}),
															_1: {ctor: '[]'}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}),
			_1: {
				ctor: '::',
				_0: _user$project$TreeCard$viewTrees(model),
				_1: {ctor: '[]'}
			}
		});
};

var _user$project$Generator$generatorTreeBool = _elm_lang$core$Random$bool;
var _user$project$Generator$generatorBoolNode = A2(
	_elm_lang$core$Random$map,
	function (b) {
		return _user$project$NodeTag$BoolNodeVal(
			_elm_lang$core$Maybe$Just(b));
	},
	_user$project$Generator$generatorTreeBool);
var _user$project$Generator$generatorTreeMusicNote = function () {
	var _p0 = _user$project$MusicNote$maxMidiNumber;
	var max = _p0._0;
	var _p1 = _user$project$MusicNote$minMidiNumber;
	var min = _p1._0;
	return A2(
		_elm_lang$core$Random$map,
		function (i) {
			return _user$project$MusicNote$MusicNote(
				_user$project$MusicNote$MidiNumber(i));
		},
		A2(_elm_lang$core$Random$int, min, max));
}();
var _user$project$Generator$generatorMusicNoteNode = A2(
	_elm_lang$core$Random$map,
	function (n) {
		return _user$project$NodeTag$MusicNoteNodeVal(
			_user$project$MusicNotePlayer$on(n));
	},
	_user$project$Generator$generatorTreeMusicNote);
var _user$project$Generator$generatorNothingNode = A2(
	_elm_lang$core$Random$map,
	function (b) {
		return _user$project$NodeTag$NothingNodeVal;
	},
	_elm_lang$core$Random$bool);
var _user$project$Generator$boolToDirection = function (b) {
	var _p2 = b;
	if (_p2 === true) {
		return _user$project$BTree$Right;
	} else {
		return _user$project$BTree$Left;
	}
};
var _user$project$Generator$generateIds = F2(
	function (count, startSeed) {
		var generate = function (seed) {
			return A2(_mgold$elm_random_pcg$Random_Pcg$step, _danyx23$elm_uuid$Uuid$uuidGenerator, seed);
		};
		var fn = F2(
			function (a, _p3) {
				var _p4 = _p3;
				return generate(_p4._1);
			});
		var tuples = A3(
			_elm_lang$core$List$scanl,
			fn,
			generate(startSeed),
			A2(_elm_lang$core$List$repeat, count - 1, _elm_lang$core$Maybe$Nothing));
		var ids = A2(_elm_lang$core$List$map, _elm_lang$core$Tuple$first, tuples);
		var lazyDefault = _elm_lang$lazy$Lazy$lazy(
			function (_p5) {
				var _p6 = _p5;
				return {
					ctor: '_Tuple2',
					_0: _elm_lang$core$Tuple$first(
						generate(startSeed)),
					_1: startSeed
				};
			});
		var currentSeed = _elm_lang$core$Tuple$second(
			A3(
				_user$project$Lib$lazyUnwrap,
				lazyDefault,
				_elm_lang$core$Basics$identity,
				_elm_community$list_extra$List_Extra$last(tuples)));
		return {ctor: '_Tuple2', _0: ids, _1: currentSeed};
	});
var _user$project$Generator$maxRandomListLength = 12;
var _user$project$Generator$minRandomListLength = 3;
var _user$project$Generator$generatorRandomListLength = A2(_elm_lang$core$Random$int, _user$project$Generator$minRandomListLength, _user$project$Generator$maxRandomListLength);
var _user$project$Generator$generatorTreeMusicNotes = function () {
	var randomMusicNotes = function (length) {
		return A2(_elm_lang$core$Random$list, length, _user$project$Generator$generatorTreeMusicNote);
	};
	return A2(_elm_lang$core$Random$andThen, randomMusicNotes, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorBoolNodes = function () {
	var nodes = function (length) {
		return A2(_elm_lang$core$Random$list, length, _user$project$Generator$generatorBoolNode);
	};
	return A2(_elm_lang$core$Random$andThen, nodes, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorTuplesOfMusicNoteDirection = function () {
	var randomTuplesOfMusicNoteDirection = function (length) {
		return A2(
			_elm_lang$core$Random$list,
			length,
			A2(
				_elm_lang$core$Random$pair,
				_user$project$Generator$generatorTreeMusicNote,
				A2(_elm_lang$core$Random$map, _user$project$Generator$boolToDirection, _elm_lang$core$Random$bool)));
	};
	return A2(_elm_lang$core$Random$andThen, randomTuplesOfMusicNoteDirection, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorTuplesOfBoolNode_Direction = function () {
	var tuples = function (length) {
		return A2(
			_elm_lang$core$Random$list,
			length,
			A2(
				_elm_lang$core$Random$pair,
				_user$project$Generator$generatorBoolNode,
				A2(_elm_lang$core$Random$map, _user$project$Generator$boolToDirection, _elm_lang$core$Random$bool)));
	};
	return A2(_elm_lang$core$Random$andThen, tuples, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$maxRandomTreeStringLength = 10;
var _user$project$Generator$minRandomTreeStringLength = 3;
var _user$project$Generator$generatorTreeString = A3(_elm_community$random_extra$Random_String$rangeLengthString, _user$project$Generator$minRandomTreeStringLength, _user$project$Generator$maxRandomTreeStringLength, _elm_community$random_extra$Random_Char$english);
var _user$project$Generator$generatorStringNode = A2(_elm_lang$core$Random$map, _user$project$NodeTag$StringNodeVal, _user$project$Generator$generatorTreeString);
var _user$project$Generator$generatorStringNodes = function () {
	var nodes = function (length) {
		return A2(_elm_lang$core$Random$list, length, _user$project$Generator$generatorStringNode);
	};
	return A2(_elm_lang$core$Random$andThen, nodes, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorTuplesOfStringNode_Direction = function () {
	var tuples = function (length) {
		return A2(
			_elm_lang$core$Random$list,
			length,
			A2(
				_elm_lang$core$Random$pair,
				_user$project$Generator$generatorStringNode,
				A2(_elm_lang$core$Random$map, _user$project$Generator$boolToDirection, _elm_lang$core$Random$bool)));
	};
	return A2(_elm_lang$core$Random$andThen, tuples, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$maxRandomTreeInt = 999;
var _user$project$Generator$minRandomTreeInt = 1;
var _user$project$Generator$generatorTreeInt = A2(_elm_lang$core$Random$int, _user$project$Generator$minRandomTreeInt, _user$project$Generator$maxRandomTreeInt);
var _user$project$Generator$generatorIntNode = A2(
	_elm_lang$core$Random$map,
	function (i) {
		return _user$project$NodeTag$IntNodeVal(
			_user$project$MaybeSafe$toMaybeSafeInt(i));
	},
	_user$project$Generator$generatorTreeInt);
var _user$project$Generator$generatorIntNodes = function () {
	var nodes = function (length) {
		return A2(_elm_lang$core$Random$list, length, _user$project$Generator$generatorIntNode);
	};
	return A2(_elm_lang$core$Random$andThen, nodes, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorTuplesOfIntNode_Direction = function () {
	var tuples = function (length) {
		return A2(
			_elm_lang$core$Random$list,
			length,
			A2(
				_elm_lang$core$Random$pair,
				_user$project$Generator$generatorIntNode,
				A2(_elm_lang$core$Random$map, _user$project$Generator$boolToDirection, _elm_lang$core$Random$bool)));
	};
	return A2(_elm_lang$core$Random$andThen, tuples, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorBigIntNode = A2(
	_elm_lang$core$Random$map,
	function (i) {
		return _user$project$NodeTag$BigIntNodeVal(
			_gilbertkennen$bigint$BigInt$fromInt(i));
	},
	_user$project$Generator$generatorTreeInt);
var _user$project$Generator$generatorBigIntNodes = function () {
	var nodes = function (length) {
		return A2(_elm_lang$core$Random$list, length, _user$project$Generator$generatorBigIntNode);
	};
	return A2(_elm_lang$core$Random$andThen, nodes, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorNodeVariety = function () {
	var generatorOn = function (selector) {
		var _p7 = selector;
		switch (_p7) {
			case 1:
				return A2(_elm_lang$core$Random$map, _user$project$NodeTag$IntVariety, _user$project$Generator$generatorIntNode);
			case 2:
				return A2(_elm_lang$core$Random$map, _user$project$NodeTag$BigIntVariety, _user$project$Generator$generatorBigIntNode);
			case 3:
				return A2(_elm_lang$core$Random$map, _user$project$NodeTag$StringVariety, _user$project$Generator$generatorStringNode);
			case 4:
				return A2(_elm_lang$core$Random$map, _user$project$NodeTag$BoolVariety, _user$project$Generator$generatorBoolNode);
			case 5:
				return A2(_elm_lang$core$Random$map, _user$project$NodeTag$MusicNoteVariety, _user$project$Generator$generatorMusicNoteNode);
			default:
				return A2(_elm_lang$core$Random$map, _user$project$NodeTag$NothingVariety, _user$project$Generator$generatorNothingNode);
		}
	};
	var nodeVarietyOfInterestCount = 5;
	return A2(
		_elm_lang$core$Random$andThen,
		generatorOn,
		A2(_elm_lang$core$Random$int, 1, nodeVarietyOfInterestCount));
}();
var _user$project$Generator$generatorNodeVarieties = function () {
	var nodes = function (length) {
		return A2(_elm_lang$core$Random$list, length, _user$project$Generator$generatorNodeVariety);
	};
	return A2(_elm_lang$core$Random$andThen, nodes, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorTuplesOfNodeVariety_Direction = function () {
	var tuples = function (length) {
		return A2(
			_elm_lang$core$Random$list,
			length,
			A2(
				_elm_lang$core$Random$pair,
				_user$project$Generator$generatorNodeVariety,
				A2(_elm_lang$core$Random$map, _user$project$Generator$boolToDirection, _elm_lang$core$Random$bool)));
	};
	return A2(_elm_lang$core$Random$andThen, tuples, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$generatorTuplesOfBigIntNode_Direction = function () {
	var tuples = function (length) {
		return A2(
			_elm_lang$core$Random$list,
			length,
			A2(
				_elm_lang$core$Random$pair,
				_user$project$Generator$generatorBigIntNode,
				A2(_elm_lang$core$Random$map, _user$project$Generator$boolToDirection, _elm_lang$core$Random$bool)));
	};
	return A2(_elm_lang$core$Random$andThen, tuples, _user$project$Generator$generatorRandomListLength);
}();
var _user$project$Generator$maxRandomExponent = 10;
var _user$project$Generator$minRandomExponent = 1;
var _user$project$Generator$generatorExponent = A2(_elm_lang$core$Random$int, _user$project$Generator$minRandomExponent, _user$project$Generator$maxRandomExponent);
var _user$project$Generator$maxRandomDelta = 100;
var _user$project$Generator$minRandomDelta = 1;
var _user$project$Generator$generatorDelta = A2(_elm_lang$core$Random$int, _user$project$Generator$minRandomDelta, _user$project$Generator$maxRandomDelta);

var _user$project$Ports$port_playNote = _elm_lang$core$Native_Platform.outgoingPort(
	'port_playNote',
	function (v) {
		return {freq: v.freq, id: v.id, startOffset: v.startOffset, duration: v.duration, isHarmonize: v.isHarmonize, isLast: v.isLast};
	});
var _user$project$Ports$port_disconnectAll = _elm_lang$core$Native_Platform.outgoingPort(
	'port_disconnectAll',
	function (v) {
		return null;
	});
var _user$project$Ports$port_startPlayNote = _elm_lang$core$Native_Platform.incomingPort('port_startPlayNote', _elm_lang$core$Json_Decode$string);
var _user$project$Ports$port_donePlayNote = _elm_lang$core$Native_Platform.incomingPort('port_donePlayNote', _elm_lang$core$Json_Decode$string);
var _user$project$Ports$port_donePlayNotes = _elm_lang$core$Native_Platform.incomingPort(
	'port_donePlayNotes',
	_elm_lang$core$Json_Decode$null(
		{ctor: '_Tuple0'}));

var _user$project$TreeMusicPlayer$setPlayMode = F3(
	function (isPlaying, mbUuid, _p0) {
		var _p1 = _p0;
		var fn = function (_p2) {
			var _p3 = _p2;
			var _p5 = _p3._0._0;
			var isUpdate = function () {
				var _p4 = mbUuid;
				if (_p4.ctor === 'Just') {
					return _elm_lang$core$Native_Utils.eq(
						_p5.mbId,
						_elm_lang$core$Maybe$Just(_p4._0));
				} else {
					return true;
				}
			}();
			var updatedParams = isUpdate ? _elm_lang$core$Native_Utils.update(
				_p5,
				{isPlaying: isPlaying}) : _p5;
			return _user$project$NodeTag$MusicNoteNodeVal(
				_user$project$MusicNotePlayer$MusicNotePlayer(updatedParams));
		};
		return A2(
			_user$project$BTreeUniform$MusicNotePlayerTree,
			_p1._0,
			A2(_user$project$BTree$map, fn, _p1._1));
	});
var _user$project$TreeMusicPlayer$startPlayNote = F2(
	function (uuid, musicNotePlayerTree) {
		return A3(
			_user$project$TreeMusicPlayer$setPlayMode,
			true,
			_elm_lang$core$Maybe$Just(uuid),
			musicNotePlayerTree);
	});
var _user$project$TreeMusicPlayer$donePlayNote = F2(
	function (uuid, musicNotePlayerTree) {
		return A3(
			_user$project$TreeMusicPlayer$setPlayMode,
			false,
			_elm_lang$core$Maybe$Just(uuid),
			musicNotePlayerTree);
	});
var _user$project$TreeMusicPlayer$donePlayNotes = function (musicNotePlayerTree) {
	return A3(_user$project$TreeMusicPlayer$setPlayMode, false, _elm_lang$core$Maybe$Nothing, musicNotePlayerTree);
};
var _user$project$TreeMusicPlayer$toAudioNotes = F4(
	function (isHarmonize, playSpeed, gapDuration, notePlayers) {
		var lastIndex = _elm_lang$core$List$length(notePlayers) - 1;
		var noteDuration = _user$project$TreePlayerParams$noteDurationFor(playSpeed);
		var interval = noteDuration + gapDuration;
		var fn = F2(
			function (index, _p6) {
				var _p7 = _p6;
				var _p8 = _p7._0;
				var isLast = _elm_lang$core$Native_Utils.eq(index, lastIndex);
				var startOffset = _elm_lang$core$Basics$toFloat(index) * interval;
				var stopOffset = startOffset + noteDuration;
				return A6(_user$project$AudioNote$audioNote, _p8.mbNote, _p8.mbId, startOffset, noteDuration, isHarmonize, isLast);
			});
		return _elm_community$maybe_extra$Maybe_Extra$values(
			A2(_elm_lang$core$List$indexedMap, fn, notePlayers));
	});
var _user$project$TreeMusicPlayer$treeMusicPlay = F2(
	function (isHarmonize, _p9) {
		var _p10 = _p9;
		var _p13 = _p10._0;
		return _elm_lang$core$Platform_Cmd$batch(
			A2(
				_elm_lang$core$List$map,
				_user$project$Ports$port_playNote,
				A4(
					_user$project$TreeMusicPlayer$toAudioNotes,
					isHarmonize,
					_p13.playSpeed,
					_p13.gapDuration,
					A2(
						_elm_lang$core$List$filter,
						_user$project$MusicNotePlayer$isPlayable,
						A2(
							_user$project$BTree$flattenBy,
							_p13.traversalOrder,
							A2(
								_user$project$BTree$map,
								function (_p11) {
									var _p12 = _p11;
									return _p12._0;
								},
								_p10._1))))));
	});

var _user$project$Main$subscriptions = function (model) {
	return _elm_lang$core$Platform_Sub$batch(
		{
			ctor: '::',
			_0: _user$project$Ports$port_startPlayNote(_user$project$Msg$StartPlayNote),
			_1: {
				ctor: '::',
				_0: _user$project$Ports$port_donePlayNote(_user$project$Msg$DonePlayNote),
				_1: {
					ctor: '::',
					_0: _user$project$Ports$port_donePlayNotes(_user$project$Msg$DonePlayNotes),
					_1: {ctor: '[]'}
				}
			}
		});
};
var _user$project$Main$stopPlayNotes = function (model) {
	var updatedTree = _user$project$TreeMusicPlayer$donePlayNotes(model.musicNoteTree);
	return A2(
		_elm_lang$core$Platform_Cmd_ops['!'],
		_elm_lang$core$Native_Utils.update(
			model,
			{isPlayNotes: false, musicNoteTree: updatedTree}),
		{
			ctor: '::',
			_0: _user$project$Ports$port_disconnectAll(
				{ctor: '_Tuple0'}),
			_1: {ctor: '[]'}
		});
};
var _user$project$Main$playNotes = function (model) {
	var fn = function (params) {
		return _elm_lang$core$Native_Utils.update(
			params,
			{traversalOrder: model.masterTraversalOrder, playSpeed: model.masterPlaySpeed});
	};
	var musicNoteTree = A2(_user$project$BTreeUniform$transformTreePlayerParamsIn, model.musicNoteTree, fn);
	return A2(
		_elm_lang$core$Platform_Cmd_ops['!'],
		_elm_lang$core$Native_Utils.update(
			model,
			{musicNoteTree: musicNoteTree, isPlayNotes: true}),
		{
			ctor: '::',
			_0: A2(_user$project$TreeMusicPlayer$treeMusicPlay, model.isHarmonize, musicNoteTree),
			_1: {ctor: '[]'}
		});
};
var _user$project$Main$intFromInput = function (string) {
	return A2(
		_elm_lang$core$Result$withDefault,
		0,
		_elm_lang$core$String$toInt(string));
};
var _user$project$Main$defaultMorphUniformTree = F2(
	function (fn, tree) {
		return A2(
			_elm_lang$core$Maybe$withDefault,
			_user$project$BTreeUniform$toNothing(tree),
			fn(tree));
	});
var _user$project$Main$changeVariedTrees = F2(
	function (fn, model) {
		return _elm_lang$core$Native_Utils.update(
			model,
			{
				variedTree: fn(model.variedTree)
			});
	});
var _user$project$Main$nodeValOperateOnVariedTrees = F2(
	function (operation, model) {
		return A2(
			_user$project$Main$changeVariedTrees,
			_user$project$BTreeVaried$nodeValOperate(operation),
			model);
	});
var _user$project$Main$deDuplicateVariedTrees = function (model) {
	var fn = _user$project$BTreeVaried$deDuplicate;
	return A2(_user$project$Main$changeVariedTrees, fn, model);
};
var _user$project$Main$morphToVariedTrees = F2(
	function (fn, model) {
		return A2(_user$project$Main$changeVariedTrees, fn, model);
	});
var _user$project$Main$changeUniformTrees = F2(
	function (fn, model) {
		return _elm_lang$core$Native_Utils.update(
			model,
			{
				intTree: _user$project$BTreeUniform$intTreeFrom(
					fn(
						_user$project$BTreeUniform$UniformInt(model.intTree))),
				bigIntTree: _user$project$BTreeUniform$bigIntTreeFrom(
					fn(
						_user$project$BTreeUniform$UniformBigInt(model.bigIntTree))),
				stringTree: _user$project$BTreeUniform$stringTreeFrom(
					fn(
						_user$project$BTreeUniform$UniformString(model.stringTree))),
				boolTree: _user$project$BTreeUniform$boolTreeFrom(
					fn(
						_user$project$BTreeUniform$UniformBool(model.boolTree))),
				musicNoteTree: _user$project$BTreeUniform$musicNotePlayerTreeFrom(
					fn(
						_user$project$BTreeUniform$UniformMusicNotePlayer(model.musicNoteTree)))
			});
	});
var _user$project$Main$nodeValOperateOnUniformTrees = F2(
	function (operation, model) {
		return A2(
			_user$project$Main$changeUniformTrees,
			_user$project$BTreeUniform$nodeValOperate(operation),
			model);
	});
var _user$project$Main$sortUniformTrees = function (model) {
	return A2(
		_user$project$Main$changeUniformTrees,
		_user$project$BTreeUniform$sort(model.directionForSort),
		model);
};
var _user$project$Main$deDuplicateUniformTrees = function (model) {
	var fn = _user$project$BTreeUniform$deDuplicate;
	return A2(_user$project$Main$changeUniformTrees, fn, model);
};
var _user$project$Main$deDuplicate = function (model) {
	return _user$project$Main$deDuplicateVariedTrees(
		_user$project$Main$deDuplicateUniformTrees(model));
};
var _user$project$Main$morphUniformTrees = F2(
	function (fn, model) {
		return _elm_lang$core$Native_Utils.update(
			model,
			{
				intTreeMorph: fn(
					_user$project$BTreeUniform$UniformInt(model.intTree)),
				bigIntTreeMorph: fn(
					_user$project$BTreeUniform$UniformBigInt(model.bigIntTree)),
				stringTreeMorph: fn(
					_user$project$BTreeUniform$UniformString(model.stringTree)),
				boolTreeMorph: fn(
					_user$project$BTreeUniform$UniformBool(model.boolTree)),
				musicNoteTreeMorph: fn(
					_user$project$BTreeUniform$UniformMusicNotePlayer(model.musicNoteTree))
			});
	});
var _user$project$Main$morphToMbUniformTrees = F2(
	function (fn, model) {
		var defaultMorph = function (tree) {
			return A2(_user$project$Main$defaultMorphUniformTree, fn, tree);
		};
		return A2(_user$project$Main$morphUniformTrees, defaultMorph, model);
	});
var _user$project$Main$unCacheVariedTree = function (model) {
	return _elm_lang$core$Native_Utils.update(
		model,
		{variedTree: model.variedTreeCache});
};
var _user$project$Main$cacheVariedTree = function (model) {
	return _elm_lang$core$Native_Utils.update(
		model,
		{variedTreeCache: model.variedTree});
};
var _user$project$Main$unCacheTreesFor_ShowLength = function (model) {
	return _user$project$Main$unCacheVariedTree(model);
};
var _user$project$Main$unCacheTreesFor_ShowIsIntPrime = function (model) {
	return _user$project$Main$unCacheVariedTree(model);
};
var _user$project$Main$cacheTreesFor_ShowLength = function (model) {
	return _user$project$Main$cacheVariedTree(model);
};
var _user$project$Main$cacheTreesFor_ShowIsIntPrime = function (model) {
	return _user$project$Main$cacheVariedTree(model);
};
var _user$project$Main$directionForTreeRandomInsertStyle = function (style) {
	var _p0 = style;
	switch (_p0.ctor) {
		case 'Random':
			return _user$project$BTree$Left;
		case 'Right':
			return _user$project$BTree$Right;
		default:
			return _user$project$BTree$Left;
	}
};
var _user$project$Main$viewMain = function (model) {
	return A2(
		_elm_lang$html$Html$main_,
		{
			ctor: '::',
			_0: _justgage$tachyons_elm$Tachyons$classes(
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons_Classes$pt5,
					_1: {
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$pb0,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$w_100,
							_1: {ctor: '[]'}
						}
					}
				}),
			_1: {ctor: '[]'}
		},
		{
			ctor: '::',
			_0: _user$project$Dashboard$viewDashboardWithTreesUnderneath(model),
			_1: {ctor: '[]'}
		});
};
var _user$project$Main$viewHeader = function (model) {
	return A2(
		_elm_lang$html$Html$header,
		{
			ctor: '::',
			_0: _justgage$tachyons_elm$Tachyons$classes(
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons_Classes$bg_green,
					_1: {
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons_Classes$fixed,
						_1: {
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$w_100,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$h3,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$f2,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$ph3,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$pv2,
											_1: {
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$b,
												_1: {
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$pl2,
													_1: {
														ctor: '::',
														_0: _justgage$tachyons_elm$Tachyons_Classes$pr2,
														_1: {
															ctor: '::',
															_0: _justgage$tachyons_elm$Tachyons_Classes$z_max,
															_1: {
																ctor: '::',
																_0: _justgage$tachyons_elm$Tachyons_Classes$tc,
																_1: {ctor: '[]'}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}),
			_1: {ctor: '[]'}
		},
		{
			ctor: '::',
			_0: A2(
				_elm_lang$html$Html$span,
				{
					ctor: '::',
					_0: _justgage$tachyons_elm$Tachyons$classes(
						{
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons_Classes$black,
							_1: {
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$bg_light_green,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$hover_light_green,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_black,
										_1: {ctor: '[]'}
									}
								}
							}
						}),
					_1: {ctor: '[]'}
				},
				{
					ctor: '::',
					_0: _elm_lang$html$Html$text('Binary Tree'),
					_1: {ctor: '[]'}
				}),
			_1: {
				ctor: '::',
				_0: A2(
					_elm_lang$html$Html$span,
					{
						ctor: '::',
						_0: _justgage$tachyons_elm$Tachyons$classes(
							{
								ctor: '::',
								_0: _justgage$tachyons_elm$Tachyons_Classes$light_green,
								_1: {
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$bg_black,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$hover_black,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$hover_bg_light_green,
											_1: {
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$ml2,
												_1: {ctor: '[]'}
											}
										}
									}
								}
							}),
						_1: {ctor: '[]'}
					},
					{
						ctor: '::',
						_0: _elm_lang$html$Html$text('Playground'),
						_1: {ctor: '[]'}
					}),
				_1: {
					ctor: '::',
					_0: A2(
						_elm_lang$html$Html$span,
						{
							ctor: '::',
							_0: _justgage$tachyons_elm$Tachyons$classes(
								{
									ctor: '::',
									_0: _justgage$tachyons_elm$Tachyons_Classes$fr,
									_1: {
										ctor: '::',
										_0: _justgage$tachyons_elm$Tachyons_Classes$pr2,
										_1: {
											ctor: '::',
											_0: _justgage$tachyons_elm$Tachyons_Classes$pt2,
											_1: {
												ctor: '::',
												_0: _justgage$tachyons_elm$Tachyons_Classes$f4,
												_1: {
													ctor: '::',
													_0: _justgage$tachyons_elm$Tachyons_Classes$grow_large,
													_1: {ctor: '[]'}
												}
											}
										}
									}
								}),
							_1: {ctor: '[]'}
						},
						{
							ctor: '::',
							_0: A2(
								_elm_lang$html$Html$a,
								{
									ctor: '::',
									_0: _elm_lang$html$Html_Attributes$href('https://github.com/pdavidow/btree'),
									_1: {
										ctor: '::',
										_0: _elm_lang$html$Html_Attributes$target('_blank'),
										_1: {ctor: '[]'}
									}
								},
								{
									ctor: '::',
									_0: _elm_lang$html$Html$text('Github'),
									_1: {ctor: '[]'}
								}),
							_1: {ctor: '[]'}
						}),
					_1: {ctor: '[]'}
				}
			}
		});
};
var _user$project$Main$view = function (model) {
	return A2(
		_elm_lang$html$Html$div,
		{
			ctor: '::',
			_0: _justgage$tachyons_elm$Tachyons$classes(
				{ctor: '[]'}),
			_1: {ctor: '[]'}
		},
		{
			ctor: '::',
			_0: _justgage$tachyons_elm$Tachyons$tachyons.css,
			_1: {
				ctor: '::',
				_0: _user$project$Main$viewHeader(model),
				_1: {
					ctor: '::',
					_0: _user$project$Main$viewMain(model),
					_1: {ctor: '[]'}
				}
			}
		});
};
var _user$project$Main$notePlayerOn = function (bTree) {
	return A2(
		_user$project$BTreeUniform$MusicNotePlayerTree,
		_user$project$TreePlayerParams$defaultTreePlayerParams,
		A2(
			_user$project$BTree$map,
			function (player) {
				return _user$project$NodeTag$MusicNoteNodeVal(player);
			},
			bTree));
};
var _user$project$Main$idedMusicNoteDirectedTree = F3(
	function (startSeed, directedListToTree, directedNotes) {
		var fn = F2(
			function (id, _p1) {
				var _p2 = _p1;
				return {
					ctor: '_Tuple2',
					_0: A2(
						_user$project$MusicNotePlayer$idedOn,
						_elm_lang$core$Maybe$Just(id),
						_p2._0),
					_1: _p2._1
				};
			});
		var _p3 = A2(
			_user$project$Generator$generateIds,
			_elm_lang$core$List$length(directedNotes),
			startSeed);
		var ids = _p3._0;
		var endSeed = _p3._1;
		var tree = _user$project$Main$notePlayerOn(
			directedListToTree(
				A3(_elm_lang$core$List$map2, fn, ids, directedNotes)));
		return {ctor: '_Tuple2', _0: tree, _1: endSeed};
	});
var _user$project$Main$idedMusicNoteTree = F3(
	function (startSeed, listToTree, notes) {
		var fn = F2(
			function (id, note) {
				return A2(
					_user$project$MusicNotePlayer$idedOn,
					_elm_lang$core$Maybe$Just(id),
					note);
			});
		var _p4 = A2(
			_user$project$Generator$generateIds,
			_elm_lang$core$List$length(notes),
			startSeed);
		var ids = _p4._0;
		var endSeed = _p4._1;
		var tree = _user$project$Main$notePlayerOn(
			listToTree(
				A3(_elm_lang$core$List$map2, fn, ids, notes)));
		return {ctor: '_Tuple2', _0: tree, _1: endSeed};
	});
var _user$project$Main$initialModel = {
	intTree: _user$project$BTreeUniform$IntTree(
		A3(
			_user$project$BTree$Node,
			_user$project$NodeTag$IntNodeVal(
				_user$project$MaybeSafe$toMaybeSafeInt(_elm_community$basics_extra$Basics_Extra$maxSafeInteger)),
			_user$project$BTree$singleton(
				_user$project$NodeTag$IntNodeVal(
					_user$project$MaybeSafe$toMaybeSafeInt(4))),
			A3(
				_user$project$BTree$Node,
				_user$project$NodeTag$IntNodeVal(
					_user$project$MaybeSafe$toMaybeSafeInt(-9)),
				_user$project$BTree$Empty,
				_user$project$BTree$singleton(
					_user$project$NodeTag$IntNodeVal(
						_user$project$MaybeSafe$toMaybeSafeInt(4)))))),
	bigIntTree: _user$project$BTreeUniform$BigIntTree(
		A3(
			_user$project$BTree$Node,
			_user$project$NodeTag$BigIntNodeVal(
				_gilbertkennen$bigint$BigInt$fromInt(_elm_community$basics_extra$Basics_Extra$maxSafeInteger)),
			_user$project$BTree$singleton(
				_user$project$NodeTag$BigIntNodeVal(
					_gilbertkennen$bigint$BigInt$fromInt(4))),
			A3(
				_user$project$BTree$Node,
				_user$project$NodeTag$BigIntNodeVal(
					_gilbertkennen$bigint$BigInt$fromInt(-9)),
				_user$project$BTree$Empty,
				_user$project$BTree$singleton(
					_user$project$NodeTag$BigIntNodeVal(
						_gilbertkennen$bigint$BigInt$fromInt(4)))))),
	stringTree: _user$project$BTreeUniform$StringTree(
		A3(
			_user$project$BTree$Node,
			_user$project$NodeTag$StringNodeVal('maxSafeInteger'),
			_user$project$BTree$singleton(
				_user$project$NodeTag$StringNodeVal('four')),
			A3(
				_user$project$BTree$Node,
				_user$project$NodeTag$StringNodeVal('-nine'),
				_user$project$BTree$Empty,
				_user$project$BTree$singleton(
					_user$project$NodeTag$StringNodeVal('four'))))),
	boolTree: _user$project$BTreeUniform$BoolTree(
		A3(
			_user$project$BTree$Node,
			_user$project$NodeTag$BoolNodeVal(
				_elm_lang$core$Maybe$Just(true)),
			_user$project$BTree$singleton(
				_user$project$NodeTag$BoolNodeVal(
					_elm_lang$core$Maybe$Just(true))),
			A3(
				_user$project$BTree$Node,
				_user$project$NodeTag$BoolNodeVal(
					_elm_lang$core$Maybe$Just(false)),
				_user$project$BTree$Empty,
				A3(
					_user$project$BTree$Node,
					_user$project$NodeTag$BoolNodeVal(
						_elm_lang$core$Maybe$Just(true)),
					_user$project$BTree$Empty,
					_user$project$BTree$singleton(
						_user$project$NodeTag$BoolNodeVal(
							_elm_lang$core$Maybe$Just(false))))))),
	initialMusicNoteTree: A2(_user$project$BTreeUniform$MusicNotePlayerTree, _user$project$TreePlayerParams$defaultTreePlayerParams, _user$project$BTree$Empty),
	musicNoteTree: A2(_user$project$BTreeUniform$MusicNotePlayerTree, _user$project$TreePlayerParams$defaultTreePlayerParams, _user$project$BTree$Empty),
	variedTree: _user$project$BTreeVaried$BTreeVaried(
		A3(
			_user$project$BTree$Node,
			_user$project$NodeTag$BigIntVariety(
				_user$project$NodeTag$BigIntNodeVal(
					_gilbertkennen$bigint$BigInt$fromInt(_elm_community$basics_extra$Basics_Extra$maxSafeInteger))),
			A3(
				_user$project$BTree$Node,
				_user$project$NodeTag$StringVariety(
					_user$project$NodeTag$StringNodeVal('A')),
				_user$project$BTree$singleton(
					_user$project$NodeTag$MusicNoteVariety(
						_user$project$NodeTag$MusicNoteNodeVal(
							_user$project$MusicNotePlayer$on(
								_user$project$MusicNote$MusicNote(
									_user$project$MusicNote$MidiNumber(57)))))),
				_user$project$BTree$singleton(
					_user$project$NodeTag$IntVariety(
						_user$project$NodeTag$IntNodeVal(
							_user$project$MaybeSafe$toMaybeSafeInt(123))))),
			A3(
				_user$project$BTree$Node,
				_user$project$NodeTag$BoolVariety(
					_user$project$NodeTag$BoolNodeVal(
						_elm_lang$core$Maybe$Just(true))),
				_user$project$BTree$singleton(
					_user$project$NodeTag$MusicNoteVariety(
						_user$project$NodeTag$MusicNoteNodeVal(
							_user$project$MusicNotePlayer$on(
								_user$project$MusicNote$MusicNote(
									_user$project$MusicNote$MidiNumber(57)))))),
				_user$project$BTree$singleton(
					_user$project$NodeTag$BoolVariety(
						_user$project$NodeTag$BoolNodeVal(
							_elm_lang$core$Maybe$Just(true))))))),
	intTreeMorph: _user$project$BTreeUniform$uniformNothingTreeFrom(_user$project$BTree$Empty),
	bigIntTreeMorph: _user$project$BTreeUniform$uniformNothingTreeFrom(_user$project$BTree$Empty),
	stringTreeMorph: _user$project$BTreeUniform$uniformNothingTreeFrom(_user$project$BTree$Empty),
	boolTreeMorph: _user$project$BTreeUniform$uniformNothingTreeFrom(_user$project$BTree$Empty),
	musicNoteTreeMorph: _user$project$BTreeUniform$uniformNothingTreeFrom(_user$project$BTree$Empty),
	variedTreeCache: _user$project$BTreeVaried$BTreeVaried(_user$project$BTree$Empty),
	masterPlaySpeed: _user$project$TreePlayerParams$Slow,
	masterTraversalOrder: _user$project$BTree$InOrder,
	delta: 1,
	exponent: 2,
	isHarmonize: false,
	isPlayNotes: false,
	isTreeMorphing: false,
	directionForSort: _user$project$BTree$Left,
	treeRandomInsertStyle: _user$project$TreeRandomInsertStyle$Left,
	intView: _user$project$IntView$IntView,
	uuidSeed: _mgold$elm_random_pcg$Random_Pcg$initialSeed(0),
	pTriangleDepth: 1
};
var _user$project$Main$init = function (jsSeed) {
	var initialMusicNotes = A2(
		_elm_lang$core$List$map,
		function (i) {
			return _user$project$MusicNote$MusicNote(
				_user$project$MusicNote$MidiNumber(i));
		},
		{
			ctor: '::',
			_0: 65,
			_1: {
				ctor: '::',
				_0: 64,
				_1: {
					ctor: '::',
					_0: 61,
					_1: {
						ctor: '::',
						_0: 64,
						_1: {
							ctor: '::',
							_0: 67,
							_1: {
								ctor: '::',
								_0: 57,
								_1: {
									ctor: '::',
									_0: 58,
									_1: {ctor: '[]'}
								}
							}
						}
					}
				}
			}
		});
	var listToTree = _user$project$BTree$fromListBy(_user$project$MusicNotePlayer$sorter);
	var startSeed = _mgold$elm_random_pcg$Random_Pcg$initialSeed(jsSeed);
	var _p5 = A3(_user$project$Main$idedMusicNoteTree, startSeed, listToTree, initialMusicNotes);
	var musicNoteTree = _p5._0;
	var uuidSeed = _p5._1;
	return {
		ctor: '_Tuple2',
		_0: _elm_lang$core$Native_Utils.update(
			_user$project$Main$initialModel,
			{initialMusicNoteTree: musicNoteTree, musicNoteTree: musicNoteTree, uuidSeed: uuidSeed}),
		_1: _elm_lang$core$Platform_Cmd$none
	};
};
var _user$project$Main$update = F2(
	function (msg, model) {
		var _p6 = msg;
		switch (_p6.ctor) {
			case 'NodeValueOperate':
				var _p7 = _p6._0;
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					A2(
						_user$project$Main$nodeValOperateOnVariedTrees,
						_p7,
						A2(_user$project$Main$nodeValOperateOnUniformTrees, _p7, model)),
					{ctor: '[]'});
			case 'SortUniformTrees':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_user$project$Main$sortUniformTrees(model),
					{ctor: '[]'});
			case 'RemoveDuplicates':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_user$project$Main$deDuplicate(model),
					{ctor: '[]'});
			case 'Delta':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{
							delta: _user$project$Main$intFromInput(_p6._0)
						}),
					{ctor: '[]'});
			case 'Exponent':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{
							exponent: _user$project$Main$intFromInput(_p6._0)
						}),
					{ctor: '[]'});
			case 'RequestRandomTrees':
				var directedInsert = A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					model,
					{
						ctor: '::',
						_0: _elm_lang$core$Platform_Cmd$batch(
							{
								ctor: '::',
								_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomTreeMusicNotes, _user$project$Generator$generatorTreeMusicNotes),
								_1: {
									ctor: '::',
									_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomIntNodes, _user$project$Generator$generatorIntNodes),
									_1: {
										ctor: '::',
										_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomBigIntNodes, _user$project$Generator$generatorBigIntNodes),
										_1: {
											ctor: '::',
											_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomStringNodes, _user$project$Generator$generatorStringNodes),
											_1: {
												ctor: '::',
												_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomBoolNodes, _user$project$Generator$generatorBoolNodes),
												_1: {
													ctor: '::',
													_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomNodeVarieties, _user$project$Generator$generatorNodeVarieties),
													_1: {ctor: '[]'}
												}
											}
										}
									}
								}
							}),
						_1: {ctor: '[]'}
					});
				var randomInsert = A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					model,
					{
						ctor: '::',
						_0: _elm_lang$core$Platform_Cmd$batch(
							{
								ctor: '::',
								_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomTuplesOfMusicNote_Direction, _user$project$Generator$generatorTuplesOfMusicNoteDirection),
								_1: {
									ctor: '::',
									_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomTuplesOfIntNode_Direction, _user$project$Generator$generatorTuplesOfIntNode_Direction),
									_1: {
										ctor: '::',
										_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomTuplesOfBigIntNode_Direction, _user$project$Generator$generatorTuplesOfBigIntNode_Direction),
										_1: {
											ctor: '::',
											_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomTuplesOfStringNode_Direction, _user$project$Generator$generatorTuplesOfStringNode_Direction),
											_1: {
												ctor: '::',
												_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomTuplesOfBoolNode_Direction, _user$project$Generator$generatorTuplesOfBoolNode_Direction),
												_1: {
													ctor: '::',
													_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomTuplesOfNodeVariety_Direction, _user$project$Generator$generatorTuplesOfNodeVariety_Direction),
													_1: {ctor: '[]'}
												}
											}
										}
									}
								}
							}),
						_1: {ctor: '[]'}
					});
				var _p8 = model.treeRandomInsertStyle;
				switch (_p8.ctor) {
					case 'Random':
						return randomInsert;
					case 'Right':
						return directedInsert;
					default:
						return directedInsert;
				}
			case 'RequestRandomScalars':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					model,
					{
						ctor: '::',
						_0: _elm_lang$core$Platform_Cmd$batch(
							{
								ctor: '::',
								_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomDelta, _user$project$Generator$generatorDelta),
								_1: {
									ctor: '::',
									_0: A2(_elm_lang$core$Random$generate, _user$project$Msg$ReceiveRandomExponent, _user$project$Generator$generatorExponent),
									_1: {ctor: '[]'}
								}
							}),
						_1: {ctor: '[]'}
					});
			case 'ReceiveRandomTreeMusicNotes':
				var direction = _user$project$Main$directionForTreeRandomInsertStyle(model.treeRandomInsertStyle);
				var listToTree = _user$project$BTree$fromListAsIsBy(direction);
				var _p9 = A3(_user$project$Main$idedMusicNoteTree, model.uuidSeed, listToTree, _p6._0);
				var musicNoteTree = _p9._0;
				var uuidSeed = _p9._1;
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{musicNoteTree: musicNoteTree, uuidSeed: uuidSeed}),
					{ctor: '[]'});
			case 'ReceiveRandomIntNodes':
				var direction = _user$project$Main$directionForTreeRandomInsertStyle(model.treeRandomInsertStyle);
				var tree = _user$project$BTreeUniform$IntTree(
					A2(_user$project$BTree$fromListAsIsBy, direction, _p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{intTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomBigIntNodes':
				var direction = _user$project$Main$directionForTreeRandomInsertStyle(model.treeRandomInsertStyle);
				var tree = _user$project$BTreeUniform$BigIntTree(
					A2(_user$project$BTree$fromListAsIsBy, direction, _p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{bigIntTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomStringNodes':
				var direction = _user$project$Main$directionForTreeRandomInsertStyle(model.treeRandomInsertStyle);
				var tree = _user$project$BTreeUniform$StringTree(
					A2(_user$project$BTree$fromListAsIsBy, direction, _p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{stringTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomBoolNodes':
				var direction = _user$project$Main$directionForTreeRandomInsertStyle(model.treeRandomInsertStyle);
				var tree = _user$project$BTreeUniform$BoolTree(
					A2(_user$project$BTree$fromListAsIsBy, direction, _p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{boolTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomNodeVarieties':
				var direction = _user$project$Main$directionForTreeRandomInsertStyle(model.treeRandomInsertStyle);
				var tree = _user$project$BTreeVaried$BTreeVaried(
					A2(_user$project$BTree$fromListAsIsBy, direction, _p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{variedTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomTuplesOfMusicNote_Direction':
				var listToTree = _user$project$BTree$fromListAsIs_directed;
				var _p10 = A3(_user$project$Main$idedMusicNoteDirectedTree, model.uuidSeed, listToTree, _p6._0);
				var musicNoteTree = _p10._0;
				var uuidSeed = _p10._1;
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{musicNoteTree: musicNoteTree, uuidSeed: uuidSeed}),
					{ctor: '[]'});
			case 'ReceiveRandomTuplesOfIntNode_Direction':
				var tree = _user$project$BTreeUniform$IntTree(
					_user$project$BTree$fromListAsIs_directed(_p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{intTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomTuplesOfBigIntNode_Direction':
				var tree = _user$project$BTreeUniform$BigIntTree(
					_user$project$BTree$fromListAsIs_directed(_p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{bigIntTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomTuplesOfStringNode_Direction':
				var tree = _user$project$BTreeUniform$StringTree(
					_user$project$BTree$fromListAsIs_directed(_p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{stringTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomTuplesOfBoolNode_Direction':
				var tree = _user$project$BTreeUniform$BoolTree(
					_user$project$BTree$fromListAsIs_directed(_p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{boolTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomTuplesOfNodeVariety_Direction':
				var tree = _user$project$BTreeVaried$BTreeVaried(
					_user$project$BTree$fromListAsIs_directed(_p6._0));
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{variedTree: tree}),
					{ctor: '[]'});
			case 'ReceiveRandomDelta':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{delta: _p6._0}),
					{ctor: '[]'});
			case 'ReceiveRandomExponent':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{exponent: _p6._0}),
					{ctor: '[]'});
			case 'StartShowIsIntPrime':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					A2(
						_user$project$Main$morphToVariedTrees,
						_user$project$BTreeVaried$toIsIntPrime,
						A2(
							_user$project$Main$morphToMbUniformTrees,
							_user$project$BTreeUniform$toIsIntPrime,
							_user$project$Main$cacheTreesFor_ShowIsIntPrime(
								_elm_lang$core$Native_Utils.update(
									model,
									{isTreeMorphing: true})))),
					{ctor: '[]'});
			case 'StopShowIsIntPrime':
				var newModel = model.isTreeMorphing ? _user$project$Main$unCacheTreesFor_ShowIsIntPrime(
					_elm_lang$core$Native_Utils.update(
						model,
						{isTreeMorphing: false})) : model;
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					newModel,
					{ctor: '[]'});
			case 'StartShowLength':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					A2(
						_user$project$Main$morphToVariedTrees,
						_user$project$BTreeVaried$toLength,
						A2(
							_user$project$Main$morphToMbUniformTrees,
							_user$project$BTreeUniform$toLength,
							_user$project$Main$cacheTreesFor_ShowLength(
								_elm_lang$core$Native_Utils.update(
									model,
									{isTreeMorphing: true})))),
					{ctor: '[]'});
			case 'StopShowLength':
				var newModel = model.isTreeMorphing ? _user$project$Main$unCacheTreesFor_ShowLength(
					_elm_lang$core$Native_Utils.update(
						model,
						{isTreeMorphing: false})) : model;
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					newModel,
					{ctor: '[]'});
			case 'TogglePlayNotes':
				var _p11 = model.isPlayNotes;
				if (_p11 === true) {
					return _user$project$Main$stopPlayNotes(model);
				} else {
					return _user$project$Main$playNotes(model);
				}
			case 'ChangeTraversalOrder':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{masterTraversalOrder: _p6._0}),
					{ctor: '[]'});
			case 'ChangePlaySpeed':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{masterPlaySpeed: _p6._0}),
					{ctor: '[]'});
			case 'ChangeSortDirection':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{directionForSort: _p6._0}),
					{ctor: '[]'});
			case 'ChangeTreeRandomInsertStyle':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{treeRandomInsertStyle: _p6._0}),
					{ctor: '[]'});
			case 'StartPlayNote':
				var mbUuid = _danyx23$elm_uuid$Uuid$fromString(_p6._0);
				var updatedTree = function () {
					var _p12 = mbUuid;
					if (_p12.ctor === 'Just') {
						return A2(_user$project$TreeMusicPlayer$startPlayNote, _p12._0, model.musicNoteTree);
					} else {
						return model.musicNoteTree;
					}
				}();
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{musicNoteTree: updatedTree}),
					{ctor: '[]'});
			case 'DonePlayNote':
				var mbUuid = _danyx23$elm_uuid$Uuid$fromString(_p6._0);
				var updatedTree = function () {
					var _p13 = mbUuid;
					if (_p13.ctor === 'Just') {
						return A2(_user$project$TreeMusicPlayer$donePlayNote, _p13._0, model.musicNoteTree);
					} else {
						return model.musicNoteTree;
					}
				}();
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{musicNoteTree: updatedTree}),
					{ctor: '[]'});
			case 'DonePlayNotes':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{isPlayNotes: false}),
					{ctor: '[]'});
			case 'SwitchToIntView':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{intView: _p6._0}),
					{ctor: '[]'});
			case 'ToggleHarmonize':
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{isHarmonize: !model.isHarmonize}),
					{ctor: '[]'});
			case 'Reset':
				var seed = model.uuidSeed;
				var tree = model.initialMusicNoteTree;
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						_user$project$Main$initialModel,
						{initialMusicNoteTree: tree, musicNoteTree: tree, uuidSeed: seed}),
					{
						ctor: '::',
						_0: _user$project$Ports$port_disconnectAll(
							{ctor: '_Tuple0'}),
						_1: {ctor: '[]'}
					});
			default:
				return A2(
					_elm_lang$core$Platform_Cmd_ops['!'],
					_elm_lang$core$Native_Utils.update(
						model,
						{
							pTriangleDepth: _user$project$Main$intFromInput(_p6._0)
						}),
					{ctor: '[]'});
		}
	});
var _user$project$Main$main = _elm_lang$html$Html$programWithFlags(
	{init: _user$project$Main$init, view: _user$project$Main$view, update: _user$project$Main$update, subscriptions: _user$project$Main$subscriptions})(_elm_lang$core$Json_Decode$int);

var Elm = {};
Elm['Main'] = Elm['Main'] || {};
if (typeof _user$project$Main$main !== 'undefined') {
    _user$project$Main$main(Elm['Main'], 'Main', undefined);
}

if (typeof define === "function" && define['amd'])
{
  define([], function() { return Elm; });
  return;
}

if (typeof module === "object")
{
  module['exports'] = Elm;
  return;
}

var globalElm = this['Elm'];
if (typeof globalElm === "undefined")
{
  this['Elm'] = Elm;
  return;
}

for (var publicModule in Elm)
{
  if (publicModule in globalElm)
  {
    throw new Error('There are two Elm modules called `' + publicModule + '` on this page! Rename one of them.');
  }
  globalElm[publicModule] = Elm[publicModule];
}

}).call(this);

