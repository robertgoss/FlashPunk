package tests
{
	import flash.display.Sprite;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	
	import tests.TestSuite;
	
	public class UnitTestsTrace extends Sprite
	{
		private var core:FlexUnitCore;
		
		
		public function UnitTestsTrace()
		{
			super();
			
			core = new FlexUnitCore();
			core.addListener( new TraceListener() );
			core.run( TestSuite );
		}
	}
}
