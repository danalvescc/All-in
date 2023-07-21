//
//  Dropdown.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 20/07/23.
//

import SwiftUI
let dropdownCornerRadius = 30.0

struct DropdownOption: Hashable {
    var key: String
    var val: String
}

struct DropdownOptionElement: View {
    var dropdownOption: DropdownOption
    var onSelect: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        Button(action: {
            if let onSelect = self.onSelect {
                onSelect(dropdownOption)
            }
        }) {
            Text(dropdownOption.val)
                .font(Font.custom("AvenirNextLTPro-Regular", size: 20))
                .foregroundColor(Color.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 60)
        .padding(.vertical, 14)
    }
}

struct DropdownButton: View {
    @State private var shouldShowDropdown = false
    @Binding var selectedOption: DropdownOption?
    var title: String
    var defaultText: String = "Select the value"
    var options: [DropdownOption]
    var onSelect: ((_ option: DropdownOption) -> Void)?
    
    func onSelectDecorator(_ option: DropdownOption) {
        if let onSelect = onSelect {
            onSelect(option)
        }
        selectedOption = option
        shouldShowDropdown = false
    }

    let buttonHeight: CGFloat = 80
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                self.shouldShowDropdown.toggle()
            }) {
                HStack {
                    Text(title)
                        .foregroundColor(Color.greyLight)
                        .font(Font.custom("AvenirNextLTPro-Regular", size: 24))
                    Spacer()
                    Text(selectedOption?.val ?? defaultText)
                        .font(Font.custom("AvenirNextLTPro-Regular", size: 20))
                    Spacer()
                        .frame(width: 16)
                    Image(systemName: self.shouldShowDropdown ? "chevron.up" : "chevron.down")
                }.foregroundColor(Color.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: self.buttonHeight)
            .padding(.horizontal, dropdownCornerRadius)
            .background(
                Color.greyDark
            )
            .roundedCorner(dropdownCornerRadius, corners: shouldShowDropdown ? [.topLeft, .topRight] : [.allCorners])
            .padding(.horizontal)
            if self.shouldShowDropdown {
                Dropdown(options: self.options, onSelect: self.onSelectDecorator)
            }
        }
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var onSelect: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.purpleDark)
                    .frame(height: 1)
                    .padding(.horizontal)
            }
            ForEach(self.options, id: \.self) { option in
                DropdownOptionElement(dropdownOption: option, onSelect: self.onSelect)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.greyDark)
        .roundedCorner(dropdownCornerRadius, corners: [.bottomLeft, .bottomRight])
        .padding(.horizontal)
    }
}

struct DropdownButton_Struct_Preview: View {
    @State private var selectedOption: DropdownOption?
    func onSelect(option: DropdownOption) {
        self.selectedOption = option
    }
    
    let options = [
        DropdownOption(key: "week", val: "This week"),
        DropdownOption(key: "month", val: "This month"),
        DropdownOption(key: "year", val: "This year")
    ]

    
    var body: some View {
        VStack(alignment: .leading) {
            DropdownButton(selectedOption: $selectedOption , title: "Sections", options: self.options, onSelect: self.onSelect)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purpleDark)
    }
}


struct DropdownButton_Previews: PreviewProvider {
    static var previews: some View {
        DropdownButton_Struct_Preview()
    }
}

