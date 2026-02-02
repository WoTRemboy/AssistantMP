//
//  PropertyAddressView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import SwiftUI

struct PropertyAddressView: View {
    
    @ObservedObject private var viewModel: PropertyViewModel
    
    init(viewModel: PropertyViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        VStack(spacing: 8) {
            Button {
                withAnimation(.smooth(duration: 0.25)) {
                    viewModel.showAddressPickerToggle()
                }
            } label: {
                addressButtonContent
            }
            .buttonStyle(.plain)
            
            if viewModel.showAddressPicker {
                VStack(spacing: 8) {
                    ForEach(viewModel.properties, id: \.self) { address in
                        addressRow(address)
                    }
                }
                .transition(.blurReplace)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemGray6))
        )
    }
    
    private var addressButtonContent: some View {
        HStack(spacing: 12) {
            Image.Property.location
                
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.selectedProperty.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                    .contentTransition(.numericText())
                
                Text(Texts.Property.address)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.LabelColors.labelSecondary)
            }
            Spacer()
            Image.Chevron.down
                .rotationEffect(.degrees(viewModel.showAddressPicker ? 180 : 0))
        }
        .contentShape(Rectangle())
        .sensoryFeedback(.selection, trigger: viewModel.showAddressPicker)
    }
    
    private func addressRow(_ property: PropertyItem) -> some View {
        Button {
            withAnimation(.smooth(duration: 0.2)) {
                viewModel.selectedProperty = property
                viewModel.showAddressPickerToggle()
            }
        } label: {
            HStack(spacing: 12) {
                (viewModel.selectedProperty == property ? Image.Selector.selected : Image.Selector.unselected)
                    .foregroundStyle(viewModel.selectedProperty == property ? Color.LabelColors.labelWhite : Color.LabelColors.labelSecondary)
                
                Text(property.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(viewModel.selectedProperty == property ? Color.LabelColors.labelWhite : Color.LabelColors.labelPrimary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(viewModel.selectedProperty == property ? Color.black.opacity(0.9) : Color(.systemGray5))
            )
            .foregroundStyle(viewModel.selectedProperty == property ? Color.white : Color.LabelColors.labelPrimary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PropertyAddressView(viewModel: PropertyViewModel())
}
