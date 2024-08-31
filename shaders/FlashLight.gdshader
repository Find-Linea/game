shader_type canvas_item;
uniform vec2 mouse_position;

uniform vec4 color: source_color = vec4(0.305, 0.298, 0.341, 1.0);
uniform float dis1 = 0.1;
uniform float dis2 = 0.15;

uniform float mult = 0.56; // Missing semicolon here

void fragment() {
    float transp = 0.5; // Missing semicolon here
    float val = distance(vec2(UV.x, UV.y * mult), vec2(mouse_position.x, mouse_position.y * mult));
    if (val < dis1) {
        transp = 0.1;
    } else if (val < dis2) {
        transp = 0.7;
    } else {
        transp = 0.91;
    }
    COLOR = vec4(color.x, color.y, color.z, transp);
}
