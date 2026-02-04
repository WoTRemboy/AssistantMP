//
//  SceletonView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

struct SceletonView<S: Shape>: View {
    
    private var shape: S
    private var color: Color
    
    init(_ shape: S, _ color: Color = .gray.opacity(0.3)) {
        self.shape = shape
        self.color = color
    }
    
    internal var body: some View {
        TimelineView(.animation) { timeline in
            shape
                .fill(color)
                .overlay {
                    GeometryReader {
                        let size = $0.size
                        let skeletonWidth = size.width / 2
                        let blurRadius = max(skeletonWidth / 2, 30)
                        let blurDiameter = blurRadius * 2
                        
                        let minX = -(skeletonWidth + blurDiameter)
                        let maxX = size.width + skeletonWidth + blurDiameter
                        let offset = shimmerOffset(minX: minX, maxX: maxX, date: timeline.date)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: skeletonWidth, height: size.height * 2)
                            .frame(height: size.height)
                            .blur(radius: blurRadius)
                            .rotationEffect(.init(degrees: rotation))
                            .blendMode(.softLight)
                            .offset(x: offset)
                    }
                }
                .clipShape(shape)
                .compositingGroup()
        }
    }
    
    private var rotation: Double {
        return 5
    }
    
    private func shimmerOffset(minX: CGFloat, maxX: CGFloat, date: Date) -> CGFloat {
        let duration: TimeInterval = 1.5
        let time = date.timeIntervalSinceReferenceDate
        let progress = (time.truncatingRemainder(dividingBy: duration)) / duration
        return minX + (maxX - minX) * progress
    }
}

#Preview {
    @Previewable
    @State var isTapped: Bool = false
    
    SceletonView(.circle)
        .frame(width: 100, height: 100)
        .onTapGesture {
            withAnimation(.smooth) {
                isTapped.toggle()
            }
        }
        .padding(.bottom, isTapped ? 15 : 0)
}

