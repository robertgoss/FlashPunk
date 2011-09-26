package  tests.flashpunk
{
	import net.flashpunk.Entity;
	import net.flashpunk.Mask;
	
	import tests.matchers.masks.collides;
	
	import org.flexunit.assertThat;
	
	import org.hamcrest.core.not;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.everyItem;
	
	public class TestMask
	{
		private var _masks:Array;
		private var _mask_mask:Array;
		
		public function makeMask(x:int, y:int, width:int, height:int, originX:int, originY:int):Mask
		{
			var entity:Entity = new Entity(x, y, null, new Mask());
			entity.setHitbox(width, height, originX, originY);
			return entity.mask;
		}
		
		
		[Before]
		public function setupMasks():void
		{
			_masks = new Array();
			_masks.push(makeMask(0, 0, 10, 15, 0, 0))
			_masks.push(makeMask(20, 10, 10, 10, 10, 10))
			_masks.push(makeMask(15, 5, 1, 1, 0, 0))
			_masks.push(makeMask(23, -3, 5, 5, 3, -3))
			_masks.push(makeMask(8, 11, 4, 3, 0, 3))
			for (var i in _masks)
			{
				_masks[i].parent.name = i;
			}
			_mask_mask = [[1,0,0,0,1],[0,1,1,0,1],[0,1,1,0,0],[0,0,0,1,0],[1,1,0,0,1]]
			
		}
		
		[Test]
		public function collisionsMaskMask():void
		{
			for (var i in _masks)
			{
				for (var j in _masks)
				{
					if (_mask_mask[i][j] == 1)
					{
						assertThat(_masks[i] as Mask, collides(_masks[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsMaskMask():void
		{
			for (var i in _masks)
			{
				for(var j in _masks)
				{
					if (_mask_mask[i][j] == 0)
					{
						assertThat(_masks[i] as Mask, not(collides(_masks[j] as Mask)));
					}
				}
			}
		}
	}
}