import java.io.*
import kotlin.io.*
import kotlin.text.*

val required = listOf(
    "byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"
)
fun check(keys: List<String>): Boolean {
    required.forEach {
        if (it !in keys) {
            return false
        }
    }
    return true
}

fun main() {
    val file = File("input.txt")
    val input = file.readText()
    var valid = 0
    input.split("\n\n").forEach {
        val keys = mutableListOf<String>()
        it.replace(" ", ",").replace("\n", ",").split(",").forEach {
            val key = it.split(":")[0]
            keys.add(key)
        }
        if (check(keys)) {
            valid++
        }
    }
    println(valid)
}
