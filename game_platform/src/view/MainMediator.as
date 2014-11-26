/**
 * Created by AMD on 29.10.14.
 */
package view {

import layers.GameLayer;

import messages.ModelToViewMessage;
import messages.ViewToControllerMessage;

import model.MainProxy;

import mvcexpress.mvc.Mediator;

import starling.events.Event;

public class MainMediator extends Mediator{
    [Inject]
    public var starlingMain:StarlingMain;

    override protected function onRegister():void {
        mediatorMap.mediate(starlingMain.gameLayer);
    }

    override protected function onRemove():void {

    }


}
}
