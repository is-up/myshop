/**
 * Created by AMD on 24.11.14.
 */
package model.objects {
import flash.geom.Point;

import model.prototypes.ShopObjectProto;

public class ShopObjectData {
    public var position:Point = new Point();
    public var angle:int = 45;
    private var _params:Array = null;

    private var _proto:ShopObjectProto;
    public function ShopObjectData(proto:ShopObjectProto, params:Array = null) {
        this._proto = proto;
        this._params = params;
    }

    public function get proto():ShopObjectProto {
        return _proto;
    }

    /// stringCoords example = "x1y2"
    public static function convertPosition(stringCoords:String):Point{
        var bufArray:Array = stringCoords.substring(1,stringCoords.length).split("y");
        return new Point(int(bufArray[0]),int(bufArray[1]));
    }

    public function get params():Array {
        return this._params;
    }
}
}
