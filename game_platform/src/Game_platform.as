package {

import flash.display.Sprite;
import flash.display.Sprite;

import flash.text.TextField;

import mvcexpress.MvcExpress;

import starling.core.Starling;
import starling.events.Event;
[SWF(width = 800, height = 600, frameRate = 60)]
public class Game_platform extends flash.display.Sprite {

    private var _module:MvcMainModule;
    private var _starling:Starling;


    public function Game_platform() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
       // addChild(textField);

        this._starling = new Starling(StarlingMain,stage);
        this._starling.addEventListener(Event.ROOT_CREATED, this._onStarlingInit);
        this._starling.showStats = true;
        this._starling.start();
    }

    private function _onStarlingInit(event:Event):void {
        trace("starling init");
    }
}
}



