/**
 * Created by AMD on 29.10.14.
 */
package model {
import messages.ModelToViewMessage;

import mvcexpress.mvc.Proxy;

public class MainProxy extends Proxy{
    public function MainProxy() {
    }

    override protected function onRegister():void {
        trace("MainProxy.onRegister");
    }

    override protected function onRemove():void {

    }
}
}
