shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(0.34, 0.58, 0.18, 1.0);
uniform vec4 color2 : source_color = vec4(0.28, 0.09, 0.44, 1.0);
uniform float repeat_amount : hint_range(1.0, 100.0) = 30.0;
uniform float mod_value : hint_range(1.0, 10.0) = 2.0;
uniform float rotation_speed : hint_range(0.0, 1.0) = 0.02;
uniform bool use_rainbow = false;
uniform float rainbow_speed : hint_range(0.0, 2.0) = 0.5;
uniform float rainbow_opacity : hint_range(0.0, 1.0) = 1.0;

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

float atan2_(in float y, in float x) {
    return atan(y, x);
}

vec2 to_polar(vec2 cartesian) {
    const float TWO_PI = 6.28318530718;
    float len = length(cartesian);
    float angle = atan2_(cartesian.y, cartesian.x);
    return vec2(angle / TWO_PI, len);
}

float scanlines(float x, float repeat_, float modValue) {
    x = floor(x * repeat_);
    return mod(x, modValue);
}

void fragment() {
    vec2 uv = UV;
    vec2 pos = uv - 0.5;
    float aspect = (1.0 / SCREEN_PIXEL_SIZE.x) / (1.0 / SCREEN_PIXEL_SIZE.y);
    pos.x *= aspect;
    pos = to_polar(pos);

    float scan = scanlines(pos.x + (TIME * rotation_speed), repeat_amount, mod_value);
    vec4 final_color;
    if (use_rainbow) {
        float hue1 = fract(TIME * rainbow_speed);
        float hue2 = fract(TIME * rainbow_speed + 0.5);
        vec3 rainbow1 = hsv2rgb(vec3(hue1, 1.0, 1.0));
        vec3 rainbow2 = hsv2rgb(vec3(hue2, 1.0, 1.0));
        vec3 rgb = mix(rainbow1, rainbow2, scan / (mod_value - 1.0));
        final_color = vec4(rgb, rainbow_opacity);
    } else {
        final_color = mix(color1, color2, scan / (mod_value - 1.0));
    }
    
    COLOR = final_color;
}