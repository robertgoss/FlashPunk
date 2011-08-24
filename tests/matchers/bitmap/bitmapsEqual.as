package tests.matchers.bitmap
{
    import org.hamcrest.Matcher

    public function bitmapsEqual(value:BitmapData):Matcher
    {
        return new EqualBitmapMatcher(value);
    }
        
}