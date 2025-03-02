//
//  APICaller.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 1.03.2025.
//

import Foundation

enum APIConstant {
    static let baseURLString = "https://api.themoviedb.org"
    static let apiKey = "7ead39064cf25b25406f9057d30662d2"
}

enum APIError: Error {
    case invalidURL
    case badResponse
    case decodingFailed
}

class APICaller{
    static let shared = APICaller()
    private init() {}
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstant.baseURLString)/3/trending/movie/day?api_key=\(APIConstant.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.badResponse))
            }
        }
        
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstant.baseURLString)/3/trending/tv/day?api_key=\(APIConstant.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.badResponse))
            }
        }
        
        task.resume()
    }
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstant.baseURLString)/3/movie/upcoming?api_key=\(APIConstant.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print(error.localizedDescription)
            }

        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstant.baseURLString)/3/movie/popular?api_key=\(APIConstant.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.badResponse))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstant.baseURLString)/3/movie/top_rated?api_key=\(APIConstant.apiKey)&language=en-US&page=1") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))

            } catch {
                completion(.failure(APIError.badResponse))
            }

        }
        task.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(APIConstant.baseURLString)/3/discover/movie?api_key=\(APIConstant.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(results.results))

            } catch {
                completion(.failure(APIError.badResponse))
            }

        }
        task.resume()
    }
    
}
