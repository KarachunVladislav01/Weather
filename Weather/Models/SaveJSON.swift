//
//  SaveJSON.swift
//  weatherApp
//
//  Created by Vladislav on 4/20/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import Foundation

func getDocumentsURL() -> URL {
    if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        return url
    } else {
        fatalError("Could not retrieve documents directory")
    }
}
func getPostsFromDisk() -> Data {
    let url = getDocumentsURL().appendingPathComponent("posts.json")
    print(getDocumentsURL().appendingPathComponent("posts.json"))
    do {
        let data = try Data(contentsOf: url, options: [])
        return data
    } catch {
        fatalError(error.localizedDescription)
    }
}
func decodable() -> Weather {
    var information: Weather?
    do{
        information = try? JSONDecoder().decode(Weather.self, from: getPostsFromDisk())
    } catch {
        print("Error serislizing json:")
        information = nil
    }
    return information!
}





