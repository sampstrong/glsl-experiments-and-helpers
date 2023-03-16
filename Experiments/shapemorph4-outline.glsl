#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    vec2 pos = vec2(0.5)-st;

    float r = length(pos)*2.0;
    float a1 = atan(pos.y,pos.x);
    a1 += u_time / 10.0;
    
    float a2 = atan(pos.y,pos.x);
    a2 += u_time / 10.0 +5.2;

    float f = cos(a1*3.);
    f = abs(cos(a1*3.));
    f = abs(cos(a1*2.5))*.5+.3;
    float f2 = sin(cos(a2*3.) + u_time)*0.1+0.5;
    float f1 = sin(cos(a1*3.) + u_time)*0.2+0.6;

    vec3 color1 = vec3( 1.-smoothstep(f1,f1+0.02,r) );
    vec3 color2 = vec3( 1.-smoothstep(f2,f2+0.02,r) );
    
    color = color1 - color2;
    
    float pct1 = plot(st, f1);
    float pct2 = plot(st, f2);
    
    //color2 *= pct2;
    //color *= pct2;
    
    color = fract(color);
   

    gl_FragColor = vec4(color, 1.0);
}