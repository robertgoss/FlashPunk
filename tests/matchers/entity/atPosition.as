package tests.matchers.entity
{
    import org.hamcrest.Matcher

    public function atPosition(x:Number,y:Number):Matcher
    {
        var o:Object = new Object();
        o.x = x; o.y = y;
        return new SamePositionMatcher(o);
    }
        
}