/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 19:37
 */
package com.trembit.as3commands.commands {
import com.trembit.as3commands.constants.EventState;
import com.trembit.as3commands.event.CommandEvent;
import com.trembit.as3commands.util.Commands;

public class Command {

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

	public final function onComplete(data:* = null):void{
		if(!preComplete(data)){
			return;
		}
		var event:CommandEvent = this.event;
		event.state = EventState.COMPLETE;
		data = prepareCompleteData(data);
		clearData();
		if(event.completeEvent){
			event.completeEvent.data = data;
			Commands.run(event.completeEvent);
		}
	}

	public final function onFault(data:* = null):void{
		if(!preFault(data)){
			return;
		}
		var event:CommandEvent = this.event;
		event.state = EventState.FAULT;
		data = prepareFaultData(data);
		clearData();
		if(event.faultEvent){
			event.faultEvent.data = data;
			Commands.run(event.faultEvent);
		}
	}

	protected function execute():void{}

	protected function preComplete(data:*):Boolean{
		trace("On Complete Command", event.type, "with data", data);
		return true;
	}

	protected function preFault(data:*):Boolean{
		trace("On Fault Command", event.type, "with data", data);
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
