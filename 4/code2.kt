import java.io.*
import kotlin.io.*
import kotlin.text.*

val eyeColours = listOf(
    "amb", "blu", "brn", "gry", "grn", "hzl", "oth"
)
val required = listOf(
    "byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"
)
fun check(fields: Map<String, String>): Boolean {
    required.forEach {
        if (!(it in fields)) {
            return false
        }
        val value = fields[it]
        if (!(value == null || when (it) {
                  "byr" -> value.toInt() in 1920..2002
                  "ecl" -> value in eyeColours
                  "eyr" -> value.toInt() in 2020..2030
                  "hcl" -> value.startsWith('#')
                  && value.count({it.isDigit() || it in 'a'..'f'}) == 6
                  "hgt" -> value.substringBefore('c').substringBefore('i')
                      .toInt() in (if ('c' in value) 150..193 else 59..76)
                  "iyr" -> value.toInt() in 2010..2020
                  "pid" -> value.count() == 9
                  && value.count({it.isDigit()}) == 9
                  else -> false
        })) {
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
        val fields = mutableMapOf<String, String>()
        it.replace(" ", ",").replace("\n", ",").split(",").forEach {
            val items = it.split(":")
            var key: String
            var value: String
            try {
                key = items[0]
                value = items[1]
            } catch (e: IndexOutOfBoundsException) {
                key = ""
                value = ""
            }
            fields[key] = value
        }
        if (check(fields)) {
            valid++
        }
    }
    println(valid)
}
