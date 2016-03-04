object Scala0104 {
    def main(args:Array[String]) {
        for (i <- 1 to 9) {
            if (i % 3 == 0) {
                print(i + ", ")
            }
        }
        println()

        for (i <- 1 to 9 if i % 3 == 0) {
            print(i + ", ")
        }
        println()
    }
}
