using Gee;

uint count(string group) {
	HashSet<unichar> unique = new HashSet<unichar>();
	unichar c;
	for (int i = 0; group.get_next_char(ref i, out c);) {
		unique.add(c);
	}
	return unique.size;
}

int main() {
	try {
		File file = File.new_for_path("input.txt");
		DataInputStream stream = new DataInputStream(file.read());
		string group = "", line;
		uint sum = 0;
		while ((line = stream.read_upto("\n", 1, null)) != null) {
			if (line.length == 0) {
			    sum += count(group);
				group = "";
			} else {
				group += line;
			}
			stream.read_byte();
		}
		sum += count(group);
		stdout.printf("%u\n", sum);
	} catch (Error e) {
		return -1;
	}
	return 0;
}
