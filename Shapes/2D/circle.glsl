#ifdef GL_ES
precision mediump float;
#endif

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
    

    // a. The DISTANCE from the pixel to the center
    vec3 circle = circle(st, 0.4, 0.5, vec3(0.1, 0.8, 0.2));

    // other functions that do the same thing as distance
    
    // b. The LENGTH of the vector
    //    from the pixel to the center
    //vec2 toCenter = vec2(0.5)-st;
    //pct = length(toCenter);

    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
    //vec2 tC = vec2(0.5)-st;
    //pct = sqrt(tC.x*tC.x+tC.y*tC.y);

    

	gl_FragColor = vec4( circle, 1.0 );
}