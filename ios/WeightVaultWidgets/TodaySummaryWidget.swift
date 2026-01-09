import WidgetKit
import SwiftUI

private let appGroupId = "group.com.example.kilotakibi"

struct TodaySummaryEntry: TimelineEntry {
  let date: Date
  let trend: String
  let etaDays: String
}

struct TodaySummaryProvider: TimelineProvider {
  func placeholder(in context: Context) -> TodaySummaryEntry {
    TodaySummaryEntry(date: Date(), trend: "78.4", etaDays: "42")
  }

  func getSnapshot(in context: Context, completion: @escaping (TodaySummaryEntry) -> Void) {
    completion(loadEntry())
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<TodaySummaryEntry>) -> Void) {
    let entry = loadEntry()
    let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date().addingTimeInterval(1800)
    completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
  }

  private func loadEntry() -> TodaySummaryEntry {
    let defaults = UserDefaults(suiteName: appGroupId)
    let trend = defaults?.string(forKey: "trend") ?? "--"
    let etaRaw = defaults?.string(forKey: "etaDays") ?? "--"
    let eta = etaRaw == "-1" ? "Stable" : etaRaw
    return TodaySummaryEntry(date: Date(), trend: trend, etaDays: eta)
  }
}

struct TodaySummaryWidget: Widget {
  let kind: String = "TodaySummaryWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: TodaySummaryProvider()) { entry in
      TodaySummaryView(entry: entry)
    }
    .configurationDisplayName("Today Summary")
    .description("Shows trend and ETA.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

struct TodaySummaryView: View {
  let entry: TodaySummaryEntry

  var body: some View {
    ZStack {
      Color(.systemBackground)
      VStack(alignment: .leading, spacing: 8) {
        Text("Trend").font(.caption).foregroundColor(.secondary)
        Text(entry.trend).font(.system(size: 28, weight: .semibold))
        Text("ETA").font(.caption).foregroundColor(.secondary)
        Text(entry.etaDays == "--" ? "--" : "\(entry.etaDays) d").font(.headline)
      }
      .padding()
    }
  }
}
