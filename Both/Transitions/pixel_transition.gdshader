shader_type canvas_item;

uniform float time = 1.0;
uniform vec3 transition_color : source_color = vec3(0.0, 0.0, 0.0); // Black by default
uniform float resolution = 6.0;//6.0;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,96.233))) * 43758.5453);
}

void fragment()
{
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy / iResolution.xy;
    vec2 lowresxy = floor(FRAGCOORD.xy / resolution);

    if (sin(time) > rand(lowresxy)) {
        COLOR = vec4(0.0);
    } else {
        COLOR = vec4(transition_color, 1.0);
    }
}
