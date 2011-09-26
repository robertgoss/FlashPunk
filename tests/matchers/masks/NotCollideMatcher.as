package tests.matchers.masks 
{
	import net.flashpunk.Mask;
	import org.hamcrest.Description;
    import org.hamcrest.BaseMatcher;
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;

	/**
      * Matches if the mask collides with the given mask
      * This is based on hamcrest-as3
      */
	public class NotCollideMatcher extends BaseMatcher
	{
		private var _value:Object;
		
		public function NotCollideMatcher(value:Object) 
		{
			if (!(value is Mask))
			{
				throw new ArgumentError('object must be a mask');
			}	
			_value = value;
		}
		
		override public function matches(item:Object):Boolean
        {
            if (!(item is Mask)) return false;
			return !(_value as Mask).collide(item as Mask);
        }
		
		override public function describeMismatch(item:Object, mismatchDescription:Description):void
        {
            if (!(item is Mask))
            {
                mismatchDescription
                    .appendValue(item)
                    .appendText(" is not a mask ")
            }else
            {
                mismatchDescription
                    .appendText(maskString(item as Mask))
					.appendValue(item.parent.name)
					.appendText(" did collide with ")
            }
        }


        override public function describeTo(description:Description):void
        {
            description
                .appendText("A mask which does not collide with ")
                .appendText(maskString(_value as Mask))
				.appendValue(_value.parent.name)
        }
		
		private function maskString(item:Mask):String
		{
			var _class:Class = Class(getDefinitionByName(getQualifiedClassName(item)));
			var s:String = String(_class);
			return s.substring(7, s.length - 1);
		}
	}

}