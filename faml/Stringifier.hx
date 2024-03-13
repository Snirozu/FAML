package faml;

class Stringifier {
	public static function stringify(map:Map<String, Dynamic>) {
		var data = "";

		for (key => value in map) {
			data += '$key: ${stringifyValue(value)}\n';
		}

		return data;
	}

	static function stringifyArray(array:Array<Dynamic>):String {
		var data = "[";

		for (i in 0...array.length) {
			data += '${i == 0 ? "" : ", "}${stringifyValue(array[i])}';
		}

		return data + "]";
	}

	static function stringifyValue(value:Dynamic) {
		var data = "";

		if (value is String)
			data += '"$value"';
		else if (value is Array)
			data += stringifyArray(value);
		else
			data += value;

		return data;
	}
}