package UI 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class HudTextField extends Sprite 
	{
		private var format : TextFormat = new TextFormat("Palatino");
		private var textField : TextField = new TextField();
		
		public function HudTextField(text : String = "", size : int = 20,color : uint = 0x000000,customFormat : TextFormat = null) 
		{
			if (customFormat != null) {
				format = customFormat;
			}
			format.size = size;
			format.color = color;
			textField.defaultTextFormat = format;
			textField.multiline = true;
			textField.selectable = false;
			textField.width = measureString(text, format).width;
			textField.height = measureString(text, format).height;
			textField.text = text;
			addChild(textField);
		}
		
		public function changeText(text : String) :void {
			textField.htmlText = text;
			textField.width = measureString(text, format).width;
			textField.height = measureString(text, format).height;
		}
		public function changeColor(color : uint) :void{
			format.color = color;
			textField.setTextFormat(format);
		}
		public function changeSize(size : int) :void{
			format.size = size;
			textField.setTextFormat(format);
			textField.width = measureString(textField.text, format).width;
			textField.height = measureString(textField.text, format).height;
		}
		
		private function measureString(str:String, format:TextFormat):Rectangle {
			var textField:TextField = new TextField();
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.defaultTextFormat = format;
			textField.text = str;
			return new Rectangle(0, 0, textField.textWidth + 3, textField.textHeight + 3);
		}
	}
}