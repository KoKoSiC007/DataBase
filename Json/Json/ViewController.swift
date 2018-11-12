//
//  ViewController.swift
//  Json
//
//  Created by Grisha Okin on 12/11/2018.
//  Copyright © 2018 Grisha Okin. All rights reserved.
//

import UIKit

struct Visitors:Decodable {
	let name: String?
	let time: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrl = "https://raw.githubusercontent.com/KoKoSiC007/DataBase/master/Data_Base.json"
        
		guard let url = URL(string: jsonUrl) else {return}
		
		URLSession.shared.dataTask(with: url) { (data, response, err) in
			guard let data = data else {return}
		
			do{
				let visits = try JSONDecoder().decode([Visitors].self, from: data)
				print(visits[0].name ?? String.self)
				print(type(of: visits))
			}catch {
				print("error")
			}
			
		}.resume()
		

    }
}
