package  tests.flashpunk
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	import org.flexunit.assumeThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.number.closeTo;
	import org.hamcrest.core.both;
	import org.hamcrest.number.between;
	import org.flexunit.experimental.theories.Theories;
	
	import net.flashpunk.FP
	
	[RunWith("org.flexunit.experimental.theories.Theories")]
	public class TestFP 
	{
		private var theory:Theories;
		
		[Before]
		public function init():void
		{
			FP.entity = new Entity();
            FP.entity.x = -2;
            FP.entity.y = 3.2;
		}
		
		[DataPoints]
		[ArrayElementType("Number")]
		public  static var numValues:Array = [-23,-10,-1.56,0,0.1,1.4,1.5,3.1,3.2,50,65,230];

        [DataPoints]
		[ArrayElementType("int")]
		public  static var intValues:Array = [-1,0,2];
		
		[Test]
		public function removeSucc():void
		{
			var arr:Array = [1, 2, 4, 6];
			FP.remove(arr, 4);
			assertThat(array(arr, [1, 2, 6]));
		}
		
		[Test]
		public function removeFail():void
		{
			var arr:Array = [1, 2, 4, 6];
			FP.remove(arr, 105);
			assertThat(array(arr, [1, 2, 4, 6]));
		}
		
		[Ignore("Want clarification on canonical behaviour")]
		[Test]
		public function removeDup():void
		{
			var arr:Array = [1, 2, 4, 4, 6];
			FP.remove(arr, 4);
			assertThat(array(arr, [1, 2, 6]));
		}
		
		[Test]
		public function choose():void
		{
			//make sure all values are from correct array
			var arr:Array = [1, 2, 4, 6, 1009, -4];
			var i:int = 20;
			while (i)
			{
				assertThat(arr, hasItem(FP.choose(arr)));
				i--;
			}
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
		
		[Ignore("Want clarification on canonical behaviour")]
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
		
		[Test]
		public function anchorZero():void
		{
			FP.entity.x = 1; FP.entity.y = -3;
			var anchor:Entity = new Entity();
			anchor.x = 4; anchor.y = 5;
			FP.anchorTo(FP.entity, anchor, 0);
			Assert.assertEquals(4, FP.entity.x);
			Assert.assertEquals(5, FP.entity.y);
		}
		
		[Test]
		public function anchorInside():void
		{
			FP.entity.x = 1; FP.entity.y = -3;
			var anchor:Entity = new Entity();
			anchor.x = 1; anchor.y = 5;
			FP.anchorTo(FP.entity, anchor, 1);
			Assert.assertEquals(1, FP.entity.x);
			Assert.assertEquals(4, FP.entity.y);
		}
		
		[Test]
		public function anchorOutside():void
		{
			FP.entity.x = 1; FP.entity.y = -3;
			var anchor:Entity = new Entity();
			anchor.x = 4; anchor.y = 5;
			FP.anchorTo(FP.entity, anchor, 100);
			Assert.assertEquals(1, FP.entity.x);
			Assert.assertEquals(-3, FP.entity.y);
		}
		
		[Test]
		public function angleTranslate():void
		{
			assertThat(FP.angle(0, 0, 3, 4), closeTo(FP.angle(1, -4.5, 4, -0.5),10e-6));
		}
		
		[Test]
		public function angleSimple():void
		{
			assertThat(FP.angle(0, 0,  1,  0), closeTo(0, 10e-6));
			assertThat(FP.angle(0, 0,  1, -1), closeTo(45, 10e-6));
			assertThat(FP.angle(0, 0,  0, -1), closeTo(90, 10e-6));
			assertThat(FP.angle(0, 0, -1, -1), closeTo(135, 10e-6));
			assertThat(FP.angle(0, 0, -1,  0), closeTo(180, 10e-6));
			assertThat(FP.angle(0, 0, -1,  1), closeTo(225, 10e-6));
			assertThat(FP.angle(0, 0,  0,  1), closeTo(270, 10e-6));
			assertThat(FP.angle(0, 0,  1,  1), closeTo(315, 10e-6));
		}
		
		[Test]
		public function angleXYSimple():void
		{
			FP.angleXY(FP.entity, 0, 1, 0, 0);
			assertThat(both(FP.entity.x, 1, FP.entity.y, 0));
			FP.angleXY(FP.entity, 45, 1, 0, 0);
			assertThat(both(FP.entity.x, 1, FP.entity.y, -1));
			FP.angleXY(FP.entity, 90, 1, 0, 0);
			assertThat(both(FP.entity.x, 0, FP.entity.y, -1));
			FP.angleXY(FP.entity, 135, 1, 0, 0);
			assertThat(both(FP.entity.x, -1, FP.entity.y, -1));
			FP.angleXY(FP.entity, 180, 1, 0, 0);
			assertThat(both(FP.entity.x, -1, FP.entity.y, 0));
			FP.angleXY(FP.entity, 225, 1, 0, 0);
			assertThat(both(FP.entity.x, -1, FP.entity.y, 1));
			FP.angleXY(FP.entity, 270, 1, 0, 0);
			assertThat(both(FP.entity.x, 0, FP.entity.y, 1));
			FP.angleXY(FP.entity, 315, 1, 0, 0);
			assertThat(both(FP.entity.x, 1, FP.entity.y, 1));
		}
		
		[Theory]
		public function angleXYReflexive(ang:Number):void
		{
			assumeThat(ang, between(0,360))
			FP.angleXY(FP.entity, ang, 1, 0, 0)
			assertThat(FP.angle(0, 0, FP.entity.x, FP.entity.y), closeTo(ang,10e-6));
		}
		
		[Theory]
		public function angleXYScale(ang:Number, len:Number):void
		{
			assumeThat(ang, between(0, 360))
			var e:Entity = new Entity()
			FP.angleXY(e, ang, len, 0, 0)
			FP.angleXY(FP.entity, ang, 1, 0, 0)
			assertThat(e.x, closeTo(FP.entity.x * len, 10e-6));
			assertThat(e.y, closeTo(FP.entity.y * len, 10e-6));
		}

        [Test]
        public function rotateAroundZero():void
        {
            var e:Entity = new Entity();
            e.x = 1;  e.y = -3;
            FP.rotateAround(e,FP.entity,0);
            Assert.assertEquals(1,e.x);
            Assert.assertEquals(-3,e.y);
        }

        [Test]
        public function rotateAroundSelf():void
        {
            FP.entity.x = 1;  FP.entity.y = -3;
            FP.rotateAround(FP.entity,FP.entity,234);
            Assert.assertEquals(1,FP.entity.x);
            Assert.assertEquals(-3,FP.entity.y);
        }

        [Theory]
        public function rotateAroundCenter(ang:Number):void
        {
            var e:Entity = new Entity();
            FP.entity.x = 1;  FP.entity.y = 0;
            var o:Entity = new Entity();
            o.x = 0;  o.y = 0;
            FP.angleXY(e,ang,1);
            FP.rotateAround(FP.entity,o,ang);
            Assert.assertEquals(e.x,FP.entity.x);
            Assert.assertEquals(e.y,FP.entity.y);
        }

        [Theory]
        public function rotateAroundDist(ang:Number):void
        {
            var e:Entity = new Entity();
            e.x = 1;  e.y = -3;
            FP.entity.x = 1; FP.entity.y = -1;
            FP.rotateAround(e,FP.entity,ang);
            assertThat((e.x-1)*(e.x-1) + (e.y+1)*(e.y+1), closeTo(4,10e-5));
		}

        [Test]
        public function angleDiff():void
        {
            Assert.assertEquals(30,FP.angleDiff(20,50))
            Assert.assertEquals(0,FP.angleDiff(-180,180))
        }

        [Test]
        public function distanceSame():void
        {
            Assert.assertEquals(0,FP.distance(4.1,-3,4.1,-3));
        }

        [Test]
        public function distanceCheck():void
        {
            assertThat(FP.distance(4,5,6,6), closeTo(Math.sqrt(5),10e-6));
        }
		
        [Test]
        public function distanceRectsOverlapFull():void
        {
            Assert.assertEquals(0,FP.distanceRects(0,0,2,2,1,1,2,2));
        }

        [Test]
        public function distanceRectsOverlapEdge():void
        {
            Assert.assertEquals(0,FP.distanceRects(0,0,2,2,0,2,2,2));
        }

        [Test]
        public function distanceRectsOverlapVertex():void
        {
            Assert.assertEquals(0,FP.distanceRects(0,0,2,2,2,2,2,2));
        }

        [Test]
        public function distanceRectsNonOverlap():void
        {
            assertThat(FP.distanceRects(0,0,2,2,3,3,2,2), closeTo(Math.sqrt(2),10e-6));
        }

        [Test]
        public function distanceRectPointOverlapFull():void
        {
            Assert.assertEquals(0,FP.distanceRectPoint(1,1,0,0,2,2));
        }

        [Test]
        public function distanceRectPointOverlapEdge():void
        {
            Assert.assertEquals(0,FP.distanceRectPoint(0,1,0,0,2,2));
        }

        [Test]
        public function distanceRectPointOverlapVertex():void
        {
            Assert.assertEquals(0,FP.distanceRectPoint(2,2,0,0,2,2));
        }

        [Test]
        public function distanceRectPointNonOverlap():void
        {
            assertThat(FP.distanceRectPoint(3,3,0,0,2,2), closeTo(Math.sqrt(2),10e-6));
        }

        [Test]
        public function clamp():void
        {
            Assert.assertEquals(5,FP.clamp(6,3,5))
            Assert.assertEquals(3,FP.clamp(1,3,5))
            Assert.assertEquals(4,FP.clamp(4,3,5))
        }

        [Test]
        public function clampSame():void
        {
            Assert.assertEquals(5,FP.clamp(6,5,5));
        }

        [Test]
        public function clampInRectInside():void
        {
            FP.entity.x = 1; FP.entity.y = 1;
            FP.clampInRect(FP.entity,0,0,2,2);
            Assert.assertEquals(1,FP.entity.x);
            Assert.assertEquals(1,FP.entity.y);
        }

        [Test]
        public function clampInRectOutsideX():void
        {
            FP.entity.x = 4; FP.entity.y = 1;
            FP.clampInRect(FP.entity,0,0,2,2);
            Assert.assertEquals(2,FP.entity.x);
            Assert.assertEquals(1,FP.entity.y);
        }

        [Test]
        public function scale():void
        {
            //From doc
            Assert.assertEquals(15,FP.scale(.5, 0, 1, 10, 20))
            Assert.assertEquals(40,FP.scale(3, 0, 5, 100, 0))
        }

        [Ignore("Want clarification on canonical behaviour")]
        [Test]
        public function scaleZero():void
        {
            Assert.assertEquals(3,FP.scale(5,0,4,3,3));
        }

        [Theory]
        public function scaleClamp(n1:int,n2:int,n3:int,n4:int,n5:int):void
        {
            Assert.assertEquals(FP.clamp(FP.scale(n1,n2,n3,n4,n5),n4,n5),FP.scaleClamp(n1,n2,n3,n4,n5));
        }

        
	}

}