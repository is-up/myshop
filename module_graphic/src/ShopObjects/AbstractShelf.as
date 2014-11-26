/**
 * Created by AMD on 18.11.14.
 */
package ShopObjects {
import dragonBones.Armature;

public class AbstractShelf extends AbstractGameObject {
    protected var _armature:Armature = null;
    protected var _currentAnimation:String = "FF";
    protected var _productPlacesNames:Array = null;
    protected var _placePointer:int = 0;

    public function AbstractShelf() {
        super();
        if(GraphicFactory.isReady){
            this._buildArmature();
        } else {
            throw new Error("GraphicFactory is NOT READY")
        }
    }

    protected virtual function _buildArmature():void {
        throw new Error("Attempt to call virtual function: _buildArmature() (AbstractShelf.as)");
    }

    public function clear():void{
        for(var i:int = 0; i<this._productPlacesNames.length; i++){
            this._setProductsOn(this._productPlacesNames[i],null,0);
        }
        this._placePointer = 0;
    }
    public function setNextProduct(productName:String, quantity:uint):void{
        if(this._placePointer < this._productPlacesNames.length){
            this._setProductsOn(this._productPlacesNames[this._placePointer],productName,quantity);
            this._placePointer ++;
        }
    }

    protected virtual function _setProductsOn(location:String,productName:String, quantity:uint):void {
        throw new Error("Attempt to call virtual function: _setProductsOn() (AbstractShelf.as)");
    }

    override public function set angle(angle:int):void {
        super.angle = angle;
        this._armature.advanceTime(-1);
    }

    protected function _changeAnimation(label:String):void {
        //this.unflatten();

        this._currentAnimation = label;
        this._armature.animation.gotoAndPlay(label);
        this._armature.advanceTime(-1);

        //this.flatten();
    }

    override protected function _onRotate45():void{
        this._changeAnimation("HF");
        this._armature.display.scaleX = -1;
    }
    override protected function _onRotate135():void{
        this._changeAnimation("FF");
        this._armature.display.scaleX = -1;
    }
    override protected function _onRotate225():void{
        this._changeAnimation("FF");
        this._armature.display.scaleX = 1;
    }
    override protected function _onRotate315():void{
        this._changeAnimation("HF");
        this._armature.display.scaleX = 1;
    }

    protected virtual function getModel():String{
        throw new Error("Attempt to call virtual function: getModel() (AbstractShelf.as)");
        return "virtualModel";
    }

    override public function get typemodel():String{
        return "s"+ this.getModel();
    }
}
}
