/**
 * Created by AMD on 29.10.14.
 */
package {
import controller.DebugErrorCommand;
import controller.GameLayerTouchCommand;
import controller.TestCommand;
import controller.UnpackGameObjectsCommand;

import layers.GameLayer;

import messages.DebugMessage;
import messages.ModelToControllerMessage;
import messages.ModelToViewMessage;
import messages.ViewToControllerMessage;

import model.MainProxy;
import model.PrototypeProxy;
import model.RuntimeProxy;

import model.UserProxy;

import mvcexpress.core.MediatorMap;
import mvcexpress.modules.ModuleCore;
import mvcexpress.utils.checkClassStringConstants;

import view.GameLayerMediator;

import view.MainMediator;

public class MvcMainModule extends ModuleCore{
    private var _userProxy:UserProxy;
    private var _prototypeProxy:PrototypeProxy;


     override protected function onInit():void {
         trace("MainModule.onInit");
         mediatorMap.map(StarlingMain,MainMediator);
         mediatorMap.map(GameLayer,GameLayerMediator);

         commandMap.map(ViewToControllerMessage.MAIN_ORANGE_BUTTON_CLICKED,TestCommand);
         commandMap.map(ViewToControllerMessage.GAME_LAYER_TOUCH,GameLayerTouchCommand);

         commandMap.map(ModelToControllerMessage.USER_SHOP_OBJECTS_LOADED,UnpackGameObjectsCommand);

         commandMap.map(DebugMessage.ERROR_MESSAGE,DebugErrorCommand);
         //commandMap.map(ViewMessage.MAIN_ORANGE_BUTTON_CLICKED2,TestCommand2);


         this._prototypeProxy = new PrototypeProxy();
         proxyMap.map(this._prototypeProxy);

         this._userProxy = new UserProxy();
         proxyMap.map(this._userProxy);
         proxyMap.map(new RuntimeProxy());


         //proxyMap.map(_mainProxy,null,null,MainProxy);

     }

    public function start(main:StarlingMain):void {
        trace("MainModule.start > main : " + main);
        mediatorMap.mediate(main);
        trace("Hello mvcExpress!!!");

        this._fillTestData();

    }

    private function _fillTestData():void {
        //field 'extra' is for making more fields by replacing pattern 'extra:""' with 'new_field:"someValue", extra""'
        //occ_matrix -  "0" - reserved ;  "1" - occupied ; "-1" - free
        this._prototypeProxy.shelfPrototypes = {
            s1:{name:"Basic shelf", price:"10g", part_volume:"2000", parts_num:"2", level:"1",occ_matrix:"[[0,0,0],[-1,1,-1],[0,0,0]]", extra:""}
        };
        //field 'extra' is for making more fields by replacing pattern 'extra:""' with 'new_field:"someValue", extra""'
        this._prototypeProxy.productPrototypes = {
            p1:{name:"Water", sprite_id:"Water_1", price:"1g", group:"Aqua", volume:"500", demand:"30", exp:"144", extra:""},
            p2:{name:"Bananas", sprite_id:"Banana", price:"1g", group:"Fruits",volume:"120", demand:"20", exp:"72", extra:""},
            p3:{name:"Tooth paste", sprite_id:"ToothPaste", price:"1g", group:"Household", volume:"30",demand:"20", exp:"72", extra:""}
        };




        _userProxy.shopViewSetting = {
            sizeX:10,sizeY:8,
            floors:{x5y6:"2",x0y0:"2"},
            walls:{x1:"w1",x3:"d1",y2:"d1"},
            covers:{x1:"w1",y4:"w1"}  //wall covers (windows, etc)
        };
        //make same as _userProxy.shopObjectsPacked  ===> command ===> runtimeProxy ====> view


        _userProxy.shopObjectsPacked = {
            x3y4:"s1|225|p1x2e123456789,p2x2e123456789",
            x5y6:"s1|225|p2x25e123456789,p3x35e123456789",
            x6y7:"s1|45|p2x25e123456789,p3x35e123456789",
            x8y7:"s1|225|p2x25e123456789,p3x35e123456789"
        };

        // !!!!ready!!!!
        //_userProxy.shopObjectsSettingPacked change ====>>  unpack command ====[upd by single cell or complex upd]====>>
        // runtimeProxy gameField change ====[single cell or complex]====>> GameLayerMediator change
        //--------------------------------------




        //_userProxy.shopObjectsPacked = _userProxy.shopObjectsPacked;
    }
}
}
