import Foundation
import OSLog

public enum LogType: String {
    case Error      = "📕"
    case Warning    = "📙"
    case Ok         = "📗"
    case Action     = "📘"
    case Canceled   = "📓"
    case Other      = "📔"
}

public func log(_ type: LogType, _ items: Any..., file: String = #file, funcName: String = #function, _ line: Int = #line) {
    let _logLabel: String = "->"
    let fileName = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
    let date = Date()
    let calendar = Calendar.current
    let min = calendar.component(.minute, from: date)
    let sec = calendar.component(.second, from: date)
    var myClassDumped = String()
    dump(items, to: &myClassDumped)
    let result: String =
"""

\(_logLabel) \(type.rawValue) [\(min):\(sec) \(fileName), \(funcName) on \(line)]
\(myClassDumped)

"""
    switch type {
        case .Error:
            Logger.statistics.error("\(result)")
        case .Warning:
            Logger.statistics.warning("\(result)")
        case .Ok:
            Logger.statistics.trace("\(result)")
        case .Action:
            Logger.statistics.info("\(result)")
        case .Canceled:
            Logger.statistics.warning("\(result)")
        case .Other:
            Logger.statistics.notice("\(result)")
    }
}

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let statistics = Logger(subsystem: subsystem, category: "FastAppLogger")
}

