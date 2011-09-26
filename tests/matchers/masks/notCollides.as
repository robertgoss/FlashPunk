package tests.matchers.masks
{
    import org.hamcrest.Matcher
	import net.flashpunk.Mask

    public function notCollides(value:Mask):Matcher
    {
        return new NotCollideMatcher(value);
    }
        
}