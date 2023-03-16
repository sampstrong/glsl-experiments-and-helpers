#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.912,0.698,0.352);
vec3 colorB = vec3(0.645,0.942,1.000);
vec3 colorC = vec3(0.859,0.679,1.000);

float easeOutElastic(float x) {
    float PI = 3.1415926;
    float c = (2.0 * PI) / 3.0;
    
    return pow(2.0, -10.0 * x) * sin((x * 10.0 - 0.75) * c) + 1.0;
}

float easeInOutBack(float x) {
    
    float c1 = 1.70158;
    float c2 = c1 * 1.525;
    
    if (x < 0.5) {
        return (pow(2.0 * x, 2.0) * ((c2 + 1.0) * 2.0 * x - c2)) / 2.0;
    }
    else {
        return (pow(2.0 * x - 2.0, 2.0) * ((c2 + 1.0) * (x * 2.0 - 2.0) + c2) + 2.0) / 2.0;
    }
}

float easeOutCirc(float x) {
	return sqrt(1.0 - pow(x - 1.0, 2.0));
}

float easeInCirc(float x) {
    return 1.0 - sqrt(1.0 - pow(x, 2.0));
}

void main() {
    
	vec2 uv = gl_FragCoord.xy/u_resolution;
    
    vec3 color = vec3(0.0);
    vec3 color2 = vec3(0.0);
    vec3 color3 = vec3(0.0);
    vec3 color4 = vec3(0.0);

    float pct = easeInOutBack(sin(u_time) * 0.5);
    float pct2 = easeInOutBack(cos(u_time * 5.0) * 0.3);
    float pct3 = easeOutCirc(abs(fract(u_time * 0.1))) - easeInCirc(fract(u_time * 0.1 + 2.0));

    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    color = mix(colorA, colorB, pct);
    color2 = mix(color, colorC, pct2);
    color3 = mix(colorB, colorA, pct3);
    color4 = vec3(color3.r * uv.y, color3.g * uv.x, uv.x + 2.0 * 0.25);

    gl_FragColor = vec4(color4,1.0);
}