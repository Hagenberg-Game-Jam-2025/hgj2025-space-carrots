shader_type fog;

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
    for( int i=0; i<4; i++ )
    {
        float n = noise(x);
        a += b*n;
        b *= s;
        x = f*m2*x;
    }
	return a;
}

void fog() {
	vec3 pos = vec3(WORLD_POSITION.x, WORLD_POSITION.y - OBJECT_POSITION.y, WORLD_POSITION.z);
	//if (abs(pos.x) < 1.5) {
		//ALBEDO = vec3(1.0, 1.0, 1.0);
	//} else if (abs(pos.x) < 3.0) {
		//ALBEDO = vec3(245.0 / 255.0, 169.0 / 255.0, 184.0 / 255.0);
	//} else if (abs(pos.x) < 6.0) {
		//ALBEDO = vec3(91.0 / 255.0, 206.0 / 255.0, 250.0 / 255.0);
	//}
	//EMISSION = vec3(.1);
	//if (pos.y > 0.0) {
		ALBEDO = vec3(0.2, 0.04, 0.01);
	//} else {
		//ALBEDO = vec3(0.7, 0.2, 0.7);
	//}
	DENSITY = smoothstep(.1, .1, max(0.0, -pos.y + smoothstep(-.4, 1.2, fbm_4(vec2(pos.x + TIME * 0.1, pos.z + TIME * 0.2) * 0.3)) * 3.0 + 0.1));
	//DENSITY = max(0.0, 1000000.0 * (-pos.y + fbm_4(vec2(pos.x + TIME, pos.z) / 4.0) * 1.0 + 3.2) / (SDF * SDF * 0.4));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
