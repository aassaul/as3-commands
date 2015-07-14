/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 1:33
 */
package com.trembit.messages.commands.support {
import com.trembit.messages.commands.*;

import flexunit.framework.Assert;

public class AssertFalseCommand extends Command {

	override protected function execute():void {
		onComplete();
	}

	override protected function preComplete(data:*):Boolean {
		Assert.assertTrue(false);
		return super.preComplete(data);
	}
}
}
