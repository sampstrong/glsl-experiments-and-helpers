#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 rectangle(vec2 uv, float offset, float smoothing){
    vec3 color = vec3(0.0);

    vec2 bl = smoothstep(vec2(offset), vec2(offset + smoothing), uv);
    vec2 tr = smoothstep(vec2(offset), vec2(offset + smoothing), 1.0 - uv);
    color = vec3(bl.x * bl.y * tr.x * tr.y);
    
    return color;
}

vec3 rectangleOutline(vec2 uv, float offset, float thickness, float smoothing) {
    vec3 color = vec3(0.0);
    
    vec3 outerRect = 1.0 - (rectangle(uv, offset, smoothing));
    vec3 innerRect = rectangle(uv, offset + thickness, smoothing);
    
    return outerRect + innerRect;
}


void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    vec3 color = rectangleOutline(st, 0.1, 0.05, 0.05);

    gl_FragColor = vec4(color,1.0);
}