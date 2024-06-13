Shader "Tutorials/5-1"
{
	Properties
	{
		_BaseColor ("Base Color", Color) = (1, 1, 1, 1)
		_BaseTex ("Base Texture", 2D) = "White" {} // Braces are required, I assume for syntax reasons | 2D types are represented in a 2D array of colors. Will be using "sampler2D"
	}
	SubShader
	{
		Tags 
		{
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
		}

		Pass {
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct VertexInput { //appdata
				float4 positionOS : Position;
				float2 uv : TEXCOORD0;
			};

			struct VertexOutput { //v2f
				float4 positionCS : SV_Position;
				float2 uv : TEXCOORD0;
			};

			sampler2D _BaseTex;
			float4 _BaseTex_ST; // Optional varible normally but must be defined if using the TRANSFORM_TEX macro which auto applies transforms
			float4 _BaseColor;

			VertexOutput vert (VertexInput v) { // This setup in this shader allows us to access the UV coords in the fragment shader //vertex coords
				VertexOutput o;
				o.positionCS = UnityObjectToClipPos(v.positionOS);
				o.uv = TRANSFORM_TEX(v.uv, _BaseTex);
				return o;
			};

			float4 frag (VertexOutput i) : SV_Target { // color
				float4 textureSample = tex2D(_BaseTex, i.uv); // samples color from the _baseTex based on the vertex input (i.uv)

				return textureSample * _BaseColor;
			};

			ENDHLSL
		}
	}
}
/*
-MISC-
Pixel - Picture element
Texel - Texture element

texture2D's have optional variables called texturename_ST, texturename_TexelSize, and texturename_HDR
*/
