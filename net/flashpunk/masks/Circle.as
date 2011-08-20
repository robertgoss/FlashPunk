package net.flashpunk.masks 
{
	import net.flashpunk.*;
	
	/**
	 * A circular mask.
	 */
	public class Circle extends Mask
	{
		/**
		 * Constructor.
		 * @param	radius      Radius of the Cicle
		 * @param	x			X offset of the center of the Circle.
		 * @param	y			Y offset of the center of the Circle.
		 */
		public function Circle(radius:uint = 1, x:int = 0, y:int = 0) 
		{
            if (radius<0) throw new Error("Cannot have negative radius");
			_radius = radius;
			_x = x;
			_y = y;
			_check[Mask] = collideMask;
			_check[Hitbox] = collideHitbox;
            _check[Circle] = collideCircle;
		}
		
		/** @private Collides against an Entity. */
		private function collideMask(other:Mask):Boolean
		{
            return radius > FP.distanceRectPoint(parent.x + _x,parent.y + _y,
                     other.parent.x - other.parent.originX, other.parent.y - other.parent.originY, 
                     other.parent.width, other.parent.height);
		}
		
		/** @private Collides against a Hitbox. */
		private function collideHitbox(other:Hitbox):Boolean
		{
			return radius > FP.distanceRectPoint(parent.x + _x,parent.y + _y,
                     other.parent.x + other._x, other.parent.y + other._y, other.width, other.height);
		}

        /** @private Collides against a Circle. */
        private function collideCircle(other:Circle):Boolean
        {
            var xDiff:int = parent.x + _x - other.parent.x - other._x;
            var yDiff:int = parent.y + _y - other.parent.y - other._y;
            var distSq:int = xDiff*xDiff + yDiff*yDiff;
            return distSq < (radius + other.radius) * (radius + other.radius);
        }
		
		// Hitbox information.
		/** @private */ internal var _radius:uint;
		/** @private */ internal var _x:int;
		/** @private */ internal var _y:int;
	}
}