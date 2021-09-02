//
//  StatusService.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/30/21.
//

import Foundation

class StatusService {
    
    let key: String
    
    func loadEntity() -> Entity?{
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        let decoder = JSONDecoder()
        guard let loadedEntity = try? decoder.decode(Entity.self, from: data) else {return nil}
        return loadedEntity
        
    }
    
    func store(entity: Entity) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(entity)
        guard let data = data else { return }
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func clearEntity(){
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    init(key: String) {
        self.key = key
    }
}
