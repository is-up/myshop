/**
 * Created by AMD on 31.10.14.
 */
package view {
import ShopObjects.AbstractGameObject;
import ShopObjects.AbstractShelf;
import ShopObjects.Shelf1View;

import flash.geom.Point;

import layers.GameLayer;

import messages.ModelToViewMessage;

import messages.ViewToControllerMessage;

import model.objects.ProductData;

import model.objects.ShopObjectData;
import model.prototypes.ShelfProto;
import model.prototypes.ShelfProto;
import model.prototypes.ShopObjectProto;

import mvcexpress.mvc.Mediator;

import starling.display.Sprite;

import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class GameLayerMediator extends Mediator{
    [Inject]
    public var gameLayer:GameLayer;

    private var _dragDelta:Point = new Point();
    private var _draggingGameLayer:Boolean = false;
    private var _dragInertion:Point = new Point(0,0);

    override protected function onRegister():void {
        trace("GameLayerMediator onRegister");
        gameLayer.addEventListener(TouchEvent.TOUCH, this._gameLayerTouchHandler);
        addHandler(ModelToViewMessage.USER_SHOP_VIEW_UPDATE, this._onUserShopViewChanged);
        addHandler(ModelToViewMessage.SHOP_OBJECT_UPDATE, this._shopObjectUpdateHandler);
        addHandler(ModelToViewMessage.SHOP_OBJECTS_RESET, this._shopObjectsResetHandler);

        addHandler(ModelToViewMessage.TOGGLE_DRAG_GAME_LAYER,this._onToggleDragVariable);

        gameLayer.addEventListener(Event.ENTER_FRAME,this._enterFrameHandler)
    }
    private function _onUserShopViewChanged(shopViewSetting:Object):void {
        gameLayer.shopView.updateAsQuad(shopViewSetting);
    }

    private function _shopObjectsResetHandler(blankParam:Object):void {
        gameLayer.removeAllObjects();
    }

    private function _shopObjectUpdateHandler(shopObjectData:ShopObjectData):void {
        this.updateObject(shopObjectData.proto,shopObjectData.position,shopObjectData.angle,shopObjectData.params)
    }


    public function updateObject(objectProto:ShopObjectProto,quadrantCoords:Point,rotation:int,params:Array):void {
        // update object or create new on this place

        var _localPoint:Point = gameLayer.getLocalCoordsByQuadrant(quadrantCoords);
        var i:int = 0;

        var _bufPoint:Point;

        var _currentObject:AbstractGameObject = gameLayer.getStaticObjectOnQuadrant(quadrantCoords);
        if(_currentObject == null || _currentObject.typemodel != objectProto.typemodel){
                if(_currentObject) gameLayer.removeStaticObject(_currentObject);
                _currentObject = GraphicFactory.createGameObject(objectProto.typemodel);
                gameLayer.addChild(_currentObject);
        }
        _currentObject.x = _localPoint.x;
        _currentObject.y = _localPoint.y;
        _currentObject.angle = rotation;



        switch (objectProto.type){
            case "s": //Shelf
                AbstractShelf(_currentObject).clear();
                    var _productDataBuf:ProductData;
                    for(i=0;i<ShelfProto(objectProto).partsNum; i++){
                        _productDataBuf = ProductData(params[i]);
                        AbstractShelf(_currentObject).setNextProduct(_productDataBuf.proto.spriteId,
                                        100*(_productDataBuf.count*_productDataBuf.proto.volume/ShelfProto(objectProto).partVolume));
                    }
                break;
        }

        //-----------------------------------------
        //_currentObject.updateByParams(params)

    }


    override protected function onRemove():void {

    }

    private var _bufTouch:Touch = null;
    private function _gameLayerTouchHandler(event:TouchEvent):void {
        this._bufTouch = event.touches[0];

        if(this._bufTouch == null) return; //for safety

        if(this._bufTouch.phase != TouchPhase.HOVER && this._bufTouch.phase != TouchPhase.MOVED){
            sendMessage(ViewToControllerMessage.GAME_LAYER_TOUCH,event.touches[0])
        }

        if(this._bufTouch.phase == TouchPhase.MOVED){
            if(this._draggingGameLayer){
                this.gameLayer.x = this._bufTouch.globalX + this._dragDelta.x;
                this.gameLayer.y = this._bufTouch.globalY + this._dragDelta.y;
            }
        }
    }
    private function _onToggleDragVariable(param:Object):void {
        if(param.drag){//start drag
            this._dragDelta = new Point(gameLayer.x,gameLayer.y).subtract(Point(param.point));
        } else {//stop drag
            this._dragInertion = param.inertion;
        }
        this._draggingGameLayer = Boolean(param.drag);
    }
    private function _enterFrameHandler(event:Event):void {
        if(!this._draggingGameLayer){
            if(Math.abs(this._dragInertion.x) > 1 || Math.abs(this._dragInertion.y) > 1 ){
                this.gameLayer.x += this._dragInertion.x *0.2;
                this.gameLayer.y += this._dragInertion.y *0.2;

                this._dragInertion.x *= 0.84;
                this._dragInertion.y *= 0.84;
            } else {
                this._dragInertion.x = this._dragInertion.y = 0;
            }

        }

    }



}
}
