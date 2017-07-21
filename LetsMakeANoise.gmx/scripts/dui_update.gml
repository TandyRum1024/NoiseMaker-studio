///dui_update(durrrr)
var guiELEMENTS = global.guiElements;
var guiELEMENTS_L = global.guiElements_L;

var current = -1;
var parent = -1;
var type = -1;

var pX = -1;
var pY = -1;
var cX = -1;
var cY = -1;

//Depth thing
if (global.guiUpdate)
{
    //Sort
    ds_grid_sort(global.guiDepths, 0, true);
    global.guiUpdate = false;
}

//Update parenting issues
for (var i=0;i<ds_list_size(guiELEMENTS_L);i++)
{
    current = guiELEMENTS_L[| i];
    type = ds_map_find_value( guiELEMENTS, current+"_type");
    
    /*
        PARENT
    */
    
    //Who's your daddy?
    parent = ds_map_find_value( guiELEMENTS, current+"_par");
    if (parent != -1)
    {
        cX = ds_map_find_value( guiELEMENTS, current+"_ox");
        cY = ds_map_find_value( guiELEMENTS, current+"_oy");
        pX = ds_map_find_value( guiELEMENTS, parent+"_x");
        pY = ds_map_find_value( guiELEMENTS, parent+"_y");
        
        //show_debug_message("PARENT : "+string(parent)+", CX : "+string(cX)+", CY : "+string(cY)+", PX : "+string(pX)+", PY : "+string(pY));
        
        //Now set the position
        ds_map_replace( guiELEMENTS, current+"_x", pX+cX);
        ds_map_replace( guiELEMENTS, current+"_y", pY+cY);
    }
    
    /*
        BUTTON
    */
    if (type == 2)
    {
        cX = ds_map_find_value( guiELEMENTS, current+"_x");
        cY = ds_map_find_value( guiELEMENTS, current+"_y");
        pX = ds_map_find_value( guiELEMENTS, current+"_w");
        pY = ds_map_find_value( guiELEMENTS, current+"_h");
        
        if (point_in_rectangle(mouse_x, mouse_y, cX, cY, cX+pX, cY+pY))
        {
            ds_map_replace(guiELEMENTS, current+"_hover", true);
            ds_map_replace(guiELEMENTS, current+"_click", mouse_check_button_pressed(mb_left));
            ds_map_replace(guiELEMENTS, current+"_down", mouse_check_button(mb_left));
            ds_map_replace(guiELEMENTS, current+"_click", mouse_check_button_released(mb_left));
        }
        else
        { 
            ds_map_replace(guiELEMENTS, current+"_hover", false);
            ds_map_replace(guiELEMENTS, current+"_click", false);
            ds_map_replace(guiELEMENTS, current+"_down", false);
            ds_map_replace(guiELEMENTS, current+"_click", false);
        }
    }
}

