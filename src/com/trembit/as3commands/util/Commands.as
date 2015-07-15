/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 14.07.2015
 * Time: 19:46
 */
package com.trembit.as3commands.util {
import com.trembit.as3commands.commands.Command;
import com.trembit.as3commands.events.CommandEvent;

import flash.utils.Dictionary;

public final class Commands {

	private static const SINGLETON_COMMANDS:Dictionary = new Dictionary();

	public static function run(event:CommandEvent):void {
		inflate(event.command).run(event);
	}

	private static function inflate(command:Class):Command{
		var result:Command = SINGLETON_COMMANDS[command];
		if(result){
			return result;
		}
		result = new command();
		if(result.isSingleton){
			SINGLETON_COMMANDS[command] = result;
		}
		return result;
	}

	public function Commands() {
		throw new Error("Commands is static and should not be instantiated");
	}
}
}