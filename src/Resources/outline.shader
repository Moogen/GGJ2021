shader_type canvas_item;
render_mode unshaded;

uniform float width = 1;
uniform vec4 outline_color : hint_color = vec4(1.0, 0.89, 0.47, 1.0);

void fragment() 
{
	float size = width * 1.0 / float(textureSize(TEXTURE, 0).x);
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -4.0 * sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(size, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(-size, 0)).a;
	alpha += texture(TEXTURE, UV + vec2(0, size)).a;
	alpha += texture(TEXTURE, UV + vec2(0, -size)).a;
	
	vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
}