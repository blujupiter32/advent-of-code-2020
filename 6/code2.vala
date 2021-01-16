using Gee;

uint count(string group, uint n) {
     HashSet<unichar> unique = new HashSet<unichar>();
     unichar c1;
     for (int i = 0; group.get_next_char(ref i, out c1);) {
          unique.add(c1);
     }
     uint8 ctotal, total = 0;
     foreach (unowned unichar c2 in unique) {
          ctotal = 0;
          for (int i = 0; group.get_next_char(ref i, out c1);) {
               if (c1 == c2) {
                    ctotal++;
               }
          }
          if (ctotal == n) {
               total++;
          }
     }
     return total;
}

int main() {
     try {
          File file = File.new_for_path("input.txt");
          DataInputStream stream = new DataInputStream(file.read());
          string group = "", line;
          uint n = 0, sum = 0;
          while ((line = stream.read_upto("\n", 1, null)) != null) {
               if (line.length == 0) {
                    sum += count(group, n);
                    group = "";
                    n = 0;
               } else {
                    group += line;
                    n++;
               }
               stream.read_byte();
          }
          sum += count(group, n);
          stdout.printf("%u\n", sum);
     } catch (Error e) {
          return -1;
     }
     return 0;
}
