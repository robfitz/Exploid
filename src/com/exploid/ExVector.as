package com.exploid
{
	/**
	 * Our simple little point class for exploid! 
	 * @author devin
	 * 
	 */	
	
	public class ExVector
	{
		
		public var x:Number;
		public var y:Number;
		
		public function ExVector(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
		}
		
		public function toString():String {
			return "ExPoint @ (" + x + ", " + y + ")";
		}
	}
}