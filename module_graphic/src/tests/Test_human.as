package tests {



import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

import starling.core.Starling;

[SWF(height = 600, width = 800, frameRate = 60)]
public class Test_human extends flash.display.Sprite {
    public function Test_human() {
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

import feathers.controls.Button;

import starling.display.Sprite;
import starling.events.Event;

class Test_Starling_Module extends Sprite{
    public function Test_Starling_Module() {
        GraphicFactory.init(this._onFactoryInit)
        this.addEventListener(Event.ENTER_FRAME, this._enterFrameHandler)
    }

    private var _human:HumanView = null;
    private function _onFactoryInit():void {
        this._human = new HumanView();
        this._human.x = 400;
        this._human.y = 300;

        addChild(this._human);


        this._drawButtons();

    }

    private function _enterFrameHandler(event:Event):void {
        WorldClock.clock.advanceTime(-1);
    }

    private function _drawButtons():void {
        var _btn:Button;

        _btn = GraphicFactory.createOrangeButton(100,50,"Change Clothes Top");
        _btn.addEventListener(Event.TRIGGERED, this._changeClothesTopHandler);
        _btn.x = 30;
        _btn.y = 30;
        addChild(_btn);
        _btn = GraphicFactory.createOrangeButton(100,50,"Change Clothes Bottom");
        _btn.addEventListener(Event.TRIGGERED, this._changeClothesBottomHandler);
        _btn.x = 30;
        _btn.y = 90;
        addChild(_btn);
        _btn = GraphicFactory.createOrangeButton(100,50,"Change Face Animation");
        _btn.addEventListener(Event.TRIGGERED, this._changeAnimationTopHandler);
        _btn.x = 30;
        _btn.y = 170;
        addChild(_btn);
        _btn = GraphicFactory.createOrangeButton(100,50,"Change Body Animation");
        _btn.addEventListener(Event.TRIGGERED, this._changeAnimationBottomHandler);
        _btn.x = 30;
        _btn.y = 230;
        addChild(_btn);


        _btn = GraphicFactory.createOrangeButton(100,50,"Turn Right");
        _btn.addEventListener(Event.TRIGGERED, this._turnRightHandler);
        _btn.x = stage.stageWidth - _btn.width - 30;
        _btn.y = 30;
        addChild(_btn);
        _btn = GraphicFactory.createOrangeButton(100,50,"Turn Left");
        _btn.addEventListener(Event.TRIGGERED, this._turnLeftHandler);
        _btn.x = stage.stageWidth - _btn.width - 30;
        _btn.y = 90;
        addChild(_btn);
    }

    private function _changeClothesTopHandler(event:Event):void {
        this._human.switchBodyClothes(this._human.bodyClothesAssetPointer + 1);
    }

    private function _changeClothesBottomHandler(event:Event):void {
        this._human.switchFootClothes(this._human.footClothesAssetPointer + 1);
    }

    private function _changeAnimationTopHandler(event:Event):void {
        this._human.changeFaceAnimation(this._human.currentFaceAnimation + 1);
    }

    private function _changeAnimationBottomHandler(event:Event):void {
        this._human.changeBodyAnimation(this._human.currentBodyAnimation + 1);
    }

    private function _turnRightHandler(event:Event):void {
        this._human.angle += 100;
    }

    private function _turnLeftHandler(event:Event):void {
        this._human.angle -= 100;
    }
}


