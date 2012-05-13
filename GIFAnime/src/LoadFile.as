package  
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	public class LoadFile extends EventDispatcher{
		private var _fileReference:FileReference;
		/**
		 * 開始
		 */
		public function Start(typeFilter:Array = null):void
		{
			if(_fileReference){
				return;
			}
			_fileReference = new FileReference();
			_fileReference.browse(typeFilter);
			_fileReference.addEventListener(Event.SELECT, atSelect);
		}
		
		public var content:*;
		public var byteArray:ByteArray;
		
		/**
		 * ファイルの選択が完了すると動く
		 * @param event
		 *
		 */
		private function atSelect(event:Event):void{
			_fileReference.removeEventListener(Event.SELECT, atSelect);
			_fileReference.addEventListener(Event.COMPLETE, atFileComplete);
			_fileReference.load();
		}
		/**
		 * 選択したファイルを読み込み完了すると動く
		 * @param event
		 *
		 */
		private function atFileComplete(event:Event):void{
			_fileReference.removeEventListener(Event.COMPLETE, atFileComplete);
			
			byteArray = event.target.data as ByteArray;
			dispatchEvent(event);
			_fileReference = null;
			
			//var loader:Loader = new Loader();
			//var byteArray:ByteArray = event.target.data as ByteArray;
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, atBytesComplete);
			//loader.loadBytes(byteArray, new LoaderContext());
		}
		
		/**
		 * 読み込んだファイルのバイトアレイを変換完了で動く
		 * @param event
		 *
		 */
		//private function atBytesComplete(event:Event):void {
			//event.target.removeEventListener(Event.COMPLETE, atBytesComplete);
			//content = event.target.content;
			//dispatchEvent(event);
			//_fileReference = null;
		//}
	}
}