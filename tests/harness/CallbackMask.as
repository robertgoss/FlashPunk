package tests.harness
{
    import net.flashpunk.Mask

    public class CallbackMask extends Mask
    {
        public var collideCalled:Boolean = false

        override public function collide(mask:Mask):Boolean
        {
            collideCalled = true
        }
    }
}