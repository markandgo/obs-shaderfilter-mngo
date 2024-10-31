uniform bool Eye_Swap;

float4 mainImage(VertData v_in) : TARGET
{
	float2 fragCoord = v_in.uv * uv_size; // screen space coordinates of pixel
	int x = fragCoord.x;
	int y = fragCoord.y;
	float pixelSizeY = 2.0;

	
	int eyeSwapFactor;
	if (Eye_Swap) {
		eyeSwapFactor = 1;
	}
	else {
		eyeSwapFactor = 0;
	}
	
	float2 uv_out;
	uv_out[0] = v_in.uv[0];	
	uv_out[1] = (2 * int(y/pixelSizeY)  + 1.5 - eyeSwapFactor)  / uv_size.y;
	
	float4 rgba = image.Sample(textureSampler, uv_out);
	return rgba;
}