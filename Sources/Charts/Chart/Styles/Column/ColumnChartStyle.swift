import SwiftUI
import Shapes

public struct ColumnChartStyle<Column: View>: ChartStyle {
    private let column: Column
    private let spacing: CGFloat
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let data: [ColumnData] = configuration.dataMatrix
            .map { $0.reduce(0, +) }
            .enumerated()
            .map { ColumnData(id: $0.offset, data: $0.element) }
        
        return self.columnChart(data: data)
    }
    
    private func columnChart(data: [ColumnData]) -> some View {
        return ZStack(alignment: .bottomLeading) {
            ForEach(data) { element in
                self.column
            }
        }
    }

    public init(column: Column, spacing: CGFloat = 8) {
        self.column = column
        self.spacing = spacing
    }
}

struct ColumnData: Identifiable {
    let id: Int
    let data: CGFloat
}

public struct DefaultColumnView: View {
    public var body: some View {
        Rectangle().foregroundColor(.accentColor)
    }
}

public extension ColumnChartStyle where Column == DefaultColumnView {
    init(spacing: CGFloat = 8) {
        self.init(column: DefaultColumnView(), spacing: spacing)
    }
}
