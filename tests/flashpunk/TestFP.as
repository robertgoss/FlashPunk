package  tests.flashpunk
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	
	import net.flashpunk.FP
	
	public class TestFP 
	{
		[Before]
		public function init():void
		{
			FP.entity = new Entity();
		}
		
		[Test]
		public function removeSucc():void
		{
			var array = [1, 2, 4, 6];
			FP.remove(array, 4);
			Assert.assertEquals(array, [1, 2, 6]);
		}
		
		[Test]
		public function sign():void
		{
			//Test 3 possible return states of sign.
			Assert.assertEquals( 1, FP.sign(2), FP.sign(4.34));
			Assert.assertEquals(-1, FP.sign( -4), FP.sign( -4.34));
			Assert.assertEquals( 0, FP.sign(0));
		}
		
		[Test]
		public function approachUp():void
		{
			Assert.assertEquals(4.5, FP.approach(3.5, 7, 1));
			Assert.assertEquals(5.5, FP.approach(3.5, 5.5, 2));
			Assert.assertEquals(4.5, FP.approach(3.5, 4.5, 2));
		}
		
		[Ignore("Want clarification on canonical behaviour")]
		[Test]
		public function approachDown():void
		{
			//TODO These tests fail approach doesn't handle negative values
			Assert.assertEquals(2.5, FP.approach(3.5, 1.5, -1));
			Assert.assertEquals(1.5, FP.approach(3.5, 1.5, -2));
			Assert.assertEquals(6.5, FP.approach(3.5, 2.5, -2));
		}
		
		[Test]
		public function approachZero():void
		{
			Assert.assertEquals(4, FP.approach(4, 4.5, 0));
		}
		
		[Test]
		public function lerpExtremes():void
		{
			Assert.assertEquals(4, FP.lerp(4, 6, 0));
			Assert.assertEquals(6, FP.lerp(4, 6, 1));
		}
		
		[Test]
		public function lerpMid():void
		{
			Assert.assertEquals(4.5, FP.lerp(4, 6, 0.25));
			Assert.assertEquals(5, FP.lerp(4, 6, 0.5));
		}
		
		[Test]
		public function lerpZero():void
		{
			Assert.assertEquals(4, FP.lerp(4, 4, 0.25), FP.lerp(4, 4, 0.75));
		}
		
		[Ignore("Want clarification on canonical behaviour")]
		[Test]
		public function lerpOutside():void
		{
			Assert.assertEquals(4, FP.lerp(4, 6, -34));
			Assert.assertEquals(6, FP.lerp(4, 6, 34));
		}
		
		[Test]
		public function colorLerpExtremes():void
		{
			Assert.assertEquals(0xFF00FF00, FP.colorLerp(0xFF00FF00, 0x00FF00FF, 0));
			Assert.assertEquals(0x00FF00FF, FP.colorLerp(0xFF00FF00, 0x00FF00FF, 1));
		}
		
		[Test]
		public function colorLerpMid():void
		{
			Assert.assertEquals(0xbf3fbf3f, FP.colorLerp(0xFF00FF00, 0x00FF00FF, 0.25));
			Assert.assertEquals(0x3fbf3fbf, FP.colorLerp(0xFF00FF00, 0x00FF00FF, 0.75));
		}
		
		[Test]
		public function colorLerpZero():void
		{
			Assert.assertEquals(0xFF00FF00, FP.colorLerp(0xFF00FF00, 0xFF00FF00, 0.25));
			Assert.assertEquals(0xFF00FF00, FP.colorLerp(0xFF00FF00, 0xFF00FF00, 0.75));
		}
		
		[Test]
		public function colorLerpOutside():void
		{
			Assert.assertEquals(0xFF00FF00, FP.colorLerp(0xFF00FF00, 0x00FF00FF, -34));
			Assert.assertEquals(0x00FF00FF, FP.colorLerp(0xFF00FF00, 0x00FF00FF, 34));
		}
		
		[Test]
		public function stepTowardsZero():void
		{
			FP.entity.x = 1; FP.entity.y = -3;
			FP.stepTowards(FP.entity, 4, 5, 0);
			Assert.assertEquals(1, FP.entity.x);
			Assert.assertEquals(-3, FP.entity.y);
		}
		
		[Test]
		public function stepTowardsArrive():void
		{
			FP.entity.x = 1; FP.entity.y = -3;
			FP.stepTowards(FP.entity, 4, 5, 20);
			Assert.assertEquals(4, FP.entity.x);
			Assert.assertEquals(5, FP.entity.y);
		}
		
		[Test]
		public function stepTowardsNotArrive():void
		{
			FP.entity.x = 1; FP.entity.y = -3;
			FP.stepTowards(FP.entity, 1, 5, 2);
			Assert.assertEquals(1, FP.entity.x);
			Assert.assertEquals(-1, FP.entity.y);
		}
		
		
		
		
		
	}

}