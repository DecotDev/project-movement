shader_type canvas_item;

uniform float percentage: hint_range(0.0, 1.0) = 1.0;
uniform sampler2D burn_texture : source_color;

uniform vec4 layer_1: source_color = vec4(0.2, 0.2, 0.2, 1.0);
uniform float size_1 = 0.05;

uniform vec4 layer_2: source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float size_2 = 0.05;

uniform vec4 layer_3: source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float size_3 = 0.05;

void fragment() {
	float noise = texture(burn_texture, UV).r * (1.0 - (size_1 + size_2 + size_3 + 0.01));

	COLOR = texture(TEXTURE, UV);
	COLOR.a -= step(percentage, noise);
	COLOR.rgb = mix(COLOR.rgb, layer_3.rgb, step(percentage, noise + size_1 + size_2 + size_3));
	COLOR.rgb = mix(COLOR.rgb, layer_2.rgb, step(percentage, noise + size_1 + size_2));
	COLOR.rgb = mix(COLOR.rgb, layer_1.rgb, step(percentage, noise + size_1));
}
