shader_type spatial;

uniform sampler2D Texture;
uniform float Specular;

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
	vec3 diffuse = diffuseFactor * LIGHT_COLOR * ATTENUATION;
	DIFFUSE_LIGHT += diffuse;
	
	// Specular
	vec3 reflectDir = normalize(reflect(-LIGHT, NORMAL));
	float specularFactor = max(0.0, dot(VIEW, reflectDir));
	specularFactor = pow(max(dot(VIEW, reflectDir), 0.0), Specular);
	vec3 specular = specularFactor * LIGHT_COLOR * ATTENUATION;
	SPECULAR_LIGHT += specular;
}
