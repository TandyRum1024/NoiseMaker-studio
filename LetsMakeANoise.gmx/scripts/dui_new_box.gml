///dui_new_box(x,y,w,h,colour,name,parent)
var xx = argument0;
var yy = argument1;
var wid = argument2;
var hei = argument3;
var colour = argument4;
var name = argument5;
var parent = argument6;

var gID = global.guiElements;
//The actual position for draw & check
ds_map_add(gID, string(name)+"_x", xx);
ds_map_add(gID, string(name)+"_y", yy);
//For parenting issue
ds_map_add(gID, string(name)+"_ox", xx);
ds_map_add(gID, string(name)+"_oy", yy);

ds_map_add(gID, string(name)+"_w", wid);
ds_map_add(gID, string(name)+"_h", hei);
ds_map_add(gID, string(name)+"_par", parent);
ds_map_add(gID, string(name)+"_col", colour);
ds_map_add(gID, string(name)+"_tex", "NOPE");
ds_map_add(gID, string(name)+"_type", 0);
ds_map_add(gID, string(name)+"_visible", true);

ds_map_add(gID, string(name)+"_tiled", false);

var guiDepths = global.guiDepths;
var size = ds_grid_height(guiDepths);
ds_grid_resize(guiDepths, 2, size+1);

ds_grid_set(guiDepths, 0, size, global.guiDP++);
ds_grid_set(guiDepths, 1, size, name);

//ds_map_add(gID, string(name)+"_depth", global.guiDP++);

ds_list_add(global.guiElements_L, name);
ds_list_add(global.guiBOX, name);

global.guiUpdate = true;

return name;

