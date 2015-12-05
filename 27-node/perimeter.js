"use strict";

let square = function(x) { return Math.pow(x, 2); };

let roundN = function(x, n) {
	return Math.round(x * Math.pow(10, n)) / Math.pow(10, n);
}

let pythagoras = function(a, b) {
	let dist = Math.sqrt(square((a.x - b.x)) + square((a.y - b.y)));
		// dist = roundN(dist, 0);
	return dist;
};

let circlePerimeter = function(center, point) {
	let radius = pythagoras(center, point);
	return 2 * Math.PI * radius;
}

let circleArea = function(center, point) {
	let radius = pythagoras(center, point);
	let area = Math.PI * square(radius);

	return roundN(area, 0)
}

let pyth = function(a, h) {
	Math.sqrt(square(h) - square(a))
}

console.log(Math.log(150))