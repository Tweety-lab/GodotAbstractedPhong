shader_type spatial;

uniform sampler2D Texture;

void light() {
	// Sample the texture at the current UV coordinates
	vec4 texColor = texture(Texture, UV);
	
	// Diffuse
	float diffuseFactor = max(0.0, dot(LIGHT, NORMAL));
	vec3 diffuse = diffuseFactor * LIGHT_COLOR;
	DIFFUSE_LIGHT += diffuse * texColor.rgb;
	
	// Specular
	vec3 reflectDir = normalize(reflect(-LIGHT, NORMAL));
	float specularFactor = max(0.0, dot(VIEW, reflectDir));
	specularFactor = pow(specularFactor, SPECULAR_AMOUNT);
	SPECULAR_LIGHT += specularFactor * LIGHT_COLOR;
}
