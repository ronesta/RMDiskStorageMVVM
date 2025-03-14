import Foundation
import UIKit.UIImage

protocol ImageLoaderProtocol {
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}