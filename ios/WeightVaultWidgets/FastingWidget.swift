import WidgetKit
import SwiftUI

private let appGroupId = "group.com.example.kilotakibi"

struct FastingEntry: TimelineEntry {
  let date: Date
  let remaining: String
}

struct FastingProvider: TimelineProvider {
  func placeholder(in context: Context) -> FastingEntry {
    FastingEntry(date: Date(), remaining: "12h 30m")
  }

  func getSnapshot(in context: Context, completion: @escaping (FastingEntry) -> Void) {
    completion(loadEntry())
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<FastingEntry>) -> Void) {
    let entry = loadEntry()
    let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date().addingTimeInterval(900)
    completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
  }

  private func loadEntry() -> FastingEntry {
    let defaults = UserDefaults(suiteName: appGroupId)
    let remaining = defaults?.string(forKey: "fastingRemaining") ?? "--"
    return FastingEntry(date: Date(), remaining: remaining)
  }
}

struct FastingWidget: Widget {
  let kind: String = "FastingWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: FastingProvider()) { entry in
      FastingView(entry: entry)
    }
    .configurationDisplayName("Fasting Timer")
    .description("Shows remaining fasting time.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

struct FastingView: View {
  let entry: FastingEntry

  var body: some View {
    ZStack {
      Color(.systemBackground)
      VStack(alignment: .leading, spacing: 8) {
        Text("Fasting").font(.caption).foregroundColor(.secondary)
        Text(entry.remaining).font(.system(size: 28, weight: .semibold))
        Text("Remaining").font(.caption).foregroundColor(.secondary)
      }
      .padding()
    }
  }
}
