package;

import haxe.Json;
import sys.io.File;
import faml.Faml;

class Main {
    static function main() {
		var map = Faml.parse(File.getContent("test/test.fml"));
		File.saveContent("test/output.json", Json.stringify(map));
		File.saveContent("test/output.fml", Faml.stringify(map));
    }
}