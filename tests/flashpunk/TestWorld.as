package tests.flashpunk
{
    import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;

    import tests.matchers.bitmap.bitmapSolid;
    
	import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.World;
    import net.flashpunk.Engine;
    import net.flashpunk.graphics.Stamp;

    import tests.harness.CallbackEntity;

    import flash.display.BitmapData;

    public class TestWorld
    {
        public var redSq:Entity;
        public var greenSq:Entity;
        public var blueSq:Entity;

        [Before]
        public function init()
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
        public function addOne():void
        {
            var e:Entity = new Entity();
            FP.world.add(e);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([e]))
        }

        [Test]
        public function addCalledback():void
        {
            var e:CallbackEntity = new CallbackEntity();
            FP.world.add(e);
            FP.engine.update(); //TODO callback be at source?
            Assert.assertTrue(e.addedCalled);
        }

        [Test]
        public function addAndRemove():void
        {
            var e:Entity = new Entity();
            FP.world.add(e);
            FP.world.remove(e);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([]))
        }

        [Test]
        public function removeOne():void
        {
            var e:Entity = new Entity();
            FP.world.add(e);
            FP.engine.update();
            FP.world.remove(e);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([]))
        }

        [Test]
        public function removeCalledback():void
        {
            var e:CallbackEntity = new CallbackEntity();
            FP.world.add(e);
            FP.engine.update();
            FP.world.remove(e);
            FP.engine.update();
            Assert.assertTrue(e.removedCalled);
        }

        [Test]
        public function removeNotCalledBack():void
        {
            var e:CallbackEntity = new CallbackEntity();
            FP.world.add(e);
            FP.engine.update(); //TODO callback be at source?
            Assert.assertFalse(e.removedCalled);
        }

        [Test]
        public function updateCalledback():void
        {
            var e:CallbackEntity = new CallbackEntity();
            FP.world.add(e);
            FP.engine.update();
            e.updateCalled = false;
            FP.world.update();
            Assert.assertTrue(e.updateCalled);
        }

        [Test]
        public function renderCalledBack():void
        {
            var e:CallbackEntity = new CallbackEntity();
            FP.world.add(e);
            FP.engine.update();
            FP.world.render();
            Assert.assertTrue(e.renderCalled);
        }

        [Test]
        public function renderNotCalledback():void
        {
            var e:CallbackEntity = new CallbackEntity();
            FP.world.add(e);
            FP.engine.update();
            Assert.assertFalse(e.renderCalled);
        }

        [Test]
        public function removeAll():void
        {
            for(var i:int=0;i<10;i++) FP.world.add(new Entity());
            FP.engine.update();
            FP.world.removeAll();
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([]))
        }

        [Ignore("Want clarification on canonical behaviour")]
        [Test]
        public function addAndRemoveAll():void
        {
            for(var i:int=0;i<10;i++) FP.world.add(new Entity());
            FP.world.removeAll();
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([]));
        }

        [Test]
        public function addList():void
        {
            var eList:Array = [];
            for(var i:int=0;i<10;i++) eList.push(new Entity());
            FP.world.addList(eList)
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array(eList.reverse()));//Reverse to get order correct.
        }

        [Test]
        public function addListEmpty():void
        {
            FP.world.addList([]);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([]));
        }

        [Test]
        public function removeList():void
        {
            var eList:Array = [];
            for(var i:int=0;i<10;i++) eList.push(new Entity());
            FP.world.addList(eList);
            var eList1:Array = [];
            for(var i:int=0;i<10;i++) eList1.push(new Entity());
            FP.world.addList(eList1);
            FP.engine.update();
            FP.world.removeList(eList1);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array(eList.reverse()));//Reverse to get order correct.
        }

        [Ignore("Want clarification on canonical behaviour")]
        [Test]
        public function addAndRemoveList():void
        {
            var eList:Array = [];
            for(var i:int=0;i<10;i++) eList.push(new Entity());
            FP.world.addList(eList);
            var eList1:Array = [];
            for(var i:int=0;i<10;i++) eList1.push(new Entity());
            FP.world.addList(eList1);
            FP.world.removeList(eList1);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array(eList.reverse()));//Reverse to get order correct.
        }

        [Test]
        public function createNew():void
        {
            FP.world.create(Entity,true);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            Assert.assertEquals(1,ents.length);
        }

        [Test]
        public function createDontAdd():void
        {
            FP.world.create(Entity,false);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            Assert.assertEquals(0,ents.length);
        }

        [Test]
        public function createRecycle():void
        {
            FP.entity = new Entity();
            FP.world.add(FP.entity);
            FP.engine.update();
            FP.world.recycle(FP.entity);
            FP.engine.update();
            FP.world.create(Entity,true);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([FP.entity]));
        }

        [Test]
        public function recycle():void
        {
            FP.entity = new Entity();
            FP.world.add(FP.entity);
            FP.engine.update();
            FP.world.recycle(FP.entity);
            FP.engine.update();
            var ents:Array = [];
            FP.world.getAll(ents);
            assertThat(ents, array([]));
        }

        [Test]
        public function bringToFront():void
        {
            FP.world.addList([redSq,blueSq,greenSq])
            FP.engine.update();
            FP.world.bringToFront(blueSq);
            Assert.assertTrue(FP.world.isAtFront(blueSq));
            FP.world.bringToFront(redSq);
            Assert.assertTrue(FP.world.isAtFront(redSq));
        }

        [Test]
        public function sendToBack():void
        {
            FP.world.addList([redSq,blueSq,greenSq])
            FP.engine.update();
            FP.world.sendToBack(blueSq);
            Assert.assertTrue(FP.world.isAtBack(blueSq));
            FP.world.sendToBack(redSq);
            Assert.assertTrue(FP.world.isAtBack(redSq));
        }

        [Test]
        public function bringForward():void
        {
            FP.world.addList([redSq,blueSq,greenSq])
            FP.engine.update();
            FP.world.sendToBack(blueSq);
            FP.world.bringForward(blueSq);
            Assert.assertFalse(FP.world.isAtFront(blueSq));
            FP.world.bringForward(blueSq);
            Assert.assertTrue(FP.world.isAtFront(blueSq));
        }

        [Test]
        public function sendBackward():void
        {
            FP.world.addList([redSq,blueSq,greenSq])
            FP.engine.update();
            FP.world.bringToFront(blueSq);
            FP.world.sendBackward(blueSq);
            Assert.assertFalse(FP.world.isAtBack(blueSq));
            FP.world.sendBackward(blueSq);
            Assert.assertTrue(FP.world.isAtBack(blueSq));
        }

        [Test]
        public function renderInLayerOrder():void
        {
            FP.world.addList([redSq,blueSq,greenSq])
            FP.engine.update();
            FP.world.bringToFront(redSq)
            FP.world.render()
            assertThat(FP.buffer, bitmapSolid(0xFFFF0000));
            FP.world.bringToFront(blueSq)
            FP.world.render()
            assertThat(FP.buffer, bitmapSolid(0xFF0000FF));
        }

        [Test]
        public function renderLayerOrder():void
        {
            redSq.layer = 2;
            blueSq.layer = 1;
            greenSq.layer = 0;
            FP.world.addList([redSq,blueSq,greenSq])
            FP.engine.update();
            FP.world.bringToFront(redSq)
            FP.world.render()
            assertThat(FP.buffer, bitmapSolid(0xFF00FF00));
            FP.world.bringToFront(blueSq)
            FP.world.render()
            assertThat(FP.buffer, bitmapSolid(0xFF00FF00));
        }
    }
}