/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 1:23
 */
package com.trembit.as3commands.commands {
import com.trembit.as3commands.commands.support.AssertTrueCommand;
import com.trembit.as3commands.commands.support.CompleteCommand;
import com.trembit.as3commands.commands.support.AssertFalseCommand;
import com.trembit.as3commands.commands.support.CompleteWithDataCommand;
import com.trembit.as3commands.commands.support.FaultCommand;
import com.trembit.as3commands.commands.support.NotSingleCompleteCommand;
import com.trembit.as3commands.commands.support.NotSingleFaultCommand;
import com.trembit.as3commands.events.CommandEvent;
import com.trembit.as3commands.events.ParallelCommandEvent;
import com.trembit.as3commands.events.SequenceCommandEvent;
import com.trembit.as3commands.util.Commands;

import flexunit.framework.Assert;

public class CommandTest {

	[Test]
	public function testParallel():void{
		Commands.run(new ParallelCommandEvent(
				new <CommandEvent>[new CommandEvent(FaultCommand), new CommandEvent(CompleteCommand), new CommandEvent(FaultCommand)],
				new CommandEvent(AssertFalseCommand), new CommandEvent(AssertTrueCommand)
		));
		Commands.run(new ParallelCommandEvent(
				new <CommandEvent>[new CommandEvent(FaultCommand), new CommandEvent(FaultCommand), new CommandEvent(FaultCommand)],
				new CommandEvent(AssertFalseCommand), new CommandEvent(AssertTrueCommand)
		));
		Commands.run(new ParallelCommandEvent(
				new <CommandEvent>[new CommandEvent(FaultCommand), new CommandEvent(CompleteCommand), new CommandEvent(CompleteCommand)],
				new CommandEvent(AssertFalseCommand), new CommandEvent(AssertTrueCommand)
		));
		Commands.run(new ParallelCommandEvent(
				new <CommandEvent>[new CommandEvent(CompleteCommand), new CommandEvent(CompleteCommand), new CommandEvent(CompleteCommand)],
				new CommandEvent(AssertTrueCommand), new CommandEvent(AssertFalseCommand)
		));
	}

	[Test]
	public function testSequence():void {
		Commands.run(new SequenceCommandEvent(
				new <Class>[FaultCommand, FaultCommand, FaultCommand],
				null,
				new CommandEvent(AssertFalseCommand), new CommandEvent(AssertTrueCommand)
		));
		Commands.run(new SequenceCommandEvent(
				new <Class>[CompleteCommand, FaultCommand, FaultCommand],
				null,
				new CommandEvent(AssertFalseCommand), new CommandEvent(AssertTrueCommand)
		));
		Commands.run(new SequenceCommandEvent(
				new <Class>[CompleteCommand, CompleteCommand, FaultCommand],
				null,
				new CommandEvent(AssertFalseCommand), new CommandEvent(AssertTrueCommand)
		));
		var isError:Boolean;
		try{
			Commands.run(new SequenceCommandEvent(
					new <Class>[NotSingleCompleteCommand, NotSingleCompleteCommand, NotSingleFaultCommand],
					null,
					new CommandEvent(AssertTrueCommand), new CommandEvent(AssertFalseCommand)
			));
		}catch(e:*){
			isError = true;
		}
		Assert.assertTrue(isError);
		Commands.run(new SequenceCommandEvent(
				new <Class>[CompleteCommand, CompleteCommand, CompleteCommand],
				null,
				new CommandEvent(AssertTrueCommand), new CommandEvent(AssertFalseCommand)
		));
		isError = false;
		try{
			Commands.run(new SequenceCommandEvent(
					new <Class>[NotSingleCompleteCommand, NotSingleCompleteCommand, NotSingleCompleteCommand],
					null,
					new CommandEvent(AssertFalseCommand), new CommandEvent(AssertTrueCommand)
			));
		}catch(e:*){
			isError = true;
		}
		Assert.assertTrue(isError);
	}

	[Test]
	public function testDataFlow():void{
		var event:CommandEvent = new CommandEvent(CompleteCommand, null, new CommandEvent(CompleteCommand, "TEST_DATA"));
		Commands.run(event);
		Assert.assertEquals(event.completeEvent.data, "TEST_DATA");

		event = new CommandEvent(CompleteWithDataCommand, null, new CommandEvent(CompleteCommand, "TEST_DATA"));
		Commands.run(event);
		Assert.assertEquals(event.completeEvent.data, null);

		event = new CommandEvent(CompleteWithDataCommand, undefined, new CommandEvent(CompleteCommand, "TEST_DATA"));
		Commands.run(event);
		Assert.assertEquals(event.completeEvent.data, "TEST_DATA");
	}
}
}
