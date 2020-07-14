// REDOUT.fp
// dis one me
// 
// THIS IS WHAT HAPPENS WHEN YOU OVERDOSE, IDIOT.
//
// AX^2 + BX + C : (-2.0 * (TEXTUREYCOORDINATE^2) + (2.0 * TEXTUREYCOORDINATE) + 0.1)   

void main() {
	vec4 pixelcolor;
	pixelcolor = texture(InputTexture, TexCoord); //Get the color at the coordinate of the input (screenspace)
	float t = mf_time; //defined in shader def
	vec4 newcolor;
	float timeVaryingResult = 0.15 * cos(1.85 * t) + 0.6; //this is a function that goes between 0 and a little less than 1
	float quadraticResult = (-6.8 * (TexCoord.y * TexCoord.y) + (7.3 * TexCoord.y) + 0.7) ;
	
	newcolor.r = ((pixelcolor.r * quadraticResult) - timeVaryingResult) + 0.05;
	newcolor.g = pixelcolor.g - timeVaryingResult + 0.05;
	newcolor.b = pixelcolor.b - timeVaryingResult + 0.05;
	newcolor.a = pixelcolor.a;
	
	FragColor = newcolor;
}