#ifdef GL_ES
// define default precision for float, vec, mat.
precision highp float;
#endif

varying vec2        textureCoordinate;
uniform sampler2D   image;
uniform float       rand;

void main (void)
{
    vec2 texCoord = vec2(textureCoordinate.x , textureCoordinate.y);
    
    /*vec4 col = texture2D(image,texCoord);
    vec4 col_r = texture2D(image,texCoord + vec2(-35.0*rand,0));
    vec4 col_l = texture2D(image,texCoord + vec2( 35.0*rand,0));
    vec4 col_g = texture2D(image,texCoord + vec2( -7.5*rand,0));

    col.b = col.b + col_r.b*max(1.0,sin(textureCoordinate.y*1.2)*2.5)*rand;
    col.r = col.r + col_l.r*max(1.0,sin(textureCoordinate.y*1.2)*2.5)*rand;
    col.g = col.g + col_g.g*max(1.0,sin(textureCoordinate.y*1.2)*2.5)*rand;*/
    
    
    vec4 col = texture2D(image,texCoord);
    vec4 col_r = texture2D(image,texCoord + vec2(-0.35*rand,0));
    vec4 col_l = texture2D(image,texCoord + vec2(0.35*rand,0));
    vec4 col_g = texture2D(image,texCoord + vec2(-0.075*rand,0));
    
    col.b = col.b + col_r.b*max(1.0,sin(textureCoordinate.y)*0.25)*rand;
    col.r = col.r + col_l.r*max(1.0,sin(textureCoordinate.y)*0.25)*rand;
    col.g = col.g + col_g.g*max(1.0,sin(textureCoordinate.y)*0.25)*rand;

    gl_FragColor.rgba = col.rgba;
}
