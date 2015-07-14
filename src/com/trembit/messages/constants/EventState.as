/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 0:31
 */
package com.trembit.messages.constants {
public final class EventState {

	public static const RUNNING:String = "RUNNING";
	public static const COMPLETE:String = "COMPLETE";
	public static const FAULT:String = "FAULT";

	public function EventState() {
		throw new Error("EventState is static and should not be instantiated");
	}
}
}