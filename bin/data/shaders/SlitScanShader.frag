#ifdef GL_ES
//define default precision for float, vec, mat.
precision highp float;
#endif

varying vec2        textureCoordinate;
uniform sampler2D   inputImageTexture;
uniform float       val3;
uniform float       xory;


void main() {
    
    float slit_h = val3;
    
    vec2 texCoord = vec2(0,0);
    
    if (xory>0.5) {
    
     texCoord = vec2(floor(textureCoordinate.x/slit_h)*slit_h ,textureCoordinate.y);
    } else {
        texCoord = vec2(textureCoordinate.x , floor(textureCoordinate.y/slit_h)*slit_h);
    }
    vec4 textureColor = texture2D(inputImageTexture, texCoord);
    
    gl_FragColor = textureColor;
}