/**
 * Created by AMD on 18.11.14.
 */
package controller {
import mvcexpress.mvc.Command;

public class DebugErrorCommand extends Command{
    public function execute(error:String):void {
        trace("Error:"+error);
        throw new Error(error);
    }
}
}
