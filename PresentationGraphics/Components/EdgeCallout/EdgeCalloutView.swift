//
//  EdgeCalloutView.swift
//  PresentationGraphics
//
//  Created by v.maltsev on 13.11.2024.
//

import SwiftUI

struct EdgeCalloutView<Content: View, Callout: View>: View {
    let content: Content
    let callout: Callout

    init(@ViewBuilder content: () -> Content, @ViewBuilder callout: () -> Callout) {
        self.content = content()
        self.callout = callout()
    }

    var body: some View {
        content
            .overlay {
                EdgeCalloutLayout {
                    callout
                }
            }
    }
}

extension View {
    func edgeCallout<Callout: View>(@ViewBuilder callout: () -> Callout) -> some View {
        EdgeCalloutView {
            self
        } callout: {
            callout()
        }
    }
}

#Preview {

    Rectangle()
        .fill(Color.green)
        .frame(width: 50, height: 50)
        .edgeCallout {
            Rectangle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
                .edgeCalloutPosition(.bottomTrailing)

            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
                .edgeCalloutPosition(.top)
                .edgeCallout {
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(width: 10, height: 10)
                        .edgeCalloutPosition(.trailing)
                }
        }
        .padding(50)
}

