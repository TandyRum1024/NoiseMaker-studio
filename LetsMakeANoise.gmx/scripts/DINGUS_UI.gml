#define DINGUS_UI
///Grabbin' pillz
//TODO : USE MAP 4 GUI ELEMENTS
//UPDATE FUNCTION (Parent stuff man)

// -=[TYPES]=-
// BOX [0] :: a box. can contain TEXTURE
// LABEL [1] :: a text.
// BUTTON [2] :: a AABB-tested click-able buttocks

/* --COMPOSITE GUIS-- */
// WINDOW :: BOX & BUTTON & (possibly)LABEL
// CONDOM :: Just kidding

/* --OPTIONAL-- */
// LIST :: a drop-down list?
// RADIO BUTTOCKS?!?!?!

//The GUI(s)
global.guiElements = ds_map_create();
global.guiElements_L = ds_list_create();

//BOX elements
// BOX - x,y,w,h,texture,colour,parent
// PS : Texture with Colour param tints the vertex
global.guiBOX = ds_list_create();

//LABEL elements
// LABEL - x,y,W,H,text,colour,parent
global.guiLABEL = ds_list_create();

//BUTTON elements
// BUTTON - x,y,w,h,text,colour,clicked,parent
global.guiBUTTON = ds_list_create();

//Depth pointer
global.guiDP = 0;

//Sort thing
global.guiDepths = ds_grid_create(2,0);

//Should update the depth?
global.guiUpdate = false;


#define dui_update
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


#define dui_draw
///dui_draw()
var guiELEMENTS = global.guiElements;
var guiDEPTHS = global.guiDepths;
//var guiBOX = global.guiBOX;
//var guiLABEL = global.guiLABEL;
//var guiBUTTON = global.guiBUTTON;

var current = -1;
var X = -1;
var Y = -1;
var W = -1;
var H = -1;

var type = -1;

//Draw shit
for (var i=0;i<ds_grid_height(guiDEPTHS);i++)
{
    current = guiDEPTHS[# 1, i];
    type = ds_map_find_value(guiELEMENTS, current+"_type");
    
    X = ds_map_find_value(guiELEMENTS, current+"_x");
    Y = ds_map_find_value(guiELEMENTS, current+"_y");
    W = ds_map_find_value(guiELEMENTS, current+"_w");
    H = ds_map_find_value(guiELEMENTS, current+"_h");
    
    if (type == 0) //BOX
    {
        var TEX = ds_map_find_value(guiELEMENTS, current+"_tex");
        var COL = ds_map_find_value(guiELEMENTS, current+"_col");
        
        if (TEX == "NOPE") //No texture
        {
            draw_rectangle_colour(X, Y, X+W, Y+H, COL, COL, COL, COL, false);
        }
        else //YES texture
        {
            draw_primitive_begin_texture( pr_trianglestrip, TEX);
            //TL
            draw_vertex_texture_colour( X, Y, 0, 0, COL, 1.0);
            //TR
            draw_vertex_texture_colour( X+W, Y, 1, 0, COL, 1.0);
            //BL
            draw_vertex_texture_colour( X, Y+H, 0, 1, COL, 1.0);
            //BR
            draw_vertex_texture_colour( X+W, Y+H, 1, 1, COL, 1.0);
            
            draw_primitive_end();
        }
    }
    else if (type == 1) //LABEL
    {
        var STR = ds_map_find_value(guiELEMENTS, current+"_str");
        var COL = ds_map_find_value(guiELEMENTS, current+"_col");
        
        draw_text_transformed_colour( X, Y, STR, W, H, 0, COL, COL, COL , COL, 1.0);
    }
    else if (type == 2) //BUTTON
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        var STR = ds_map_find_value(guiELEMENTS, current+"_str");
        var COL = ds_map_find_value(guiELEMENTS, current+"_col");
        
        //TODO :: MAKE A BUTTON SPRITE, YOU LAZY ASS!
        draw_rectangle_colour(X, Y, X+W, Y+H, COL, COL, COL, COL, false);
        //Text
        draw_text(X+W/2, Y+H/2, STR);
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

/*
//BOX
for (var i=0;i<ds_list_size(guiBOX);i++)
{
    current = string( guiBOX[| i] );
    
    X = ds_map_find_value(guiELEMENTS, current+"_x");
    Y = ds_map_find_value(guiELEMENTS, current+"_y");
    W = ds_map_find_value(guiELEMENTS, current+"_w");
    H = ds_map_find_value(guiELEMENTS, current+"_h");
    
    var TEX = ds_map_find_value(guiELEMENTS, current+"_tex");
    var COL = ds_map_find_value(guiELEMENTS, current+"_col");
    
    if (TEX == "NOPE") //No texture
    {
        draw_rectangle_colour(X, Y, X+W, Y+H, COL, COL, COL, COL, false);
    }
    else //YES texture
    {
        draw_primitive_begin_texture( pr_trianglestrip, TEX);
        //TL
        draw_vertex_texture_colour( X, Y, 0, 0, COL, 1.0);
        //TR
        draw_vertex_texture_colour( X+W, Y, 1, 0, COL, 1.0);
        //BL
        draw_vertex_texture_colour( X, Y+H, 0, 1, COL, 1.0);
        //BR
        draw_vertex_texture_colour( X+W, Y+H, 1, 1, COL, 1.0);
        
        draw_primitive_end();
    }
}
//LABEL
for (var i=0;i<ds_list_size(guiLABEL);i++)
{
    current = string( guiLABEL[| i] );
    
    X = ds_map_find_value(guiELEMENTS, current+"_x");
    Y = ds_map_find_value(guiELEMENTS, current+"_y");
    W = ds_map_find_value(guiELEMENTS, current+"_w");
    H = ds_map_find_value(guiELEMENTS, current+"_h");
    
    var STR = ds_map_find_value(guiELEMENTS, current+"_str");
    var COL = ds_map_find_value(guiELEMENTS, current+"_col");
    
    draw_text_transformed_colour( X, Y, STR, W, H, 0, COL, COL, COL , COL, 1.0);
}
//NOH BUTTON
*/


#define dui_get
///dui_get(name,data_to_get)
return ds_map_find_value(global.guiElements, argument0+"_"+argument1);


#define dui_set
///dui_set(name,data_to_set,val)
return ds_map_replace(global.guiElements, argument0+"_"+argument1, argument2);


#define dui_new_button
///dui_new_button(x,y,w,h,text,name,parent)
var xx = argument0;
var yy = argument1;
var wid = argument2;
var hei = argument3;
var text = argument4;
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

ds_list_add(global.guiElements_L, name);
ds_list_add(global.guiBUTTON, name);

global.guiUpdate = true;

return name;


#define dui_new_label
///dui_new_label(x,y,w,h,text,name,parent)
var xx = argument0;
var yy = argument1;
var wid = argument2;
var hei = argument3;
var text = argument4;
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
ds_map_add(gID, string(name)+"_str", text);
ds_map_add(gID, string(name)+"_par", parent);
ds_map_add(gID, string(name)+"_col", c_white);
ds_map_add(gID, string(name)+"_type", 1);

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


#define dui_new_box
///dui_new_box(x,y,w,h,name,parent)
var xx = argument0;
var yy = argument1;
var wid = argument2;
var hei = argument3;
var name = argument4;
var parent = argument5;

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
ds_map_add(gID, string(name)+"_col", c_white);
ds_map_add(gID, string(name)+"_tex", "NOPE");
ds_map_add(gID, string(name)+"_type", 0);

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
