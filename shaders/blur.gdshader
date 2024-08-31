shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform float blur_radius : hint_range(0.0, 20.0) = 5.0;
uniform int samples : hint_range(1, 64) = 16;

void fragment() {
    vec2 tex_size = vec2(textureSize(screen_texture, 0));
    vec2 uv = SCREEN_UV;
    vec4 color = vec4(0.0);

    float total_weight = 0.0;
    for (int i = 0; i < samples; i++) {
        float angle = 6.283185 * float(i) / float(samples);
        vec2 offset = vec2(cos(angle), sin(angle)) * blur_radius / tex_size;
        vec4 sample_color = texture(screen_texture, uv + offset);
        float weight = 1.0 - length(offset) / blur_radius;
        color += sample_color * weight;
        total_weight += weight;
    }

    color /= total_weight;
    COLOR = color;
}
