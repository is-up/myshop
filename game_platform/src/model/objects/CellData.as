/**
 * Created by AMD on 02.12.14.
 */
package model.objects {
import flash.geom.Point;

public class CellData {
    private var _quadCoords:Point;
    public var occ_var:int = 0; //0 -free, 1 - busy; -1 - reserved
    private var _objects:Vector.<ShopObjectData> = new Vector.<ShopObjectData>();
    public function CellData(quadCoords:Point) {
        this._quadCoords = quadCoords;
    }

    public function get quadCoords():Point {
        return this._quadCoords;
    }

    public function free():void{
        this._objects = new Vector.<ShopObjectData>();
        occ_var = 0;
    }
    public function addOwner(obj:ShopObjectData):void{
        this.free();
        this._objects.push(obj);
        occ_var = 1;
    }
    public function addObject(obj:ShopObjectData):void{
        for(var i:int = 0;i<_objects.length;i++){
            if(this._objects[i] == obj){
                return;
            }
        }
        this._objects.push(obj)
    }
    public function removeObject(obj:ShopObjectData):void {
        var i:int=0;
        while(i < this._objects.length){
            if(this._objects[i] == obj){
                this._objects.splice(i,1);
            } else {
                i++;
            }
        }

    }

    public function get objects():Vector.<ShopObjectData> {
        return _objects;
    }


}
}
