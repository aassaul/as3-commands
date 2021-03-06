/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 19:37
 */
package com.trembit.as3commands.commands {
import com.trembit.as3commands.constants.EventState;
import com.trembit.as3commands.events.CommandEvent;
import com.trembit.as3commands.util.Commands;

public class Command {

	private static function runEventWithData(event:CommandEvent, data:*):void{
		if(event){
			if(data !== undefined){
				event.data = data;
			}
			Commands.run(event);
		}
	}

	private var _event:CommandEvent;
	private var _isRunning:Boolean;

	protected final function get event():CommandEvent{
		return _event;
	}

	public function get isSingleton():Boolean{
		return true;
	}

	public final function get isRunning():Boolean{
		return _isRunning;
	}

	public final function run(event:CommandEvent):void {
		if(!isRunning){
			_isRunning = true;
			_event = event;
			_event.state = EventState.RUNNING;
			execute();
		}
	}

	public final function onComplete(data:* = undefined):void{
		if(!preComplete(data)){
			return;
		}
		var event:CommandEvent = this.event;
		event.state = EventState.COMPLETE;
		data = prepareCompleteData(data);
		clearData();
		runEventWithData(event.completeEvent, data);
	}

	public final function onFault(data:* = undefined):void{
		if(!preFault(data)){
			return;
		}
		var event:CommandEvent = this.event;
		event.state = EventState.FAULT;
		data = prepareFaultData(data);
		clearData();
		runEventWithData(event.faultEvent, data);
	}

	protected function execute():void{}

	protected function preComplete(data:*):Boolean{
		return true;
	}

	protected function preFault(data:*):Boolean{
		return true;
	}

	protected function prepareCompleteData(data:*):*{
		return data;
	}

	protected function prepareFaultData(data:*):*{
		return data;
	}

	private function clearData():void{
		_isRunning = false;
		_event = null;
	}
}
}
