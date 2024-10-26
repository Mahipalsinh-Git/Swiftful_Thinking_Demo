//
//  HomeView.swift
//  CryptoApp
//
//  Created by Mahipal on 26/10/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
    
                homeHeader
                
                Spacer()
            }
        }
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            
            CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(isAnimating: $showPortfolio)
                )
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Crypto App")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accentColor)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            CircleButtonView(imageName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    NavigationView {
        HomeView()
    }
}
