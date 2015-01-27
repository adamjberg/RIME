package views.screens;

import database.Database;
import msignal.Signal.Signal0;
import views.controls.FullWidthButton;

class DatabaseScreen extends Screen {

    public var onReloadPressed:Signal0 = new Signal0();

    private var errorsListView:DatabaseErrorListView;
    private var reloadButton:FullWidthButton;

    public function new() {
        super();

        errorsListView = new DatabaseErrorListView();
        addChild(errorsListView);

        reloadButton = new FullWidthButton("Reload Database");
        addChild(reloadButton);

        reloadButton.onClick = function(e)
        {
            onReloadPressed.dispatch();
            refresh();
        }

        onOpened.add(refresh);
    }

    public function refresh()
    {
        errorsListView.dataSource.removeAll();
        for(error in Database.instance.getErrors())
        {
            var splitString:Array<String> = error.split("\n");
            var mainText:String = splitString.shift();
            errorsListView.dataSource.add(
            {
                text: mainText,
                subtext: splitString
            });
        }
    }
}