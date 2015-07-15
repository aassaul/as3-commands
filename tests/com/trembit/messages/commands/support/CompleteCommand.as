/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 1:27
 */
package com.trembit.messages.commands.support {
import com.trembit.as3commands.commands.Command;
import com.trembit.messages.commands.*;

public class CompleteCommand extends Command {

	override protected function execute():void {
		onComplete();
	}
}
}
