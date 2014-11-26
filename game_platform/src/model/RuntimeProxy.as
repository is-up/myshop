/**
 * Created by AMD on 06.11.14.
 */
package model {
import flash.geom.Point;
import flash.utils.Timer;

import messages.ModelToViewMessage;

import model.objects.ShopObjectData;

import mvcexpress.mvc.Proxy;


//-----------------------------------------------------------------------------------------------
// В этом прокси будет храниться информация о всех параметрах,
// необходимых для работы приложения в реальном времени
//-----------------------------------------------------------------------------------------------


public class RuntimeProxy extends Proxy{
    //-----for drag game layer
    private var _dragSnapPoint:Point;
    private var _dragGameLayer:Boolean;
    private var _dragInertion:Point = new Point();
    //---------------------------

    private var _shopObjects:Vector.<ShopObjectData> = new Vector.<ShopObjectData>();

    public function RuntimeProxy() {
        this._dragSnapPoint = new Point();
        this._dragGameLayer = false;
    }

    override protected function onRegister():void {

    }

    override protected function onRemove():void {

    }

    public function get shopObjects():Vector.<ShopObjectData> {
        return this._shopObjects;
    }

    public function set shopObjects(value:Vector.<ShopObjectData>):void {
        this._shopObjects = value;
        sendMessage(ModelToViewMessage.SHOP_OBJECTS_RESET);
        for(var i:int = 0;i < this._shopObjects.length; i++){
            sendMessage(ModelToViewMessage.SHOP_OBJECT_UPDATE,this._shopObjects[i]);
        }

    }


    public function set dragSnapPoint(dragSnapPoint:Point):void {
        this._dragSnapPoint = dragSnapPoint;
    }
    public function get dragSnapPoint():Point {
        return _dragSnapPoint;
    }

    public function set dragGameLayer(dragGameLayer:Boolean):void {
        this._dragGameLayer = dragGameLayer;
        sendMessage(ModelToViewMessage.TOGGLE_DRAG_GAME_LAYER,{drag:this._dragGameLayer, point:this._dragSnapPoint, inertion:this._dragInertion});
    }

    public function set dragInertion(dragInertion:Point):void {
        this._dragInertion = dragInertion;
    }



}
}