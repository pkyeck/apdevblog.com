/*
 * Copyright 2007 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
package org.spicefactory.lib.util {
import flash.utils.getDefinitionByName;

import org.spicefactory.lib.errors.IllegalArgumentError;
import org.spicefactory.lib.logging.LogContext;
import org.spicefactory.lib.logging.Logger;

/**
 * Static utility methods to reflectively create new instances.
 * 
 * @author Jens Halm
 */
public class ClassUtil {
	
	
	private static var _log:Logger;


	/**
	 * Creates a new instance of the class with the specified name.
	 * 
	 * @param className the fully qualified name of the class
	 * @param params the parameters to pass to the constructor of the class
	 * @return the new instance
	 * @throws ReferenceError if the class with the specified name does not exist
	 */
	public static function createForName (className:String, params:Array) : Object {
		var Clazz:Class;
		try {
		 	Clazz = getDefinitionByName(className) as Class;
		} catch (e:ReferenceError) {
			if (_log == null) _log = LogContext.getLogger("org.spicefactory.lib.util.ClassUtil");
			_log.error("Unable to instantiate class with name " + className);
			throw e;
		}
		return createNewInstance(Clazz, params);
	}

	/**
	 * Creates a new instance of the specified class.
	 * 
	 * @param type the class to create a new instance of
	 * @param params the parameters to pass to the constructor of the class
	 * @return the new instance
	 */
	public static function createNewInstance (type:Class, params:Array) : Object {
		switch (params.length) {
			// Now this is really stupid. But there is no "Class.createInstance(args)" in AS3
			case 0: return new type();
			case 1: return new type(params[0]);
			case 2: return new type(params[0], params[1]);
			case 3: return new type(params[0], params[1], params[2]);
			case 4: return new type(params[0], params[1], params[2], params[3]);
			case 5: return new type(params[0], params[1], params[2], params[3], params[4]);
			case 6: return new type(params[0], params[1], params[2], params[3], params[4], params[5]);
			case 7: return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
			case 8: return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
			default: throw new IllegalArgumentError("Unsupported number of Constructor args: " + params.length);
		}
	}
	
}

}