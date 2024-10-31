uniform bool Eye_Swap;

float4 mainImage(VertData v_in) : TARGET
{
	float2 fragCoord = v_in.uv * uv_size; // screen space coordinates of pixel
	int x = fragCoord.x;
	int y = fragCoord.y;
	float halfScreenWidth = uv_size.x / 2.0;
	float pixelSizeY = 2.0;
	
	int eyeSwapFactor;
	if (Eye_Swap) {
		eyeSwapFactor = 1;
	}
	else {
		eyeSwapFactor = 0;
	}
	//eyeSwapFactor = 0;
	
	float2 uv_out;
	if (v_in.uv[0] < 0.5) {
		uv_out[0] = (2. * x  + .5)  / uv_size.x;
		uv_out[1] = (2 * int(y/pixelSizeY)  + 1.5 - eyeSwapFactor)  / uv_size.y;
	}
	else {
		uv_out[0] = (2 * (x - halfScreenWidth) + .5) / uv_size.x;
		uv_out[1] = (2 * int(y/pixelSizeY) + .5 + eyeSwapFactor) / uv_size.y;
	}
	
	float4 rgba = image.Sample(textureSampler, uv_out);
	return rgba;
}