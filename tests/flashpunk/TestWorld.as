package tests.flashpunk
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

    import tests.matchers.entity.positionsEqual;
    import tests.matchers.entity.positionsClose;
    import tests.matchers.entity.closeToPosition;
    import tests.matchers.entity.atPosition;
    
	import net.flashpunk.FP;
    import net.flashpunk.Entity;
    import net.flashpunk.World;
    import net.flashpunk.Engine;

    import tests.harness.CallbackEntity;

    public class TestWorld
    {
        [Before]
        public function init()
        {
            //Need async code to use FP.world!
            var engine:Engine = new Engine(100,100);
            FP.world = new World();
            engine.update();
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
    }
}