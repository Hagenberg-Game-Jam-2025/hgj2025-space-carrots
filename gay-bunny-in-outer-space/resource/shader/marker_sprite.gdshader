shader_type spatial;
render_mode fog_disabled;
render_mode depth_test_disabled;
render_mode unshaded;
//render_mode world_vertex_coords;
render_mode skip_vertex_transform;

void vertex() {
	float dist = length(CAMERA_POSITION_WORLD - NODE_POSITION_WORLD);
	mat4 modified_model_view = VIEW_MATRIX * mat4(
        INV_VIEW_MATRIX[0],
        INV_VIEW_MATRIX[1],
        INV_VIEW_MATRIX[2],
        MODEL_MATRIX[3]
    ) * mat4(
		vec4(dist, 0.0, 0.0, 0.0),
		vec4(0.0, dist, 0.0, 0.0),
		vec4(0.0, 0.0, 1.0, 0.0),
		vec4(0.0, 0.0, 0.0, 1.0)
	);
    MODELVIEW_MATRIX = modified_model_view;
	//MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(vec4(length(inverse(MODEL_MATRIX)[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, length(inverse(MODEL_MATRIX)[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(inverse(MODEL_MATRIX)[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    NORMAL = normalize((MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    BINORMAL = normalize((MODELVIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz);
    TANGENT = normalize((MODELVIEW_MATRIX * vec4(TANGENT, 0.0)).xyz);
}

//void vertex(){
	////Modify the vertex normal so it's pointing towards the camera (positive Z)
	//NORMAL = vec3(0.0, 1.0, 0.0);
	////Modify the model view matrix to make the vertex look at the camera
	//MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
		//vec4(normalize(cross(vec3(0.0, 1.0, 0.0), INV_VIEW_MATRIX[2].xyz)), 0.0),
		//vec4(0.0, 1.0, 0.0, 0.0),
		//vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
		//MODEL_MATRIX[3]
	//);
	//VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
    //NORMAL = normalize((MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
    //BINORMAL = normalize((MODELVIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz);
    //TANGENT = normalize((MODELVIEW_MATRIX * vec4(TANGENT, 0.0)).xyz);
//}

uniform sampler2D tex: source_color;

void fragment() {
	vec4 col = texture(tex, UV);
	ALBEDO = vec3(col.r * 2.0, col.g * 2.0, col.b * 2.0);
	ALPHA = col.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
