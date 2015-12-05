"use strict";

let center = {x: 0, y: 0};

let cows = [
	{name: 'A', x: 6, y: 8},
	{name: 'B', x: -4, y: 9},
	{name: 'C', x: 7, y: 7}
];

let roundN = function(x, n) {
	return Math.round(x * Math.pow(10, n)) / Math.pow(10, n);
}

let distance = function(cow) {
	let dist = Math.sqrt(Math.pow((cow.x - center.x), 2) + Math.pow((cow.y - center.y), 2));
		dist = roundN(dist, 1);
	return {
		name: cow.name,
		distance: dist
	};
};

let distances = cows.map(distance).sort(function(a, b) { return a.distance < b.distance }).reverse();
console.log(distances);