package tests {



import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

import starling.core.Starling;

[SWF(height = 900, width = 1200, frameRate = 60)]
public class Test_masking extends flash.display.Sprite {
    public function Test_masking() {
        if(stage){
            this._init();
        }
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

import flash.geom.Matrix;
import flash.geom.Point;

import starling.display.BlendMode;
import starling.display.Image;
import starling.display.QuadBatch;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.textures.RenderTexture;

class Test_Starling_Module extends  Sprite{
    public function Test_Starling_Module() {
        GraphicFactory.init(this._onFactoryInit)
    }

    private var _human:HumanView = null;
    private function _onFactoryInit():void {
        _human = new HumanView();
        addChild(_human)
        addEventListener(Event.ENTER_FRAME,this._enterFrameHandler)
        stage.addEventListener(TouchEvent.TOUCH,this._onTouchHandler)

        var _floorImage:QuadBatch = this._getFloorImage({sizeX:7,sizeY:5,windows:{x1:"1",x3:"1",y2:"1"}})
        _floorImage.x = 600;
        _floorImage.y = 0;
        addChild(_floorImage);
    }


    private function _getFloorImage(setting:Object): QuadBatch {
        var sizeX:int = setting.sizeX;
        var sizeY:int = setting.sizeY;

       var _bufPoint:Point = new Point();
        var _wallImage:Image = GraphicFactory.getImageForRender("ShopItems/Walls/Wall1");
        var _wallRT:RenderTexture = new RenderTexture(_wallImage.width*sizeX,_wallImage.height);
        var _bufImage:Image = null;

        _wallImage.y = _wallImage.height;

        var i:int = 0;
        for(i=0;i<sizeX;i++){
            _wallImage.x = _wallImage.width*i;
            _wallRT.draw(_wallImage);
            if(setting.windows["x"+i] != null){
                //window image
                _bufImage = GraphicFactory.getImageForRender("ShopItems/Windows/Window"+setting.windows["x"+i]);
                //erase point
                _bufPoint.x = _wallImage.x+_wallImage.width/2;
                _bufPoint.y = _wallImage.y-_wallImage.height/2;
                this._eraseWindow(_wallRT,_bufPoint.x,_bufPoint.y,_bufImage.width,_bufImage.height);

                _bufImage.alignPivot();
                _bufImage.x = _bufPoint.x;
                _bufImage.y = _bufPoint.y;
                _wallRT.draw(_bufImage);
            }
        }

        var _wall1Image:Image = new Image(_wallRT);
        var _matrix:Matrix = new Matrix();
        _matrix.b = 0.5;
        _wall1Image.transformationMatrix = _matrix;

        var _quadBatch:QuadBatch = new QuadBatch();
        _quadBatch.addImage(_wall1Image);

        //next wall drawing
        var _wallRT_Profile:RenderTexture = new RenderTexture(_wallImage.width*sizeY,_wallImage.height);

        for(i=0;i<sizeY;i++){
            _wallImage.x = _wallImage.width*i;
            _wallRT_Profile.draw(_wallImage);

        }

        var _wall2Image:Image = new Image(_wallRT_Profile);
        var _matrix:Matrix = new Matrix();
        _matrix.b = 0.5;
        _matrix.scale(-1,1);
        _wall2Image.transformationMatrix = _matrix;



        _quadBatch.addImage(_wall2Image);

        return _quadBatch;
    }



    private function _enterFrameHandler(event:Event):void {
        WorldClock.clock.advanceTime(-1);
    }
    private function _onTouchHandler(event:TouchEvent):void {
        if(event.getTouch(stage)){
            _human.x = event.getTouch(stage).globalX;
            _human.y = event.getTouch(stage).globalY;
        }
    }


    private function _eraseWindow(_wallRT:RenderTexture, x:Number, y:Number, width:Number, height:Number):void {
        var _eraser:Image = GraphicFactory.getImageForRender("ShopItems/RenderUtils/Eraser");
        _eraser.width = width;
        _eraser.height = height;
        _eraser.alignPivot();
        _eraser.x = x;
        _eraser.y = y;
        _eraser.blendMode = BlendMode.ERASE;
        _wallRT.draw(_eraser);
    }
}

