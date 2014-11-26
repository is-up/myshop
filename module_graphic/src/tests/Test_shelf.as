package tests {



import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

import starling.core.Starling;

[SWF(height = 600, width = 800, frameRate = 60)]
public class Test_shelf extends flash.display.Sprite {
    public function Test_shelf() {
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

import ShopObjects.Shelf1View;

import dragonBones.animation.WorldClock;

import feathers.controls.Button;


import starling.display.Sprite;
import starling.events.Event;

class Test_Starling_Module extends  Sprite{
    public function Test_Starling_Module() {
        GraphicFactory.init(this._onFactoryInit)
    }
    var _shelfView:Shelf1View;
    private function _onFactoryInit():void {
        _shelfView = new Shelf1View();
        _shelfView.x = 350;
        _shelfView.y = 400;
        addChild(_shelfView);

        //addChild(GraphicFactory.createOrangeButton(100,70,"orange button"));
        addEventListener(Event.ENTER_FRAME,_onEnterFrameHandler);

        this._createButtons();
    }


    private function _createButtons():void {
        var _btn:Button;

        _btn = GraphicFactory.createOrangeButton(100,50,"Change Products");
        _btn.addEventListener(Event.TRIGGERED, this._changeProductsHandler);
        _btn.x = 30;
        _btn.y = 30;
        addChild(_btn);

        _btn = GraphicFactory.createOrangeButton(100,50,"Rotate");
        _btn.addEventListener(Event.TRIGGERED, this._rotateHandler);
        _btn.x = 30;
        _btn.y = 100;
        addChild(_btn);
    }

    private function _changeProductsHandler(event:Event):void {
        _shelfView.setProductsOnTop((Math.random()<0.5)?"ToothPaste":"Banana",int(Math.random()*5));
        _shelfView.setProductsOnBottom((Math.random()<0.5)?"Water_1":"ToothPaste",int(Math.random()*5));
    }
    private function _rotateHandler(event:Event):void {
        _shelfView.angle += 100;
    }

    private function _onEnterFrameHandler(event:Event):void {
        // WorldClock.clock.advanceTime(-1);
    }


}

