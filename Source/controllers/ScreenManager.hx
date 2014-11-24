package controllers;

import haxe.ui.toolkit.containers.Stack;
import msignal.Signal.Signal0;
import views.HeaderBar;

class ScreenManager {
    public static var onBackPressed:Signal0 = new Signal0();

    public static var stack:Stack;
    public static var headerBar:HeaderBar;

    public static var screens:Array<Dynamic> = new Array<Dynamic>();

    public static function init(stack:Stack, headerBar:HeaderBar)
    {
        ScreenManager.stack = stack;
        ScreenManager.headerBar = headerBar;
        headerBar.onBackPressed.add(backButtonPressed);

    }

    public static function push(?screen)
    {
        screens.push(screen);
        ScreenManager.stack.addChild(screen);
        ScreenManager.stack.selectedIndex = screens.length - 1;
        updateBackButton();
    }

    public static function pop()
    {
        ScreenManager.stack.back();
        ScreenManager.stack.removeChild(screens.pop(), false);
        updateBackButton();
    }

    private static function updateBackButton()
    {
        if(screens.length == 1)
        {
            headerBar.hideBackButton();
        }
        else
        {
            headerBar.showBackButton();
        }
    }

    private static function backButtonPressed()
    {
        onBackPressed.dispatch();
        pop();
    }
}