/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 22:39
 */
package com.trembit.as3commands.commands {
import com.trembit.as3commands.events.FinishCommandEvent;

public class FinishCommand extends Command {

	override public function get isSingleton():Boolean {
		return false;
	}

	public function get commandForFinish():Command{
		return FinishCommandEvent(event).commandForFinish;
	}

	public function get isResult():Boolean{
		return FinishCommandEvent(event).isResult;
	}

	override protected function execute():void {
		var commandForFinish:Command = this.commandForFinish;
		var isResult:Boolean = this.isResult;
		var data:* = event.data;
		onComplete();
		if(isResult){
			commandForFinish.onComplete(data);
		}else{
			commandForFinish.onFault(data);
		}
	}
}
}
