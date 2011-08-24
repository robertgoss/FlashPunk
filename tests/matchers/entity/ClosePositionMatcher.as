package tests.matchers.entity
{
    import org.hamcrest.Description;
    import org.hamcrest.BaseMatcher;

    /**
      * Matches if the entity is at the same position as given value upto a delta in the infty metric.
      * This is based on hamcrest-as3
      */
    public class ClosePositionMatcher extends BaseMatcher
    {
        private var _value:Object;
        private var _delta:Number;

        public function ClosePositionMatcher(value:Object,delta:Number)
        {
            if (!havePositions(value))
            {
                throw new ArgumentError('object must have position data');
            }
            _value = value;
            _delta = delta;
        }

        override public function matches(item:Object):Boolean
        {
            if (!havePositions(item)) return false;
            return distance(item)<_delta;
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
                    .appendText(" differed to this position by ")
                    .appendValue(distance(item));
            }
        }


        override public function describeTo(description:Description):void
        {
            description
                .appendText("A object with a position within ")
                .appendValue(_delta)
                .appendText(" of ")
                .appendValue(_value.x)
                .appendText(",")
                .appendValue(_value.y);
        }

        /**
         * Does this object have an x and y value
         */
        protected function havePositions(item:Object):Boolean
        {
            if (!item) return false;
            if (!item.hasOwnProperty('x') || !item.hasOwnProperty('y')) return false;
            return true;
        }

        /**
         * Dist between points
         */ 
        protected function distance(item:Object):Number
        {
            var xDiff:Number = item.x-_value.x
            if (xDiff<0) xDiff = - xDiff;
            var yDiff:Number = item.y-_value.y
            if (yDiff<0) yDiff = - yDiff;
            return (xDiff<yDiff) ? xDiff : yDiff;
        }
        
    }
}