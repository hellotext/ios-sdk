public class Hellotext {

    public static let shared = Hellotext()

    private var clientID: String = ""

    private init() {}

    public func setup(clientID: String) {
        self.clientID = clientID
    }

    internal func getClientID() -> String {
        return clientID
    }

    public func track(event: String) {
        print("Tracking event: \(event)")
    }

}
