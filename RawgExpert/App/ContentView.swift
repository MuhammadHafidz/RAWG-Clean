//
//  ContentView.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    var body: some View {
        HomeView(presenter: homePresenter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
