package faml;

class Faml {
	/**
	 * parses data to a Dynamic String Map
	 */
	public static function parse(data:String):Map<String, Dynamic> {
        return new Parser(data).parse();
    }
    
    /**
     * warning: doesn't support all types
     */
    public static function stringify(map:Map<String, Dynamic>):String {
        return Stringifier.stringify(map);
    }
}