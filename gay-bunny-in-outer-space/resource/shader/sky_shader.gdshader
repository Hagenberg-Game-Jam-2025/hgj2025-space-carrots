shader_type sky;

float noise1(vec3 p)
{
    p = fract(p * vec3(233.42, 865.32, 432.54));
    p += dot(p, p+32.33);
    return fract(p.x * p.y);
}

vec3 noise2(vec3 p)
{
    float n = noise1(p);
	float o = noise1(p + n);
    return vec3(n, o, noise1(p + o));
}

vec3 map( vec3 id ) {
    vec3 noise = noise2(id);
    
    float x = sin(TIME * 0.1 * noise.x);
    float y = cos(TIME * 0.1 * noise.y);
	float z = sin(TIME * 0.1 * noise.z);
    
    return vec3(x, y, z) * 0.1;
}

vec3 stars(vec3 uv) {
    vec3 gridUv = fract(uv) -.5;
    vec3 cellId = floor(uv);
    
    vec3 p = map(cellId);
    float d = length(gridUv - p);
    float m = smoothstep(.07, .0, d);
        
    return vec3(m) * 0.8;
}

float hash1( float n )
{
    return fract( n*17.0*fract( n*0.3183099 ) );
}

float noise( in vec3 x )
{
    vec3 p = floor(x);
    vec3 w = fract(x);
    
    #if 1
    vec3 u = w*w*w*(w*(w*6.0-15.0)+10.0);
    #else
    vec3 u = w*w*(3.0-2.0*w);
    #endif
    


    float n = p.x + 317.0*p.y + 157.0*p.z;
    
    float a = hash1(n+0.0);
    float b = hash1(n+1.0);
    float c = hash1(n+317.0);
    float d = hash1(n+318.0);
    float e = hash1(n+157.0);
	float f = hash1(n+158.0);
    float g = hash1(n+474.0);
    float h = hash1(n+475.0);

    float k0 =   a;
    float k1 =   b - a;
    float k2 =   c - a;
    float k3 =   e - a;
    float k4 =   a - b - c + d;
    float k5 =   a - c - e + g;
    float k6 =   a - b - e + f;
    float k7 = - a + b + c - d + e - f - g + h;

    return -1.0+2.0*(k0 + k1*u.x + k2*u.y + k3*u.z + k4*u.x*u.y + k5*u.y*u.z + k6*u.z*u.x + k7*u.x*u.y*u.z);
}

const mat3 m3  = mat3( vec3(0.00,  0.80,  0.60),
                      vec3(-0.80,  0.36, -0.48),
                      vec3(-0.60, -0.48,  0.64) );

float fbm_4( in vec3 x )
{
    float f = 2.0;
    float s = 0.5;
    float a = 0.0;
    float b = 0.5;
    for( int i=0; i<4; i++ )
    {
        float n = noise(x);
        a += b*n;
        b *= s;
        x = f*m3*x;
    }
	return a;
}

void sky() {
	//vec2 iResolution = vec2(1024, 1024);
    //vec2 uv = (fragCoord - .5 * iResolution.xy) /iResolution.y;
    vec3 uv = EYEDIR;
    uv *= 16.0;
    uv += vec3(-TIME * .01, TIME * .005, TIME * .003);
	
	vec3 nebula = vec3(fbm_4(EYEDIR * 1.0), fbm_4(EYEDIR * .8 + vec3(.3)), fbm_4(EYEDIR * .9 + vec3(.3)));
	nebula *= vec3(1.0, .0, .1);
	nebula *= .6;
	vec3 nebula2 = vec3(fbm_4(EYEDIR * .9 + vec3(15.3)), fbm_4(EYEDIR * 1.0 + vec3(2.0)), fbm_4(EYEDIR * .9 + vec3(15.3)));
	nebula2 *= vec3(1.0, .0, .05);
	nebula2 *= .6;
	COLOR = vec3(.01) + max(stars(uv), vec3(0.0)) + max(nebula, 0.0) + max(nebula2, 0.0);
}
