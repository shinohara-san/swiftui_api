import Foundation
import Combine
import SwiftUI

//    struct  ImageLinkJson: Codable {
//        let smallThumbnail: URL?
//    }
// JSONのItem内のデータ構造
struct VolumeInfoJson: Codable {
    // 本の名称
    let title: String?
    // 著者
    let authors: [String]?
    // 本の画像
    //        let imageLinks: ImageLinkJson?
}
// Jsonのitem内のデータ構造
//    struct ItemJson: Codable {
//        let volumeInfo: VolumeInfoJson?
//    }

// JSONのデータ構造
struct ResultJson: Codable, Identifiable {
    // 複数要素
    let id = UUID()
    //        let kind: String?
    //        let totalItems: Int?
//    let items: [VolumeInfoJson]!
    let title: String
}


class BooksData: ObservableObject {
    //    let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(keyword_encode)")!
    
    @Published var books: [ResultJson] = []
//    @Published var books : [(title:String, authors:[String], image:URL)] = []
    //     var keyword: String = "Fukuoka"
    
    
    func getBookData(completion: @escaping ([ResultJson]) -> ()) {
        
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=inauthor:%E5%A4%8F%E7%9B%AE%E6%BC%B1%E7%9F%B3+intitle:%E5%90%BE%E8%BC%A9%E3%81%AF%E7%8C%AB%E3%81%A7%E3%81%82%E3%82%8B") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decoder: JSONDecoder = JSONDecoder()
            let books = try! decoder.decode([ResultJson].self, from: data)
            
            DispatchQueue.main.async {
                completion(books)
            }
        }.resume()
    }
}

