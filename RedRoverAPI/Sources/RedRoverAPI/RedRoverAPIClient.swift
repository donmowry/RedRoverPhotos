import Combine
import Foundation

/// The main interface to NASA's [Mars Rover Photos API](https://api.nasa.gov/?search=mars-rover-photos)
///
/// An API key is not required, but requests will be rate limited without one.  An API key can be obtained at the [NASA API Site](https://api.nasa.gov/)
///
@available(iOS 15.0.0, *)
public class RedRoverAPIClient: ObservableObject {
    public enum APIError: Error {
        case dataFetchError(Error?)
        case incorrectURL(String)
        case queryItemError(String)
        case serverError(ServerMessageError)
    }
    private static let baseURL = "https://api.nasa.gov/mars-photos/api/v1/"
    
    private let apiKey: String
    private let urlSession: URLSession
    
    public init(apiKey: String = "DEMO_KEY", urlSession: URLSession = .shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    public func photoManifest(forRover rover: Rovers) async -> Result<PhotoManifest, APIError> {
        guard let baseURL = URL(string: RedRoverAPIClient.baseURL) else {
            return .failure(.incorrectURL(RedRoverAPIClient.baseURL))
        }
        
        guard let url = baseURL.appendingPathComponent("manifests")
                .appendingPathComponent(rover.rawValue.lowercased())
                .appending(queryItems: [
                    URLQueryItem(name: "api_key", value: apiKey)
                ]) else {
                    return .failure(.queryItemError("api_key"))
                }
        
        guard let (data, _) = try? await urlSession.data(from: url) else {
            return .failure(.dataFetchError(nil))
        }
        do {
            let parser = Parser<PhotoManifestWrapper>()
            let manifestWrapper = try parser.parseObject(jsonData: data)
            return .success(manifestWrapper.photoManifest)
        }
        catch {
            let errorParser = Parser<ServerMessageErrorWrapper>()
            if let errorWrapper = try? errorParser.parseObject(jsonData: data) {
                return .failure(.serverError(errorWrapper.error))
            }
            return .failure(.dataFetchError(error))
        }
    }
    
    public func photos(forRover rover: Rovers, camera: Cameras, sol: Int, page: Int = 1) async -> Result<[Photo], APIError> {
        guard let baseURL = URL(string: RedRoverAPIClient.baseURL) else {
            return .failure(.incorrectURL(RedRoverAPIClient.baseURL))
        }
        
        guard let url = baseURL.appendingPathComponent("rovers")
                .appendingPathComponent("\(rover.rawValue.lowercased())")
                .appendingPathComponent("photos")
                .appending(queryItems: [
                    URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "sol", value: String(sol)),
                    URLQueryItem(name: "camera", value: camera.rawValue)
                ]) else {
                    return .failure(.queryItemError("api_key, sol, or camera"))
                }
        
        guard let (data, _) = try? await urlSession.data(from: url) else {
            return .failure(.dataFetchError(nil))
        }
        do {
            let parser = Parser<PhotosWrapper>()
            let photoWrapper = try parser.parseObject(jsonData: data)
            return .success(photoWrapper.photos)
        }
        catch {
            let errorParser = Parser<ServerMessageErrorWrapper>()
            if let errorWrapper = try? errorParser.parseObject(jsonData: data) {
                return .failure(.serverError(errorWrapper.error))
            }
            return .failure(.dataFetchError(error))
        }
    }
}
