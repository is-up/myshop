/**
 * Created by AMD on 31.10.14.
 */
package model {
import flash.geom.Matrix;

import messages.ModelToControllerMessage;

import messages.ModelToViewMessage;

import model.prototypes.ProductProto;

import mvcexpress.mvc.Proxy;

import starling.utils.MatrixUtil;

//-----------------------------------------------------------------------------------------------
// В этом прокси будет храниться все, что сохраняется
// на сервер у пользователя
//-----------------------------------------------------------------------------------------------

public class UserProxy  extends Proxy{
    private var _shopViewSetting:Object = null;
    /*
     _userProxy.shopViewSetting = {
     sizeX:10,sizeY:8,
     floors:{x5y6:"2",x0y0:"2"},
     walls:{x1:"w1",x3:"d1",y2:"d1"},
     covers:{x1:"w1",y4:"w1"}  //wall covers (windows, etc)
     };
     */

    private var _shopObjectsPacked:Object = null;
    /*
     _userProxy.shopObjectsSettingCompact = {
         x5y6:"s1|225|p1x10e123456789,p2x4e123456789"    // coords:"type+model|angle|params"
     };
     */


    private var _shopObjectsSetting:Array = null;
    /*
     _userProxy.shopObjectsSetting = [
         {
         coords:"x5y6",
         typemodel: "s1",
         angle:"225",
         params:[
                 {product:{name:"Water", sprite_id:"Water_1", price:"1g", group:"Aqua", volume:"500", demand:"30", exp:"144"},
                 count:"10",
                 exp:"123456789"}
                 ,
                 {product:{name:"Water", sprite_id:"Water_1", price:"1g", group:"Aqua", volume:"500", demand:"30", exp:"144"},
                 count:"10",
                 exp:"123456789"}
                ]

         },
     ]
     */

    public function UserProxy() {

    }

    override protected function onRegister():void {

    }

    override protected function onRemove():void {

    }

    public function get shopViewSetting():Object {
        return _shopViewSetting;
    }

    public function set shopViewSetting(value:Object):void {
        this._shopViewSetting = value;
        sendMessage(ModelToViewMessage.USER_SHOP_VIEW_UPDATE,this._shopViewSetting);
    }

    /*
     _userProxy.shopObjectsSetting = [
     {
     coords:"x5y6",
     typemodel: "s1",
     angle:"225",
     params:[
             {product:{name:"Water", sprite_id:"Water_1", price:"1g", group:"Aqua", volume:"500", demand:"30", exp:"144"},
                 count:"10",
                 exp:"123456789"}
             ,
             {product:{name:"Water", sprite_id:"Water_1", price:"1g", group:"Aqua", volume:"500", demand:"30", exp:"144"},
                 count:"10",
                 exp:"123456789"}
             ]

     },
     ]
     */
    private function _pack(setting:Array):Object{
        var _resultObject:Object = {};
        var _packedString:String;
        var _packedParams:String;
        var _bufObject:Object;
        var _bufObject2:Object;
        var _bufArr:Array;
        var j:int = 0;
        for(var i:int = 0;i<setting.length;i++){
            _packedString = "";
            _bufObject = setting[i];
            if(_bufObject.params && (_bufObject.params as Array).length > 0){
                _bufArr = [];
                for(j = 0;j<(_bufObject.params as Array).length;j++){
                    _bufObject2 = _bufObject.params[j];
                    _bufArr.push(ProductProto(_bufObject2.productProto).productId+"x"+_bufObject2.count+"e"+_bufObject2.exp);
                }
                _packedParams = _bufArr.join(",");
            }
            _packedString = _bufObject.typemodel+"|"+_bufObject.angle+"|"+_packedParams;

            _resultObject[setting[i].coords] = _packedString;
        }
        return _resultObject;
    }






    public function get shopObjectsPacked():Object {
        return _shopObjectsPacked;
    }
    public function set shopObjectsPacked(value:Object):void {
        this._shopObjectsPacked = value;
        sendMessage(ModelToControllerMessage.USER_SHOP_OBJECTS_LOADED, this._shopObjectsPacked);
    }


}
}
