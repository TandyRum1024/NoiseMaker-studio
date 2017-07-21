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
var active = false;

//Draw shit
for (var i=0;i<ds_grid_height(guiDEPTHS);i++)
{
    current = guiDEPTHS[# 1, i];
    type = ds_map_find_value(guiELEMENTS, current+"_type");
    active = ds_map_find_value(guiELEMENTS, current+"_visible");;
    
    if (active)
    {
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

