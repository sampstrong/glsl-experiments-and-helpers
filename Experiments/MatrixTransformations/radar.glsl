// Author: Sam Strong
// Title: Radar

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

mat2 scale(vec2 _scale){
    return mat2(_scale.x,0.0,
                0.0,_scale.y);
}

mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}

vec3 circle(vec2 uv, float size, float smoothing, vec3 color) {
    float pct = distance(uv,vec2(0.5));
    pct *= 2.0;
    float circle = 1.0 - (smoothstep(size, size + smoothing, pct));
    vec3 coloredCircle = circle * color;
    
    return coloredCircle;
}

vec3 rectangle(vec2 uv, float offset, float smoothing){
    vec3 color = vec3(0.0);

    vec2 bl = smoothstep(vec2(offset), vec2(offset + smoothing), uv);
    vec2 tr = smoothstep(vec2(offset), vec2(offset + smoothing), 1.0 - uv);
    color = vec3(bl.x * bl.y * tr.x * tr.y);
    
    return color;
}

float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    vec2(1.0)-_st);
    return uv.x*uv.y;
}

float cross(in vec2 _st, float _size, float thinFactor){
    return  box(_st, vec2(_size,_size/thinFactor)) +
            box(_st, vec2(_size/thinFactor,_size));
}

float shape(vec2 uv, vec2 pos, float num) {
    float d;
    
    // offset shape based on desired position
    uv -= pos;
    
    // Angle and radius from the current pixel
    float a = atan(uv.x,uv.y)+PI;
    float r = TWO_PI/float(num);
    
    // Shaping function that modulate the distance
    d = cos(floor(.5+a/r)*r-a)*length(uv);
    
    return d;
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);
    
    vec2 baseUV = st;
    
    // outer ring
    vec3 blueTone = vec3(0.039,0.962,0.990);
    vec3 ringFade = (circle(st, 0.9, 0.0, vec3(1.0)) - circle(st, 0.7, 0.5, vec3(1.0))) * blueTone;
    vec3 outerRing = (circle(st, 0.9, 0.0, vec3(1.0)) - circle(st, 0.895, 0.0, vec3(1.0))) * blueTone;
    color += outerRing + ringFade;
    
    
    // cross
    vec3 cross = clamp(vec3(cross(st, 0.25, 75.0)), 0.0, 1.0);
    vec3 rect = rectangle(st, 0.48, 0.0);
    vec3 crossHair = cross - rect;
    crossHair *= (blueTone / 2.0);
    color += crossHair;
    
    // matrix transformations for triangle 1
    st -= vec2(0.5);
    st = rotate2d( PI * 1.5) * st;
    st = scale(vec2(20.0, 8.0)) * st;
    st += vec2(0.5);
    
    vec2 translate1 = vec2(0.0,3.2);
    st += translate1;
    
    // triangele 1
    vec3 t1 = vec3(shape(st, vec2(0.5), 3.0));
    vec3 triangle1 = vec3(1.0-smoothstep(.1,.105,t1));
    triangle1 *= blueTone * 0.7;
    color += triangle1;
    
    st = baseUV;
    
    // matrix transformations for triangle 2
    st -= vec2(0.5);
    st = rotate2d( PI * 0.5) * st;
    st = scale(vec2(20.0, 8.0)) * st;
    st += vec2(0.5);
    
    st += translate1;
    
    // triangele 2
    vec3 t2 = vec3(shape(st, vec2(0.5), 3.0));
    vec3 triangle2 = vec3(1.0-smoothstep(.1,.105,t2));
    triangle2 *= blueTone * 0.7;
    color += triangle2;
    
    st = baseUV;
    
    float pulseSize = fract(u_time / 5.0) * 5.3;
    vec3 pulse= circle(st, 0.168 * pulseSize, 0.0, vec3(1.0)) - circle(st, 0.126 * pulseSize, 0.596, vec3(1.0));
    pulse *= blueTone;
    color = clamp(color, 0.0, 1.0);
    color = max(color, pulse);
    
    
    vec2 translate2 = vec2(cos(u_time / 5.0)* sin(u_time / 2.0) * 0.3,sin(u_time / 7.0) * 0.2);
    st += translate2;
    
    vec3 redTone = vec3(1.000,0.109,0.090);
    vec3 enemy = circle(st, 0.02, 0.0, vec3(1.0));
    enemy *= redTone;
    color = max(color, enemy);
    
    // enemy
    float enemyPulseSize = 0.75;
    vec3 enemyPulse = circle(st, 0.168 * enemyPulseSize, 0.0, vec3(1.0)) - circle(st, 0.126 * enemyPulseSize, -0.072, vec3(1.0));
    enemyPulse *= redTone / 5.0;
    enemyPulse *= clamp(sin(vec3(1.0) * u_time * 2.0) * 0.5 + 0.5, 0.0, 1.0) * 1.5;
    color = max(color, enemyPulse);
    

    gl_FragColor = vec4(color,1.0);
}
