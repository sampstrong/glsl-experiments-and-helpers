#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Reference to
// http://thndl.com/square-shaped-shaders.html

float shape(vec2 uv, vec2 pos, float num, float ang) {
    float d;
    
    // offset shape based on desired position
    uv -= pos;
    
    // Angle and radius from the current pixel
    float a = atan(uv.x,uv.y)+PI;
    float r = TWO_PI/float(num);
    
    a += ang;
    
    // Shaping function that modulate the distance
    d = cos(floor(.5+a/r)*r-a)*length(uv);
    
    return d;
}

void main(){
  	vec2 st = gl_FragCoord.xy/u_resolution.xy;
  	st.x *= u_resolution.x/u_resolution.y;
  	vec3 color = vec3(0.0);
  	float d = 0.0;

  	// Remap the space to -1. to 1.
  	st = st *2.-1.;
  
  	float outer = shape(st, vec2(-0.05, 0.05), 3.0, 5.0);
  	float d2 = shape(st, vec2(-0.05, 0.05), 3.0, 5.0) * 5.0;
    float d3 = shape(st, vec2(-0.47, 0.45), 3.0, 5.0) * 5.0;
    float d4 = shape(st, vec2(-0.37, 0.13), 3.0, 5.0) * 5.0;
    float d5 = shape(st, vec2(-0.15, 0.37), 3.0, 5.0) * 5.0;
    float d6 = shape(st, vec2(0.04, -0.26), 3.0, 5.0) * 5.0;
    float d7 = shape(st, vec2(-0.28, -0.18), 3.0, 5.0) * 5.0;
    float d8 = shape(st, vec2(-0.18, -0.49), 3.0, 5.0) * 5.0;
    float d9 = shape(st, vec2(0.26, -0.02), 3.0, 5.0) * 5.0;
    float d10 = shape(st, vec2(0.17, 0.29), 3.0, 5.0) * 5.0;
    float d11 = shape(st, vec2(0.48, 0.21), 3.0, 5.0) * 5.0;

  	vec3 outerColor = vec3(1.0-smoothstep(.4,.41,outer));
    
    vec3 color2 = vec3(1.0-smoothstep(.4,.42,d2));
    vec3 color3 = vec3(1.0-smoothstep(.4,.42,d3));
    vec3 color4 = vec3(1.0-smoothstep(.4,.42,d4));
    vec3 color5 = vec3(1.0-smoothstep(.4,.42,d5));
    vec3 color6 = vec3(1.0-smoothstep(.4,.42,d6));
    vec3 color7 = vec3(1.0-smoothstep(.4,.42,d7));
    vec3 color8 = vec3(1.0-smoothstep(.4,.42,d8));
    vec3 color9 = vec3(1.0-smoothstep(.4,.42,d9));
    vec3 color10 = vec3(1.0-smoothstep(.4,.42,d10));
    vec3 color11 = vec3(1.0-smoothstep(.4,.42,d11));
    
    
  	color = outerColor - color2 - color3 - color4 - color5 - color6 - color7 - color8 - color9 - color10 - color11;

  	gl_FragColor = vec4(color,1.0);
}