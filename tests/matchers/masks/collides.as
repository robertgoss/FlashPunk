package tests.matchers.masks
{
    import org.hamcrest.Matcher
	import net.flashpunk.Mask

    public function collides(value:Mask):Matcher
    {
        return new CollideMatcher(value);
    }
        
}