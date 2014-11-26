/**
 * Created by AMD on 21.11.14.
 */
package controller {
import model.PrototypeProxy;
import model.RuntimeProxy;
import model.objects.ProductData;
import model.objects.ShopObjectData;
import model.prototypes.ShelfProto;

import mvcexpress.mvc.Command;

public class UnpackGameObjectsCommand extends Command {
    [Inject]
    public var runtimeProxy:RuntimeProxy;
    [Inject]
    public var prototypeProxy:PrototypeProxy;

    public function execute(packedSetting:Object):void {
      runtimeProxy.shopObjects = _unpack(packedSetting);
    }

    ///input example: {x3y4:"s1|225|p1x10e123456789,p2x20e123456789"}
    private function _unpack(packedSetting:Object):Vector.<ShopObjectData>{
        var _resultArray:Vector.<ShopObjectData> = new Vector.<ShopObjectData>();
        var _bufObject:ShopObjectData;
        var i:int = 0;
        var _bufArray:Array;
        var typemodel:String;
        var angle:int;
        var params:Array = null;
        for(var coords:String in packedSetting){
            _bufArray = String(packedSetting[coords]).split("|");
            typemodel = _bufArray[0];
            angle = int(_bufArray[1]);
            params = [];

            switch (String(typemodel).charAt(0)){
                case "s"://shelf
                    _bufArray = _bufArray[2].split(",");
                    for(i = 0;i<_bufArray.length;i++){
                        params.push(this._unpackProductData(_bufArray[i]));
                    }
                    _bufObject = new ShopObjectData(prototypeProxy.getShelfProto(typemodel),params);
                    _bufObject.position = ShopObjectData.convertPosition(coords);
                    _bufObject.angle = angle;
                    break;
            }

            _resultArray.push(_bufObject);
        }
        return _resultArray;
    }

    ///input: p1x10e123456789
    private function _unpackProductData(str:String):ProductData {
        var _bufArray:Array = str.split("x");
        var _resultObject:ProductData = new ProductData(prototypeProxy.getProductProto(_bufArray[0]));
        _bufArray = _bufArray[1].split("e");
        _resultObject.count = int(_bufArray[0]);
        _resultObject.exp = _bufArray[1];

        return _resultObject;
    }
}
}
