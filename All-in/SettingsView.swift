//
//  SettingsView.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 19/07/23.
//

import SwiftUI
import SimpleToast

struct SettingsView: View {
    @State var focuseTime: DropdownOption?
    @State var shortBreakTime: DropdownOption?
    @State var longBreakTime: DropdownOption?
    @State var sectionsToPause: DropdownOption?
    @State var showToast = false
    
    private let toastOptions = SimpleToastOptions(
        alignment:.top,
        hideAfter: 5,
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )
    
    @AppStorage("focuseTime") private var focuseTimeMemory = 25
    @AppStorage("shortBreakTime") private var shortBreakTimeMemory = 5
    @AppStorage("longBreakTime") private var longBreakTimeMemory = 15
    @AppStorage("sectionsToPause") private var sectionsToPauseMemory = 4
    
    func save() {
        focuseTimeMemory = Int(focuseTime!.key) ?? 0
        shortBreakTimeMemory = Int(shortBreakTime!.key) ?? 0
        longBreakTimeMemory = Int(longBreakTime!.key) ?? 0
        sectionsToPauseMemory = Int(sectionsToPause!.key) ?? 0
        
        showToast = true
    }
    
    func load() {
        focuseTime = focuseTimeOptions.first(where: {$0.key == String(focuseTimeMemory)})
        shortBreakTime = shortBreakOption.first(where: {$0.key == String(shortBreakTimeMemory)})
        longBreakTime = longBreakOption.first(where: {$0.key == String(longBreakTimeMemory)})
        sectionsToPause = sectionsOption.first(where: {$0.key == String(sectionsToPauseMemory)})
    }
    
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
                    load()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .font(Font.custom("AvenirNextLTPro-Regular", size: 20))
                }
                .frame(width: 140, height: 60)
                Button {
                    save()
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
        .onAppear {
            load()
        }
        .simpleToast(isPresented: $showToast, options: toastOptions) {
            HStack(spacing: 16) {
                Image(systemName: "leaf.fill")
                Text("Saved with success!")
                    .font(Font.custom("AvenirNextLTPro-Regular", size: 20))
            }
            .foregroundColor(Color.white)
            .padding(20)
            .background(Color.blueMain)
            .roundedCorner(14, corners: .allCorners)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
