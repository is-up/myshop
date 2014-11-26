/**
 * Created by AMD on 31.10.14.
 */
package layers {
import ShopObjects.AbstractGameObject;
import ShopObjects.Shelf1View;

import flash.geom.Point;

import starling.display.Sprite;

public class GameLayer extends Sprite{
    private var _shopView:ShopView = null;

    private var _staticObjects:Vector.<AbstractGameObject> = new Vector.<AbstractGameObject>();

    public function GameLayer() {
        this._shopView = new ShopView();
        this.addChild(this._shopView);
    }

    public function removeAllObjects():void{
        trace("Deleting All Objects");
        while(_staticObjects.length > 0){
            this.removeStaticObject(_staticObjects[0]);
        }
    }

    public function removeStaticObject(gameObject:Sprite):void{
        var i:int = 0;
        for(i = 0;i <this._staticObjects.length; i ++){
            if(this._staticObjects[i] == gameObject){
                this._staticObjects.splice(i,1);
                break;
            }
        }
        gameObject.parent.removeChild(gameObject);
        gameObject.dispose();
    }

    public function getStaticObjectOnQuadrant(quadrantCoords:Point):AbstractGameObject{
        var i:int = 0;
        var  _bufPoint:Point = new Point();
        var _bufSprite:Sprite;
        for(i = 0;i <this._staticObjects.length; i ++){
            _bufSprite = this._staticObjects[i];
            _bufPoint.x = _bufSprite.x;
            _bufPoint.y = _bufSprite.y;
            _bufPoint = this._shopView.getQuadrant(_bufSprite.parent.localToGlobal(_bufPoint));
            if(_bufPoint.equals(quadrantCoords)){
                return this._staticObjects[i];
                break;
            }
        }
        return null;
    }


    public function getLocalCoordsByQuadrant(quadrantCoords:Point):Point{
        return globalToLocal(this._shopView.isometricToScreen(this._shopView.quadrantToIsometric(quadrantCoords)));
    }

    public function get shopView():ShopView {
        return _shopView;
    }

    public function get staticObjects():Vector.<AbstractGameObject> {
        return _staticObjects;
    }


}
}
