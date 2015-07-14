/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 0:13
 */
package com.trembit.messages.commands {
import com.trembit.messages.constants.EventState;
import com.trembit.messages.event.CommandEvent;
import com.trembit.messages.event.FinishCommandEvent;
import com.trembit.messages.util.Commands;

public class ParallelCommand extends Command {

	private static function removeCompleteEvent(event:CommandEvent):void{
		var nextEvent:CommandEvent = event.completeEvent;
		while(nextEvent && nextEvent.completeEvent){
			event = nextEvent;
			nextEvent = nextEvent.completeEvent;
		}
		event.completeEvent = null;
	}

	private static function removeFaultEvent(event:CommandEvent):void{
		var nextEvent:CommandEvent = event.faultEvent;
		while(nextEvent && nextEvent.faultEvent){
			event = nextEvent;
			nextEvent = nextEvent.faultEvent;
		}
		event.faultEvent = null;
	}

	public final function get events():Vector.<CommandEvent> {
		return event.data;
	}

	override public function get isSingleton():Boolean {
		return false;
	}

	override protected function execute():void {
		for each (var event:CommandEvent in events) {
			putCompleteEvent(event);
			putFaultEvent(event);
			Commands.run(event);
		}
	}

	override protected function preComplete(data:*):Boolean {
		var state:String = getState();
		switch(state){
			case EventState.RUNNING: return false;
			case EventState.COMPLETE: return true;
			case EventState.FAULT:
				onFault(data);
				break;
		}
		return false;
	}

	override protected function preFault(data:*):Boolean {
		var state:String = getState();
		switch(state){
			case EventState.RUNNING: return false;
			case EventState.FAULT: return true;
			case EventState.COMPLETE:
				onComplete(data);
				break;
		}
		return false;
	}


	override protected function prepareCompleteData(data:*):* {
		for each (var event:CommandEvent in events) {
			removeCompleteEvent(event);
			removeFaultEvent(event);
		}
		return this.event;
	}

	override protected function prepareFaultData(data:*):* {
		for each (var event:CommandEvent in events) {
			removeCompleteEvent(event);
			removeFaultEvent(event);
		}
		return this.event;
	}

	private function getState():String {
		var isFault:Boolean;
		for each (var event:CommandEvent in events) {
			if(!event.state || event.state == EventState.RUNNING){
				return EventState.RUNNING;
			}
			if(!isFault && (event.state == EventState.FAULT)){
				isFault = true;
			}
		}
		return isFault?EventState.FAULT:EventState.COMPLETE;
	}

	private function putCompleteEvent(event:CommandEvent):void{
		while(event.completeEvent){
			event = event.completeEvent;
		}
		event.completeEvent = new FinishCommandEvent(this, true);
	}

	private function putFaultEvent(event:CommandEvent):void{
		while(event.faultEvent){
			event = event.faultEvent;
		}
		event.faultEvent = new FinishCommandEvent(this, false);
	}
}
}
