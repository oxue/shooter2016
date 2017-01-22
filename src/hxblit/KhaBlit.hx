package hxblit;
import haxe.ds.Vector;
import kha.Color;
import kha.Image;
import kha.Shaders;
import kha.graphics4.BlendingOperation;
import kha.graphics4.CompareMode;
import kha.graphics4.Graphics;
import kha.graphics4.IndexBuffer;
import kha.graphics4.PipelineState;
import kha.graphics4.Usage;
import kha.graphics4.VertexBuffer;
import kha.graphics4.VertexData;
import kha.graphics4.VertexStructure;
import kha.math.FastMatrix3;
import kha.math.FastMatrix4;

/**
 * ...
 * @author ...
 */
class KhaBlit
{
	public static var contextG4:Graphics;
	public static var currentPipelineState:PipelineState;
	public static var KHBTex2PipelineState:Tex2PipelineState;
	
	public static var width:Int;
	public static var height:Int;
	
	public static var vertices:Array<Float>;
	public static var indices:Array<UInt>;
	
	public static var matrix2:FastMatrix4;
	
	public static var data32PerVertex:Int;
	
	public static var vertexBufferMap:Map<Int,VertexBuffer>;
	public static var indexBufferMap:Map<Int,IndexBuffer>;
	
	public static function init(_width:Int = 800, _height:Int = 600, _zoom:Int = 1){
		trace("kb init 2");
		width = _width;
		height = _height;
		//atlas stuff
		currentPipelineState = new PipelineState();
		var structure = new VertexStructure();
		structure.add("pos", VertexData.Float3);
		currentPipelineState.inputLayout = [structure]; 
		currentPipelineState.fragmentShader = Shaders.simple_frag;
		currentPipelineState.vertexShader = Shaders.simple_vert;
		currentPipelineState.compile();

		matrix2 = FastMatrix4.identity();
		matrix2 = (FastMatrix4.translation( -_width / (2 * _zoom), -_height / (2 * _zoom), 0).multmat(matrix2));
		matrix2 = (FastMatrix4.scale((2 * _zoom) / _width, -(2 * _zoom) / _height, -1).multmat(matrix2));
		matrix2 = (FastMatrix4.translation((2 *_zoom)/_width, (2 *_zoom)/_height, 1).multmat(matrix2));
		
		vertices = new Array<Float>();
		indices = new Array<UInt>();
		
		// looks like this can be deprecated
		//data32PerVertex = 4;
		
		vertexBufferMap = new Map<Int,VertexBuffer>();
		indexBufferMap = new Map<Int,IndexBuffer>();
		
		KHBTex2PipelineState = new Tex2PipelineState();
		
		setPipeline(KHBTex2PipelineState);
	}
	
	static public function setContext(g4:Graphics){
		contextG4 = g4;
	}
	
	static public function clear(_r:Float = 1, _g:Float = 1, _b:Float = 1, _a:Float = 1, _d:Float = 1, _s:UInt = 1):Void
	{
		contextG4.clear(Color.fromFloats(_r, _g, _b, _a), _d, _s);
	}
	
	static public function setPipeline(_pipeline:PipelineState)
	{
		currentPipelineState = _pipeline;
		var bpv:Int = _pipeline.inputLayout[0].byteSize();
		if (!vertexBufferMap.exists(bpv)){
			vertexBufferMap.set(
			bpv, new VertexBuffer(16, currentPipelineState.inputLayout[0], Usage.StaticUsage));
		}
	}
	
	static public function setUniformMatrix4(_name:String, _matrix:FastMatrix4)
	{
		contextG4.setMatrix(currentPipelineState.getConstantLocation(_name), _matrix);
	}
	
	static public function setUniformTexture(_name:String, _texture:Image) 
	{
		contextG4.setTexture(currentPipelineState.getConstantLocation(_name), _texture);
	}
	
	static public function blit(_s2:Surface2, _x:Int, _y:Int):Void
	{
		vertices[vCounter] = (_x);
		
		vCounter ++;
		vertices[vCounter] = (_y);
		
		vCounter++;
		vertices[vCounter] = (_s2.vx1);
		
		vCounter++;
		vertices[vCounter] = (_s2.vy1);
		
		vCounter++;
		vertices[vCounter] = (_x + _s2.width);
		vCounter++;
		vertices[vCounter] = (_y);
		vCounter++;
		vertices[vCounter] = (_s2.vx2);
		vCounter++;
		vertices[vCounter] = (_s2.vy2);
		
		vCounter++;
		vertices[vCounter] = (_x);
		
		vCounter++;
		vertices[vCounter] = (_y + _s2.height);
		
		vCounter++;
		vertices[vCounter] = (_s2.vx3);
		
		vCounter ++;
		vertices[vCounter] = (_s2.vy3);
		
		vCounter ++;
		vertices[vCounter] = (_x + _s2.width);
		
		vCounter++;
		vertices[vCounter] = (_y + _s2.height);
		
		vCounter++;
		vertices[vCounter] = (_s2.vx4);
	
		vCounter++;
		vertices[vCounter] = (_s2.vy4);
		vCounter ++;
		
		indices[numIndices] = iCounter;
		numIndices++;
		indices[numIndices] = iCounter + 1;
		numIndices++;
		indices[numIndices] = iCounter + 3;
		numIndices++;
		indices[numIndices] = iCounter + 0;
		numIndices++;
		indices[numIndices] = iCounter + 3;
		numIndices++;
		indices[numIndices] = iCounter + 2;
		numIndices++;
		iCounter += 4;
	}
	
}