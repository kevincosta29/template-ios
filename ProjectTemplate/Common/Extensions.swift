//
//  Extensions.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 25/8/21.
//  Copyright © 2021 Kevin Costa. All rights reserved.
//

import UIKit

// MARK: - EXTENSION - UINavigationController
extension UINavigationController {
	
	func hairLine(hide: Bool) {
		//hides hairline at the bottom of the navigationbar
		for subview in self.navigationBar.subviews {
			if subview.isKind(of: UIImageView.self) {
				for hairline in subview.subviews {
					if hairline.isKind(of: UIImageView.self) && hairline.bounds.height <= 1.0 {
						hairline.isHidden = hide
					}
				}
			}
		}
		
	}
}


// MARK: - EXTENSION - UIColor

extension UIColor {
    
    convenience init(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                }
            }
        }
        self.init(Hex: 0xffffff)
    }
	
	convenience init(hexString: String) {
		let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int = UInt64()
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		switch hex.count {
		case 3: // RGB (12-bit)
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (255, 0, 0, 0)
		}
		self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
	}
	
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(Hex:Int) {
		self.init(red:(Hex >> 16) & 0xff, green:(Hex >> 8) & 0xff, blue:Hex & 0xff)
	}
	
	func isEqualToColor(_ otherColor : UIColor) -> Bool {
		if self == otherColor {
			return true
		}
		
		let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
		let convertColorToRGBSpace : ((_ color : UIColor) -> UIColor?) = { (color) -> UIColor? in
			if color.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
				let oldComponents = color.cgColor.components
				let components : [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1] ]
				let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
				let colorOut = UIColor(cgColor: colorRef!)
				return colorOut
			}
			else {
				return color;
			}
		}
		
		let selfColor = convertColorToRGBSpace(self)
		let otherColor = convertColorToRGBSpace(otherColor)
		
		if let selfColor = selfColor, let otherColor = otherColor {
			return selfColor.isEqual(otherColor)
		}
		else {
			return false
		}
	}
}

// MARK: - EXTENSION - String

extension String {
	
	func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
		return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
	}
	
	func capitalizingFirstLetter() -> String {
		let first = String(prefix(1)).capitalized
		let other = String(dropFirst())
		return first + other
	}
    
    /**
    Canvia el format d'una data amb String cap a un altre format.
    
    - Parameter fromFormat: Format en què està la data
    - Parameter toFormat: Format en què volem la data
    
    - Returns: String amb el format de data que volem
    
    - Warning: Si es produeix un error, l'app no peta però retorna l'String `Can not format date`
    */
    func formatStrDate(fromFormat: String, toFormat: String) -> String {
        let dateFormatter = getDateFormatter(strFormat: fromFormat)
        
        if let d = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: d)
        }
        return "Can not format date"
    }
    
    /**
    Ens retorna un Date a partir d'una data que està en un format determinat
    
    - Parameter format: Format en què està la data String
    
    - Returns: Date a partir d'una data que estava amb String
    
    - Warning: Si es produeix un error l'app acabarà petant amb el text `Can not format date`
    */
    func date(format: String) -> Date {
        let dateFormatter = getDateFormatter(strFormat: format)
        if !self.isEmpty, let date = dateFormatter.date(from: self) {
            return date
        } else {
            fatalError("Can not format date")
        }
    }
    
    /**
    Converteix una data Date a una data String amb un format determinat
    
    - Parameter date: Data que volem convertir a String
    - Parameter format: Format que li volem donar a la data
    
    - Returns: String amb la data transformada amb un format determinat
    */
    func strDate(date: Date, format: String) -> String {
        let dateFormatter = getDateFormatter(strFormat: format)
        return dateFormatter.string(from: date)
    }
    
    func getDateFormatter(strFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        let localeId = UserDefaults.standard.string(forKey: "appLanguage") ?? "es"
        dateFormatter.locale = Locale(identifier: localeId)
        dateFormatter.dateFormat = strFormat
        return dateFormatter
    }
    
    func calculateDifference(format: String, dateStart: Date, component: Set<Calendar.Component>) -> DateComponents {
        let startDay = self.date(format: format)
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: dateStart)
        let date2 = calendar.startOfDay(for: startDay)
        
        return calendar.dateComponents(component, from: date1, to: date2)
    }
}

// MARK: - EXTENSION - UIScreen

extension UIScreen {
	
	public func getWidth() -> CGFloat {
		return UIScreen.main.bounds.size.width
	}
	
	public func getHeight() -> CGFloat {
		return UIScreen.main.bounds.size.height
	}
}

extension UIImage {
	
	convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
		color.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		guard let cgImage = image!.cgImage else { return nil }
		self.init(cgImage: cgImage)
	}
}

extension URLRequest {
    
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
    
}
