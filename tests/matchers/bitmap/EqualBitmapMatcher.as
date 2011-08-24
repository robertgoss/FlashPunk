package tests.matchers.bitmap
{
    import org.hamcrest.Description;
    import org.hamcrest.BaseMatcher;

    import flash.display.BitmapData;

    /**
     * Matches if the 2 bitmaps are equal.
     */
    public class EqualBitmapMatcher extends BaseMatcher
    {
        private var _value:BitmapData;

        public function EqualBitmapMatcher(value:BitmapData)
        {
            _value = value;
        }


        override public function matches(item:Object):Boolean
        {
            return dimensions(item as BitmapData) && !dataSolid(item as BitmapData);
        }


        override public function describeMismatch(item:Object, mismatchDescription:Description):void
        {
            var diff:Object = dataSolid(item as BitmapData);
            if (!diff)
            {
                if (dimensions(item as BitmapData))
                {
                     mismatchDescription
                    .appendValue(item)
                    .appendText(" has the wrong dimensions");
                }else
                {
                    mismatchDescription
                    .appendValue(item)
                    .appendText(" is the wrong type");
                }
            }else
            {
                mismatchDescription
                    .appendValue(item)
                    .appendText(" at ")
                    .appendValue(diff.i)
                    .appendText(",")
                    .appendValue(diff.j)
                    .appendText(" is ")
                    .appendValue(item.getPixel32(diff.i,diff.j))
                    .appendText(" as opposed to ")
                    .appendValue(_value)
            }
        }

        override public function describeTo(description:Description):void
        {
            description
                .appendText("Bitmap with the same data as ")
                .appendValue(_value);
        }
        
        public function dimensions(item:BitmapData):Object
        {
            return (item.width==_value.width) && (item.height==_value.height)
        }

        public function dataSolid(item:BitmapData):Object
        {
            for (var i:int=0;i<item.width;i++)
            {
                for (var j:int=0;j<item.height;j++)
                {
                    if (item.getPixel32(i,j)!=_value.getPixel32(i,j))
                    {
                        var diff:Object = new Object()
                        diff.i = i; diff.j = j;
                        return diff;
                    }
                }
            }
            return null;
        }
    }
}

