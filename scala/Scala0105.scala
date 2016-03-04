object Scala0105 {
    def main(args:Array[String]) {
        var sm = 0
        for (i <- 1 to 99) {
            if (i % 3 == 0) {
                sm += i
            }
        }
        println(sm)
    }
}
