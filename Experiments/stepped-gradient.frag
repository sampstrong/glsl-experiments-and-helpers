#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.770,0.468,0.446);
vec3 colorB = vec3(0.930,0.553,0.509);
vec3 colorC = vec3(1.000,0.735,0.578);
vec3 colorD = vec3(1.000,0.894,0.794);
vec3 colorE = vec3(0.908,0.981,1.000);
vec3 colorF = vec3(0.968,1.000,0.990);

vec3 black = vec3(0.0, 0.0, 0.0);

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    float pctA = step(0.16, st.y);
    float pctB = step(0.16, st.y) - step(0.33, st.y);
    float pctC = step(0.33, st.y) - step(0.5, st.y);
    float pctD = step(0.5, st.y) - step(0.66, st.y);
    float pctE = step(0.66, st.y) - step(0.83, st.y);
    float pctF = step(0.83, st.y);

    vec3 color1 = mix(colorA, black, pctA);
    vec3 color2 = mix(black, colorB, pctB);
    vec3 color3 = mix(black, colorC, pctC);
    vec3 color4 = mix(black, colorD, pctD);
    vec3 color5 = mix(black, colorE, pctE);
    vec3 color6 = mix(black, colorF, pctF);
    
    vec3 sum = color1 + color2 + color3 + color4 + color5 + color6;

    gl_FragColor = vec4(sum,1.0);
}