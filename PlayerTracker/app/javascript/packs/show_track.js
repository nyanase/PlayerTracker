import * as paper from 'paper';
import {makeTriangle} from './triangle';

paper.install(window);

window.onload = function() {
  paper.setup('myCanvas');

  var trackerData = $('#tracker_data').data('source');
  var tracker;
  for (tracker of trackerData) {
    var point1 = new Point(tracker.x1, tracker.y1);
    var point2 = new Point(tracker.x2, tracker.y2);
    
    drawPath(point1, point2, tracker);

    var triangle;
    makeTriangle(point1, point2, tracker.complete, triangle, 10);
  }

  var forwardPasses = $('#forward_data').data('source');
  console.log(forwardPasses);

  function drawPath(point1, point2, tracker) {
    var path = new Path();
    path.add(point1);
    path.add(point2);
    if (tracker.complete) {
      path.strokeColor = 'black';
    } else {
      path.strokeColor = 'red';
    }
  }
}