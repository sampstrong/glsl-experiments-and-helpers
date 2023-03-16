#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec2 pos = vec2(0.5)-st;

    float r = length(pos)*2.0;
    float a = atan(pos.y,pos.x);
    a += u_time / 10.0;

    float f = cos(a*3.);
    f = abs(cos(a*3.));
    f = abs(cos(a*2.5))*.5+.3;
    float f2 = sin(cos(a*12. + u_time)*sin(a*3.))*.3+0.4;
    float f1 = sin(cos(a*3.) + u_time)*0.3+0.6;

    vec3 color1 = vec3( 1.-smoothstep(f1,f1+0.02,r) );
    vec3 color2 = vec3( 1.-smoothstep(f2,f2+0.02,r) );
    
    color = color1 - color2;

    gl_FragColor = vec4(color, 1.0);
}