package
{
	// AS3 GIFPlayer 0.2
	// www.bytearray.org
	// thibault@bytearray.org
	
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.bytearray.gif.events.FileTypeEvent;
	import org.bytearray.gif.events.FrameEvent;
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.events.TimeoutEvent;
	import org.bytearray.gif.player.GIFPlayer;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite
	{
		// we create the GIFPlayer, GIF is played automatically
		private var myGIFPlayer:GIFPlayer = new GIFPlayer();
		private var imageFilter:FileFilter = new FileFilter("Image Files (*.gif)", "*.gif");
		private var infos_txt:TextField = new TextField();
		private var render_txt:TextField = new TextField();
		private var upload_btn:PushButton = new PushButton();
		private var btn_play:PushButton = new PushButton();
		private var btn_stop:PushButton = new PushButton();
		private var btn_stop_random:PushButton = new PushButton();
		private var btn_play_random:PushButton = new PushButton();
		private var _loadFile:LoadFile = new LoadFile();
		
		public function Canvas()
		{
			init();
		}
		
		private function init():void
		{
			addChild(new Ichimatsu());
			
			setUI();
			
			// we show it
			addChild(myGIFPlayer);
			
			// listen for the IOErrorEvent.IO_ERROR event, dispatched when the GIF fails to load
			myGIFPlayer.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			// listen for the GIFPlayerEvent.COMPLETE event, dispatched when GIF is loaded
			myGIFPlayer.addEventListener(GIFPlayerEvent.COMPLETE, onCompleteGIFLoad);
			// listen for the FrameEvent.FRAME_RENDERED event, dispatched when a GIF frame is rendered on screen
			myGIFPlayer.addEventListener(FrameEvent.FRAME_RENDERED, onFrameRendered);
			// listen for the FileTypeEvent.INVALID event, dispatched when an invalid file is loaded
			myGIFPlayer.addEventListener(FileTypeEvent.INVALID, onInvalidFileLoaded);
			// listen timeout
			myGIFPlayer.addEventListener(TimeoutEvent.TIME_OUT, onTimeoutError);
			// we load a GIF
			//myGIFPlayer.load(new URLRequest("diego.gif"));
			myGIFPlayer.load(new URLRequest("http://www.mztm.jp/wp/wp-content/uploads/2012/05/diego.gif"));
			
			upload_btn.addEventListener(MouseEvent.CLICK, onClick);
			
			btn_stop.addEventListener(MouseEvent.CLICK, onStopClick);
			btn_play.addEventListener(MouseEvent.CLICK, onPlayClick);
			btn_stop_random.addEventListener(MouseEvent.CLICK, onRandomStopClick);
			btn_play_random.addEventListener(MouseEvent.CLICK, onRandomPlayClick);
			
			infos_txt.text = " Loading GIF file...";
			
			_loadFile.addEventListener(Event.COMPLETE, loadFile_complete);
		}
		
		private function loadFile_complete(event:Event):void 
		{
			infos_txt.text = " parsing GIF file...";
			myGIFPlayer.loadBytes(_loadFile.byteArray);
			
			upload_btn.enabled = true;
			
		}
		
		private function setUI():void 
		{
			infos_txt.x = 8;
			infos_txt.y = 250;
			infos_txt.width = 310;
			infos_txt.height = 40;
			infos_txt.wordWrap = true;
			infos_txt.defaultTextFormat = new TextFormat("_sans", 10);
			addChild(infos_txt);
			
			render_txt.x = 8;
			render_txt.y = 290;
			render_txt.width = 320;
			render_txt.height = 60;
			render_txt.wordWrap = true;
			render_txt.defaultTextFormat = new TextFormat("_sans", 10);
			addChild(render_txt);
			
			upload_btn.x = 225;
			upload_btn.y = 16;
			upload_btn.width = 100;
			upload_btn.height = 22;
			upload_btn.label = "Load GIF File";
			addChild(upload_btn);
			
			btn_play.x = 352;
			btn_play.y = 245;
			btn_play.width = 188;
			btn_play.height = 22;
			btn_play.label = "GIFPlayer.play()";
			addChild(btn_play);
			
			btn_stop.x = 352;
			btn_stop.y = 270;
			btn_stop.width = 188;
			btn_stop.height = 22;
			btn_stop.label = "GIFPlayer.stop()";
			addChild(btn_stop);
			
			btn_stop_random.x = 352;
			btn_stop_random.y = 295;
			btn_stop_random.width = 188;
			btn_stop_random.height = 22;
			btn_stop_random.label = "GIFPlayer.gotoAndStop(random)";
			addChild(btn_stop_random);
			
			btn_play_random.x = 352;
			btn_play_random.y = 320;
			btn_play_random.width = 188;
			btn_play_random.height = 22;
			btn_play_random.label = "GIFPlayer.gotoAndPlay(random)";
			addChild(btn_play_random);
		}
		
		private function onPlayClick(pEvt:MouseEvent):void
		{
			myGIFPlayer.play();
		}
		
		private function onRandomStopClick(pEvt:MouseEvent):void
		{
			var rand:int = Math.ceil(Math.random() * myGIFPlayer.totalFrames);
			myGIFPlayer.gotoAndStop(rand);
		}
		
		private function onRandomPlayClick(pEvt:MouseEvent):void
		{
			var rand:int = Math.ceil(Math.random() * myGIFPlayer.totalFrames);
			myGIFPlayer.gotoAndPlay(rand);
		}
		
		private function onStopClick(pEvt:MouseEvent):void
		{
			myGIFPlayer.stop();
		}
		
		private function onTimeoutError(pEvt:TimeoutEvent):void
		{
			infos_txt.text = "Sorry, TIME_OUT error, please try another GIF file";
		}
		
		private function onInvalidFileLoaded(pEvt:FileTypeEvent):void
		{
			infos_txt.htmlText = "Invalid file loaded !";
		}
		
		private function onIOError(pEvt:IOErrorEvent):void
		{
			infos_txt.text = "Sorry there was an error loading the GIF file";
		}
		
		private function onCompleteGIFLoad(pEvt:GIFPlayerEvent):void
		{
			var frameRect:Rectangle = pEvt.rect;
			
			myGIFPlayer.x = (stage.stageWidth - frameRect.width) / 2;
			myGIFPlayer.y = (stage.stageHeight - frameRect.height) / 2;
			
			var text:String = "";
			text += "Total Frames : " + String(myGIFPlayer.totalFrames) + "\n";
			text += "Loop : " + String(myGIFPlayer.loopCount);
			
			infos_txt.text = text;
		}
		
		private function onFrameRendered(pEvt:FrameEvent):void
		{
			var text:String = "";
			text += "Frame Width : " + pEvt.frame.bitmapData.width + " px\n";
			text += "Frame Height : " + pEvt.frame.bitmapData.height + " px\n";
			text += "Frame delay : " + pEvt.target.getDelay(pEvt.target.currentFrame) + "\n";
			text += "Current frame : " + pEvt.target.currentFrame;
			
			render_txt.text = text;
		}
		
		private function onClick(event:MouseEvent):void
		{
			_loadFile.Start(new Array(imageFilter));
		}
	}
}

