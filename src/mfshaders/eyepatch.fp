// eyepatch.fp
// aahah look mom I'm a pirate
//
// x= 0.5((y-0.5)(y-0.5))+0.65
//

void main() {
	vec4 pixelcolor;
	pixelcolor = texture(InputTexture, TexCoord); //Get the color at the coordinate of the input (screenspace)
	vec4 col;
	//float sidewaysParabolic = 0.8 * ((0.5 * TexCoord.x - 0.8)*(0.5 * TexCoord.x - 0.7));
	
	//float swpara = 4 * pow(TexCoord.x, 2) - 0.8;
	col.r = -1.2 * (((0.78 * TexCoord.x) * (0.15 * TexCoord.y + 3.0)) - 1.75);
    col.g = -1.2 * (((0.78 * TexCoord.x) * (0.15 * TexCoord.y + 3.0)) - 1.75);
    col.b = -1.2 * (((0.78 * TexCoord.x) * (0.15 * TexCoord.y + 3.0)) - 1.75);
	col.a = 1.0;

	//newcolor.r = pixelcolor.r * sidewaysParabolic ;
	//newcolor.g = pixelcolor.g * sidewaysParabolic ;
	//newcolor.b = pixelcolor.b * sidewaysParabolic ;
	//newcolor.a = pixelcolor.a;

	//newcolor.r = pixelcolor.r * swpara;
	//newcolor.g = pixelcolor.g * swpara;
	//newcolor.b = pixelcolor.b * swpara;
	//newcolor.a = pixelcolor.a;

	FragColor = pixelcolor * col;


}