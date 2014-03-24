attribute vec4 position;
attribute vec2 texcoord;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

varying vec2 textureCoordinate;

void main(){
    
	//get our current vertex position so we can modify it
	vec4 pos = projectionMatrix * modelViewMatrix * position;
	
	
	gl_Position = pos;
    
	textureCoordinate = texcoord;
}
