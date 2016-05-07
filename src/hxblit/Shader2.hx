package hxblit;

@:shader({
     var input:{
          pos:Float2,
          uv:Float2
     };
     var tuv:Float2;
     function vertex (mproj:M44) {
          out = pos.xyzw * mproj;
          tuv = uv;
     }
     function fragment (tex:Texture) {
          out = tex.get(tuv,clamp,nearest);
     }
}) class Shader2 extends format.hxsl.Shader {
}