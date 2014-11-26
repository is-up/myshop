package tests {



import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

import starling.core.Starling;

[SWF(height = 900, width = 1400, frameRate = 60, backgroundColor = 0xffffff)]
public class Test_tiledFloor extends flash.display.Sprite {
    public function Test_tiledFloor() {
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

import dragonBones.animation.WorldClock;

import feathers.core.FeathersControl;

import feathers.display.TiledImage;



import flash.geom.Matrix;
import flash.geom.Point;

import starling.core.RenderSupport;

import starling.core.Starling;

import starling.display.BlendMode;

import starling.display.Image;
import starling.display.QuadBatch;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.extensions.pixelmask.PixelMaskDisplayObject;
import starling.textures.RenderTexture;
import starling.textures.Texture;

class Test_Starling_Module extends  Sprite{
    public function Test_Starling_Module() {
        GraphicFactory.init(this._onFactoryInit)
    }


    private var _qbWall1:QuadBatch = new QuadBatch();
    private var _wallImage:Image = null;
    private var _floorImage:Image = null;


    private var _human:HumanView = null;
    private var _shop:ShopView = null;

    private function _onFactoryInit():void {
        _human = new HumanView();
        //addChild(_human)
        //addEventListener(Event.ENTER_FRAME,this._enterFrameHandler)
        stage.addEventListener(TouchEvent.TOUCH,this._onTouchHandler)

       var _qb:QuadBatch = new QuadBatch();

       var setting:Object = {
           sizeX:10,sizeY:8,
           floors:{x5y6:"2",x0y0:"2"},
           walls:{x1:"w1",x3:"d1",y2:"d1"},
           covers:{x1:"w1",y4:"w1"}  //wall covers (windows, etc)
           };


        var _shellSprite:Sprite = new Sprite();
        _shellSprite.x = 100;
        _shellSprite.y = 50;
        addChild(_shellSprite);

        this._shop = new ShopView();
        this._shop.x = 450;
        this._shop.y = 200;
        _shellSprite.addChild(this._shop);
        this._shop.updateAsQuad(setting);

        GraphicFactory.updateFloorQuad(_qb,setting);
        _qb.x = 600;
        _qb.y = 200;
        //addChild(_qb);
    }

    private function _enterFrameHandler(event:Event):void {
        WorldClock.clock.advanceTime(-1);

    }

    private function _onTouchHandler(event:TouchEvent):void {
        if(event.getTouch(stage)){
            trace(this._shop.isometricToScreen(this._shop.quadrantToIsometric(this._shop.getQuadrant(new Point(event.getTouch(stage).globalX,event.getTouch(stage).globalY)))));
           // _human.x = event.getTouch(stage).globalX;
            //_human.y = event.getTouch(stage).globalY;
        }
    }



}














