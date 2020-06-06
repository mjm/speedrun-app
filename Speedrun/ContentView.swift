//
//  ContentView.swift
//  Speedrun
//
//  Created by Matt Moriarity on 6/6/20.
//  Copyright © 2020 Matt Moriarity. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            GameSearchScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
