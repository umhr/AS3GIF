package  
{
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class Ichimatsu extends Shape 
	{
		private var cell:BitmapData = new BitmapData(16, 16, false, 0xFFFFFFFF);
		private var _width:int;
		private var _height:int;
		public function Ichimatsu(width:int = -1, height:int = -1) 
		{
			_width = width;
			_height = height;
			init();
		}
		private function init():void 
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			cell.fillRect(new Rectangle(8, 0, 8, 8), 0xCCCCCC);
			cell.fillRect(new Rectangle(0, 8, 8, 8), 0xCCCCCC);
			
			
			draw();
		}
		
		private function draw():void 
		{
			var w:int = (_width == -1)?stage.stageWidth:_width;
			var h:int = (_height == -1)?stage.stageHeight:_height;
			
			graphics.clear();
			graphics.beginBitmapFill(cell);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
	}
	
}