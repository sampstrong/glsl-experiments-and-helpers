#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.912,0.538,0.423);
vec3 colorB = vec3(0.587,0.601,1.000);

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(st.x);

    pct.r = smoothstep(0.1,1.0, st.y) + smoothstep(0.224,-0.012, st.y);
    color = mix(colorA, colorB, pct.rrr);

    gl_FragColor = vec4(color,1.0);
}