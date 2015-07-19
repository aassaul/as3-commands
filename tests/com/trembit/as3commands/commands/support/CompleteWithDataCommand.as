/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 19.07.2015
 * Time: 18:10
 */
package com.trembit.as3commands.commands.support {
import com.trembit.as3commands.commands.Command;

public class CompleteWithDataCommand extends Command {

	override protected function execute():void {
		onComplete(event.data);
	}
}
}
