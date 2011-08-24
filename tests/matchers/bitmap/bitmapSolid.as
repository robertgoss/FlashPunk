package tests.matchers.bitmap
{
    import org.hamcrest.Matcher

    public function bitmapSolid(value:uint):Matcher
    {
        return new SolidBitmapMatcher(value);
    }
        
}