/**
 * Created by AMD on 12.11.14.
 */
package ShopObjects {
import dragonBones.Armature;
import dragonBones.Bone;
import dragonBones.animation.WorldClock;

import starling.display.Image;

import starling.display.Image;

import starling.display.Sprite;
import starling.utils.Color;

public class Shelf1View extends AbstractShelf{

    private const _productsPatch:String = "ShopItems/Products/";
    private const _productsBonesNames:Object = {
        top:["TopProduct_1","TopProduct_2","TopProduct_3","TopProduct_4"],
        bottom:["BottomProduct_1","BottomProduct_2","BottomProduct_3","BottomProduct_4"]
    };


    public function Shelf1View() {
        _productPlacesNames = ["top", "bottom"];
        super();
    }

    override protected function _buildArmature():void {
        this._armature = GraphicFactory.createShelfArmature(1);
        this._changeAnimation("FF");
        addChild(this._armature.display as Sprite);
        //this.setProductsOnTop("Water_1",3);
        //this.setProductsOnBottom("ToothPaste",1);
        //WorldClock.clock.add(this._armature)
        this.clear();
    }




    public function setProductsOnTop(productName:String, percent:uint):void {
        this._setProductsOn("top",productName,percent);
    }

    public function setProductsOnBottom(productName:String, percent:uint):void {
        this._setProductsOn("bottom",productName,percent);
    }
    override protected function _setProductsOn(location:String,productName:String, percent:uint):void {
        var i:int = 0;
        var _bufStr:String;
        var _maxQuantity:int = this._productsBonesNames[location].length ;
        if(percent > 100) percent = 100;
        var _restQuantity:int = Math.ceil(_maxQuantity*percent/100);
        this._armature.animation.gotoAndPlay(this._currentAnimation);

        for (i = 0;i<_maxQuantity;i++) {
            _bufStr = this._productsBonesNames[location][i];


            if(productName == null || percent == 0){
                this._switchTextures(this._armature,_bufStr,null)
            } else {
                if(_maxQuantity - i > _restQuantity && Math.random() > _restQuantity/(_maxQuantity - i) ){//delete random product if we can
                    this._switchTextures(this._armature,_bufStr,null)
                }else{
                    this._switchTextures(this._armature,_bufStr,this._productsPatch + productName);
                    _restQuantity -- ;
                }
            }
        }
       this._armature.advanceTime(-1);
    }


    private var _bufImage:Image = null;
    private var _bufBone:Bone = null;
    private function _switchTextures(_armature:Armature, boneName:String, textureName:String):void {
        //this.unflatten();

        this._bufImage = GraphicFactory.getTextureDisplay(textureName);
        this._bufBone = _armature.getBone(boneName);
        if(Image(this._bufBone.display) != null) this._bufBone.display.dispose();
        this._bufBone.display = this._bufImage;

        //this.flatten();
    }


    override protected virtual function getModel():String{
        return "1";
    }


}
}
