#extension GL_OES_standard_derivatives : enable

precision highp float;

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;


vec3 palette(float t)
{
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);
    
    return a + b * cos(6.28318 * (c*t*d));
}


void main( void )
{
    // shortened version
    // vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / resolution.y;
    
    // get uv coords
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    
    
    // remap coordinates so 0,0 is at the center
    uv = (uv - 0.5) * 2.0;
    
    // correct uvs for aspect ratio
    uv.x *= resolution.x / resolution.y;
    
    // final color
    vec3 finalColor = vec3(0.0);
    
    // store original uv value
    vec2 uv0 = uv;
    
    
    for (float i = 0.0; i < 4.0; i++)
    {
        // repetition
        uv *= 1.5;
        uv = fract(uv);
        uv -= 0.5;
    
    
        // get length from center
        float d = length(uv * 2.) * exp(-length(uv0 * 2.));
    
        // defining colors
        vec3 col = palette(length(uv0) + i*.4 + time*.2);
    
        // sin to get repeating rings
        d = sin(d*8.0 + time)/8.0;
    
        // getting the absolute value
        d = abs(d);
    
        // take the inverse of d
        d = 0.01 / d;
        
        // increase contrast with pow
        d = pow(d, 1.5);
    
        // adding color
        finalColor += col * d;
        
    }
