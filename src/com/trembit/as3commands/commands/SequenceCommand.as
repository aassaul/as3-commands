/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 21:11
 */
package com.trembit.as3commands.commands {
import com.trembit.as3commands.events.CommandEvent;
import com.trembit.as3commands.events.SequenceCommandEvent;
import com.trembit.as3commands.events.FinishCommandEvent;
import com.trembit.as3commands.util.Commands;

public class SequenceCommand extends Command{

	public final function get commands():Vector.<Class> {
		return SequenceCommandEvent(event).commands;
	}

	override public function get isSingleton():Boolean {
		return false;
	}

	override protected function execute():void {
		var currentCommand:Class;
		var currentEvent:CommandEvent = new FinishCommandEvent(this, true);
		for(var i:int = commands.length-1; i > 0; i--){
			currentCommand = commands[i];
			currentEvent = new CommandEvent(currentCommand, null, currentEvent, new FinishCommandEvent(this, false));
		}
		var eventForRun:CommandEvent = new CommandEvent(commands[0], event.data, currentEvent, new FinishCommandEvent(this, false));
		Commands.run(eventForRun);
	}
}
}
