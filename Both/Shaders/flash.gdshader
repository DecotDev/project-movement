shader_type canvas_item;

instance uniform vec4 flash_color: source_color = vec4(1.0);
instance uniform float flash_opacity: hint_range(0.0, 1.0) = 0;

//void vertex() {
	//// Called for every vertex the material is visible on.
//}

void fragment() {
	vec4 color = texture(TEXTURE,UV);
	color.rgb = mix(color.rgb, flash_color.rgb, flash_opacity);
	COLOR = color;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
