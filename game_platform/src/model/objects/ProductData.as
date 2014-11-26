/**
 * Created by AMD on 25.11.14.
 */
package model.objects {
import model.prototypes.ProductProto;

public class ProductData {
    private var _proto:ProductProto;
    public var exp:String = "";
    public var count:int = 0;

    public function ProductData(proto:ProductProto) {
        this._proto = proto;
    }

    public function get proto():ProductProto {
        return this._proto;
    }
}
}
