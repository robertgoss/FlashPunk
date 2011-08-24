package tests.matchers.entity
{
    import org.hamcrest.Description;
    import org.hamcrest.BaseMatcher;

    /**
      * Matches if the entity is at the same position as given value
      * This is based on hamcrest-as3
      */
    public class SamePositionMatcher extends BaseMatcher
    {
        private var _value:Object;

        public function SamePositionMatcher(value:Object)
        {
            if (!havePositions(value))
            {
                throw new ArgumentError('object must have position data');
            }
            _value = value;
        }

        override public function matches(item:Object):Boolean
        {
            trace("match");
            if (!havePositions(item)) return false;
            return (item.x==_value.x) && (item.y==_value.y);
        }

        override public function describeMismatch(item:Object, mismatchDescription:Description):void
        {
            if (!havePositions(item))
            {
                mismatchDescription
                    .appendValue(item)
                    .appendText(" has no position data ")
            }else
            {
                mismatchDescription
                    .appendValue(_value.x)
                    .appendText(",")
                    .appendValue(_value.y)
                    .appendText(" differed from this position ")
            }
        }


        override public function describeTo(description:Description):void
        {
            description
                .appendText("A object with the same position as ")
                .appendValue(_value.x)
                .appendText(",")
                .appendValue(_value.y);
        }

        /**
         * Does this object have an x and y value
         */
        protected function havePositions(item:Object):Boolean
        {
            //if (!item) return false;
            //if (!item.hasOwnProperty('x') || !item.hasOwnProperty('y')) return false;
            return true;
        }
        
    }
}