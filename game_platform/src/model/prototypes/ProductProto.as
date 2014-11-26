/**
 * Created by AMD on 20.11.14.
 */
package model.prototypes {
public class ProductProto {
    private var _productId:String;
    private var _spriteId:String;
    private var _price:String;
    private var _group:String;
    private var _volume:int;
    private var _demand:int;
    private var _exp:String;

    ///{name:"Water", sprite_id:"Water_1", price:"1g", group:"Aqua", volume:"500", demand:"30", exp:"144", extra:""}
    public function ProductProto(productId:String, spriteId:String, price:String, group:String, volume:String, demand:String, exp:String) {
        this._productId = productId;
        this._spriteId = spriteId;
        this._price = price;
        this._group = group;
        this._volume = int(volume);
        this._demand = int(demand);
        this._exp = exp;
    }

    public function get productId():String {
        return this._productId;
    }

    public function get spriteId():String {
        return this._spriteId;
    }

    public function get price():String {
        return this._price;
    }

    public function get group():String {
        return this._group;
    }

    public function get volume():int {
        return this._volume;
    }

    public function get demand():int {
        return this._demand;
    }

    public function get exp():String {
        return _exp;
    }
}
}
