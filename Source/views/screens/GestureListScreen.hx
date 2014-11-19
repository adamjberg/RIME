package views.screens;

import controllers.ScreenManager;
import gestures.controllers.GestureController;
import views.controls.FullWidthButton;
import views.GestureList;
import views.screens.Screen;

class GestureListScreen extends Screen {

    private var gestureList:GestureList;

    private var gestureController:GestureController;
    private var addGestureButton:FullWidthButton;

    public function new(?gestureController:GestureController)
    {
        super();

        this.gestureController = gestureController;

        gestureList = new GestureList(gestureController);
        gestureList.percentHeight = 100;
        addChild(gestureList);

        addGestureButton = new FullWidthButton("Add Gesture");
        addGestureButton.onClick = addGestureButtonClicked;
        addChild(addGestureButton); 
    }

    private function addGestureButtonClicked(e)
    {
        ScreenManager.push(new GestureEditScreen(gestureController));
    }
}