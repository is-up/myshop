/**
 * Created by AMD on 18.11.14.
 */
package model {
import messages.DebugMessage;

import model.prototypes.ProductProto;
import model.prototypes.ShopObjectProto;
import model.prototypes.ShelfProto;

import mvcexpress.mvc.Proxy;

//-----------------------------------------------------------------------------------------------
// В этом прокси будет храниться информация о
// параметрах всех объектов в игре
//-----------------------------------------------------------------------------------------------


public class PrototypeProxy extends Proxy{
    private var _productPrototypes:Object = null;
    private var _shelfPrototypes:Object = null;

    public function PrototypeProxy() {
    }


    //---------------------------------------------
    //Products prototypes
    //---------------------------------------------

    public function get productPrototypes():Object {
        return _productPrototypes;
    }
    public function set productPrototypes(value:Object):void {
        if(this._productPrototypes == null){
            _productPrototypes = value;
        } else {
            sendMessage(DebugMessage.ERROR_MESSAGE,"PrototypeProxy: trying to reinitialize productPrototypes")
        }
    }
    ///{name:"Water", sprite_id:"Water_1", price:"1g", group:"Aqua", volume:"500", demand:"30", exp:"144", extra:""}
    public function getProductProto(productId:String):ProductProto{
        var _resultObject:Object = this._productPrototypes[productId];
        if(_resultObject == null){
            sendMessage(DebugMessage.ERROR_MESSAGE,"ProductPrototypeProxy: can't find productId:"+productId);
        }
        return new ProductProto(productId,_resultObject.sprite_id,_resultObject.price,
                                _resultObject.group,_resultObject.volume,_resultObject.demand,
                                _resultObject.exp);
    }
    public function getIdBySpriteId(spriteId:String):String{
        for (var name:String in this._productPrototypes){
            if(this._productPrototypes[name].sprite_id == spriteId){
                return name;
            }
        }
        sendMessage(DebugMessage.ERROR_MESSAGE,"PrototypeProxy: can't find productId by Sprite ID:"+spriteId);
        return "";
    }


    //---------------------------------------------
    //Shop Objects prototypes
    //---------------------------------------------

    public function get shelfPrototypes():Object {
        return _shelfPrototypes;
    }
    public function set shelfPrototypes(value:Object):void {
        if(this._shelfPrototypes == null){
            _shelfPrototypes = value;
        } else {
            sendMessage(DebugMessage.ERROR_MESSAGE,"PrototypeProxy: trying to reinitialize shopObjectPrototypes")
        }
    }
    public function getShelfProto(objectId:String):ShelfProto{
        var _resultObject:Object = this._shelfPrototypes[objectId];
        if(_resultObject == null){
            sendMessage(DebugMessage.ERROR_MESSAGE,"PrototypeProxy: can't find objectId:"+objectId);
        }
        return new ShelfProto(objectId,_resultObject.price,_resultObject.part_volume,_resultObject.parts_num ,_resultObject.level,_resultObject.occ_matrix);
    }
}
}
