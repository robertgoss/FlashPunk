package  tests.flashpunk.masks
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Pixelmask;
	
	import tests.matchers.masks.collides;
	
	import org.flexunit.assertThat;
	
	import org.hamcrest.core.not;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.everyItem;
	
	public class TestPixelMask
	{
		private var _masks:Array;
		private var _hitboxes:Array;
		private var _grids:Array;
		private var _pixels:Array;
		private var _pixel_hitbox:Array;
		private var _pixel_mask:Array;
		private var _pixel_grid:Array;
		private var _pixel_pixel:Array;
		
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
		
		public function makeGrid(x:int, y:int, tileWidth:int, tileHeight:int, data:Array, originX:int,originY:int):Mask
		{
			var entity:Entity = new Entity(x, y, null, new Mask());
			entity.mask = new Grid((data[0] as Array).length*tileWidth, data.length*tileHeight, tileWidth, tileWidth, -originX, -originY)
			for (var i:int = 0; i < (data[0] as Array).length; i++)
			{
				for (var j:int = 0; j < data.length; j++)
				{
					if (data[j][i] == 1)
					{
						(entity.mask as Grid).setTile(i, j, true);
					}
				}
			}
			return entity.mask;
		}
		
		public function makePixelmask(x:int, y:int, data:Array, originX:int,originY:int):Mask
		{
			var entity:Entity = new Entity(x, y, null, new Mask());
			var bmd:BitmapData = new BitmapData(10, 10, true, 0);
			for each(var shape:Array in data)
			{
				if (shape.length == 4)
				{
					bmd.fillRect(new Rectangle(shape[0], shape[1], shape[2], shape[3]), 1)
				}else
				{
					bmd.setPixel32(shape[0], shape[1], 1);
				}
			}
			entity.mask = new Pixelmask(bmd, -originX, -originY);
			return entity.mask;
		}
		
		[Before]
		public function setupPixelmasks():void
		{
			_pixels = new Array()
			_pixels.push(makePixelmask(0, 0, [[9, 9], [0, 0, 5, 5]], 0, 0))
			_pixels.push(makePixelmask(0, 0, [[5, 0, 1, 5], [0, 5, 5, 1]], 0, 0))
			_pixels.push(makePixelmask(1, 1, [[0, 0, 2, 2]], 1, 1))
			_pixels.push(makePixelmask(0, 0, [[9, 8], [8, 9], [8, 8]], 0, 0))
			for (var i in _pixels)
			{
				_pixels[i].parent.name = i;
			}
			_pixel_pixel = [[1, 0, 1, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]
			_pixel_grid = [[1, 0, 1, 0, 1], [0, 1, 0, 0, 1], [0, 0, 1, 0, 1], [0, 0, 0, 1, 1]]
			_pixel_mask = [[1, 0], [1, 1], [0, 0], [1, 0]]
			_pixel_hitbox = [[1, 0], [1, 1], [0, 0], [1, 0]]
		}
		
		[Before]
		public function setupGrids():void
		{
			_grids = new Array();
			_grids.push(makeGrid(0, 0, 1, 1, [[1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
											  [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
											  [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
											  [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
											  [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
											  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
											  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
											  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
											  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
											  [0, 0, 0, 0, 0, 0, 0, 0, 0, 1]],0,0))
			_grids.push(makeGrid(0, 0, 1, 1, [[0, 0, 0, 0, 0, 1],
											  [0, 0, 0, 0, 0, 1],
											  [0, 0, 0, 0, 0, 1], 
											  [0, 0, 0, 0, 0, 1],
											  [0, 0, 0, 0, 0, 1],
											  [1, 1, 1, 1, 1, 1]], 0, 0))
			_grids.push(makeGrid(0, 0, 1, 1, [[1, 1], [1, 1]], 0, 0))
			_grids.push(makeGrid(8, 8, 1, 1, [[1, 1], [1, 0]], 0, 0))
			_grids.push(makeGrid(0, 0, 2, 2, [[1, 1, 1, 0, 0],
											  [0, 0, 0, 0, 0],
											  [0, 0, 0, 0, 0], 
											  [0, 0, 0, 0, 0],
											  [0, 0, 0, 1, 0]], 0, 0))
			for (var i in _grids)
			{
				_grids[i].parent.name = i;
			}
		}
		
		[Before]
		public function setupHitboxes():void
		{
			_hitboxes = new Array();
			_hitboxes.push(makeHitbox(4, 4, 5, 5, 0, 0))
			_hitboxes.push(makeHitbox(5, 0, 1, 1, 0, 0))
			for (var i in _hitboxes)
			{
				_hitboxes[i].parent.name = i;
			}
		}
		
		
		[Before]
		public function setupMasks():void
		{
			_masks = new Array();
			_masks.push(makeMask(6, 7, 5, 5, 2, 3))
			_masks.push(makeMask(5, 0, 1, 1, 0, 0))
			for (var i in _masks)
			{
				_masks[i].parent.name = i;
			}
			
		}
		
		[Ignore("Want clarification on canonical behaviour")]
		[Test]
		public function collisionsPixelmaskHitbox():void
		{
			for (var i in _pixels)
			{
				for (var j in _hitboxes)
				{
					if (_pixel_hitbox[i][j] == 1)
					{
						assertThat(_pixels[i] as Pixelmask, collides(_hitboxes[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsPixelmaskHitbox():void
		{
			for (var i in _pixels)
			{
				for (var j in _hitboxes)
				{
					if (_pixel_hitbox[i][j] == 0)
					{
						assertThat(_pixels[i] as Pixelmask, not(collides(_hitboxes[j] as Mask)));
					}
				}
			}
		}
		
		[Ignore("Want clarification on canonical behaviour")]
		[Test]
		public function collisionsPixelmaskMask():void
		{
			for (var i in _pixels)
			{
				for (var j in _masks)
				{
					if (_pixel_mask[i][j] == 1)
					{
						assertThat(_pixels[i] as Pixelmask, collides(_masks[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsPixelmaskMask():void
		{
			for (var i in _pixels)
			{
				for (var j in _masks)
				{
					if (_pixel_mask[i][j] == 0)
					{
						assertThat(_pixels[i] as Pixelmask, not(collides(_masks[j] as Mask)));
					}
				}
			}
		}
		
		[Ignore("Want clarification on canonical behaviour")]
		[Test]
		public function collisionsPixelmaskGrid():void
		{
			for (var i in _pixels)
			{
				for (var j in _grids)
				{
					if (_pixel_grid[i][j] == 1)
					{
						assertThat(_pixels[i] as Pixelmask, collides(_grids[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsPixelmaskGrid():void
		{
			for (var i in _pixels)
			{
				for (var j in _grids)
				{
					if (_pixel_grid[i][j] == 0)
					{
						assertThat(_pixels[i] as Pixelmask, not(collides(_grids[j] as Mask)));
					}
				}
			}
		}
		
		public function collisionsPixelmaskPixelmask():void
		{
			for (var i in _pixels)
			{
				for (var j in _pixels)
				{
					if (_pixel_pixel[i][j] == 1)
					{
						assertThat(_pixels[i] as Pixelmask, collides(_pixels[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsPixelmaskPixelmask():void
		{
			for (var i in _pixels)
			{
				for (var j in _pixels)
				{
					if (_pixel_pixel[i][j] == 0)
					{
						assertThat(_pixels[i] as Pixelmask, not(collides(_pixels[j] as Mask)));
					}
				}
			}
		}
		
	}
}