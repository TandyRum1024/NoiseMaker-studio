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

