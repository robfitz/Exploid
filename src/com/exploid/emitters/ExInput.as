package com.exploid.emitters
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class ExInput
	{
		private var _map:Object;
		
		public function ExInput(stage:Stage)
		{
			_map = new Object();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		}
		
		public function isPressed(keyCode:int):Boolean {
			if(_map[keyCode] >= 1) {
				return true;
			}
			return false;
		}
		
		
		public function updateInput():void {
			var i:uint = 0;
			while(i < 256) {
				if(_map[i] == -1) {
					_map[i] = 0;
				} else if(_map[i] == 2) {
					_map[i] = 1;
				}
				i ++;
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			_map[event.keyCode] = 2;
		}
		
		private function onKeyUp(event:KeyboardEvent):void {
			_map[event.keyCode] = -1;
		}
	}
}