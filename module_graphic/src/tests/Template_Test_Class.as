package tests {



import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

import starling.core.Starling;

[SWF(height = 600, width = 800, frameRate = 60)]
public class Template_Test_Class extends flash.display.Sprite {
    public function Template_Test_Class() {
        if(stage){
            this._init()}
        else {
            this.addEventListener(Event.ADDED_TO_STAGE, this._onAddedToStage)
        }
    }
    private function _onAddedToStage(event:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, this._onAddedToStage);
        this._init();
    }
    private var _starling:Starling = null;
    private function _init():void {
       this._starling = new Starling(Test_Starling_Module,stage,new Rectangle(0,0,stage.stageWidth,stage.stageHeight));
       this._starling.showStats = true;
        this._starling.start();
    }
}

}

import starling.display.Sprite;

class Test_Starling_Module extends  Sprite{
    public function Test_Starling_Module() {
        GraphicFactory.init(this._onFactoryInit)
    }

    private function _onFactoryInit():void {
        //addChild(GraphicFactory.createOrangeButton(100,70,"orange button"));
    }
}

