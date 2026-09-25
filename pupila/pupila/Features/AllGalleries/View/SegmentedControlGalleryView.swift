//
//  SegmentedControlGalleryView.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 23/09/26.
//

import SwiftUI

struct SegmentedControlGalleryView: View {
    
    enum IsOpenFilter: String, CaseIterable, Identifiable {
        case open = "Abertas"
        case closed = "Fechadas"
        
        var id: String {self.rawValue}
    }

    @Binding var selected: IsOpenFilter
    
    var body: some View {
        
        
        Picker("Filter", selection: $selected) {
            ForEach(IsOpenFilter.allCases) { filter in
                Text(filter.rawValue).tag(filter)
                
            }
        }
            .pickerStyle(.segmented)


    }
}

#Preview {
    SegmentedControlGalleryView(selected: .constant(.open))
}
