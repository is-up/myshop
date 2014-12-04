/**
 * Created by yuris on 04.12.14.
 */
package model.objects {
import flash.geom.Point;

public class ShopDesignData {
    public var sizeX:int;
    public var sizeY:int;

    private var _stdFloor:String;
    private var _stdWall:String;
    private var _floors:Object = {};
    private var _walls:Object = {};
    private var _wallCovers:Object = {};


    public function ShopDesignData(sizeX:int, sizeY:int, stdFloor:String, stdWall:String) {
        this.sizeX = sizeX;
        this.sizeY = sizeY;
        this._stdFloor = stdFloor;
        this._stdWall = stdWall;
    }

    public function getFloorAt(quadCoord:Point):String{
        var _result:String = this._floors["x"+quadCoord.x+"y"+quadCoord.y];
        if(_result == null){
            _result = this._stdFloor;
        }
        return _result;
    }
    public function setFloorAt(quadCoord:Point, fullSpriteName:String):void{
        this._floors["x"+quadCoord.x+"y"+quadCoord.y] = fullSpriteName;
    }




    public function getWallAt(count:int, orient:String = "x"):String{
        var _result:String = this._walls[orient.toLowerCase()+""+count];
        if(_result == null){
            _result = this._stdWall;
        }
        return _result;
    }
    public function setWallAt(count:int, orient:String, fullSpriteName:String):void{
       this._walls[orient.toLowerCase()+""+count] = fullSpriteName;
    }




    public function getWallCoverAt(count:int, orient:String = "x"):String{
        var _result:String = this._wallCovers[orient.toLowerCase()+""+count];
        return _result;
    }
    public function setWallCoverAt(count:int, orient:String, fullSpriteName:String):void{
        this._wallCovers[orient.toLowerCase()+""+count] = fullSpriteName;

    }
}
}
