//
//  SettingsView.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 19/07/23.
//

import SwiftUI

struct SettingsView: View {
    @State var focuseTime: DropdownOption? {
        didSet {
            print(self)
        }
    }
    @State var shortBreakTime: DropdownOption?
    @State var longBreakTime: DropdownOption?
    @State var sectionsToPause: DropdownOption?
    
    var body: some View {
        VStack {
            ///Header
            Text("All-In Timer")
                .foregroundColor(Color.white)
                .font(Font.custom("AvenirNextLTPro-Bold", size: 22))
                .padding(.bottom, 36)
            
            /// Inputs
            DropdownButton(selectedOption: $focuseTime, title: "Focuse Time", options: focuseTimeOptions)
            DropdownButton(selectedOption: $shortBreakTime, title: "Short Time", options: shortBreakOption)
            DropdownButton(selectedOption: $longBreakTime, title: "Long Time", options: longBreakOption)
            DropdownButton(selectedOption: $sectionsToPause, title: "Sections", options: sectionsOption)
            Spacer()
            
            HStack(spacing: 60) {
                Button {
                    print("Cancel")
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .font(Font.custom("AvenirNextLTPro-Regular", size: 20))
                }
                .frame(width: 140, height: 60)
                Button {
                    print("Save")
                } label: {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.custom("AvenirNextLTPro-Regular", size: 20))
                }
                .frame(width: 140, height: 60)
                .background(Color.blue)
                .cornerRadius(30)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(.vertical)
        .background(Color.purpleDark)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
