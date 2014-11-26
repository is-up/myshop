/**
 * Created by AMD on 29.10.14.
 */
package {
import feathers.controls.Button;

import layers.GameLayer;

import starling.display.Sprite;

public class StarlingMain extends Sprite{
    private var _module:MvcMainModule = null;
    public var orangeButton:Button;

    private var _gameLayer:GameLayer;
    public function get gameLayer():GameLayer {
        return _gameLayer;
    }

    public function StarlingMain() {
        GraphicFactory.init(this._onFactoryReady);
    }

    private function _onFactoryReady():void {
        trace("Factory ready");
        this.orangeButton = GraphicFactory.createOrangeButton(100,70,"Hello Button")
       // addChild(this.orangeButton);

        this._initLayers();

        //init MVCExpress Main Module and involve MVC to the Project
        //----------------
        this._initMVC();
    }

    private function _initLayers():void {
        this._gameLayer = new GameLayer();
        this.addChild(this._gameLayer);
    }

    private function _initMVC():void {
        this._module = new MvcMainModule();
        this._module.start(this);
    }


}
}
