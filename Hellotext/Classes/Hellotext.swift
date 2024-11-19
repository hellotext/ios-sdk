public class Hellotext {
    public static let shared = Hellotext()

    private init() {}

    public func sayHello() {
        print("Hello, World!")
    }

    public func track(event: String) {
        print("Tracking event: \(event)")
    }
}
