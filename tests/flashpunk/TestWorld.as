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
    }
}