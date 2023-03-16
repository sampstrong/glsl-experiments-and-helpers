#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.912,0.623,0.302);
vec3 colorB = vec3(0.396,0.835,1.000);

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(st.x);

    pct.r = smoothstep(0.1,1.528, st.x);
    pct.g = sin(st.y*PI - 3.288 * u_time * 0.2);
    pct.b = sin(pow(st.y,1.460));

    color = mix(colorA, colorB, pct.rgb);

    gl_FragColor = vec4(color,1.0);
}