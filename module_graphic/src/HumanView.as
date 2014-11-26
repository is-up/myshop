/**
 * Created by AMD on 13.10.14.
 */
package {
import dragonBones.Armature;
import dragonBones.Bone;
import dragonBones.animation.WorldClock;

import starling.display.Image;

import starling.display.Sprite;

public class HumanView extends Sprite{
    private var _armatureFF:Armature = null;  //Full Face armature
    private var _armatureHF:Armature = null; //Half Face Armature
    private var _rotation:int = 225; //45;135;225;315  - 4 sides

    private var _currentBodyAnimation:int = 0;
    private const _bodyAnimations:Array = [  "Still",
                                             "HandsStraight",
                                             "Walk1"
                                             ];


    private var  _bodyClothesAssetPointer:int = 1;
    private var  _footClothesAssetPointer:int = 0;
    private const _bodyClothesPath:String = "BodyParts/Clothes/";
    private const _bodyClothesAsset:Array = [
        {
            body:_bodyClothesPath+"Clothes1",//BlueCoatRedTie"
            bodyHF:_bodyClothesPath+"Clothes1_Profile",
            handTop:_bodyClothesPath+"HandClothesTop1",
            handBottom:null,
            foot:_bodyClothesPath + "FootClothes1",
            footHF:_bodyClothesPath + "FootClothes1_Profile"
        },
        {
            body:_bodyClothesPath+"Clothes2",
            bodyHF:_bodyClothesPath+"Clothes2_Profile",
            handTop:_bodyClothesPath+"HandClothesTop2",
            handBottom:_bodyClothesPath+"HandClothesBottom2",
            foot:_bodyClothesPath + "FootClothes2",
            footHF:_bodyClothesPath + "FootClothes2_Profile"
        }
    ]
    private var _currentFaceAnimation:int = 0;
    private const _faceAnimations:Array =    [  "profile",
                                                "no_emoj",
                                                "smile_lite",
                                                "evil_1",
                                                "o_O1",
                                                "smile_norm",
                                                "dream1",
                                                "smile_good",
                                                "evil_plan",
                                                "evil_norm",
                                                "evil_angry"
                                             ];
    public function HumanView() {

           if(GraphicFactory.isReady){
               this._buildArmature();
           } else {
               throw new Error("GraphicFactory is NOT READY")
           }
    }

    private function _buildArmature():void {
        this._armatureFF = GraphicFactory.createHumanArmatureFullFace();
        this._armatureHF = GraphicFactory.createHumanArmatureHalfFace();

        //this._armatureHF.display.x = 100;

        this.angle = 225; //45;135;225;315  - 4 sides

        addChild(this._armatureFF.display as Sprite);
        addChild(this._armatureHF.display as Sprite);
    }

    public function switchBodyClothes(assetNumber:int):void{
        if(assetNumber == this._bodyClothesAssetPointer) return;
        this._bodyClothesAssetPointer = (assetNumber >= this._bodyClothesAsset.length) ? 0: ((assetNumber<0)?(this._bodyClothesAsset.length-1):assetNumber);

        this.changeBodyAnimation(this._currentBodyAnimation);

        this._switchTextures(this._armatureFF,"Body",this._bodyClothesAsset[_bodyClothesAssetPointer].body);
        this._switchTextures(this._armatureFF,"HandOuterClothesTop",this._bodyClothesAsset[_bodyClothesAssetPointer].handTop);
        this._switchTextures(this._armatureFF,"HandOuterClothesBottom",this._bodyClothesAsset[_bodyClothesAssetPointer].handBottom);
        this._switchTextures(this._armatureFF,"HandInnerClothesTop",this._bodyClothesAsset[_bodyClothesAssetPointer].handTop);
        this._switchTextures(this._armatureFF,"HandInnerClothesBottom",this._bodyClothesAsset[_bodyClothesAssetPointer].handBottom);

        this._switchTextures(this._armatureHF,"Body",this._bodyClothesAsset[_bodyClothesAssetPointer].bodyHF);
        this._switchTextures(this._armatureHF,"HandOuterClothesTop",this._bodyClothesAsset[_bodyClothesAssetPointer].handTop);
        this._switchTextures(this._armatureHF,"HandOuterClothesBottom",this._bodyClothesAsset[_bodyClothesAssetPointer].handBottom);
        this._switchTextures(this._armatureHF,"HandInnerClothesTop",this._bodyClothesAsset[_bodyClothesAssetPointer].handTop);
        this._switchTextures(this._armatureHF,"HandInnerClothesBottom",this._bodyClothesAsset[_bodyClothesAssetPointer].handBottom);
    }

    public function switchFootClothes(assetNumber:int):void{
        if(assetNumber == this._footClothesAssetPointer) return;
        this._footClothesAssetPointer = (assetNumber >= this._bodyClothesAsset.length) ? 0: ((assetNumber<0)?(this._bodyClothesAsset.length-1):assetNumber);

        this.changeBodyAnimation(this._currentBodyAnimation);

        this._switchTextures(this._armatureFF,"FootInnerClothes",this._bodyClothesAsset[_footClothesAssetPointer].foot);
        this._switchTextures(this._armatureFF,"FootOuterClothes",this._bodyClothesAsset[_footClothesAssetPointer].foot);

        this._switchTextures(this._armatureHF,"FootInnerClothes",this._bodyClothesAsset[_footClothesAssetPointer].footHF);
        this._switchTextures(this._armatureHF,"FootOuterClothes",this._bodyClothesAsset[_footClothesAssetPointer].footHF);
    }


    var _bufImage:Image = null;
    var _bufBone:Bone = null;
    private function _switchTextures(_armature:Armature, boneName:String, textureName:String):void {
        this._bufImage = GraphicFactory.getTextureDisplay(textureName);
        this._bufBone = _armature.getBone(boneName);
        if(Image(this._bufBone.display) != null) this._bufBone.display.dispose();
        this._bufBone.display =this. _bufImage;
    }

    public function changeBodyAnimation(_animNumber):void {
        this._currentBodyAnimation = (_animNumber >= this._bodyAnimations.length) ? 0: ((_animNumber<0)?(this._bodyAnimations.length-1):_animNumber);

        this._armatureFF.animation.gotoAndPlay(this._bodyAnimations[this._currentBodyAnimation]);
        this._armatureHF.animation.gotoAndPlay(this._bodyAnimations[this._currentBodyAnimation]);
    }

    public function changeFaceAnimation(animNumber:int):void {
        this._currentFaceAnimation = (animNumber >= this._faceAnimations.length) ? 0: ((animNumber<0)?(this._faceAnimations.length-1):animNumber);

        var _bone:Bone = this._armatureFF.getBone("Head");
        _bone.childArmature.animation.gotoAndPlay(this._faceAnimations[this._currentFaceAnimation]);
    }

    public function set angle(angle:int):void {
        angle = angle%360;
        (angle<0)?(angle+=360):null;
        //45;135;225;315  - 4 sides
        if(angle <= 360) this._rotation = 315;
        if(angle <= 270) this._rotation = 225;
        if(angle <= 180) this._rotation = 135;
        if(angle <= 90) this._rotation = 45;

        WorldClock.clock.remove(_armatureFF);
        WorldClock.clock.remove(_armatureHF);

        switch(this._rotation){
            //HalfFace
            case 315:
                _armatureFF.display.visible = false;
                _armatureHF.display.visible = true;
                _armatureHF.display.scaleX = 1;
                WorldClock.clock.add(_armatureHF);
                break;
            case 45:
                _armatureFF.display.visible = false;
                _armatureHF.display.visible = true;
                _armatureHF.display.scaleX = -1;
                WorldClock.clock.add(_armatureHF);
                break;
            //FullFace
            case 225:
                _armatureHF.display.visible = false;
                _armatureFF.display.visible = true;
                _armatureFF.display.scaleX = 1;
                WorldClock.clock.add(_armatureFF);
                break;
            case 135:
                _armatureHF.display.visible = false;
                _armatureFF.display.visible = true;
                _armatureFF.display.scaleX = -1;
                WorldClock.clock.add(_armatureFF);
                break;
        }
    }
    public function get angle():int {
        return _rotation;
    }

    public function get bodyClothesAssetPointer():int {
        return _bodyClothesAssetPointer;
    }

    public function get currentBodyAnimation():int {
        return _currentBodyAnimation;
    }


    public function get footClothesAssetPointer():int {
        return _footClothesAssetPointer;
    }

    public function get currentFaceAnimation():int {
        return _currentFaceAnimation;
    }
}
}
