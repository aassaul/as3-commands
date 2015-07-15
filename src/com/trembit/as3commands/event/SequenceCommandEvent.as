/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 22:10
 */
package com.trembit.as3commands.event {
import com.trembit.as3commands.commands.SequenceCommand;

import flash.events.Event;

public class SequenceCommandEvent extends CommandEvent{

	private var _commands:Vector.<Class>;

	public function get commands():Vector.<Class>{
		return _commands;
	}

	public function SequenceCommandEvent(commands:Vector.<Class>, data:* = null, completeEvent:CommandEvent = null, faultEvent:CommandEvent = null, bubbles:Boolean = false) {
		super(SequenceCommand, data, completeEvent, faultEvent, bubbles);
		_commands = commands;
	}


	override public function clone():Event {
		return new SequenceCommandEvent(data, commands, completeEvent, faultEvent);
	}
}
}
