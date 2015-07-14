/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 2:48
 */
package com.trembit.messages.commands.support {
public class NotSingleCompleteCommand extends CompleteCommand {

	override public function get isSingleton():Boolean {
		return false;
	}
}
}
