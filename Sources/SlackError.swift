import Vapor

public struct SlackError: DebuggableError {
    
    public enum Error {
        case environmentNotFound(String)
    }
    
    public var identifier: String {
        return "\(self.error)"
    }
    
    public var reason: String {
        switch self.error {
        case .environmentNotFound(let key):
            return "Environment not found: \(key)."
        }
    }
    
    var error: Error
    public var source: ErrorSource?
    
    init(_ error: Error, file: String = #file, function: String = #function, line: UInt = #line, column: UInt = #column) {
        self.error = error
        self.source = .init(file: file, function: function, line: line, column: column)
    }
}
