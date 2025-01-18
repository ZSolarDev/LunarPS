package lunarps.renderer.backends.flixel;

import flixel.system.FlxAssets.FlxShader;

class CircleShader extends FlxShader
{
	@:glFragmentSource('
        #pragma header

        void main() {
            vec2 uv = openfl_TextureCoordv.xy;
            vec4 tex = texture2D (bitmap, uv);
            float d = 1.0 - step(0.5, distance(uv, vec2(0.5)));
        
            gl_FragColor = tex * vec4(d) * openfl_Alphav;
        }
    ')
	public function new()
	{
		super();
	}
}

class AlphaShader extends FlxShader
{
	public var shaderAlpha(default, set):Float = 0;

	@:glFragmentSource('
        #pragma header

        uniform float alphaVal;

        void main() {
            vec2 uv = openfl_TextureCoordv.xy;
            vec4 tex = texture2D(bitmap, uv);

            gl_FragColor = tex * (openfl_Alphav * alphaVal);
        }
    ')
	public function new(alpha:Float = 1)
	{
		super();
		shaderAlpha = alpha;
	}

	function set_shaderAlpha(val:Float):Float
	{
		shaderAlpha = val;
		data.alphaVal.value = [shaderAlpha];
		return shaderAlpha;
	}
}
