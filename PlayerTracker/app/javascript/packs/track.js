import * as paper from 'paper';

paper.install(window);
// Keep global references to both tools, so the HTML
// links below can access them.
var tool1, tool2;

window.onload = function() {
	paper.setup('myCanvas');

	// // Create two drawing tools.
	// // tool1 will draw straight lines,
	// // tool2 will draw clouds.

	// // Both share the mouseDown event:
	// var path;
	// function onMouseDown(event) {
	// 	path = new Path();
	// 	path.strokeColor = 'black';
	// 	path.add(event.point);
	// }

	// tool1 = new Tool();
	// tool1.onMouseDown = onMouseDown;

	// tool1.onMouseDrag = function(event) {
	// 	path.add(event.point);
	// }

	// tool2 = new Tool();
	// tool2.minDistance = 20;
	// tool2.onMouseDown = onMouseDown;

	// tool2.onMouseDrag = function(event) {
	// 	// Use the arcTo command to draw cloudy lines
	// 	path.arcTo(event.point);
	// }

	// Create a new path once, when the script is executed:
	var tool = new Tool();

	var path
	var point;
	var color = 'black';
	var radius = 10;
	var flag = false;

	// on click draw line
	tool.onMouseDown = function(event) {
		if (!flag) {
			point = event.point;
			flag = true;
		} else {
			path = new Path();
			path.strokeColor = color;
			path.add(point);
			path.add(event.point);
			console.log("Point 1: " + point.x + ", " + point.y);
			console.log("Point 2: " + event.point.x + ", " + event.point.y);

			var angle = calcAngle(point, event.point);
			var center = calcCenter(event.point, angle, radius);
			console.log("Center: " + center.x + ", " + center.y);

			// triangle for arrow
			var triangle = new Path.RegularPolygon(center, 3, radius);
			triangle.fillColor = color;
			var degAngle = radToDeg(angle);
			console.log("Angle: " + degAngle);
			rotateTriangle(triangle, degAngle, center);


			flag = false;
		}
	}

	function calcAngle(point1, point2) {
		var dx = point1.x - point2.x;
		var dy = point1.y - point2.y;

		var angle = Math.atan(dy / dx);

		if (dx > 0) {
			return angle + Math.PI;
		} else {
			return angle;
		}
	}

	function calcCenter(point, angle, radius) {
		var r = radius / 2.0;
		console.log("r: " + r);
		var xCenter = point.x + r * Math.cos(angle);
		var yCenter = point.y + r * Math.sin(angle);
		var center = new Point(xCenter, yCenter);
		return center;
	}

	function radToDeg(rad) {
		return rad * (180 / Math.PI);
	}

	function rotateTriangle(triangle, degAngle, center) {
		triangle.rotate(90, center);
		if (degAngle == 90 || degAngle == -90) {
			triangle.rotate(-1 * degAngle, center);
		} else {
			triangle.rotate(degAngle, center);
		}
	}
}

