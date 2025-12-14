shader_type spatial;
//render_mode skip_vertex_transform;

float hash1( vec2 p ) {
    p  = 50.0*fract( p*0.3183099 );
    return fract( p.x*p.y*(p.x+p.y) );
}

float noise( in vec2 x ) {
    vec2 p = floor(x);
    vec2 w = fract(x);
    #if 1
    vec2 u = w*w*w*(w*(w*6.0-15.0)+10.0);
    #else
    vec2 u = w*w*(3.0-2.0*w);
    #endif

    float a = hash1(p+vec2(0,0));
    float b = hash1(p+vec2(1,0));
    float c = hash1(p+vec2(0,1));
    float d = hash1(p+vec2(1,1));

    return -1.0+2.0*(a + (b-a)*u.x + (c-a)*u.y + (a - b - c + d)*u.x*u.y);
}

const mat2 m2 = mat2(vec2(0.80,  0.60), vec2(-0.60,  0.80));

float fbm_4( in vec2 x ) {
    float f = 1.9;
    float s = 0.55;
    float a = 0.0;
    float b = 0.5;
    for( int i=0; i<12; i++ )
    {
        float n = noise(x);
        a += b*n;
        b *= s;
        x = f*m2*x;
    }
	return a;
}

varying vec3 vertex_pos;

void vertex() {
	//vec3 vertex = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	vec3 displacement = vec3(VERTEX.x, VERTEX.y + smoothstep(-.4, .9, fbm_4(VERTEX.xz * 0.06 + vec2(-10.0, 10.0))) * 10.0, VERTEX.z);
	vertex_pos = displacement;
	vec3 vertex = displacement;
    VERTEX = vertex;
    //NORMAL = normalize((MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    //BINORMAL = normalize((MODELVIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz);
    //TANGENT = normalize((MODELVIEW_MATRIX * vec4(TANGENT, 0.0)).xyz);
}

void fragment() {
	vec3 pos = vertex_pos;
	//vec3 high_color = pos;
	vec3 high_color = vec3(0.2, 0.04, 0.01);
	vec3 base_color;
	base_color = high_color * clamp((pos.y + 1.3 + fbm_4(pos.xz * .1 + vec2(10.0, 1.0)) * 1.5), 0.3, 1.0);
	base_color *= smoothstep(0.9, 0.0, fbm_4(pos.xz * .2));
	ALBEDO = base_color;
	ROUGHNESS = .9;
	RIM = .2;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
