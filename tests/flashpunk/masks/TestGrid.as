package  tests.flashpunk.masks
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Grid;
	
	import tests.matchers.masks.collides;
	
	import org.flexunit.assertThat;
	
	import org.hamcrest.core.not;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.everyItem;
	
	public class TestGrid
	{
		private var _masks:Array;
		private var _hitboxes:Array;
		private var _grids:Array;
		private var _grid_hitbox:Array;
		private var _grid_mask:Array;
		private var _grid_grid:Array;
		
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
		
		[Before]
		public function setupGrids():void
		{
			_grids = new Array();
			_grids.push(makeGrid(0, 0, 5, 5, [[1, 0], [0, 1]], 0, 0))
			_grids.push(makeGrid(3, 3, 2, 2, [[1, 0, 0], [0, 0, 0], [0, 0, 1]], 2, 2))
			_grids.push(makeGrid(0, 0, 2, 2, [[0, 0, 1]], 0, 0))
			_grids.push(makeGrid(0, 0, 2, 2, [[0, 1]], 0, -1));
			for (var i:String in _grids)
			{
				_grids[i].parent.name = i;
			}
			
			_grid_grid = [[1, 1, 1, 1], [1, 1, 0, 1], [1, 0, 1, 0], [1, 1, 0, 1]]
			_grid_hitbox = [[1, 1, 1, 1], [1, 1, 0, 1], [1, 0, 1, 0], [1, 1, 0, 1]]
			_grid_mask = [[1, 1, 1, 1], [1, 1, 0, 1], [1, 0, 1, 0], [1, 1, 0, 1]]
			
		}
		
		[Before]
		public function setupHitboxes():void
		{
			_hitboxes = new Array();
			_hitboxes.push(makeHitbox(0, 0, 5, 5, 0, 0))
			_hitboxes.push(makeHitbox(1, 1, 2, 2, 0, 0))
			_hitboxes.push(makeHitbox(5, 1, 2, 2, 1, 1))
			_hitboxes.push(makeHitbox(3, 2, 2, 2, 1, 1))
			for (var i:String in _hitboxes)
			{
				_hitboxes[i].parent.name = i;
			}
		}
		
		
		[Before]
		public function setupMasks():void
		{
			_masks = new Array();
			_masks.push(makeMask(0, 0, 5, 5, 0, 0))
			_masks.push(makeMask(1, 1, 2, 2, 0, 0))
			_masks.push(makeMask(5, 1, 2, 2, 1, 1))
			_masks.push(makeMask(3, 2, 2, 2, 1, 1))
			for (var i:String in _masks)
			{
				_masks[i].parent.name = i;
			}
			
		}
		
		[Test]
		public function collisionsGridHitbox():void
		{
			for (var i:String in _grids)
			{
				for (var j:String in _hitboxes)
				{
					if (_grid_hitbox[i][j] == 1)
					{
						assertThat(_grids[i] as Hitbox, collides(_hitboxes[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsGridHitbox():void
		{
			for (var i:String in _grids)
			{
				for (var j:String in _hitboxes)
				{
					if (_grid_hitbox[i][j] == 0)
					{
						assertThat(_grids[i] as Hitbox, not(collides(_hitboxes[j] as Mask)));
					}
				}
			}
		}
		
		[Test]
		public function collisionsGridMask():void
		{
			for (var i:String in _grids)
			{
				for (var j:String in _masks)
				{
					if (_grid_mask[i][j] == 1)
					{
						assertThat(_grids[i] as Hitbox, collides(_masks[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsGridMask():void
		{
			for (var i:String in _grids)
			{
				for (var j:String in _masks)
				{
					if (_grid_mask[i][j] == 0)
					{
						assertThat(_grids[i] as Hitbox, not(collides(_masks[j] as Mask)));
					}
				}
			}
		}
		
		[Test]
		public function collisionsGridGrid():void
		{
			for (var i:String in _grids)
			{
				for (var j:String in _grids)
				{
					if (_grid_grid[i][j] == 1)
					{
						assertThat(_grids[i] as Hitbox, collides(_grids[j] as Mask));
					}
				}
			}
		}
		
		[Test]
		public function noCollisionsGridGrid():void
		{
			for (var i:String in _grids)
			{
				for (var j:String in _grids)
				{
					if (_grid_grid[i][j] == 0)
					{
						assertThat(_grids[i] as Hitbox, not(collides(_grids[j] as Mask)));
					}
				}
			}
		}
		
	}
}