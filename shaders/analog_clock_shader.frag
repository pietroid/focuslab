// angle_radial.frag
#version 320 es
#include <flutter/runtime_effect.glsl>
#define pi 3.14159265

precision highp float;

uniform vec2 uSize;      // canvas size
uniform vec4 midDayColor;
uniform vec4 dayColor;
uniform vec4 midNightColor;
uniform vec4 nightColor;

uniform float dayColorTimeDelta;
uniform float nightColorTimeDelta;

out vec4 fragColor;

void main() {
  // Normalize coordinates: [-1, 1]
  vec2 uv = (FlutterFragCoord().xy / uSize) * 2.0 - 1.0;

  // Distance from center
  float r = length(uv);
  
  // Angle is zero pointing down
  float angle = atan(uv.x, -uv.y) + pi; 

  // Time by angle
  float timeInHours = angle * 24.0 / (2 * pi);

  // Time difference to midDay
  float timeDeltaToMidday = 12.0 - timeInHours;

  if (timeInHours > 12.0){
    timeDeltaToMidday = timeInHours - 12.0;
  }

  if (timeDeltaToMidday < dayColorTimeDelta){
    float t = timeDeltaToMidday / dayColorTimeDelta;
    fragColor = mix(midDayColor, dayColor, t);
  } else if (timeDeltaToMidday < nightColorTimeDelta) {
    float t = (timeDeltaToMidday - dayColorTimeDelta)  / (nightColorTimeDelta - dayColorTimeDelta);
    fragColor = mix(dayColor, nightColor, t);
  } else {
    float t = (timeDeltaToMidday - nightColorTimeDelta) / (12.0 - nightColorTimeDelta);
    fragColor = mix(nightColor, midNightColor, t);
  }

  fragColor = mix(fragColor, vec4(0.0), smoothstep(0.0, 1.0, 1 - r*r*r*r));
}
