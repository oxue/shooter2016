package hxblit;

@:shader({
     var input:{
          pos:Float2,
     };
	 var rel:Float4;
	 var reld:Float;
     function vertex (mproj:M44, cpos:Float4, radius:Float4) {
		  rel = pos.xyzw - cpos.xyzw;
		  out = pos.xyzw * mproj;
		  reld = radius.x;
     }
     function fragment (color:Float4) {
          var t = color * (1 - length(rel) / (reld));
		  //t = if (length(rel) <= 1.5) [1, 1, 1, 1] else t;
		  var g:Float4;
		  g.x = if (t.x >= 1) 1 else t.x;
		  g.y = if (t.y >= 1) 1 else t.y;
		  g.z = if (t.z >= 1) 1 else t.z;
		  g.w = if (t.w >= 1) 1 else t.w;
		  out = g;
     }
}) class LightShader extends format.hxsl.Shader {
}