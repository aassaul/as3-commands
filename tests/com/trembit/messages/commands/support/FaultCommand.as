/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 1:25
 */
package com.trembit.messages.commands.support {
import com.trembit.as3commands.commands.Command;
import com.trembit.messages.commands.*;

public class FaultCommand extends Command{

	override protected function execute():void {
		onFault();
	}
}
}
