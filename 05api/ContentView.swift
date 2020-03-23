import SwiftUI

struct ContentView: View {
    @ObservedObject var bookData = BooksData()
    @State var keyword = ""
//    @EnvironmentObject var shareData: ShareData
    @State var books:[ResultJson] = []

    var body: some View {
        VStack {
            TextField("検索したい本を入力してください。", text: $keyword).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            List(books) { (book) in
                Text(book.title)
            }
            .onAppear{
                BooksData().getBookData(completion: { (books) in
                    self.books = books
                })
            }
        }
    }
}

//struct UserRow: View {
//    var book: ResultJson
//
//    var body: some View {
//        Text("ああああ").onAppear{
//            BooksData().getApi { (books) in
//                <#code#>
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
