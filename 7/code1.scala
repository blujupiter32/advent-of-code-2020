import scala.collection.mutable.Map;
import scala.io.Source;
import scala.util.matching.Regex;

object code1 {

  val data = Map[String, Map[String, Int]]();

  def evalBranch(contents: Map[String, Int]): Int =
    try {
      contents("shiny gold");
      1
    } catch {
      case _: Throwable => {
        contents.foreach {
          case (colour, _) => if (evalBranch(data(colour)) > 0) return 1
        }
        0
      }
    }

  def main(args: Array[String]): Unit = {
    val currentRegex = "^(\\w+ \\w+) bags".r;
    val contentsRegex = "(\\d+)\\ (\\w+\\ \\w+)\\ bags?".r;
    val file = Source.fromFile("input.txt");
    for (
      line <- file.getLines();
      current <- currentRegex.findFirstMatchIn(line)
    ) {
      val counts = Map[String, Int]();
      for (
        matches <- contentsRegex.findAllMatchIn(line)
      ) {
        counts += (matches.group(2) -> matches.group(1).toInt);
      }
      data += (current.group(1) -> counts);
    }
    file.close;
    var total = 0;
    data.foreach {
      case (_, contents) => total += evalBranch(contents)
    }
    println(total);
  }

}
