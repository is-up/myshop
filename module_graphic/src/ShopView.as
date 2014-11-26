/**
 * Created by AMD on 29.10.14.
 */
package {
import flash.geom.Matrix;
import flash.geom.Point;

import starling.display.Image;

import starling.display.QuadBatch;
import starling.display.Sprite;

public class ShopView extends Sprite {
    private var _qb:QuadBatch = new QuadBatch();
    private var _setting:Object = null;
    private var _coordinator:Sprite = new Sprite();
    private var _quadrantWidth:Number = 0;
    public function  ShopView() {
        var _floorImage:Image = GraphicFactory.getImageByName("ShopItems/Floors/Floor1");;
        this._quadrantWidth = _floorImage.width-1;

        var _matrix:Matrix = new Matrix();
        _matrix.rotate(Math.PI/4)
        _matrix.scale(1,0.5);
        _coordinator.transformationMatrix = _matrix;
        //_coordinator.y -= 3; //correct coordinator
        this.addChild(_coordinator);
    }

    public function updateAsQuad(setting:Object):void{
        this._setting = setting;
        GraphicFactory.updateFloorQuad(_qb, this._setting);
        this.addChild(_qb);
    }

    public function getIsometricCoords(screenCoords:Point):Point{
        return this._coordinator.globalToLocal(screenCoords);
    }

    public function getQuadrant(screenCoords:Point):Point{
        var _bufCoords:Point = this.getIsometricCoords(screenCoords);
        var _bufNumber:int = int(_bufCoords.x/_quadrantWidth);
        var _xQuadrant:int = _bufNumber-((_bufCoords.x>0)?0:1);
        _bufNumber = int(_bufCoords.y/_quadrantWidth);
        var _yQuadrant:int = _bufNumber-((_bufCoords.y>0)?0:1);

        return new Point(_xQuadrant,_yQuadrant);
    }

    public function quadrantToIsometric(quadrant:Point):Point{
        var _x:Number = (quadrant.x + 0.5) * _quadrantWidth;
        var _y:Number = (quadrant.y + 0.5) * _quadrantWidth;

        return new Point(_x,_y);
    }

    public function isometricToScreen(isometricCoords:Point):Point{
        return this._coordinator.localToGlobal(isometricCoords);
    }


}
}
