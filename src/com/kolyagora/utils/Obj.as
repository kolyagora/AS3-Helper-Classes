package com.kolyagora.utils
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Класс, содержащий вспомогательные методы для работы с объектами
	 */
	public class Obj
	{
		/**
		 * Получить строковое представление объекта любого типа в виде XML-дерева
		 * @param	o Объект
		 * @param	name Название корневого узла
		 * @return
		 */
		public static function toString(o:*, name:String = "object"):String
		{
			var x:XML = describeType(o);
			var xl:XMLList = x..variable;
			
			var xs:String = "<" + name + ">";
			
			for each (var n:*in xl)
				if (typeof(o[n.@name]) === "object")
					xs += toString(o[n.@name], n.@name);
				else
					xs += "<" + n.@name + ">" + o[n.@name] + "</" + n.@name + ">";
			for (n in o)
				if (typeof(o[n]) === "object")
					xs += toString(o[n], n);
				else
					xs += "<" + n + ">" + o[n].toString() + "</" + n + ">";
			
			xs += "</" + name + ">";
			
			return xs;
		}
		
		/**
		 * Получить имя класса, экземпляром корого является указанный объект
		 * @param	o Объект
		 * @return
		 */
		public static function getClassName(o:*):String
		{
			return getQualifiedClassName(o).split('::').pop();
		}
	}
}