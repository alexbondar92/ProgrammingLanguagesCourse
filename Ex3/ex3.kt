// anastasia neiman 313103400 anastasiane@campus
// alex bondar      311822258 alex.bondar@campus

import java.io.File

fun main(args: Array<String>) {
    // Change this to read the right file
    val inputPath = "/home/tomer/work/repy/src/REPY"
    val outputPath = "/home/tomer/work/repy/src/output"
//    val inputPath = "/Users/alexbondar/REPY"
//    val outputPath = "/Users/alexbondar/output"
    File(outputPath).writeBytes(completeMe(File(inputPath).readBytes()))
}

fun completeMe(input: ByteArray): ByteArray {
    val output:ByteArray = input
    // convert CP862 Decoding to IEC_8859-8 Decoding
    var i = 0
    while(i < input.size){
        if (-128 <= input[i] && input[i] <= -101) {
            input[i] = (input[i] + 96).toByte()
        }
        i +=1
    }
    return output
}