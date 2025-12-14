shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

float noise1(vec2 p)
{
    p = fract(p * vec2(233.42, 865.32));
    p += dot(p, p+32.33);
    return fract(p.x * p.y);
}

vec2 noise2(vec2 p)
{
    float n = noise1(p);
    return vec2(n, noise1(p+n));
}

vec2 map( vec2 id ) {
    vec2 noise = noise2(id);
    
    float x = sin(TIME * 0.1 * noise.x);
    float y = cos(TIME * 0.1 * noise.y);
    
    return vec2(x, y) * 0.4;
}

void fragment() {
	//vec2 fragCoord = VERTEX.xz;
	vec2 fragCoord = FRAGCOORD.xy;
	vec2 iResolution = vec2(1024, 1024);
    vec2 uv = (fragCoord - .5 * iResolution.xy) /iResolution.y;
    //vec2 uv = fragCoord;
	
    uv *= 6.0;
    uv += vec2(-TIME * .04, TIME * .02);
    
    vec2 gridUv = fract(uv) -.5;
    vec2 cellId = floor(uv);
    
    vec2 p = map(cellId);
    float d = length(gridUv - p);
    float m = smoothstep(.03, .0, d);
        
    vec4 col = vec4(m) * 0.8;

    // Output to screen
    ALBEDO = col.xyz;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
