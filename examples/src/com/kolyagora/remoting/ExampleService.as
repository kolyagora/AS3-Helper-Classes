package com.kolyagora.remoting
{
	/**
	 * Пример реализации клиентской части сервиса
	 *
	 * @author Nikolay Podoprigora, volzhanin@gmail.com
	 */
	public class ExampleService extends AbstractService
	{
		/**
		 * Конструктор
		 * @param	gateway Адрес шлюза
		 */
		public function ExampleService(gateway:String)
		{
			// Вызов конструктора родительского класса
			super(gateway);
			
			// Назначение обработчиков
			setCallbacks('get_data', onGetData, onError);
			setCallbacks('get_sum', onGetSum, onError);
		}
		
		/**
		 * Вызов удалённого метода без параметров
		 */
		public function getData():void
		{
			call('get_data');
		}
		
		/**
		 * Вызов удалённого метода с передачей двух параметров
		 * @param	x
		 * @param	y
		 */
		public function getSum(x:Number, y:Number):void
		{
			call('get_sum', x, y);
		}
		
		/**
		 * Обработчик результата вызова удалённого метода
		 * @param	response Ответ сервера
		 */
		private function onGetData(response:Object):void
		{
			// Обработка результата и оповещение внешнего объекта, инициировавшего
			// вызов удалённого метода
		}
		
		/**
		 * Обработчик результата вызова удалённого метода
		 * @param	response Ответ сервера
		 */
		private function onGetSum(response:Object):void
		{
			// Обработка результата и оповещение внешнего объекта, инициировавшего
			// вызов удалённого метода
		}
		
		/**
		 * Обработчик ошибок, которые могут возникнуть во время выполнения удалённого метода
		 * @param	response Объект, содержащий сообщение об ошибке
		 */
		private function onError(response:Object):void
		{
			// Обработка ошибки
		}
	}
}