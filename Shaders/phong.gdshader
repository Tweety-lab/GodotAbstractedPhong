shader_type spatial;

uniform sampler2D Texture;

void fragment() {
	// Apply texture
    vec4 albedo_tex = texture(Texture, UV);
    ALBEDO = albedo_tex.rgb;
    ALPHA = albedo_tex.a;
}

void light() {
	// Sample the texture at the current UV coordinates
	vec4 texColor = texture(Texture, UV);
	
	// Diffuse
	float diffuseFactor = max(0.0, dot(LIGHT, NORMAL));
	vec3 diffuse = diffuseFactor * LIGHT_COLOR;
	DIFFUSE_LIGHT += diffuse;
	
	// Specular
	vec3 reflectDir = normalize(reflect(-LIGHT, NORMAL));
	float specularFactor = max(0.0, dot(VIEW, reflectDir));
	specularFactor = pow(specularFactor, SPECULAR_AMOUNT);
	SPECULAR_LIGHT += specularFactor * LIGHT_COLOR;
}
