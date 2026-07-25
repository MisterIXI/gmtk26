shader_type canvas_item;

uniform sampler2D bg_sampler: repeat_enable;
uniform vec4 color1: source_color = vec4(1,1,1,1);
uniform vec4 color2: source_color = vec4(0,0,0,1);
uniform float tile_mult = 4.0;

void fragment() {
	vec2 uv = UV + TIME * 0.1;
	vec4 bg_texture = texture(bg_sampler, uv * tile_mult);
	bg_texture = mix(color1, color2, bg_texture);
	COLOR = bg_texture;
}
