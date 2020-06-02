export function makeTriangle(point1, point2, completePass, triangle, radius) {
  var angle = calcAngle(point1, point2);
  var center = calcCenter(point2, angle, radius);
  triangle = new Path.RegularPolygon(center, 3, radius);
  if (completePass) {
    triangle.fillColor = 'black';
  } else {
    triangle.fillColor = 'red';
  }
  var degAngle = radToDeg(angle);
  rotateTriangle(triangle, degAngle, center);
  
  return triangle;
}

export function rotateTriangle(triangle, degAngle, center) {
  triangle.rotate(90, center);
  if (degAngle == 90 || degAngle == -90) {
    triangle.rotate(-1 * degAngle, center);
  } else {
    triangle.rotate(degAngle, center);
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

export function calcCenter(point, angle, radius) {
  var r = radius / 2.0;
  var xCenter = point.x + r * Math.cos(angle);
  var yCenter = point.y + r * Math.sin(angle);
  var center = new Point(xCenter, yCenter);
  return center;
}

export function radToDeg(rad) {
  return rad * (180 / Math.PI);
}

