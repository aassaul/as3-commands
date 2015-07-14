/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 1:30
 */
package com.trembit.messages.commands.support {
import com.trembit.messages.commands.*;

import flexunit.framework.Assert;

public class AssertTrueCommand extends Command {

	override protected function execute():void {
		onComplete();
	}

	override protected function preComplete(data:*):Boolean {
		Assert.assertTrue(true);
		return super.preComplete(data);
	}
}
}
