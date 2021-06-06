//
//  SingInView.swift
//  tvOS-MAD
//
//  Created by user on 06.06.2021.
//

import SwiftUI

struct SingInView: View {
    @State var username = ""
    @State var password = ""
    @StateObject var model = ViewModel()
    
    
    //переменные для всплывающего окна
    @State var message = ""
    @State var errorAlert = false
    var body: some View {
        ZStack(alignment:.top) {
            Image("backgroungimage")
                .resizable()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack{
                //UserName
                ZStack{
                    Rectangle()
                        .frame(width: 697, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    HStack(spacing:0){
                        Image("username").padding()
                        Divider().frame(width:1, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        CustomUserName(placeholder: Text("Ivanov.I"), username: $username).padding(.horizontal,10)
                        
                    }.frame(width: 697, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                //Password
                    ZStack{
                        Rectangle()
                            .frame(width: 697, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                        HStack(spacing:0){
                            Image("password").padding()
                            Divider().frame(width:1, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            CustomPassword(placeholder: Text("passvord"), password: $password).padding(.horizontal,10)
                            
                        }.frame(width: 697, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }
                Button(action: {
                    if password != "" && username != "" {
                        model.singIn(username: username, password: password)
                    } else {
                        errorAlert.toggle()
                        message = "Заолните все поля"
                    }
                } , label: {
                    ZStack{
                        Rectangle().frame(width:696, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("SING IN").foregroundColor(.white).font(.custom("", size: 24))
                        
                    }
                }).alert(isPresented: $errorAlert, content: {
                    Alert(title:Text("ОШИБКА"), message: Text("\(message)"), dismissButton: .default(Text("Закрыть")))
                }).buttonStyle(PlainButtonStyle())
                
                }.offset(y:400)
            }
            
        }
    }


struct SingInView_Previews: PreviewProvider {
    static var previews: some View {
        SingInView()
    }
}


struct CustomUserName:View {
    @State var placeholder: Text
    @Binding var  username: String
    @State var edit: (Bool) -> () = {_ in}
    @State var commit: () -> () = {}
    
    
    var body: some View{
        ZStack(alignment: .leading) {
            if username.isEmpty {
                placeholder.foregroundColor(.gray).font(.custom("", size: 24))
                
            }
            TextField("", text: $username, onEditingChanged: edit, onCommit: commit).frame(width: 630, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).font(.custom("", size: 24)).foregroundColor(.gray)
        }
    }
}
struct CustomPassword:View {
    @State var placeholder: Text
    @Binding var  password: String
    @State var edit: (Bool) -> () = {_ in}
    @State var commit: () -> () = {}
    
    
    var body: some View{
        ZStack(alignment: .leading) {
            if password.isEmpty {
                placeholder.foregroundColor(.gray).font(.custom("", size: 24))
                
            }
            SecureField("", text: $password,  onCommit: commit).frame(width: 630, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).font(.custom("", size: 24)).foregroundColor(.gray)
        }
    }
}
