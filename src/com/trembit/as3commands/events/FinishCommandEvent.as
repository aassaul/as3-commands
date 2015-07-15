/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 22:44
 */
package com.trembit.as3commands.events {
import com.trembit.as3commands.commands.Command;
import com.trembit.as3commands.commands.FinishCommand;

import flash.events.Event;

public class FinishCommandEvent extends CommandEvent {

	private var _commandForFinish:Command;
	private var _isResult:Boolean;

	public final function get commandForFinish():Command{
		return _commandForFinish;
	}

	public final function get isResult():Boolean{
		return _isResult;
	}

	public function FinishCommandEvent(commandForFinish:Command, isResult:Boolean) {
		super(FinishCommand);
		_commandForFinish = commandForFinish;
		_isResult = isResult;
	}

	override public function clone():Event {
		return new FinishCommandEvent(commandForFinish, isResult);
	}
}
}
