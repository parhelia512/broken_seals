tool
extends Reference

const Commons = preload("res://addons/mat_maker_gd/nodes/common/commons.gd")

#----------------------
#sdarc.mmg
#An arc as a signed distance function

#"outputs": [
#{
#	"longdesc": "The arc as a signed distance function",
#	"sdf2d": "sdArc($uv-vec2(0.5), mod($a1, 360.0)*0.01745329251, mod($a2, 360.0)*0.01745329251, $r1, $r2)",
#	"shortdesc": "Output",
#	"type": "sdf2d"
#}
#],
#"parameters": [
#{
#	"control": "Angle1.a",
#	"default": 0,
#	"label": "Angle 1",
#	"longdesc": "The first angle of the arc",
#	"max": 180,
#	"min": -180,
#	"name": "a1",
#	"shortdesc": "Angle1",
#	"step": 1,
#	"type": "float"
#},
#{
#	"control": "Angle2.a",
#	"default": 0,
#	"label": "Angle 2",
#	"longdesc": "The second angle of the arc",
#	"max": 180,
#	"min": -180,
#	"name": "a2",
#	"shortdesc": "Angle2",
#	"step": 1,
#	"type": "float"
#},
#{
#	"control": "Radius1.r",
#	"default": 0.5,
#	"label": "Radius",
#	"longdesc": "The radius of the arc",
#	"max": 1,
#	"min": 0,
#	"name": "r1",
#	"shortdesc": "Radius",
#	"step": 0.01,
#	"type": "float"
#},
#{
#	"control": "Radius11.r",
#	"default": 0.1,
#	"label": "Width",
#	"longdesc": "The width of the shape around the arc",
#	"max": 1,
#	"min": 0,
#	"name": "r2",
#	"shortdesc": "Width",
#	"step": 0.01,
#	"type": "float"
#}
#]

#----------------------
#sdboolean.mmg
#Performs a boolean operation (union, intersection or difference) between two shapes

#"inputs": [
#{
#	"default": "0.0",
#	"label": "",
#	"longdesc": "The first shape, defined as a signed distance function",
#	"name": "in1",
#	"shortdesc": "Input1",
#	"type": "sdf2d"
#},
#{
#	"default": "0.0",
#	"label": "",
#	"longdesc": "The second shape, defined as a signed distance function",
#	"name": "in2",
#	"shortdesc": "Input2",
#	"type": "sdf2d"
#}
#],
#"outputs": [
#{
#	"longdesc": "The shape generated by the boolean operation",
#	"sdf2d": "$op $in1($uv), $in2($uv))",
#	"shortdesc": "Output",
#	"type": "sdf2d"
#}
#],
#"parameters": [
#{
#	"default": 2,
#	"label": "",
#	"longdesc": "The operation performed by this node",
#	"name": "op",
#	"shortdesc": "Operation",
#	"type": "enum",
#	"values": [
#		{
#		"name": "Union",
#		"value": "min("
#		},
#		{
#		"name": "Subtraction",
#		"value": "max(-"
#		},
#		{
#		"name": "Intersection",
#		"value": "max("
#		}
#	]
#}
#],

#----------------------
#sdbox.mmg
#A rectangle described as a signed distance function

#		"code": "vec2 $(name_uv)_d = abs($uv-vec2($cx+0.5, $cy+0.5))-vec2($w, $h);",
#		"outputs": [
#			{
#				"longdesc": "The generated signed distance function",
#				"sdf2d": "length(max($(name_uv)_d,vec2(0)))+min(max($(name_uv)_d.x,$(name_uv)_d.y),0.0)",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "Rect1.x",
#				"default": 0.5,
#				"label": "Width",
#				"longdesc": "The width of the box",
#				"max": 1,
#				"min": 0,
#				"name": "w",
#				"shortdesc": "Width",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "Rect1.y",
#				"default": 1,
#				"label": "Height",
#				"longdesc": "The height of the box",
#				"max": 1,
#				"min": 0,
#				"name": "h",
#				"shortdesc": "Height",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.x",
#				"default": 0,
#				"label": "Center X",
#				"longdesc": "The position of the center of the box on the X axis",
#				"max": 1,
#				"min": -1,
#				"name": "cx",
#				"shortdesc": "Center.x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.y",
#				"default": 0,
#				"label": "Center Y",
#				"longdesc": "The position of the center of the box on the Y axis",
#				"max": 1,
#				"min": -1,
#				"name": "cy",
#				"shortdesc": "Center.y",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdcircle.mmg
#A circle described as a signed distance function

#		"outputs": [
#			{
#				"longdesc": "The generated signed distance function",
#				"sdf2d": "length($uv-vec2($cx+0.5, $cy+0.5))-$r",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "Radius1.r",
#				"default": 0.5,
#				"label": "Radius",
#				"longdesc": "The radius of the circle",
#				"max": 1,
#				"min": 0,
#				"name": "r",
#				"shortdesc": "Radius",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.x",
#				"default": 0,
#				"label": "Center X",
#				"longdesc": "The position of the center on the X axis",
#				"max": 1,
#				"min": -1,
#				"name": "cx",
#				"shortdesc": "Center.x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.y",
#				"default": 0,
#				"label": "Center Y",
#				"longdesc": "The position of the center on the Y axis",
#				"max": 1,
#				"min": -1,
#				"name": "cy",
#				"shortdesc": "Center.y",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdcirclerepeat.mmg
#Repeats its input shape around a circle

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The input shape, defined as a signed distance function",
#				"name": "in",
#				"shortdesc": "Input",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The shape generated by the repeat operation",
#				"sdf2d": "$in(circle_repeat_transform_2d($uv-vec2(0.5), $c)+vec2(0.5))",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "None",
#				"default": 4,
#				"label": "",
#				"longdesc": "The number of repetitions of the input shape around the circle",
#				"max": 32,
#				"min": 1,
#				"name": "c",
#				"shortdesc": "Count",
#				"step": 1,
#				"type": "float"
#			}
#		],
		

#----------------------
#sdelongation.mmg

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"name": "in",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"sdf2d": "$in($uv-clamp($uv-vec2(0.5), -vec2($x, $y), vec2($x, $y)))",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "Rect1.x",
#				"default": 0,
#				"label": "X",
#				"max": 1,
#				"min": 0,
#				"name": "x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "Rect1.y",
#				"default": 0,
#				"label": "Y",
#				"max": 1,
#				"min": 0,
#				"name": "y",
#				"step": 0.01,
#				"type": "float"
#			}
#		]

#----------------------
#sdline.mmg
#A line or a capsule shape described as a signed distance function

#		"code": "vec2 $(name_uv)_sdl = sdLine($uv, vec2($ax+0.5, $ay+0.5), vec2($bx+0.5, $by+0.5));",
#		"outputs": [
#			{
#				"longdesc": "The shape as signed distance function",
#				"sdf2d": "$(name_uv)_sdl.x-$r*$profile($(name_uv)_sdl.y)",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "P1.x",
#				"default": 0,
#				"label": "A X",
#				"longdesc": "The position on the X axis of the first point of the line",
#				"max": 1,
#				"min": -1,
#				"name": "ax",
#				"shortdesc": "A.x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.y",
#				"default": 0,
#				"label": "A Y",
#				"longdesc": "The position on the Y axis of the first point of the line",
#				"max": 1,
#				"min": -1,
#				"name": "ay",
#				"shortdesc": "A.y",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P2.x",
#				"default": 1,
#				"label": "B X",
#				"longdesc": "The position on the X axis of the second point of the line",
#				"max": 1,
#				"min": -1,
#				"name": "bx",
#				"shortdesc": "B.x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P2.y",
#				"default": 1,
#				"label": "B Y",
#				"longdesc": "The position on the Y axis of the second point of the line",
#				"max": 1,
#				"min": -1,
#				"name": "by",
#				"shortdesc": "B.y",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "Radius1.r",
#				"default": 0,
#				"label": "Width",
#				"longdesc": "The width of the capsule shape around the line",
#				"max": 1,
#				"min": 0,
#				"name": "r",
#				"shortdesc": "Width",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"default": {
#					"points": [
#						{
#							"ls": 0,
#							"rs": 0,
#							"x": 0,
#							"y": 1
#						},
#						{
#							"ls": 0,
#							"rs": 0,
#							"x": 1,
#							"y": 1
#						}
#					],
#					"type": "Curve"
#				},
#				"label": "Profile",
#				"name": "profile",
#				"type": "curve"
#			}
#		],

#----------------------
#sdmorph.mmg
#Morphs between 2 input shapes

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The first shape, defined as a signed distance function",
#				"name": "in1",
#				"shortdesc": "Input1",
#				"type": "sdf2d"
#			},
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The second shape, defined as a signed distance function",
#				"name": "in2",
#				"shortdesc": "Input2",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The generated hybrid shape",
#				"sdf2d": "mix($in1($uv), $in2($uv), $amount)",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "None",
#				"default": 0.5,
#				"label": "",
#				"longdesc": "The amount of the second input in the result",
#				"max": 1,
#				"min": 0,
#				"name": "amount",
#				"shortdesc": "Amount",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdngon.mmg (inc sdrotate.mmg, sdcirclerepeat.mmg)
#An n-gon described as a signed distance function

#		"outputs": [
#			{
#				"longdesc": "The n-gon as a signed distance function",
#				"sdf2d": "sdNgon(sdf2d_rotate($uv-vec2($cx, $cy), $rot*0.01745329251-1.57079632679)-vec2(0.5), $r, $n)",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "None",
#				"default": 3,
#				"label": "N",
#				"longdesc": "The number of sides of the n-gon",
#				"max": 12,
#				"min": 3,
#				"name": "n",
#				"shortdesc": "N",
#				"step": 1,
#				"type": "float"
#			},
#			{
#				"control": "Radius1.r",
#				"default": 0.5,
#				"label": "Radius",
#				"longdesc": "The radius of the n-gon",
#				"max": 1,
#				"min": 0,
#				"name": "r",
#				"shortdesc": "Radius",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "Radius1.a",
#				"default": 0,
#				"label": "Rotation",
#				"longdesc": "The rotation of the n-gon",
#				"max": 180,
#				"min": -180,
#				"name": "rot",
#				"shortdesc": "Rotation",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.x",
#				"default": 0,
#				"label": "Center X",
#				"longdesc": "The position of the center on the X axis",
#				"max": 0.5,
#				"min": -0.5,
#				"name": "cx",
#				"shortdesc": "Center.x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.y",
#				"default": 0,
#				"label": "Center Y",
#				"longdesc": "The position of the center on the Y axis",
#				"max": 0.5,
#				"min": -0.5,
#				"name": "cy",
#				"shortdesc": "Center.y",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdpolygon.mmg
#A polygon as a signed distance function

#		"instance": "float sdPolygon_$(name)(vec2 p) {vec2 v[] = $polygon;int l = v.length();    float d = dot(p-v[0],p-v[0]);    float s = 1.0;int j = l-1;    for(int i=0; i<l; i++)    {        vec2 e = v[j] - v[i];        vec2 w =    p - v[i];        vec2 b = w - e*clamp( dot(w,e)/dot(e,e), 0.0, 1.0 );        d = min( d, dot(b,b) );        bvec3 c = bvec3(p.y>=v[i].y,p.y<v[j].y,e.x*w.y>e.y*w.x);        if( all(c) || all(not(c)) ) s*=-1.0;j=i;    }    return s*sqrt(d);}",
#		"outputs": [
#			{
#				"longdesc": "The polygon as a signed distance function",
#				"sdf2d": "sdPolygon_$(name)($uv)",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"default": {
#					"points": [
#						{
#							"x": 0.2,
#							"y": 0.2
#						},
#						{
#							"x": 0.4,
#							"y": 0.7
#						},
#						{
#							"x": 0.7,
#							"y": 0.4
#						}
#					],
#					"type": "Polygon"
#				},
#				"label": "",
#				"longdesc": "The polygon to be drawn",
#				"name": "polygon",
#				"shortdesc": "Polygon",
#				"type": "polygon"
#			}
#		],

#----------------------
#sdrepeat.mmg
#Repeats its input shape on a grid.This node does not support overlapping between instances.

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The input shape, defined as a signed distance function",
#				"name": "in",
#				"shortdesc": "Input",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The shape generated by the repeat operation",
#				"sdf2d": "$in(repeat_2d($uv, vec2(1.0/$rx, 1.0/$ry), float($seed), $r))",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "None",
#				"default": 4,
#				"label": "X",
#				"longdesc": "The number of columns in the grid",
#				"max": 32,
#				"min": 1,
#				"name": "rx",
#				"shortdesc": "Columns",
#				"step": 1,
#				"type": "float"
#			},
#			{
#				"control": "None",
#				"default": 4,
#				"label": "Y",
#				"longdesc": "The number of lines in the grid",
#				"max": 32,
#				"min": 1,
#				"name": "ry",
#				"shortdesc": "Lines",
#				"step": 1,
#				"type": "float"
#			},
#			{
#				"control": "None",
#				"default": 0.5,
#				"label": "R",
#				"longdesc": "The amount of random rotation on each instance of the input shape",
#				"max": 1,
#				"min": 0,
#				"name": "r",
#				"shortdesc": "Rotation",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdrhombus.mmg
#A rhombus described as a signed distance function

#		"outputs": [
#			{
#				"longdesc": "The rhombus as a signed distance function",
#				"sdf2d": "sdRhombus($uv-vec2($cx+0.5, $cy+0.5), vec2($w, $h))",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "Rect1.x",
#				"default": 0.5,
#				"label": "Width",
#				"longdesc": "The width of the rhombus",
#				"max": 1,
#				"min": 0,
#				"name": "w",
#				"shortdesc": "Width",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "Rect1.y",
#				"default": 1,
#				"label": "Height",
#				"longdesc": "The height of the rhombus",
#				"max": 1,
#				"min": 0,
#				"name": "h",
#				"shortdesc": "Height",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.x",
#				"default": 0,
#				"label": "Center X",
#				"longdesc": "The position of the center on the X axis",
#				"max": 1,
#				"min": -1,
#				"name": "cx",
#				"shortdesc": "Center.x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.y",
#				"default": 0,
#				"label": "Center Y",
#				"longdesc": "The position of the center on the Y axis",
#				"max": 1,
#				"min": -1,
#				"name": "cy",
#				"shortdesc": "Center.y",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdrotate.mmg
#Rotates its input shape described as a signed distance function

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The input shape, defined as a signed distance function",
#				"name": "in",
#				"shortdesc": "Input",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The rotated shape",
#				"sdf2d": "$in(sdf2d_rotate($uv, $a*0.01745329251))",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "Radius1.a",
#				"default": 0,
#				"label": "",
#				"longdesc": "The rotation angle",
#				"max": 180,
#				"min": -180,
#				"name": "a",
#				"shortdesc": "Angle",
#				"step": 1,
#				"type": "float"
#			}
#		],

#----------------------
#sdroundedshape.mmg
#Dilates an input shape into a rounded shape

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The input shape, defined as a signed distance function",
#				"name": "in",
#				"shortdesc": "Input",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The shape generated by the operation",
#				"sdf2d": "$in($uv)-$r",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "None",
#				"default": 0,
#				"label": "",
#				"longdesc": "The length of the dilate operation",
#				"max": 1,
#				"min": 0,
#				"name": "r",
#				"shortdesc": "Radius",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdscale.mmg
#Scales its input shape described as a signed distance function

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The input shape, defined as a signed distance function",
#				"name": "in",
#				"shortdesc": "Input",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The generated scaled shape",
#				"sdf2d": "$in(($uv-vec2(0.5))/$s+vec2(0.5))*$s",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "Scale1.x",
#				"default": 1,
#				"label": "",
#				"longdesc": "The scale of the transform",
#				"max": 5,
#				"min": 0,
#				"name": "s",
#				"shortdesc": "Scale",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdshow.mmg
#Creates a greyscale image from a shape described as a 2D Signed Distance Function

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The input shape",
#				"name": "in",
#				"shortdesc": "Input",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"f": "clamp($base-$in($uv)/max($bevel, 0.00001), 0.0, 1.0)",
#				"longdesc": "Shows the shape as a greyscale image",
#				"shortdesc": "Output",
#				"type": "f"
#			}
#		],
#		"parameters": [
#			{
#				"control": "None",
#				"default": 0,
#				"label": "Bevel",
#				"longdesc": "The width of the gradient at the edges of the shape",
#				"max": 1,
#				"min": 0,
#				"name": "bevel",
#				"shortdesc": "Bevel",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "None",
#				"default": 0,
#				"label": "Base",
#				"longdesc": "The base value of the output",
#				"max": 1,
#				"min": 0,
#				"name": "base",
#				"shortdesc": "Base",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdsmoothboolean.mmg
#Performs a smooth boolean operation (union, intersection or difference) between two shapes

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The first shape, defined as a signed distance function",
#				"name": "in1",
#				"shortdesc": "Input1",
#				"type": "sdf2d"
#			},
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The second shape, defined as a signed distance function",
#				"name": "in2",
#				"shortdesc": "Input2",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The shape generated by the boolean operation",
#				"sdf2d": "sdSmooth$op($in1($uv), $in2($uv), $k)",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"default": 0,
#				"label": "",
#				"longdesc": "The operation performed by this node",
#				"name": "op",
#				"shortdesc": "Operation",
#				"type": "enum",
#				"values": [
#					{
#						"name": "Union",
#						"value": "Union"
#					},
#					{
#						"name": "Subtraction",
#						"value": "Subtraction"
#					},
#					{
#						"name": "Intersection",
#						"value": "Intersection"
#					}
#				]
#			},
#			{
#				"control": "None",
#				"default": 0,
#				"label": "",
#				"longdesc": "The smoothness of the boolean operation",
#				"max": 1,
#				"min": 0,
#				"name": "k",
#				"shortdesc": "Smoothness",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

#----------------------
#sdtranslate.mmg
#Translates its input shape described as signed distance function

#		"inputs": [
#			{
#				"default": "0.0",
#				"label": "",
#				"longdesc": "The input shape, defined as a signed distance function",
#				"name": "in",
#				"shortdesc": "Input",
#				"type": "sdf2d"
#			}
#		],
#		"outputs": [
#			{
#				"longdesc": "The translated shape",
#				"sdf2d": "$in($uv-vec2($x, $y))",
#				"shortdesc": "Output",
#				"type": "sdf2d"
#			}
#		],
#		"parameters": [
#			{
#				"control": "P1.x",
#				"default": 0,
#				"label": "X",
#				"longdesc": "The translation along the X axis",
#				"max": 1,
#				"min": -1,
#				"name": "x",
#				"shortdesc": "Translate.x",
#				"step": 0.01,
#				"type": "float"
#			},
#			{
#				"control": "P1.y",
#				"default": 0,
#				"label": "Y",
#				"longdesc": "The translation along the Y axis",
#				"max": 1,
#				"min": -1,
#				"name": "y",
#				"shortdesc": "Translate.y",
#				"step": 0.01,
#				"type": "float"
#			}
#		],

static func sdf_show(val : float, bevel : float) -> Color:
	var f : float = clamp(-val / max(bevel, 0.00001), 0.0, 1.0);
	
	return Color(f, f, f, 1)

static func sdf_circle(uv : Vector2, c : Vector2, r : float) -> float:
	c.x += 0.5
	c.y += 0.5
	
	return (uv - c).length() - r;

static func sdf_box(uv : Vector2, c : Vector2, wh : Vector2) -> float:
	c.x += 0.5
	c.y += 0.5
	
	var d : Vector2 = Commons.absv2(uv - c) - wh
	
	return Commons.maxv2(d, Vector2(0, 0)).length() + min(max(d.x, d.y), 0.0)

static func sdf_line(uv : Vector2, a : Vector2, b : Vector2, r : float) -> float:
	a.x += 0.5
	a.y += 0.5
	
	b.x += 0.5
	b.y += 0.5
	
	return sdLine(uv, a, b) - r


static func sdf_rhombus(uv : Vector2, c : Vector2, wh : Vector2) -> float:
	c.x += 0.5
	c.y += 0.5
	
	return sdRhombus(uv - c, wh);


static func sdf_arc(uv : Vector2, a : Vector2, r : Vector2) -> float:
	return sdArc(uv - Vector2(0.5, 0.5), Commons.modf(a.x, 360.0) * 0.01745329251, Commons.modf(a.y, 360.0)*0.01745329251, r.x, r.y)

#float sdr_ndot(vec2 a, vec2 b) { 
#	return a.x*b.x - a.y*b.y; 
#}

static func sdr_ndot(a : Vector2, b : Vector2) -> float:
	return a.x * b.x - a.y * b.y;

#float sdRhombus(in vec2 p, in vec2 b) {
#	vec2 q = abs(p);
#	float h = clamp((-2.0*sdr_ndot(q,b)+sdr_ndot(b,b))/dot(b,b),-1.0,1.0);
#	float d = length( q - 0.5*b*vec2(1.0-h,1.0+h) );
#	return d * sign( q.x*b.y + q.y*b.x - b.x*b.y );
#}

static func sdRhombus(p : Vector2, b : Vector2) -> float:
	var q : Vector2 = Commons.absv2(p);
	var h : float = clamp((-2.0 * sdr_ndot(q,b) + sdr_ndot(b,b)) / b.dot(b), -1.0, 1.0);
	var d : float = ( q - 0.5*b * Vector2(1.0-h, 1.0+h)).length()
	return d * sign(q.x*b.y + q.y*b.x - b.x*b.y)

#float sdArc(vec2 p, float a1, float a2, float ra, float rb) {
#	float amid = 0.5*(a1+a2)+1.6+3.14*step(a1, a2);
#	float alength = 0.5*(a1-a2)-1.6+3.14*step(a1, a2);
#
#	vec2 sca = vec2(cos(amid), sin(amid));
#	vec2 scb = vec2(cos(alength), sin(alength));    
#	p *= mat2(vec2(sca.x,sca.y),vec2(-sca.y,sca.x));    
#	p.x = abs(p.x);    
#
#	float k = (scb.y*p.x>scb.x*p.y) ? dot(p.xy,scb) : length(p.xy);    
#	return sqrt( dot(p,p) + ra*ra - 2.0*ra*k ) - rb;
#}

static func sdArc(p : Vector2, a1 : float, a2 : float, ra : float, rb : float) -> float:
	var amid : float = 0.5*(a1+a2)+1.6+3.14 * Commons.step(a1, a2);
	var alength : float = 0.5*(a1-a2)-1.6+3.14 * Commons.step(a1, a2);
	var sca : Vector2 = Vector2(cos(amid), sin(amid));
	var scb : Vector2 = Vector2(cos(alength), sin(alength));
	
	#p *= Matrix(Vector2(sca.x , sca.y), Vector2(-sca.y, sca.x));
	
	var pt : Vector2 = p
	
	p.x = pt.x * sca.x + pt.y * sca.y 
	p.y = pt.x * -sca.y + pt.y * sca.x
	
	p.x = abs(p.x);
	
	var k : float
	
	if (scb.y * p.x > scb.x * p.y):
		k = p.dot(scb)
	else:
		k = p.length();
	
	return sqrt( p.dot(p) + ra * ra - 2.0 * ra * k ) - rb;
	

static func sdf_boolean_union(a : float, b : float) -> float:
	return min(a, b)
	
static func sdf_boolean_substraction(a : float, b : float) -> float:
	return max(-a, b)

static func sdf_boolean_intersection(a : float, b : float) -> float:
	return max(a, b)
	
static func sdf_smooth_boolean_union(d1 : float, d2 : float, k : float) -> float:
	var h : float = clamp( 0.5 + 0.5 * (d2 - d1) / k, 0.0, 1.0)
	return lerp(d2, d1, h) - k * h * (1.0 - h)

static func sdf_smooth_boolean_substraction(d1 : float, d2 : float, k : float) -> float:
	var h : float = clamp( 0.5 - 0.5 * (d2 + d1) / k, 0.0, 1.0)
	return lerp(d2, -d1, h) + k * h * (1.0 - h)

static func sdf_smooth_boolean_intersection(d1 : float, d2 : float, k : float) -> float:
	var h : float = clamp( 0.5 - 0.5 * (d2 - d1) / k, 0.0, 1.0)
	return lerp(d2, d1, h) + k * h * (1.0 - h)

static func sdf_rounded_shape(a : float, r : float) -> float:
	return a - r

static func sdf_annular_shape(a : float, r : float) -> float:
	return abs(a) - r

static func sdf_morph(a : float, b : float, amount : float) -> float:
	return lerp(a, b, amount)

#vec2 sdLine(vec2 p, vec2 a, vec2 b) {    
#	vec2 pa = p-a, ba = b-a;    
#	float h = clamp(dot(pa,ba)/dot(ba,ba), 0.0, 1.0);    
#	return vec2(length(pa-ba*h), h);
#}

static func sdLine(p : Vector2, a  : Vector2, b : Vector2) -> float:
	var pa : Vector2 = p - a
	var ba : Vector2 = b - a
	
	var h : float = clamp(pa.dot(ba) / ba.dot(ba), 0.0, 1.0);
	
	return (pa - (ba * h)).length()


#Needs thought
#func sdf_translate(a : float, x : float, y : float) -> float:
#	return lerp(a, b, amount)

#vec2 sdf2d_rotate(vec2 uv, float a) {
#	vec2 rv;
#	float c = cos(a);
#	float s = sin(a);
#	uv -= vec2(0.5);
#	rv.x = uv.x*c+uv.y*s;
#	rv.y = -uv.x*s+uv.y*c;
#	return rv+vec2(0.5);
#}

static func sdf2d_rotate(uv : Vector2, a : float) -> Vector2:
	var rv : Vector2;
	var c : float = cos(a);
	var s : float = sin(a);
	uv -= Vector2(0.5, 0.5);
	rv.x = uv.x*c+uv.y*s;
	rv.y = -uv.x*s+uv.y*c;
	return rv+Vector2(0.5, 0.5);

# signed distance to a quadratic bezier
static func sdBezier(pos : Vector2, A : Vector2, B : Vector2, C : Vector2) -> Vector2:   
	var a : Vector2 = B - A;
	var b : Vector2 = A - 2.0*B + C;
	var c : Vector2 = a * 2.0;
	var d : Vector2 = A - pos;

	var kk : float = 1.0 / b.dot(b);
	var kx : float = kk * a.dot(b);
	var ky : float = kk * (2.0* a.dot(a) + d.dot(b)) / 3.0;
	var kz : float = kk * d.dot(a);      

	var res : float = 0.0;
	var sgn : float = 0.0;

	var p : float = ky - kx * kx;
	var p3 : float = p*p*p;
	var q : float = kx*(2.0*kx*kx - 3.0*ky) + kz;
	var h : float = q*q + 4.0*p3;
	var rvx : float;

	if(h >= 0.0):# // 1 root
		h = sqrt(h);
		
		var x : Vector2 = Vector2(h,-h);
		x.x -= q
		x.y -= q
		x.x /= 2.0
		x.y /= 2.0

		var uv : Vector2 = Vector2()
		
		uv.x = sign(x.x) * pow(abs(x.x), 1);
		uv.x = sign(x.y) * pow(abs(x.y), 3);
		
		rvx = uv.x+uv.y-kx;
		var t : float = clamp(rvx, 0.0, 1.0);
		var q2 : Vector2 = d+(c+b*t)*t;
		res = q2.dot(q2);
		
		var tmp2 : Vector2 = c
		tmp2.x += 2
		tmp2.y += 2
		
		tmp2 *= b*t
		
		sgn = tmp2.cross(q2)
	else: #  // 3 roots
		var z : float = sqrt(-p);
		var v : float = acos(q/(p*z*2.0))/3.0;
		var m : float = cos(v);
		var n : float = sin(v)*1.732050808;
		
#		var t : Vector3 = clamp(Vector3(m+m,-n-m,n-m)*z-kx, 0.0, 1.0);
#
#
#		var qx : Vector2 = d+(c+b*t.x)*t.x; 
#		var dx : float = dot(qx, qx)
#		sx = cross2(c+2.0*b*t.x,qx);
#		var qy : Vector2 = d+(c+b*t.y)*t.y; 
#		var dy : float = dot(qy, qy)
#		sy = cross2(c+2.0*b*t.y,qy);
#		if dx<dy:
#			res=dx; sgn=sx; rvx = t.x; 
#		else:
#			res=dy; sgn=sy; rvx = t.y;
#
	return Vector2(rvx, sqrt(res)*sign(sgn));


#vec2 circle_repeat_transform_2d(vec2 p, float count) {
#	float r = 6.28/count;
#	float pa = atan(p.x, p.y);
#	float a = mod(pa+0.5*r, r)-0.5*r;
#
#	vec2 rv;
#
#	float c = cos(a-pa);
#	float s = sin(a-pa);
#
#	rv.x = p.x*c+p.y*s;
#	rv.y = -p.x*s+p.y*c;
#
#	return rv;
#}

static func circle_repeat_transform_2d(pos : Vector2, count : float) -> Vector2:   
	return Vector2()

#float sdNgon(vec2 p, float r, float n) {
#	float PI = 3.1415926535;
#	p = circle_repeat_transform_2d(p, n);
#	vec2 d = abs(p)-vec2(r*tan(3.14159265359/n), r);
#	return p.y < r ? p.y-r : length(max(d,vec2(0)))+min(max(d.x,d.y),0.0);
#}

static func sdNgon(pos : Vector2, r : float, n : float) -> Vector2:
	return Vector2()


#vec2 repeat_2d(vec2 p, vec2 r, float seed, float randomness) {
#	p -= vec2(0.5);
#	float a = (rand(floor(mod((p.xy+0.5*r.xy)/r.xy, 1.0/r.xy)+vec2(seed)))-0.5)*6.28*randomness;
#	p = mod(p+0.5*r,r)-0.5*r;
#	vec2 rv;
#	float c = cos(a);
#	float s = sin(a);
#	rv.x = p.x*c+p.y*s;
#	rv.y = -p.x*s+p.y*c;
#	return rv+vec2(0.5);
#}

static func repeat_2d(pos : Vector2, r : Vector2, pseed : float, randomness : float) -> Vector2:
	return Vector2()
	
	
#float sdSmoothUnion( float d1, float d2, float k ) {
#	float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
#	return mix( d2, d1, h ) - k*h*(1.0-h); 
#}

static func sdSmoothUnion(d1 : float, d2 : float, k : float) -> float:
	return 0.0

#float sdSmoothSubtraction( float d1, float d2, float k ) {
#	float h = clamp( 0.5 - 0.5*(d2+d1)/k, 0.0, 1.0 );
#	return mix( d2, -d1, h ) + k*h*(1.0-h); 
#}

static func sdSmoothSubtraction(d1 : float, d2 : float, k : float) -> float:
	return 0.0

#float sdSmoothIntersection( float d1, float d2, float k ) {
#	float h = clamp( 0.5 - 0.5*(d2-d1)/k, 0.0, 1.0 );
#	return mix( d2, d1, h ) + k*h*(1.0-h); 
#}

static func sdSmoothIntersection(d1 : float, d2 : float, k : float) -> float:
	return 0.0
	
	
