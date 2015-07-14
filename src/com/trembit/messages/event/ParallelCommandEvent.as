/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 0:19
 */
package com.trembit.messages.event {
import com.trembit.messages.commands.ParallelCommand;

import flash.events.Event;

public class ParallelCommandEvent extends CommandEvent{

	public function ParallelCommandEvent(data:Vector.<CommandEvent>, completeEvent:CommandEvent = null, faultEvent:CommandEvent = null, bubbles:Boolean = false) {
		super(ParallelCommand, data, completeEvent, faultEvent, bubbles);
	}

	override public function clone():Event {
		return new ParallelCommandEvent(data, completeEvent, faultEvent, bubbles);
	}
}
}
