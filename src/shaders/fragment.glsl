uniform vec2 u_resolution;
uniform float u_time;

const int octaves = 6;
const float seed = 43758.5453123;
const float seed2 = 73156.8473192;


vec4 RGBtoCMYK(vec3 rgb) {
    float x = rgb.x;
    float y = rgb.y;
    float z = rgb.z;
    float k = min(1.0 - x, min(1.0 - y, 1.0 - z));
    vec3 cmy = vec3(0.0);
    float invK = 1.0 - k;
    if (invK != 0.0) {
        cmy.x = (1.0 - x - k);
        cmy.y = (1.0 - y - k) ;
        cmy.z = (1.0 - z - k);
    }
    return clamp(vec4(cmy, 1.), 0., 1.);
}
vec2 random2(vec2 st, float seed){
st = vec2( dot(st,vec2(127.1,311.7)),
          dot(st,vec2(269.5,183.3)) );
return -1.0 + 2.0*fract(sin(st)*seed);
}

// Value Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise(vec2 st, float seed) {
vec2 i = floor(st);
vec2 f = fract(st);

vec2 u = f*f*(3.0-2.0*f);

return mix( mix( dot( random2(i + vec2(0.0,0.0), seed ), f - vec2(0.0,0.0) ),
                  dot( random2(i + vec2(1.0,0.0), seed ), f - vec2(1.0,0.0) ), u.x),
            mix( dot( random2(i + vec2(0.0,1.0), seed ), f - vec2(0.0,1.0) ),
                  dot( random2(i + vec2(1.0,1.0), seed ), f - vec2(1.0,1.0) ), u.x), u.y);
}

float fbm1(in vec2 _st, float seed) {
float v = 0.0;
float a = 0.5;
vec2 shift = vec2(100.0);
// Rotate to reduce axial bias
mat2 rot = mat2(cos(0.5), sin(0.5),
              -sin(0.5), cos(0.50));
for (int i = 0; i < octaves; ++i) {
  v += a * noise(_st, seed);
  _st = rot * _st * 2.0 + shift;
  a *= 0.4;
}
return v;
}

float pattern(vec2 uv, float seed, float time, inout vec2 q, inout vec2 r) {

q = vec2( fbm1( uv + vec2(0.0,0.0), seed ),
              fbm1( uv + vec2(5.2,1.3), seed ) );

r = vec2( fbm1( uv + 4.0*q + vec2(1.7 - time / 2.,9.2), seed ),
              fbm1( uv + 4.0*q + vec2(8.3 - time / 2.,2.8), seed ) );

vec2 s = vec2( fbm1( uv + 4.0*r + vec2(21.7 - time / 2.,90.2), seed ),
              fbm1( uv + 4.0*r + vec2(80.3 - time / 2.,20.8), seed ) );

vec2 t = vec2( fbm1( uv + 4.0*s + vec2(121.7 - time / 2.,90.2), seed ),
              fbm1( uv + 4.0*s + vec2(180.3 - time / 2.,20.8), seed ) );

float rtn = fbm1( uv + 4.0*t, seed );

rtn = clamp(rtn, 0., .5); // This shit is magic!

return rtn;
}

void main() {
vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy) / u_resolution.y;
uv *= 1. + dot(uv, uv)*.3;


float time = u_time / 20.;

float rotSpeed = 0.3 * time;


mat2 rot = mat2(cos(rotSpeed), sin(rotSpeed),
              -sin(rotSpeed), cos(rotSpeed));
uv = rot * uv;
uv *= 1.4 + sin(time) * .3;
uv.x -= time;

vec2 q = vec2(0.,0.);
vec2 r = vec2(0.,0.);

// vec3 colour = vec3(pattern(uv, seed, time, q, r));
// float QR = clamp(dot(q, r), -1., 1.);
// colour = vec3(
//   (q.x + q.y) + QR * 60., 
//   (q.y) * 10. + QR * 95., 
//   r.x * r.y + QR * 50.
// );
// colour += .0;
// colour = clamp(colour, 0.1, 0.99);
// gl_FragColor = vec4(colour, 0.99);
// gl_FragColor = vec4(RGBtoCMYK(colour));
// gl_FragColor = clamp( gl_FragColor, 0., 1.);

// vec3 colour = vec3(pattern(uv, seed, time, q, r));
// float QR = clamp(dot(q, r), -1., 1.);
// colour += vec3(
// (q.x + q.y) + QR * 30.,
// QR * 15.,
// r.x * r.y + QR * 5.
// );
// colour += .5;
// colour = clamp(colour, 0.05, 0.8);
// gl_FragColor = vec4(colour, 0.99);
vec3 colour = vec3(pattern(uv, seed, time, q, r));
// float QR = clamp(dot(q, r), -1., 1.);
float QR = clamp(dot(q, r), 0., 1.);
float RQ = clamp(dot(r, q), 0., 1.);
colour = colour = clamp( 1. - colour, 0., 1.);
colour -= clamp(vec3(
 RQ * 10.,
 0.,
 0.
) * cos(time *3.), 0., 1.);
colour -= clamp(vec3(
  0.,
  RQ * 5.,
  0.
) * sin(time *3.), 0., 1.);
colour = clamp(colour, 0., 1.);
gl_FragColor = vec4(colour, 1.);
}