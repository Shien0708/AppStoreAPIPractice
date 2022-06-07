//
//  ResultTypeUsage.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/6.
//

import Foundation
import UIKit

enum PasswordError: Error {
    case wrongPassword
    case emptyPassword
}



func getAnswer(password: String) throws -> String {
    guard password.isEmpty == false else {
        throw PasswordError.emptyPassword
    }
    guard password == "Hello" else {
        throw PasswordError.wrongPassword
    }
    return "Password Verified!"
}


func enterPassword() {
    do {
        let answer = try getAnswer(password: "Hello")
        print(answer)
    }
    catch PasswordError.wrongPassword {
        print("wrong password")
    }
    catch PasswordError.emptyPassword {
        print("please enter your password")
    }
    catch {
        print("other error")
    }
}




func newDownloadImage(urlString: String, completion:@escaping(Result<UIImage, NetworkError>) -> Void) {
    guard let url = URL(string: urlString) else {
        return completion(.failure(.invalidUrl))
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            return completion(.failure(.requestFailed(error)))
        }
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return completion(.failure(.invalidResponse))
           
        }
        guard let data = data, let image = UIImage(data: data) else {
            return completion(.failure(.invalidData))
        }
        return completion(.success(image))
    }.resume()
}

