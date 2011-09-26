package  tests.flashpunk.masks
{
	import net.flashpunk.Entity;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	
	import tests.matchers.masks.collides;
	
	import org.flexunit.assertThat;
	
	import org.hamcrest.core.not;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.everyItem;
	
	public class TestHitbox
	{
		private var _masks:Array;
		private var _hitboxes:Array;
		private var _hitbox_hitbox:Array;
		private var _hitbox_mask:Array;
		
		public function makeMask(x:int, y:int, width:int, height:int, originX:int, originY:int):Mask
		{
			var entity:Entity = new Entity(x, y, null, new Mask());
			entity.setHitbox(width, height, originX, originY);
			return entity.mask;
		}
		
		public function makeHitbox(x:int, y:int, width:int, height:int, originX:int, originY:int):Mask
		{
			var entity:Entity = new Entity(x, y, null, new Mask());
			entity.mask = new Hitbox(width, height, -originX, -originY);
			return entity.mask;
		}
		
		[Before]
		public function setupHitboxes():void
		{
			_hitboxes = new Array();
			_hitboxes.push(makeHitbox(0, 0, 10, 15, 0, 0))
			_hitboxes.push(makeHitbox(20, 10, 10, 10, 10, 10))
			_hitboxes.push(makeHitbox(15, 5, 1, 1, 0, 0))
			_hitboxes.push(makeHitbox(23, -3, 5, 5, 3, -3))
			_hitboxes.push(makeHitbox(8, 11, 4, 3, 0, 3))
			for (var i:String in _masks)
			{
				_hitboxes[i].parent.name = i;
			}
			_hitbox_mask = [
							[1, 0, 0, 0, 1],
							[0, 1, 1, 0, 1],
							[0, 1, 1, 0, 0],
							[0, 0, 0, 1, 0],
							[1, 1, 0, 0, 1]]
			_hitbox_hitbox = [
							[1, 0, 0, 0, 1],
							[0, 1, 1, 0, 1],
							[0, 1, 1, 0, 0],
							[0, 0, 0, 1, 0],
							[1, 1, 0, 0, 1]]
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
			for (var i:String in _masks)
			{
				_masks[i].parent.name = i;
			}
			
		}
		
		[Test]
		public function collisionsHitboxHitbox():void
		{
			for (var i:String in _hitboxes)
			{
				for (var j:String in _hitboxes)
				{
					if (_hitbox_hitbox[i][j] == 1)
					{
						assertThat(_hitboxes[i] as Hitbox, collides(_hitboxes[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsHitboxHitbox():void
		{
			for (var i:String in _hitboxes)
			{
				for (var j:String in _hitboxes)
				{
					if (_hitbox_hitbox[i][j] == 0)
					{
						assertThat(_hitboxes[i] as Hitbox, not(collides(_hitboxes[j] as Mask)));
					}
				}
			}
		}
		
		[Test]
		public function collisionsHitboxMask():void
		{
			for (var i:String in _hitboxes)
			{
				for (var j:String in _masks)
				{
					if (_hitbox_mask[i][j] == 1)
					{
						assertThat(_hitboxes[i] as Hitbox, collides(_masks[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsHitboxMask():void
		{
			for (var i:String in _hitboxes)
			{
				for(var j:String in _masks)
				{
					if (_hitbox_mask[i][j] == 0)
					{
						assertThat(_hitboxes[i] as Hitbox, not(collides(_masks[j] as Mask)));
					}
				}
			}
		}
	}
}