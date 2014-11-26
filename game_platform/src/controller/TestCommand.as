/**
 * Created by AMD on 29.10.14.
 */
package controller {
import model.MainProxy;

import mvcexpress.mvc.Command;

public class TestCommand extends Command{
    [Inject]
    public var proxy:MainProxy;

    public function execute(testData:Object):void {
        trace("TestCommand.execute(" + testData.test + ")");
    }
}
}
