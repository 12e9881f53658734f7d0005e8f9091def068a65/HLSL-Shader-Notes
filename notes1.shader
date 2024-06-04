Shader "shader2/Tutorial" {
    Properties {
        _BaseColor("Base Color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
            "Queue" = "Geometry"
        }
        LOD 200
        Pass // Pass blocked used when we want more control. Surface shaders typically dont use a Pass block.
        {
            
            HLSLPROGRAM // Proper syntax, (Not required I think)
                #pragma vertex vert 
                #pragma fragment frag

                #include "UnityCG.cginc" // This is the standard shader lib for the built in rendering pipeline

                // Structs to pull and pass data to and from the vertex shader
                struct VertexInput
                {
                    float4 positionOS : POSITION; // Input type
                };

                struct VertexOutput // AKA v2f (vertex to fragment)
                {
                    float4 positionCS : SV_POSITION; // Output type
                };

                // Unity can generate shader varaibles that we dont have to declare
                // inside Properties or pass the data to the shader ourselves with scripting.
                // EX _CameraDepthTexture

                float4 _BaseColor;

                VertexOutput vert (VertexInput v) // Vertex shader
                {
                    VertexOutput o; // o has the property positionCS (Type:float4) because of the struct
                    o.positionCS = UnityObjectToClipPos(v.positionOS); // Takes object-space position as input and returns the clip-space poition as output.
                    return o;
                }

                // Included "VertexOuput i" because unity automatically uses the varible with SV_POSITION semantic to rasterize
                // the object into fragments
                float4 frag (VertexOutput i) : SV_Target // Fragment shader
                {
                    return _BaseColor; 
                }
            ENDHLSL
        }
    }
    //FallBack "Diffuse" //pg 68
}
