//
//  File.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 3.03.2025.
//

import Foundation
import UIKit
import CoreData

class DataPercistenceManager {
    static let shared = DataPercistenceManager()
    private init() {}
    
    func DownloadMoview(with model : Movie,completeion : @escaping (Result<Void,Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let item = MovieItem(context: context)
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average

        do{
            try context.save()
            completeion(.success(()))
        }catch(let error) {
            completeion(.failure((error)))
        }
    }
    
    func getAllDownloadedMovies(completion:@escaping (Result<[MovieItem],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        do{
            let result = try context.fetch(request)
            completion(.success(result))
        }catch(let error){
            completion(.failure(error))
        }
    }
}
