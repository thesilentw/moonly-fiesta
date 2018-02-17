//REDOUT.GLSL
// dis one me

uniform float timer;

void main() {

	float t = timer * 35.0;
	vec2 uv = TexCoord;

	float temp = 0.8*cos(t);
    
	// quadratic to make color only block out the center of the screen
	float quadratic_color = (-5.0 * (uv[1] * uv[1]) + (5.0 * uv[1]) + 0.75);

	FragColor = vec4(1.0, 0, 0, temp);
	
	//(temp*quadratic_color*0.5)

}