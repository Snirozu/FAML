package faml;

using StringTools;

class Parser {
	var content:String = "";

	var i:Int = -1;
	var char:String = "";

    public function new(content:String) {
		this.content = content;
    }

	public function parse() {
        var data:Map<String, Dynamic> = new Map();

		var word:String = "";
		while (++i <= content.length) {
			char = content.charAt(i);
            
			if (char == ":") {
				data.set(word.trim(), parseValue());
				word = "";
				continue;
			}

			word += char;
        }

		return data;
    }

	function parseValue(?inArray:Bool = false):Dynamic {
		var word:String = "";

        while (++i <= content.length) {
			char = content.charAt(i);

			if (char == "[") {
				return parseArray();
			}

			if ((!inArray ? char == "\n" : char == "," || char == "]") || i == content.length) {
				if (inArray)
                    i--;
				return parseLiteral(word);
            }

			word += char;
        }

        return null;
    }

	function parseArray():Array<Dynamic> {
		var values:Array<Dynamic> = [parseValue(true)];

		while (++i <= content.length) {
			char = content.charAt(i);

			if (char == "]") {
				break;
			}
            if (char == ",") {
				values.push(parseValue(true));
                continue;
            }
			if (i == content.length) {
				return null;
			}
		}

		return values;
    }

	var numberRegex = ~/^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$/;

    function parseLiteral(value:String):Dynamic {
        value = value.trim();

        // booleans
        if (value == "true")
            return true;
		if (value == "false")
			return false;

        // number, (using floats only because it's the only type that supports 64-bit integers)
		if (numberRegex.match(value))
            return Std.parseFloat(value);

        // string
		if ((value.charAt(0) == "'" || value.charAt(0) == '"') && value.charAt(0) == value.charAt(value.length - 1))
            return value.substr(1, value.length - 2);
        return value;
    }
}