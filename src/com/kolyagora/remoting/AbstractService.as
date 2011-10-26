package com.kolyagora.remoting
{
	import com.kolyagora.utils.Obj;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.Dictionary;
	
	/**
	 * Класс служит основой для реализации сервисов, предназначенных для взаимодействия с сервером.
	 *
	 * Для реализации собственного сервиса необходимо унаследовать его класс от класса AbstractService и
	 * вызвать конструктор родительского класса, передав в качестве параметра адрес шлюза, обрабатывающего
	 * запросы.
	 * В целях упрощения имена удалённых сервисов считаются совпадающими с именами дочерних классов.
	 *
	 * @author Nikolay Podoprigora, volzhanin@gmail.com
	 */
	public class AbstractService
	{
		/**
		 * Имя удалённого сервиса
		 */
		protected var service:String;
		/**
		 * Удалённое соединение
		 */
		protected var connection:NetConnection;
		/**
		 * Набор обектов типа flash.net.Responder, используемых для получения результатов вызовов серверных методов
		 *
		 * Ключами словаря являются названия удалённых методов, значениями - объекты типа flash.net.Responder
		 */
		protected var responders:Dictionary;
		
		/**
		 * Конструктор, который должен быть вызван дочерним классом для инициализации внутренних переменных и
		 * установки соединения с сервером
		 * @param	gateway Адрес шлюза
		 * @param	name Название класса удалённого сервиса. Если не указано, то используется название дочернего класса
		 */
		public function AbstractService(gateway:String, name:String = null)
		{
			service = name || Obj.getClassName(this);
			
			// Создаём соединение с удалённым сервером
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connection.connect(gateway);
			
			// Инициализируем словарь с обработчиками рельтатов вызовов удалённых методов
			responders = new Dictionary();
		}
		
		/**
		 * Установка обработчиков результата вызова указанного метода
		 * @param	methodName Название метода
		 * @param	onResult Функция, в которую будет передан результат вызова удалённого метода
		 * @param	onError Функция, которая будет вызвана в случае возникновения ошибки на сервере
		 */
		protected function setCallbacks(methodName:String, onResult:Function, onError:Function = null):void
		{
			responders[methodName] = new Responder(onResult, onError);
		}
		
		/**
		 * Вызов удалённого метода
		 * @param	method Название метода
		 * @param	params Необязательные параметры
		 */
		protected function call(method:String, ... params):void
		{
			connection.call.apply(connection, [service + '.' + method, responders[method]].concat(params));
		}
		
		/**
		 * Обработчик ошибок сети
		 * @param	event
		 */
		private function netStatusHandler(event:NetStatusEvent):void
		{
			trace(event.type + ': ' + event.info.code);
		}
		
		/**
		 * Обработчик ошибок безопасности
		 * @param	event
		 */
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace(event.type + ': ' + event.text);
		}
	}
}