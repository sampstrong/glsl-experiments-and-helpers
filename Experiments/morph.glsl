#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 circle(vec2 uv, float size, float smoothing, vec3 color) {
    float pct = distance(uv,vec2(0.5));
    pct *= 2.0;
    float circle = 1.0 - (smoothstep(size, size + smoothing, pct));
    vec3 coloredCircle = circle * color;
    
    return coloredCircle;
}

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution;
    
    vec3 morph = circle(sin(vec2(st.x, st.y) * PI)* PI / 3.9, sin(0.5 + u_time * 0.3) * 0.5 + 0.5, 0.15, vec3(0.1, 0.8, 0.7));
    
	gl_FragColor = vec4( morph, 1.0 );
}