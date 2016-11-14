import Foundation

protocol Parsing {
    associatedtype Response
    func parse(dictionary dict: [String: Any]) -> Response?
}

struct CooperHewittRandomObjectParser: Parsing {
    func parse(dictionary dict: [String : Any]) -> CooperHewittRandomObject? {
        guard let objectData = dict["object"] as? [String: Any],
            let id = objectData["id"] as? String,
            let imageDict = (objectData["images"] as? [[String: Any]])?.first,
            let imageN = imageDict["n"] as? [String: Any],
            let imageUrlString = imageN["url"] as? String,
            let imageUrl = URL(string: imageUrlString) else { return nil }
        return CooperHewittRandomObject(objectId: id, objectUrl: imageUrl)
    }
}
