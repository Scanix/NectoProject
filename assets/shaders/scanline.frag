#version 120

#ifdef GL_ES
    precision mediump float;
#endif

varying vec2 vTexCoord;
uniform sampler2D uImage0;
uniform float uTime;

void main(void)
{
	vec2 aux = vTexCoord;
	aux.x += sin(radians((uTime*100) + aux.y * 500)) * 0.07;
	aux.y += cos(radians((uTime*100) + aux.x * 250)) * 0.03;
	
	vec4 pixel_color = texture2D(uImage0, aux);
	
    gl_FragColor = pixel_color;
}
