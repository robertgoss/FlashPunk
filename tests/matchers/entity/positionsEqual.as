package tests.matchers.entity
{
    import org.hamcrest.Matcher

    public function positionsEqual(value:Object):Matcher
    {
        return new SamePositionMatcher(value);
    }
        
}