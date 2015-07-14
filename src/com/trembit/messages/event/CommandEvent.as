/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 19:50
 */
package com.trembit.messages.event {

import avmplus.getQualifiedClassName;

import flash.events.Event;
import flash.utils.Dictionary;

public class CommandEvent extends Event{

	private static const CLASS_NAME_MAP:Dictionary = new Dictionary();

	private var _command:Class;

	public var data:*;

	public var state:String;

	public var completeEvent:CommandEvent;
	public var faultEvent:CommandEvent;

	public final function get command():Class {
		return _command;
	}

	public function CommandEvent(command:Class, data:* = null, completeEvent:CommandEvent = null, faultEvent:CommandEvent = null, bubbles:Boolean = false) {
		var commandName:String = CLASS_NAME_MAP[command];
		if(!commandName){
			commandName = getQualifiedClassName(command);
			CLASS_NAME_MAP[command] = commandName;
		}
		super(commandName, bubbles, false);
		this.data = data;
		this.faultEvent = faultEvent;
		this.completeEvent = completeEvent;
		_command = command;
	}

	override public function clone():Event{
		return new CommandEvent(command, data, completeEvent, faultEvent, bubbles);
	}
}
}
