import * as paper from 'paper';
import {makeTriangle} from './triangle';

paper.install(window);

window.onload = function() {
	paper.setup('myCanvas');

	var tool = new Tool();

	var path;
	var point;
	var triangle;
	var drawPoint;
	var color = 'black';
	var radius = 10;
	var pointFlag = false;

	var trackerList = [];
	var initPointList = [];

	// on click draw line
	tool.onMouseDown = function(event) {
		if (!pointFlag) {
			// remove previous tracker
			if (path) {
				drawPoint.remove();
				path.remove();
				triangle.remove();	
			}
			
			// draw initial point of path
			point = event.point;
			drawPoint = new Path.Circle(point, 3);
			drawPoint.fillColor = color;
			initPointList.push({ x: point.x, y: point.y, complete: true });

			pointFlag = true;
		} else {
			var completePass;

			if (initPointList.slice(-1)[0].complete) {
				completePass = true
			} else {
				completePass = false;
			}

			// draw path
			path = new Path();
			if (completePass) {
				path.strokeColor = color;
			} else {
				path.strokeColor = "red";
			}
			path.add(point);
			path.add(event.point);
			
			// draw triangle
			triangle = makeTriangle(point, event.point, completePass, triangle, radius);

			// store tracker info 
			var tracker = { x1: point.x, y1: point.y, x2: event.point.x, y2: event.point.y, complete: completePass};
			trackerList.push(tracker);
			console.log("Tracker added!");
			console.log(trackerList);

			pointFlag = false;
		}
	}

	function markIncomplete() {
		if (pointFlag) {
			if (drawPoint) {
				if (initPointList.slice(-1)[0].complete) {
					drawPoint.fillColor = "red";
					initPointList.slice(-1)[0].complete = false;
				} else {
					drawPoint.fillColor = color;
					initPointList.slice(-1)[0].complete = true;
				}
			}
		} else {
			if (path) {
				if (trackerList.slice(-1)[0].complete) {
					trackerList.slice(-1)[0].complete = false;
					initPointList.slice(-1)[0].complete = false;
					path.strokeColor = 'red';
					triangle.fillColor = 'red';
					drawPoint.fillColor = 'red';
				} else {
					trackerList.slice(-1)[0].complete = true;
					initPointList.slice(-1)[0].complete = true;
					path.strokeColor = color;
					triangle.fillColor = color;
					drawPoint.fillColor = color;
				}
			}
		}
	}

	function cancelPass() {
		if (pointFlag) {
			if (drawPoint) {
				// remove the point
				drawPoint.remove();
				pointFlag = false;

				if (trackerList.length > 0) {
					// get both points for previous tracker
					var point1 = new Point(trackerList.slice(-1)[0].x1, trackerList.slice(-1)[0].y1);
					var point2 = new Point(trackerList.slice(-1)[0].x2, trackerList.slice(-1)[0].y2);

					// draw previous point
					drawPoint = new Path.Circle(point1, 3);

					// draw previous path + triangle
					path = new Path();
					path.add(point1);
					path.add(point2);
					triangle = makeTriangle(point1, point2, true, triangle, radius);
					if (trackerList.slice(-1)[0].complete) {
						path.strokeColor = color;
						triangle.fillColor = color;
						drawPoint.fillColor = color;
					} else {
						path.strokeColor = 'red';
						drawPoint.fillColor = 'red';
						triangle.fillColor = 'red';
					}
				}

			}
		} else {
			if (path && trackerList.length > 0) {
				// remove the arrow
				path.remove();
				triangle.remove();;
				pointFlag = true

				trackerList.pop();
			}
		}
	}

	function submitTracks() {
		console.log(trackerList);
		var sendData = {'trackerArr': trackerList, 'player_id': $('#player').val(), 'game_id': $('#game').val()};
		$.ajax({
			url: '/create_tracks',
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			data: sendData,
			type: 'POST',
			dataType: 'json',
			success: function(response) {
				console.log(response);
				if (response.success) {
					var game_id = $('#game').val();
					window.location.href = `/games/${game_id}`;
				}
			},
			error: function(error) {
				console.log(error);
			}
		})
	}

	$('button#incomplete_button').on(
		'click',
		function() {
			markIncomplete();
		}
	)

	$('button#cancel_pass_button').on(
    'click',
    function() {
      cancelPass();
    } 
	);

	$('button#submit_button').on(
		'click',
		function() {
			submitTracks();
		}
	);

}

