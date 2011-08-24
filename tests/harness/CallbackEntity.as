package tests.harness
{
    import net.flashpunk.Entity

    /**
     * Dectects if a the entitys callback have been called.
     */
    public class CallbackEntity extends Entity
    {
        /**
         * If the added method called.
         */
        public var addedCalled:Boolean = false;

        /**
         * If the removed method called.
         */
        public var removedCalled:Boolean = false;

        /**
         * If the update method called.
         */
        public var updateCalled:Boolean = false;

        /**
         * If the render method called.
         */
        public var renderCalled:Boolean = false;
        
        override public function added():void
        {
            addedCalled = true;
        }

        override public function removed():void
        {
            removedCalled = true;
        }

        override public function update():void
        {
            updateCalled = true;
        }

        override public function render():void
        {
            renderCalled = true;
        }
    }
}