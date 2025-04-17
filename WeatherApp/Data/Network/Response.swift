
enum Response<T> {
    case success(data: T)
    case error(message: String)
}
