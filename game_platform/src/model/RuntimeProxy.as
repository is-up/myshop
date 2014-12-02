/**
 * Created by AMD on 06.11.14.
 */
package model {
import flash.geom.Point;
import flash.utils.Timer;

import messages.DebugMessage;

import messages.ModelToViewMessage;

import model.objects.CellData;

import model.objects.ShopObjectData;

import mvcexpress.mvc.Proxy;

import starling.display.Quad;


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
    private var _gameField:Object = {};

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
        this._gameField = {};
        sendMessage(ModelToViewMessage.SHOP_OBJECTS_RESET);
        for(var i:int = 0;i < this._shopObjects.length; i++){
            this._updateShopObject(this._shopObjects[i]);
        }
    }
    private function _updateShopObject(shopObjectData:ShopObjectData):void {
        var _bufPoint:Point = shopObjectData.position;

        var _cell:CellData = this._getCellData(_bufPoint);
        _cell.free();
        _cell.addOwner(shopObjectData);
        this._updateGameFieldOccPoints (shopObjectData,45);



        //change near cells according to occ_matrix

        sendMessage(ModelToViewMessage.SHOP_OBJECT_UPDATE,shopObjectData);
    }
    private function _updateGameFieldOccPoints(objectData:ShopObjectData, adding:Boolean = true):void {

        //
        //do matrix rotation according to object angle
        //...

        var occ_matrix:Array = objectData.proto.occ_matrix;

        var _bufPoint:Point = objectData.position.clone();
        var _bufCell:CellData;
        for(var i:int = 0;i< occ_matrix.length; i++){
            for(var j:int = 0;j< occ_matrix[i].length; j++){
                _bufPoint.y = objectPoint.y + (i - 1);
                _bufPoint.x = objectPoint.x + (j - 1);
                _bufCell = this._getCellData(_bufPoint);
                if(occ_matrix[i][j] < 0){
                    if(_bufCell.occ_var <= 0){
                        if(adding){
                            _bufCell.occ_var -= occ_matrix[i][j];
                            _bufCell.addObject(objectData);
                        } else {
                            _bufCell.occ_var += occ_matrix[i][j];
                            _bufCell.removeObject(objectData);
                        }
                    } else {
                        sendMessage(DebugMessage.ERROR_MESSAGE,"Trying to reserve busy cell ["+_bufPoint.x+","+_bufPoint.y+"] " +
                                "by object on ["+objectData.position.x+","+objectData.position.y);
                    }
                }
            }
        }
    }
    private function _getCellData(quad:Point):CellData {
        var _result:CellData = this._gameField["x"+quad.x+"y"+quad.y] as CellData;
        if(_result ==  null){
            _result = new CellData(quad);
            this._gameField["x"+quad.x+"y"+quad.y] = _result;
        }
        return _result;
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
