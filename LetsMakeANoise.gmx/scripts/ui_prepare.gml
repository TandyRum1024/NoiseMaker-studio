/*
Get the screen size
*/
var winW = global.winWid;
var winH = global.winHei;

//Colourz
var baseRed = make_colour_rgb(227, 0, 44);
var baseBG = make_colour_rgb(81, 64, 57);
var baseMint = make_colour_rgb(109, 239, 199);
var baseGray = make_colour_rgb(164, 170, 188);
var baseWhite = make_colour_rgb(244, 239, 236);
var baseDark = make_colour_rgb(23, 19, 19);
var BGdark = make_colour_rgb(42, 30, 23);

col[0] = baseBG;
col[1] = baseMint;
col[2] = baseGray;
col[3] = baseWhite;
col[4] = baseDark;
col[5] = BGdark;
col[6] = baseRed;

enum CIND
{
    BROWN = 0,
    MINT = 1,
    GRAY = 2,
    WHITE = 3,
    BLACK = 4,
    DARKBROWN = 5,
    RED = 6
}

var offX = 10;
//Main rect for toolbar
dui_new_box(0, 0, winW, 44, BGdark, "toolbarBox", -1);
//Button 1
dui_new_box(offX, 0, 21*6, 42, baseBG, "toolbarBoxOpen", "toolbarBox");
dui_new_button(0, 0, 21*6, 42, "OPEN", false, "toolbarButtonOpen", "toolbarBoxOpen");
dui_new_label(21, 5, 3, 4, "OPEN", baseMint, "toolbarLabelOpen", "toolbarBoxOpen");
offX += 21*6+10;

//Button 2
dui_new_box(offX, 0, 21*5, 42, baseBG, "toolbarBoxNew", "toolbarBox");
dui_new_button(0, 0, 21*5, 42, "NEW", false, "toolbarButtonNew", "toolbarBoxNew");
dui_new_label(21, 5, 3, 4, "NEW", baseMint, "toolbarLabelNew", "toolbarBoxNew");
offX += 21*5+10;

//Button 3
dui_new_box(offX, 0, 21*7, 42, baseBG, "toolbarBoxAbout", "toolbarBox");
dui_new_button(0, 0, 21*7, 42, "ABOUT", false, "toolbarButtonAbout", "toolbarBoxAbout");
dui_new_label(21, 5, 3, 4, "ABOUT", baseMint, "toolbarLabelAbout", "toolbarBoxAbout");
offX += 21*7+10;

//Wave generator menu
dui_new_box(0, 43, offX, 300, BGdark, "waveMenuBox", -1);
dui_new_box(2, 2, offX-4, 296, baseBG, "waveMenuInBox", "waveMenuBox");

//Big-as-fuck sound name
dui_new_label(10, winH-74, 5, 8, "SOUND_NAME_GOEZ_HIER.dsd", c_white, "soundNameLabel", -1);
