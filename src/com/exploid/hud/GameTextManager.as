package com.exploid.hud
{
	import mx.containers.Canvas;

	public class GameTextManager extends Canvas
	{
		
		public static function get instance():GameTextManager {
			if (!_instance) _instance = new GameTextManager();
			return _instance;
		}
		private static var _instance:GameTextManager;
		
		private var labels:Array;
		
		public function GameTextManager()
		{
			super();
			labels = [];
			createLabels();
		}
		
		private function createLabels(numToAdd:uint=10):void {
			for (var i:int = 0; i < numToAdd; i ++) {
				labels.push(addChild(new GameText()));
				
			}
		}
		
		public function show(message:String, x:int, y:int):void {
			for each (var text:GameText in labels) {
				if (!text.is_active()) {
					text.x = x;
					text.y = y;
					text.show(message);
					return; //avoids infinite loop by breaking on success
				}
			}
			//if haven't found an empty label to recycle, create some blank
			//ones and try again
			createLabels();
			show(message, x, y);
		}		
	}
}