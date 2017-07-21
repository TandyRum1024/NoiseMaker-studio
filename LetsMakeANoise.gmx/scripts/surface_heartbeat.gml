var winW = global.winWid;
var winH = global.winHei;

if (!surface_exists(screenSurf))
{
    screenSurf = surface_create(winW, winH);
}
if (!surface_exists(guiSurf))
{
    guiSurf = surface_create(winW, winH);
}
if (!surface_exists(smallSurf))
{
    smallSurf = surface_create(winW/5, winH/5);
}

/*surface_set_target(screenSurf);
    draw_clear_alpha(0, 0);
surface_reset_target();

surface_set_target(guiSurf);
    draw_clear_alpha(0, 0);
surface_reset_target();

surface_set_target(smallSurf);
    draw_clear_alpha(0, 0);
surface_reset_target();
