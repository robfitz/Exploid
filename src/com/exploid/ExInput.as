package com.exploid
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
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
			return _map[keyCode] && _map[keyCode].current >= 1;
		}
		
		public function isJustPressed(keyCode:int):Boolean {
			return _map[keyCode] && _map[keyCode].current == 2;
		}
		
		public function updateInput():void {
			var i:uint = 0;
			while(i < 256) {
				var k:Object = _map[i ++];
				if(k) {
					if(k.current == -1 && k.last == -1) {
						k.current = 0;
					} else if(k.current == 2 && k.last == 2) {
						k.current = 1;
					}
					k.last = k.current;
				}
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			if(_map[event.keyCode]) {
				if(_map[event.keyCode].current > 0) {
					_map[event.keyCode].current = 1;
				} else {
					_map[event.keyCode].current = 2;
				}
			}
		}
		
		private function onKeyUp(event:KeyboardEvent):void {
			if(_map[event.keyCode]) {
				_map[event.keyCode].current = -1;
			}
		}
		
		public function addKey(keyCode:uint):void {
			_map[keyCode] = {current: 0, last: 0};
		}
	}
}