package 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	public class DrawRectangle extends EventDispatcher
	{
		var border_sprite:Sprite;

		var left_point:Point;
		var right_point:Point;
		var start_point:Point;

		var _stage:Stage;

		public var rec:Rectangle;
		public static var RECT_OK:String = "rectangle_ok";

		public function DrawRectangle(_stage:Stage=null)
		{
			// constructor code
			this._stage = _stage;
			left_point = new Point();
			right_point = new Point();
			start_point = new Point();
		}


		public function startDraw()
		{
			_stage.addEventListener(MouseEvent.MOUSE_DOWN ,MouseDownHandler);
		}


		function MouseDownHandler(_evt:MouseEvent):void
		{
			border_sprite = new Sprite  ;
			_stage.addChild(border_sprite);
			start_point.x = _stage.mouseX;
			start_point.y = _stage.mouseY;
			_stage.addEventListener(MouseEvent.MOUSE_MOVE ,MouseMoveHandler);
			_stage.addEventListener(MouseEvent.MOUSE_UP ,MouseUpHandler);
		}
		function MouseMoveHandler(_evt:MouseEvent):void
		{
			right_point.x = Math.max(_stage.mouseX,start_point.x);
			right_point.y = Math.max(_stage.mouseY,start_point.y);
			left_point.x = Math.min(_stage.mouseX,start_point.x);
			left_point.y = Math.min(_stage.mouseY,start_point.y);

			border_sprite.graphics.clear();
			border_sprite.graphics.lineStyle(1,0xffff00);
			border_sprite.graphics.moveTo(left_point.x,left_point.y);
			border_sprite.graphics.lineTo(right_point.x,left_point.y);
			border_sprite.graphics.lineTo(right_point.x,right_point.y);
			border_sprite.graphics.lineTo(left_point.x,right_point.y);
			border_sprite.graphics.lineTo(left_point.x,left_point.y);
		}
		function MouseUpHandler(_evt:MouseEvent):void
		{
			border_sprite.graphics.clear();
			var _rectangle:Rectangle = new Rectangle(left_point.x,left_point.y,right_point.x - left_point.x,right_point.y - left_point.y);
			rec = _rectangle;
			dispatchEvent(new Event(RECT_OK));
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE ,MouseMoveHandler);
			_stage.removeEventListener(MouseEvent.MOUSE_UP ,MouseUpHandler);
		}



	}

}