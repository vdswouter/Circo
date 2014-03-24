#ifdef GL_ES
// define default precision for float, vec, mat.
precision highp float;
#endif

varying vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform float contrast;
uniform float   alpha;


void main()
{
    vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    
    //gl_FragColor = vec4(((textureColor.rgb - vec3(0.5)) * contrast + vec3(0.5)), textureColor.w);
    
    gl_FragColor = vec4(((textureColor.rgb - vec3(0.5)) * contrast + vec3(0.5)), alpha);
}