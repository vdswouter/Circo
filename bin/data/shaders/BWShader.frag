#ifdef GL_ES
// define default precision for float, vec, mat.
precision highp float;
#endif

uniform sampler2D src_tex_unit0;
uniform float   alpha;

varying vec2 texCoordVarying;


const highp vec3 W = vec3(0.2125, 0.7154, 0.0721);

void main(){
	
    
    lowp vec4 textureColor = texture2D(src_tex_unit0, texCoordVarying);
    
    float luminance = dot(textureColor.rgb, W);
    
    gl_FragColor = vec4(vec3(luminance), alpha);

}