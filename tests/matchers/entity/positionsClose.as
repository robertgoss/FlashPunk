package tests.matchers.entity
{
    import org.hamcrest.Matcher

    public function positionsClose(value:Object,delta:Number):Matcher
    {
        return new ClosePositionMatcher(value,delta);
    }
        
}