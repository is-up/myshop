/**
 * Created by AMD on 24.11.14.
 */
package model.prototypes {
public class ShelfProto extends ShopObjectProto{
    private var _partVolume:int;
    private var _partsNum:int;

    public function ShelfProto(typemodel:String, price:String,partVolume:String,partsNum:String, level:String, occ_matrix:String = "[[-1,-1,-1],[-1,1,-1],[-1,-1,-1]]") {
        super(typemodel,price,level,occ_matrix);
        this._partVolume = int(partVolume);
        _partsNum = int(partsNum);
    }

    public function get partVolume():int {
        return _partVolume;
    }

    public function get partsNum():int {
        return _partsNum;
    }
}

}
