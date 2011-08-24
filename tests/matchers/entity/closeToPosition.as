package tests.matchers.entity
{
    import org.hamcrest.Matcher

    public function closeToPosition(x:Number,y:Number,delta:Number):Matcher
    {
        var o:Object = new Object();
        o.x = x; o.y = y;
        return new ClosePositionMatcher(o,delta);
    }
        
}