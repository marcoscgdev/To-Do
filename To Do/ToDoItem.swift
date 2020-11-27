//
//  ToDoItem.swift
//  To Do
//
//  Created by Marcos Calvo Garcia on 16/11/2020.
//

class ToDoItem: Codable {
    
    var title: String
    var done: Bool
    
    enum CodingKeys: String, CodingKey {
        case title
        case done
    }

    public init(_ title: String) {
        self.title = title
        self.done = false
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        done = try container.decode(Bool.self, forKey: .done)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(done, forKey: .done)
    }

}

