/**
 * Created by AMD on 06.11.14.
 */
package controller {
import flash.geom.Point;
import flash.geom.Point;
import flash.utils.Timer;

import model.RuntimeProxy;

import mvcexpress.mvc.PooledCommand;

import starling.events.Touch;
import starling.events.TouchPhase;

public class GameLayerTouchCommand extends PooledCommand{
    [Inject]
    public var runtimeProxy:RuntimeProxy;

    private var _dragTimer:Timer = new Timer(50);
    private var _bufPoint:Point = null;
    private var _bufNumber:Number = 0;
    public function execute(touch:Touch):void {
        trace("GameLayerTouchCommand.execute(" + touch.target + ")");
        if(touch.phase == TouchPhase.BEGAN){
            _dragTimer.reset();
            _dragTimer.start();
            runtimeProxy.dragSnapPoint = new Point(touch.globalX,touch.globalY);
            runtimeProxy.dragGameLayer = true;
        } else if(touch.phase == TouchPhase.ENDED){
            _dragTimer.stop();
            _bufPoint = new Point(touch.globalX,touch.globalY).subtract(runtimeProxy.dragSnapPoint);
            _bufNumber = _dragTimer.currentCount;
            if(_bufNumber > 5) _bufNumber = 0;
            if(_bufNumber !=0 ){
                _bufNumber = 1/_bufNumber;
                _bufPoint.x *= _bufNumber;
                _bufPoint.y *= _bufNumber;
            }else {
                _bufPoint.x = _bufPoint.y = 0;
            }
            runtimeProxy.dragInertion = _bufPoint;
            runtimeProxy.dragGameLayer = false;
        }

    }
}
}
