import scala.collection.mutable.Map;
import scala.io.Source;
import scala.util.matching.Regex;

object code2 {

  val data = Map[String, Map[String, Int]]();

  def evalBranch(contents: Map[String, Int]): Int = {
      var total = 1;
      contents.foreach {
        case (current, n) => total += n * evalBranch(data(current))
      }
      total
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
    println(evalBranch(data("shiny gold")) - 1);
  }

}
