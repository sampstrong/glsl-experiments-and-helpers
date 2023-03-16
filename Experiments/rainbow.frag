#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.912,0.145,0.137);
vec3 colorB = vec3(1.000,0.650,0.226);
vec3 colorC = vec3(1.000,0.990,0.197);
vec3 colorD = vec3(0.434,1.000,0.359);
vec3 colorE = vec3(0.316,0.826,1.000);
vec3 colorF = vec3(0.677,0.566,1.000);

vec3 black = vec3(0.0, 0.0, 0.0);

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    float pctA = smoothstep(0.0,0.2, st.x);
    float pctB = smoothstep(0.0,0.2, st.x) - smoothstep(0.2,0.4, st.x);
    float pctC = smoothstep(0.2,0.4, st.x) - smoothstep(0.4,0.6, st.x);
    float pctD = smoothstep(0.4,0.6, st.x) - smoothstep(0.6,0.8, st.x);
    float pctE = smoothstep(0.6,0.8, st.x) - smoothstep(0.8,1.0, st.x);
    float pctF = smoothstep(0.8,1.0, st.x);

    vec3 color1 = mix(colorA, black, pctA);
    vec3 color2 = mix(black, colorB, pctB);
    vec3 color3 = mix(black, colorC, pctC);
    vec3 color4 = mix(black, colorD, pctD);
    vec3 color5 = mix(black, colorE, pctE);
    vec3 color6 = mix(black, colorF, pctF);
    
    vec3 sum = color1 + color2 + color3 + color4 + color5 + color6;

    gl_FragColor = vec4(sum,1.0);
}