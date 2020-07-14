// teargas.fp
// 
// AAAGH I CAN'T SEE MY EYES ARE BURNING
// 
// Gaussian Blur from https://www.shadertoy.com/view/XdfGDH
//
//

varying vec4 pixelPos;
uniform sampler2D tex;

float normpdf(float x, float sigma)
{
	return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}

void main() {
	
	//float t = mf_time; //defined in shader def
	//vec4 pixelcolor;
	//pixelcolor = texture(InputTexture, TexCoord); //Get the color at the coordinate of the input (screenspace)
	//vec4 newcolor;
	
	const int mSize = 11;  // was 11
	const int kSize = (mSize-1)/2;
	float kernel[mSize];
	vec3 final_color;
	
	//create the 1-D kernel
	float sigma = 7.0; // was 7
	float Z = 0.0;
	for (int j = 0; j <= kSize; ++j)
	{
		kernel[kSize+j] = kernel[kSize-j] = normpdf(float(j), sigma);
	}
	
	//get the normalization factor (as the gaussian has been clamped)
	for (int j = 0; j < mSize; ++j)
	{
		Z += kernel[j];
	}
	
	//read out the texels
	for (int i=-kSize; i <= kSize; ++i)
	{
		for (int j=-kSize; j <= kSize; ++j)
		{
			final_color += kernel[kSize+j] * kernel[kSize+i] * texture(InputTexture, (TexCoord.xy + vec2(float(i), float(j) ) ) ).rgb;
		}
	}
	
	FragColor = vec4(final_color, 1.0); // final_color * Z^2
	
	
	
	/*
	float timeVaryingResult = 0.15 * cos(1.85 * t) + 0.6; //this is a function that goes between 0 and a little less than 1
	float quadraticResult = (-6.8 * (TexCoord.y * TexCoord.y) + (7.3 * TexCoord.y) + 0.7) ;
	
	newcolor.r = ((pixelcolor.r * quadraticResult) - timeVaryingResult) + 0.05;
	newcolor.g = pixelcolor.g - timeVaryingResult + 0.05;
	newcolor.b = pixelcolor.b - timeVaryingResult + 0.05;
	newcolor.a = pixelcolor.a;
	
	FragColor = newcolor;
	*/
}
//eof