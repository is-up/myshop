/**
 * Created by AMD on 07.10.14.
 */
package {
import ShopObjects.AbstractGameObject;
import ShopObjects.Shelf1View;

import dragonBones.Armature;
import dragonBones.animation.WorldClock;
import dragonBones.factorys.StarlingFactory;

import feathers.controls.Button;
import feathers.display.Scale9Image;
import feathers.textures.Scale9Textures;

import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import starling.display.Image;
import starling.display.QuadBatch;

import starling.display.Sprite;
import starling.filters.BlurFilter;
import starling.filters.ColorMatrixFilter;
import starling.text.TextField;
import starling.textures.Texture;

public class GraphicFactory {
    [Embed(source="/../asset_graphic/atlas_main.png", mimeType="application/octet-stream")]
    private static const ResourseData:Class;

    [Embed(source="/../asset_graphic/fonts/Nautilus.otf", embedAsCFF="false", fontFamily="Nautilus")]
    private static const Nautilus:Class;

    private static var _factory:StarlingFactory = null;
    private static var _completeCallback:Function = null;



    public static function init(completeCallback:Function = null):void {
        GraphicFactory._factory = new StarlingFactory();
        GraphicFactory._factory.parseData(new GraphicFactory.ResourseData());

        GraphicFactory._completeCallback = completeCallback;
        GraphicFactory._factory.addEventListener(flash.events.Event.COMPLETE, GraphicFactory._onCompleteHandler);
    }

    private static function _onCompleteHandler(event:Event):void {
        GraphicFactory._factory.removeEventListener(flash.events.Event.COMPLETE, GraphicFactory._onCompleteHandler);
        if(GraphicFactory._completeCallback != null){
            GraphicFactory._completeCallback();
        }
    }


    private static var _orangeBtnTexture:Scale9Textures = null;
    public static function createOrangeButton(width:int,height:int,label:String = ""):Button{
        var _button = new Button();

        if(GraphicFactory._orangeBtnTexture == null){
            var _bufImg:Image = GraphicFactory.getImageByName("Interface/OrangeButtonSkin");
            GraphicFactory._orangeBtnTexture = new Scale9Textures(_bufImg.texture,new Rectangle(_bufImg.width/2,_bufImg.height/1.5,1,1));
        }
        var btnImg =new Scale9Image(GraphicFactory._orangeBtnTexture,1);

        var btnImgHover =new Scale9Image(GraphicFactory._orangeBtnTexture,1);
        var _filter:ColorMatrixFilter = new ColorMatrixFilter();
        _filter.adjustBrightness(0.2);
        btnImgHover.filter = _filter;

        var btnImgDown =new Scale9Image(GraphicFactory._orangeBtnTexture,1);
        _filter = new ColorMatrixFilter();
        _filter.adjustBrightness(0.1);
        btnImgDown.filter = _filter;

        _button.defaultSkin =  btnImg;
        _button.hoverSkin = btnImgHover;
        _button.downSkin = btnImgDown;

        _button.width = width;
        _button.height = height;

        var _label:TextField = new TextField(width,height,label,"Nautilus",15,0xFFCD27);

        //_label.filter = BlurFilter.createDropShadow();
        _label.batchable = true;
        //_label.alignPivot();
        _label.autoScale = true;

        if(label.length) _button.addChild(_label)

        _button.useHandCursor = true;

        return _button;
    }

    private static var _qbBuf:QuadBatch = new QuadBatch();
    public static function updateFloorQuad(_qb:QuadBatch,setting:Object): void {
        _qb.reset();
        var sizeX:int = setting.sizeX;
        var sizeY:int = setting.sizeY;

        var i:int = 0;
        var j:int = 0;

        var _floorImageStd:Image = GraphicFactory.getImageForRender("ShopItems/Floors/Floor1");
        var _floorImage:Image = _floorImageStd;
        var _wallImageStd:Image = GraphicFactory.getImageForRender("ShopItems/Walls/Wall1");
        var _wallImage:Image = _wallImageStd;
        var _shadowImage:Image = GraphicFactory.getImageForRender("ShopItems/Shadows/Shadow");


        var _matrix:Matrix = null;
        //_floorImage.rotation = Math.PI/4
        _qbBuf.reset();
        for(i=0;i<sizeX;i++){
            for(j=0;j<sizeY;j++){
                _floorImage = null;
                if(setting.floors!=null && setting.floors["x"+i+"y"+j] != null){
                    _floorImage = GraphicFactory.getImageForRender("ShopItems/Floors/Floor"+String(setting.floors["x"+i+"y"+j]));
                }
                if(_floorImage == null){
                    _floorImage = _floorImageStd;
                }
                _floorImage.x = i*(_floorImage.width-1);
                _floorImage.y = j*(_floorImage.height-1);
                _qbBuf.addImage(_floorImage);
            }
        }


        _matrix = new Matrix();
        _matrix.rotate(Math.PI/4)
        _matrix.scale(1,0.5);
        _qbBuf.transformationMatrix = _matrix;
        _qb.addQuadBatch(_qbBuf);

        //-------------------
        //Walls & Shadows X Side
        GraphicFactory._constructWallQuad(_qbBuf,_wallImageStd,_floorImage.width,"x",sizeX,setting);
        _matrix = new Matrix();
        _matrix.b = 0.5;
        _qbBuf.transformationMatrix = _matrix;
        _qb.addQuadBatch(_qbBuf);

        //-------------------
        //Walls & Shadows Y Side
        _qbBuf.reset();

        for(i=0;i<sizeY;i++){
            _wallImage.x = -(_wallImage.width - _wallImage.pivotX) - i*(_floorImage.width-1)*Math.cos(Math.PI/4);
            _qbBuf.addImage(_wallImage);
            _shadowImage.x = _wallImage.x;
            _shadowImage.width = _wallImage.width+1;
            _qbBuf.addImage(_shadowImage);
        }

        GraphicFactory._constructWallQuad(_qbBuf,_wallImageStd,_floorImage.width,"y",sizeY,setting)
        _matrix = new Matrix();
        _matrix.b = -0.5;
        _qbBuf.transformationMatrix = _matrix;
        _qb.addQuadBatch(_qbBuf);


    }
    private static function _constructWallQuad(_qbBuf:QuadBatch,_wallImageStd:Image,_floorImageWidth:Number, orient:String, size:int, setting:Object):void {
        _qbBuf.reset();
        var _bufStr:String = "";
        var _doorFlag:Boolean = false;
        var _wallImage:Image = _wallImageStd;
        var _wallCoverImage:Image = null;
        var _shadowImage:Image = GraphicFactory.getImageForRender("ShopItems/Shadows/Shadow");
        var i:int = 0;
        var _currentWallPosition:Number = 0;

        for(i=0;i<size;i++){
            _doorFlag = false;
            _wallCoverImage = null;
            _wallImage = _wallImageStd;

            _currentWallPosition = (_wallImage.pivotX+((orient == "x")?0:-1)*_wallImage.width) + ((orient == "x")?1:-1)*i*(_floorImageWidth-1)*Math.cos(Math.PI/4);

            if(setting.walls!=null){
                _bufStr = setting.walls[orient+i];
                if(_bufStr!=null){
                    if(_bufStr.indexOf("d") >= 0){//it is DOOR
                        _doorFlag = true;
                    }
                    if(_bufStr.indexOf("w") >= 0){//it is WALL
                        _wallImage = GraphicFactory.getImageForRender("ShopItems/Walls/Wall"+String(_bufStr.split("w")[1]));
                    }
                }
            }
            if(setting.covers != null){
                _bufStr = setting.covers[orient+i];
                if(_bufStr!=null){
                    if(_bufStr.indexOf("w") >= 0){//it is WINDOW
                        _wallCoverImage = GraphicFactory.getImageForRender("ShopItems/Windows/Window"+String(_bufStr.split("w")[1]));
                    }
                    //if some other wall cover do the same
                    //---------------------
                }
            }
            if(!_doorFlag){
                _wallImage.x = _currentWallPosition;
                _qbBuf.addImage(_wallImage);
                if(_wallCoverImage){
                    _wallCoverImage.x = _wallImage.x;
                    _qbBuf.addImage(_wallCoverImage);
                }
            }
            _shadowImage.x = _currentWallPosition;
            _shadowImage.width = _wallImage.width+1;
            _qbBuf.addImage(_shadowImage);
        }
    }


    public static function getImageByName(name:String):Image{
        return (GraphicFactory._factory.getTextureDisplay(name) as Image);
    }

    private static var _renderImagesAsset:Object = {}
    ///Возвращает ранее созданное изображение по имени, или создает новое если не использовалось
    public static function getImageForRender(name:String):Image{
        if(GraphicFactory._renderImagesAsset[name] == null){
            GraphicFactory._renderImagesAsset[name] = (GraphicFactory._factory.getTextureDisplay(name) as Image);
        }
        return GraphicFactory._renderImagesAsset[name] as Image;
    }


    public static function createHumanArmatureFullFace():Armature {
        var _armature:Armature = GraphicFactory._factory.buildArmature("HumanFull");
        _armature.getBone("Head").childArmature.animation.gotoAndPlay("smile_good");
        return _armature;
    }
    public static function createHumanArmatureHalfFace():Armature {
        var _armature:Armature = GraphicFactory._factory.buildArmature("HumanFullProfile");
        return _armature;
    }

    public static function createGameObject(typemodel:String):AbstractGameObject{
        var type:String = typemodel.charAt(0);
        var model:String = typemodel.substring(1,typemodel.length);
        switch(type){
            case "s": //s - shelf
                    switch (model){
                        case "1":
                                return new Shelf1View();
                            break;
                    }
                break
        }
        return null;
    }

    public static function createShelfArmature(shelfModel:int):Armature{
        var _armature:Armature = GraphicFactory._factory.buildArmature("ShopItems/Shelfs/Shelf"+shelfModel);
        return _armature;
    }

    public static function getTextureDisplay(_textureName:String):Image {
        return (_factory.getTextureDisplay(_textureName) as Image);
    }

    public static function get isReady():Boolean {
        return Boolean(_factory != null);
    }

    public static function get factory():StarlingFactory {
        if(_factory == null){
            throw new Error("GraphicFactory is NOT READY. Use init() function first!");
        }
        return _factory;
    }
}
}
