import Crashlytics

struct Logger {
    static func debug(_ message: String, file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
        log(message: message, level: .debug, file: file, line: line, function: function)
    }

    static func info(_ message: String, file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
        log(message: message, level: .debug, file: file, line: line, function: function)
    }

    static func warn(_ message: String, file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
        log(message: message, level: .debug, file: file, line: line, function: function)
    }

    static func error(_ message: String, file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
        log(message: message, level: .debug, file: file, line: line, function: function)
    }

    private static func log(message: String, level: LogLevel, file: StaticString, line: Int, function: StaticString) {
        let location: String = {
            var locationString = ""

            if let filename = file.description.components(separatedBy: "/").last {
                locationString += filename
            }
            locationString += ":\(line)"
            locationString += " 📈 \(function)"
            return locationString
        }()

        let date = DateFormatter().string(from: Date())
        let fullLog = "\(level.emoji) \(date) 👉 \(location)\n\(message)"
        print(fullLog)

        switch level {
        case .error:
            Crashlytics.sharedInstance().recordError(NSError(domain: fullLog, code: 999, userInfo: nil))
        default:
            break
        }
    }
}

extension Logger {
    private enum LogLevel {
        case debug
        case info
        case warn
        case error

        var emoji: String {
            switch self {
            case .debug:
                return "🐞"
            case .info:
                return "ℹ️"
            case .warn:
                return "⚠️"
            case .error:
                return "‼️"
            }
        }
    }
}
