///dui_new_button(x,y,w,h,text,visible,name,parent)
var xx = argument0;
var yy = argument1;
var wid = argument2;
var hei = argument3;
var text = argument4;
var active = argument5;
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
ds_map_add(gID, string(name)+"_col", c_white);

var guiDepths = global.guiDepths;
var size = ds_grid_height(guiDepths);
ds_grid_resize(guiDepths, 2, size+1);
ds_grid_set(guiDepths, 0, size, global.guiDP++);
ds_grid_set(guiDepths, 1, size, name);

//ds_map_add(gID, string(name)+"_depth", global.guiDP++);

//STATS
ds_map_add(gID, string(name)+"_down", false);
ds_map_add(gID, string(name)+"_click", false);
ds_map_add(gID, string(name)+"_release", false);
ds_map_add(gID, string(name)+"_hover", false);
ds_map_add(gID, string(name)+"_type", 2);
ds_map_add(gID, string(name)+"_visible", active);

ds_list_add(global.guiElements_L, name);
ds_list_add(global.guiBUTTON, name);

global.guiUpdate = true;

return name;

