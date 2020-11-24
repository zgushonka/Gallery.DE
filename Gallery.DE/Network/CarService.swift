import Foundation

protocol CarService {
    func getCarInfo(for carId: CarId, completion: @escaping (Result<Car, Error>) -> Void)
}

final class CarServiceImpl: CarService {
    private let session: URLSession
    private let decoder = JSONDecoder()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getCarInfo(
        for carId: CarId,
        completion: @escaping (Result<Car, Error>) -> Void
    ) {
        guard let url = API.Search.car(carId).makeURL() else {
            completion(.failure(NetworkError.wrongRequest))
            return
        }
        networkFetch(with: url, completion: completion)
    }

    private func networkFetch(
        with url: URL,
        completion: @escaping (Result<Car, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy
        request.httpMethod = "get"

        let decoder = self.decoder
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data,
                  let car = try? decoder.decode(Car.self, from: data) else {
                completion(.failure(NetworkError.noData))
                return
            }

            debugPrint("total image items count - \(car.imageURIs.count)")
            completion(.success(car))
        }.resume()
    }
}
