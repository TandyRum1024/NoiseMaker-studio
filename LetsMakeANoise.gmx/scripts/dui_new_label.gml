///dui_new_label(x,y,w,h,text,colour,name,parent)
var xx = argument0;
var yy = argument1;
var wid = argument2;
var hei = argument3;
var text = argument4;
var col = argument5;
var name = argument6;
var parent = argument7;

var gID = global.guiElements;
//The actual position for draw & check
ds_map_add(gID, string(name)+"_x", xx);
ds_map_add(gID, string(name)+"_y", yy);
//For parenting issue
ds_map_add(gID, string(name)+"_ox", xx);
ds_map_add(gID, string(name)+"_oy", yy);

ds_map_add(gID, string(name)+"_w", wid);
ds_map_add(gID, string(name)+"_h", hei);
ds_map_add(gID, string(name)+"_str", text);
ds_map_add(gID, string(name)+"_par", parent);
ds_map_add(gID, string(name)+"_col", col);
ds_map_add(gID, string(name)+"_type", 1);
ds_map_add(gID, string(name)+"_visible", true);

ds_map_add(gID, string(name)+"_tiled", false);

var guiDepths = global.guiDepths;
var size = ds_grid_height(guiDepths);
ds_grid_resize(guiDepths, 2, size+1);

ds_grid_set(guiDepths, 0, size, global.guiDP++);
ds_grid_set(guiDepths, 1, size, name);

//ds_map_add(gID, string(name)+"_depth", global.guiDP++);

ds_list_add(global.guiElements_L, name);
ds_list_add(global.guiLABEL, name);

global.guiUpdate = true;

return name;

