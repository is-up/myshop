/**
 * Created by AMD on 18.11.14.
 */
package ShopObjects {
import starling.display.Sprite;

public class AbstractGameObject extends  Sprite{
    private var _rotation:int = 225; //45;135;225;315  - 4 sides;

    public function AbstractGameObject() {
    }

    public function set angle(angle:int):void {
        this._setAngle(angle);
    }

    private function _setAngle(angle:int):void{
        angle = angle%360;
        (angle<0)?(angle+=360):null;
        //45;135;225;315  - 4 sides
        if(angle <= 360) this._rotation = 315;
        if(angle <= 270) this._rotation = 225;
        if(angle <= 180) this._rotation = 135;
        if(angle <= 90) this._rotation = 45;

        switch(this._rotation){
            //HalfFace
            case 315:
                this._onRotate315();
                break;
            case 45:
                this._onRotate45();
                break;
            //FullFace
            case 225:
                this._onRotate225();
                break;
            case 135:
                this._onRotate135();
                break;
        }
    }

    protected virtual function _onRotate45():void{
        throw new Error("Attempt to call virtual function: _onRotate45() (AbstractGameObject.as)");
    }
    protected virtual function _onRotate135():void{
        throw new Error("Attempt to call virtual function: _onRotate135() (AbstractGameObject.as)");
    }
    protected virtual function _onRotate225():void{
        throw new Error("Attempt to call virtual function: _onRotate225() (AbstractGameObject.as)");
    }
    protected virtual function _onRotate315():void{
        throw new Error("Attempt to call virtual function: _onRotate315() (AbstractGameObject.as)");
    }

    public function get angle():int {
        return this._rotation;
    }

    public virtual function get typemodel():String{
        throw new Error("Attempt to call virtual function: get typemodel() (AbstractGameObject.as)");
        return "virtualGameObject0";
    }
}
}
