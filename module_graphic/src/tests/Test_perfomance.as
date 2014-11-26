package tests {
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

import starling.core.Starling;

[SWF(height = 600, width = 800, frameRate = 60)]
public class Test_perfomance extends flash.display.Sprite {
    public function Test_perfomance() {
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

import dragonBones.Armature;
import dragonBones.animation.WorldClock;

import starling.display.Sprite;
import starling.events.Event;

class Test_Starling_Module extends  Sprite{
    public function Test_Starling_Module() {
        GraphicFactory.init(this._onFactoryInit);
        this.addEventListener(Event.ENTER_FRAME, this._enterFrameHandler)
    }
    private function _enterFrameHandler(event:Event):void {
        WorldClock.clock.advanceTime(-1);
    }

    private function _onFactoryInit():void {
        //addChild(GraphicFactory.createOrangeButton(100,70,"orange button"));
        var xPos:int = 50;
        var yPos:int = 50;
        for(var i:int = 0;i<50; i++){
            var _human:HumanView = new HumanView();
            _human.x = xPos;
            _human.y = yPos;
            xPos += 60;
            if(xPos>800){
                xPos = 50;
                yPos += 120;
            }
            _human.changeBodyAnimation(2)
            addChild(_human);
        }
    }
}


