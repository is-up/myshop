/**
 * Created by yuris on 04.12.14.
 */
package controller {
import flash.geom.Point;

import messages.DebugMessage;

import model.Constants;
import model.RuntimeProxy;
import model.objects.ShopDesignData;
import model.objects.ShopObjectData;

import mvcexpress.mvc.Command;

public class UnpackShopDesignCommand extends Command{
    [Inject]
    public var runtimeProxy:RuntimeProxy;

    public function execute(packedDesign:Object):void {
        runtimeProxy.shopDesign = _unpackShopDesign(packedDesign);
    }


//    _userProxy.shopDesignPacked = {
//        sizeX:10,sizeY:8,
//        floors:{x5y6:"2",x0y0:"2", std:"1"},
//        walls:{x1:"w1",x3:"d1",y2:"d1", std:"w1"},
//        covers:{x1:"w1",y4:"w1"}  //wall covers (windows, etc)
//    };
    private function _unpackShopDesign(packedDesign:Object):ShopDesignData {
        var _stdWall:String = Constants.PATH_WALL_SPRITES+"/"+packedDesign.walls.std;
        var _stdFloor:String = Constants.PATH_FLOOR_SPRITES+"/"+packedDesign.floors.std;

        var _result:ShopDesignData = new ShopDesignData(packedDesign.sizeX,packedDesign.sizeY,_stdFloor,_stdWall);

        var bufName:String;
        var orient:String;
        var fullSpriteName:String;
        var bufValue:String;

        for (bufName in packedDesign.walls){
            if(bufName != "std"){

                orient = bufName.charAt(0);
                bufValue = packedDesign.walls[bufName];

                switch (bufValue.charAt(0)){
                    case "w"://wall
                        fullSpriteName = Constants.PATH_WALL_SPRITES+"/Wall" + bufValue.substring(1,bufValue.length);
                        break;
                    case "d"://door
                        fullSpriteName = Constants.PATH_DOOR_SPRITES+"/Door" + bufValue.substring(1,bufValue.length);
                        break;
                    default:
                        fullSpriteName = _stdWall;
                        //error state: fault to standart
                        sendMessage(DebugMessage.ERROR_MESSAGE, "UnpackShopDesignCommand: " +
                                "incorrect wall name '"+bufValue+
                                "' on coords: '"+bufName+"'");
                        break;
                }
                _result.setWallAt(int(bufName.substring(1,bufName.length)),orient,fullSpriteName);

            }
        }

        var bufPoint:Point = new Point();
        for (bufName in packedDesign.floors){
            if(bufName != "std"){

                bufPoint = ShopObjectData.convertPosition(bufName);
                bufValue = packedDesign.floors[bufName];
                if(bufValue == null){
                    fullSpriteName = _stdFloor;
                } else {
                    fullSpriteName = Constants.PATH_FLOOR_SPRITES+"/Floors" + bufValue.substring(1,bufValue.length);
                }
                _result.setFloorAt(bufPoint,fullSpriteName);

            }
        }

        for (bufName in packedDesign.covers){

            orient = bufName.charAt(0);
            bufValue = packedDesign.walls[bufName];

            fullSpriteName = null;

            switch (bufValue.charAt(0)){
                case "w"://window
                    fullSpriteName = Constants.PATH_WINDOW_SPRITES+"/Window" + bufValue.substring(1,bufValue.length);
                    break;

            }

            if(fullSpriteName != null && fullSpriteName != ""){
                _result.setWallCoverAt(int(bufName.substring(1,bufName.length)),orient,fullSpriteName)
            } else {
                //error state: fault to standart
                sendMessage(DebugMessage.ERROR_MESSAGE, "UnpackShopDesignCommand: " +
                        "incorrect cover name '"+bufValue+
                        "' on coords: '"+bufName+"'");
            }


        }
        return _result;
    }
}
}
