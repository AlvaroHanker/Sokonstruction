// Upgrade NOTE: upgraded instancing buffer 'CubeShader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CubeShader"
{
	Properties
	{
		_Albedo("Albedo", Color) = (0,0,0,0)
		_Emmisive("Emmisive", Color) = (0,0,0,0)
		_TextureMax("Texture Max", 2D) = "white" {}
		_OffsetVector("Offset Vector", Vector) = (0,0,0,0)
		_EmStrength("EmStrength", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureMax;
		uniform float2 _OffsetVector;

		UNITY_INSTANCING_BUFFER_START(CubeShader)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Albedo)
#define _Albedo_arr CubeShader
			UNITY_DEFINE_INSTANCED_PROP(float4, _Emmisive)
#define _Emmisive_arr CubeShader
			UNITY_DEFINE_INSTANCED_PROP(float, _EmStrength)
#define _EmStrength_arr CubeShader
		UNITY_INSTANCING_BUFFER_END(CubeShader)

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 _Albedo_Instance = UNITY_ACCESS_INSTANCED_PROP(_Albedo_arr, _Albedo);
			o.Albedo = _Albedo_Instance.rgb;
			float4 _Emmisive_Instance = UNITY_ACCESS_INSTANCED_PROP(_Emmisive_arr, _Emmisive);
			float2 uv_TexCoord1 = i.uv_texcoord * float2( 1,1 ) + _OffsetVector;
			float _EmStrength_Instance = UNITY_ACCESS_INSTANCED_PROP(_EmStrength_arr, _EmStrength);
			o.Emission = ( ( _Emmisive_Instance * tex2D( _TextureMax, uv_TexCoord1 ).a ) * _EmStrength_Instance ).rgb;
			o.Metallic = 0.5;
			o.Smoothness = 1.0;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
183;150;1553;849;1619.073;314.2864;1.089904;True;False
Node;AmplifyShaderEditor.Vector2Node;29;-1288.142,152.9704;Float;False;Property;_OffsetVector;Offset Vector;3;0;Create;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1020.043,33.63374;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-634.1924,-264.0356;Float;False;InstancedProperty;_Emmisive;Emmisive;1;0;Create;0,0,0,0;0.8382353,0.8382353,0.8382353,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-713.5577,-1.99465;Float;True;Property;_TextureMax;Texture Max;2;0;Create;59acb58d1cd1bda4cafddd0ee13ff140;59acb58d1cd1bda4cafddd0ee13ff140;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-254.9384,-140.1241;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-408.9909,150.4397;Float;False;InstancedProperty;_EmStrength;EmStrength;4;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-55.15973,-96.75119;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-50.63136,40.87885;Float;False;Constant;_Metallic;Metallic;5;1;[HDR];Create;0.5;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-72.76825,189.3523;Float;False;Constant;_Smoothness;Smoothness;3;1;[HDR];Create;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;30;-325.866,-415.0019;Float;False;InstancedProperty;_Albedo;Albedo;0;0;Create;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;255.708,-170.4467;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;CubeShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;1;29;0
WireConnection;20;1;1;0
WireConnection;4;0;3;0
WireConnection;4;1;20;4
WireConnection;31;0;4;0
WireConnection;31;1;32;0
WireConnection;0;0;30;0
WireConnection;0;2;31;0
WireConnection;0;3;6;0
WireConnection;0;4;7;0
ASEEND*/
//CHKSM=1C657E767EA1E82E12755AA450927BCA91E2C668