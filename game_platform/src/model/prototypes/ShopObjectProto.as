/**
 * Created by AMD on 20.11.14.
 */
package model.prototypes {
public class ShopObjectProto {

    private var _typemodel:String;
    private var _type:String;
    private var _model:String;
    private var _price:String

    private var _level:String;
    private var _occ_matrix:String;

    //name:"Basic shelf", price:"10g", volume:"4000", level:"1", occ_matrix:"[[0,0,0],[-1,1,-1],[0,0,0]]", extra:""
    public function ShopObjectProto(typemodel:String, price:String, level:String, occ_matrix:String) {
        this._typemodel = typemodel;
        this._type = this._typemodel.charAt(0);
        this._model = this._typemodel.substring(1,this._typemodel.length);

        this._price = price;

        this._level = level;
        this._occ_matrix = occ_matrix;
    }

    public function get price():String {
        return _price;
    }



    public function get level():String {
        return _level;
    }

    public function get occ_matrix():Array {
        return JSON.parse(_occ_matrix) as Array;
    }

    public function get typemodel():String {
        return _typemodel;
    }

    public function get model():String {
        return _model;
    }

    public function get type():String {
        return _type;
    }
}
}
