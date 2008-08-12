{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 787.0, 44.0, 600.0, 426.0 ],
		"bglocked" : 0,
		"defrect" : [ 787.0, 44.0, 600.0, 426.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Lucida Sans Regular",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sprintf %s",
					"fontsize" : 12.0,
					"id" : "obj-21",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"patching_rect" : [ 242.0, 103.0, 63.0, 20.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "1",
					"fontsize" : 12.0,
					"id" : "obj-1",
					"numinlets" : 2,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 302.0, 71.0, 19.0, 18.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"fontsize" : 12.0,
					"id" : "obj-2",
					"numinlets" : 1,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 294.0, 38.0, 67.0, 20.0 ],
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "+ 1",
					"fontsize" : 12.0,
					"id" : "obj-3",
					"numinlets" : 2,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 185.0, 65.0, 36.0, 20.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"id" : "obj-4",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 93.0, 241.0, 15.0, 15.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Translate",
					"fontsize" : 12.0,
					"frgb" : [ 1.0, 1.0, 1.0, 1.0 ],
					"id" : "obj-5",
					"numinlets" : 1,
					"textcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 0,
					"patching_rect" : [ 109.0, 241.0, 66.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "switch 2",
					"fontsize" : 12.0,
					"id" : "obj-6",
					"numinlets" : 3,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 129.0, 141.0, 69.0, 20.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "itoa",
					"fontsize" : 12.0,
					"id" : "obj-7",
					"numinlets" : 3,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 251.0, 65.0, 53.0, 20.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "gate",
					"fontsize" : 12.0,
					"id" : "obj-8",
					"numinlets" : 2,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 71.0, 193.0, 40.0, 20.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"id" : "obj-9",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 34.0, 241.0, 15.0, 15.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-10",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 393.0, 28.0, 15.0, 15.0 ],
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "jam 0",
					"fontsize" : 12.0,
					"id" : "obj-11",
					"numinlets" : 2,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 432.0, 44.0, 49.0, 18.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "counter 300",
					"fontsize" : 12.0,
					"id" : "obj-12",
					"numinlets" : 5,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 4,
					"patching_rect" : [ 437.0, 69.0, 96.0, 20.0 ],
					"outlettype" : [ "int", "", "", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "clear",
					"fontsize" : 12.0,
					"id" : "obj-13",
					"numinlets" : 2,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 6.0, 162.0, 44.0, 18.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-14",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 203.0, 241.0, 15.0, 15.0 ],
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textedit",
					"fontsize" : 12.0,
					"id" : "obj-15",
					"numinlets" : 1,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 3,
					"patching_rect" : [ 32.0, 262.0, 188.0, 144.0 ],
					"outlettype" : [ "", "int", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend append",
					"fontsize" : 12.0,
					"id" : "obj-16",
					"numinlets" : 1,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 125.0, 165.0, 111.0, 20.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r serialText",
					"fontsize" : 12.0,
					"id" : "obj-17",
					"numinlets" : 0,
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 1,
					"patching_rect" : [ 14.0, 0.0, 94.0, 20.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Clear",
					"fontsize" : 12.0,
					"frgb" : [ 1.0, 1.0, 1.0, 1.0 ],
					"id" : "obj-18",
					"numinlets" : 1,
					"textcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 0,
					"patching_rect" : [ 166.0, 241.0, 38.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Active",
					"fontsize" : 12.0,
					"frgb" : [ 1.0, 1.0, 1.0, 1.0 ],
					"id" : "obj-19",
					"numinlets" : 1,
					"textcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"fontname" : "Lucida Sans Regular",
					"numoutlets" : 0,
					"patching_rect" : [ 50.0, 241.0, 53.0, 20.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "panel",
					"border" : 1,
					"id" : "obj-20",
					"rounded" : 0,
					"numinlets" : 1,
					"bgcolor" : [ 0.294118, 0.294118, 0.294118, 1.0 ],
					"numoutlets" : 0,
					"patching_rect" : [ 0.0, 224.0, 262.0, 198.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-6", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 2 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 497.833344, 102.0, 523.0, 102.0, 523.0, 35.0, 441.5, 35.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-6", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 1,
					"midpoints" : [ 102.0, 158.0, 154.0, 158.0, 154.0, 51.0, 194.5, 51.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-8", 1 ],
					"hidden" : 0,
					"midpoints" : [ 134.5, 186.0, 101.5, 186.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 1,
					"midpoints" : [ 43.0, 261.0, 30.0, 261.0, 30.0, 186.0, 80.5, 186.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 1,
					"midpoints" : [ 80.5, 231.0, 30.0, 231.0, 30.0, 261.0, 41.5, 261.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 1,
					"midpoints" : [ 15.5, 261.0, 41.5, 261.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 1,
					"midpoints" : [ 212.0, 262.0, 359.0, 262.0, 359.0, 29.0, 15.5, 29.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 2 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
