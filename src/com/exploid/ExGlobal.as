package com.exploid
{
	
	import flash.display.Graphics;
	
	public class ExGlobal
	{
		/**
		 * How much time in seconds has occured since the last frame 
		 */			
		public static var elapsed:Number;
		
		public static var worldWidth:int = 800;
		
		public static var worldHeight:int = 400;
		
		public static var input:ExInput;
		
		[Bindable] public static var score:int  = 0;
		
		public static var currentMultiplier:int = 0;
		
		/**
		 * Draws information about the current state on a ExGroup
		 * directly onto the graphics buffer. 
		 *  
		 * @param g The graphics context to draw onto
		 * @param group The group to draw
		 * @param lineColor The colors to use (default black)
		 */		
		public static function debugDraw(g:Graphics, group:ExGroup, lineColor:uint = 0x0):void {
			
			g.lineStyle(1, lineColor);
			
			for each(var obj:ExParticle in group.members) {
				g.drawCircle(obj.x, obj.y, obj.radius);
				g.moveTo(obj.x, obj.y);
				g.lineTo(obj.x + obj.velocity.x, obj.y + obj.velocity.y);
			}
		}
	}
}