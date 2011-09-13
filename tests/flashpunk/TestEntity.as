package tests.flashpunk
{
    import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;

    import tests.matchers.entity.atPosition;
    import tests.matchers.bitmap.bitmapSolid;
    
	import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.World;
    import net.flashpunk.Engine;
    import net.flashpunk.Graphic;
    import net.flashpunk.graphics.Stamp;
    import net.flashpunk.masks.Hitbox;

    import tests.harness.CallbackEntity;

    import flash.display.BitmapData;

    public class TestEntity
    {

        public var redSq:Entity;
        public var greenSq:Entity;
        public var blueSq:Entity;

        [Before]
        public function init():void
        {
            //Need async code to use FP.world!
            var engine:Engine = new Engine(100,100);
            FP.world = new World();
            engine.update();

            redSq = new Entity(0,0,new Stamp(new BitmapData(100,100,true,0xFFFF0000)));
            greenSq = new Entity(0,0,new Stamp(new BitmapData(100,100,true,0xFF00FF00)));
            blueSq = new Entity(0,0,new Stamp(new BitmapData(100,100,true,0xFF0000FF)));
         
        }

        [Test]
        public function create():void
        {
            var m:Hitbox = new Hitbox(3,2)
            var g:Graphic = new Stamp(new BitmapData(100,100,true,0xFFFF0000))
            var e:Entity = new Entity(-1,2,g,m)
            Assert.assertEquals(m,e.mask)
            Assert.assertEquals(g,e.graphic)
            assertThat(e, atPosition(-1,2))
        }

        [Test]
        public function renderToTarget():void
        {
            var target:BitmapData = new BitmapData(100,100,true,0xFF000000);
            redSq.renderTarget = target
            redSq.render()
            assertThat(target,bitmapSolid(0xFFFF0000))
        }

        /* Ignore most getters /setters unless needs a callback */

        [Test]
        public function world():void
        {
            FP.world.add(redSq)
            FP.engine.update()
            Assert.assertEquals(FP.world,redSq.world)
        }

        [Test]
        public function layerDefault():void
        {
            Assert.assertEquals(0,redSq.layer)
        }

        [Test]
        public function layerChange():void
        {
            FP.world.add(redSq)
            FP.engine.update()
            redSq.layer = 10
            Assert.assertEquals(1,FP.world.layerCount(10))
            Assert.assertEquals(0,FP.world.layerCount(0))
        }

        [Test]
        public function typeDefault():void
        {
            Assert.assertEquals(null,redSq.type)
        }

        [Test]
        public function typeChange():void
        {
            FP.world.add(redSq)
            FP.engine.update()
            redSq.type = "A type"
            Assert.assertEquals(1,FP.world.typeCount("A type"))
            Assert.assertEquals(0,FP.world.typeCount(""))
        }

        [Test]
        public function maskAssign():void
        {
            redSq.mask = new Hitbox(10,10)
            Assert.assertEquals(redSq,redSq.mask.parent)
        }

        [Test]
        public function maskHitbox():void
        {
            redSq.mask = new Hitbox(10,10)
            Assert.assertEquals(10,redSq.width)
            Assert.assertEquals(10,redSq.height)
        }

        [Test]
        public function setHitboxToOriginXY():void
        {
            var obj:Object = {width:10, height:3, originX:1, originY:1}
            var e:Entity = new Entity(0,0);
            e.setHitboxTo(obj)
            Assert.assertEquals(10,e.width)
            Assert.assertEquals(3,e.height)
            Assert.assertEquals(1,e.originX)
            Assert.assertEquals(1,e.originY)
        }

        [Ignore("Want clarification on canonical behaviour")]
        [Test]
        public function setHitboxToXY():void
        {
            var obj:Object = {width:10, height:3, x:-1, y:-1}
            var e:Entity = new Entity(0,0);
            e.setHitboxTo(obj)
            Assert.assertEquals(10,e.width)
            Assert.assertEquals(3,e.height)
            Assert.assertEquals(1,e.originX)
            Assert.assertEquals(1,e.originY)
        }

        
            
    }
}
