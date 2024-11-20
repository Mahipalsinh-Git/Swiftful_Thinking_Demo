//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Mahipal on 26/10/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    
    var body: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
            
        }
    }
}

struct CodeRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}

/*
// Below code not working
 
#Preview {
//    @Previewable @State var value = true
    @Previewable @State var value : CoinModel = PreviewProvider.dev.coin
    CoinRowView(coin: value)
}
*/
