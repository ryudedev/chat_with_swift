//
//  MessageRow.swift
//  ChatViewWithSwiftUI
//
//  Created by IT on 2024/05/22.
//

import SwiftUI

struct MessageRow: View {
    let message: Message
    var body: some View {
        HStack(alignment: .top) {
            if message.user.isCurrentUser {
                Spacer()
                messageState
                messageText
            } else {
                userThumb
                messageText
                messageState
                Spacer()
            }
        }
        .padding(.bottom)
    }
}

//#Preview {
//    MessageRow()
//        .background(.cyan)
//}

extension MessageRow {
    private var userThumb: some View {
        Image(message.user.image)
            .resizable()
            .frame(width: 48, height: 48)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
    
    private var messageText: some View {
        Text(message.text)
            .padding()
            .background(message.user.isCurrentUser ? Color("Bubble") : Color(uiColor: .tertiarySystemBackground))
            .foregroundColor(message.user.isCurrentUser ? .black : .primary)
            .cornerRadius(30)
    }
    
    private var messageState: some View {
        VStack(alignment: .trailing) {
            Spacer()
            if message.user.isCurrentUser && message.readed {
                Text(message.readed ? "既読" : "")
            }
            Text(formattedDataString)
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }
    
    private var formattedDataString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: message.date)
        else {
            return ""
        }
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
