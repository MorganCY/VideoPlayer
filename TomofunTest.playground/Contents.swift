import Foundation

let concurrentQueue = DispatchQueue(label: "concurrent.queue",
                                    attributes: .concurrent)
let anotherConcurrentQueue = DispatchQueue(label: "another.queue",
                                           attributes: .concurrent)

class Concurrent {
    init() {
        anotherConcurrentQueue.async {
            print("A1")
            concurrentQueue.sync {
                sleep(2)
                print("A2")
            }
        }
        anotherConcurrentQueue.async {
            print("B1")
            concurrentQueue.sync {
                print("B2")
            }
        }
    }
}

let concurrent = Concurrent()
concurrent
