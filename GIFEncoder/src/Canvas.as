package {
	import com.bit101.components.PushButton;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import org.bytearray.gif.encoder.GIFEncoder;
	
	public class Canvas extends Sprite {
		
		private var _myGIFEncoder:GIFEncoder = new GIFEncoder();
			
		public function Canvas() {
			init();
		}
		
		private function init():void{
			addChild(new Ichimatsu());
			setBitmap();
			setUI();
		}
		
		/**
		 * bitmapの生成
		 */
		private function setBitmap():void 
		{
			_myGIFEncoder.start();
			_myGIFEncoder.setRepeat(0);
			
			var rgb:int = 0xFFFFFF * Math.random();
			
			var n:int = 15;
			for (var i:int = 0; i < n; i++ ) {
				var bitmap:Bitmap = new Bitmap( new BitmapData(80, 80, false, rgb) );
				bitmap.x = 16 + (i % 5 * (bitmap.width + 10));
				bitmap.y = 16 + Math.round ( Math.floor ( i / 5 ) ) * (bitmap.height + 10) ;
				
				var rectangle:Rectangle = new Rectangle(30 * Math.cos(2 * Math.PI * (i / n)) + 30, 30 * Math.sin(2 * Math.PI * (i / n)) + 30, 20, 20);
				bitmap.bitmapData.fillRect(rectangle, 0xFFFF0000);
				addChild(bitmap);
				
				_myGIFEncoder.setDelay(70);
				_myGIFEncoder.addFrame(bitmap.bitmapData);
			}
			_myGIFEncoder.finish();
		}
		
		/**
		 * UIの生成
		 */
		private function setUI():void 
		{
			var button:PushButton = new PushButton();
			button.x = 180;
			button.y = 295;
			button.label = "Generate GIF";
			button.addEventListener( MouseEvent.CLICK, button_click);
			addChild(button);
		}
		
		/**
		 * ダイアログを開いて保存します。
		 * @param	event
		 */
		private function button_click(e:MouseEvent):void 
		{
			var fileReference:FileReference = new FileReference();
			fileReference.save(_myGIFEncoder.stream, "image.gif");
		}
		
	}
}
