//
//  WhatDoYouPrefferViewCellTableViewCell.swift
//  practing
//
//  Created by shy attoun on 07/03/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import Lottie

struct Cities:Decodable {
    let id : Int
    let cityName : String
    let imageUrl: String
}

struct Food:Decodable {
    let id : Int
    let foodName : String
    let imageUrl: String
}

struct Music:Decodable {
    let id : Int
    let artistName : String
    let imageUrl: String
}

struct LifeStyle:Decodable {
    let id : Int
    let lifestyletype : String
    let imageUrl: String
}

struct Movies:Decodable {
    let id : Int
    let movieName : String
    let imageUrl: String
}

class WhatDoYouPrefferController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var lotAnimateScreen: AnimationView!
    @IBOutlet weak var blurScreen: UIVisualEffectView!
    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var leftImageName: UILabel!
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var rightImageName: UILabel!
    
    @IBOutlet var WDYPViewController: UIView!
    
    private var city = [Cities] ()
    private var food = [Food] ()
    private var music = [Music] ()
    private var lifestyle = [LifeStyle] ()
    private var movie = [Movies] ()
    
    var topics = ["choose your topic:","food","lifestyle","cities","movies","music"]
    
    @IBOutlet weak var randomBtn: UIButton!
    
    var effect: UIVisualEffect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.WDYPViewController.backgroundColor = .lightGray
        
        viewsDesign()
        blurEffect ()
        startAnimation()
        downloadCityJson ()
        downloadFoodJson ()
        downloadMusicJson ()
        downloadLifeStyleJson ()
        downloadMoviesJson()
      
        
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            topics[0] = ""
            topicLabel.text = topics[row]
        
        
       
    }
    
    
    @IBAction func showRandomPic(_ sender: UIButton) {
        
        if topicLabel.text == "cities" {
            
            showRandomCities()
        }
         else if topicLabel.text == "food" {
        showRandomFood()
        }
        else if topicLabel.text == "music" {
            showRandomMusic()
        }
        else if topicLabel.text == "lifestyle" {
            showRandomLifeStyle ()
        }
        else if topicLabel.text == "movies" {
            showRandomMovie()
        }
    }
        
        func showRandomCities (){
            
            let leftObject  = city.randomElement()
            leftImageName.text = leftObject?.cityName
            let url = URL(string: leftObject!.imageUrl)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.leftImage.image = UIImage(data:data!)
                }
            }
            
            let rightObject = city.randomElement()
            rightImageName.text = rightObject?.cityName
            let url2 = URL(string: rightObject!.imageUrl)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url2!)
                DispatchQueue.main.async {
                    self.rightImage.image = UIImage(data:data!)
                }
            }
            
            
        }
            func showRandomFood (){
                let leftObject = food.randomElement()
                leftImageName.text = leftObject?.foodName
                let url = URL(string:leftObject!.imageUrl)
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        self.leftImage.image = UIImage(data:data!)
                    }
                }
                
                let rightObject = food.randomElement()
                rightImageName.text = rightObject?.foodName
                let url2 = URL(string: rightObject!.imageUrl)
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url2!)
                    DispatchQueue.main.async {
                        self.rightImage.image = UIImage(data:data!)
                    }
                }
                
          
            }
    
                func showRandomMusic (){
                    let leftObject = music.randomElement()
                    leftImageName.text = leftObject?.artistName
                    let url = URL(string: leftObject!.imageUrl)
                    
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!)
                        DispatchQueue.main.async {
                            self.leftImage.image = UIImage(data:data!)
                        }
                    }
                    
                    let rightObject = music.randomElement()
                    rightImageName.text = rightObject?.artistName
                    let url2 = URL(string: rightObject!.imageUrl)
                    
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url2!)
                        DispatchQueue.main.async {
                            self.rightImage.image = UIImage(data:data!)
                        }
                    }
                    
    }
    
    func showRandomLifeStyle (){
        let leftObject = lifestyle.randomElement()
        leftImageName.text = leftObject?.lifestyletype
        let url = URL(string: leftObject!.imageUrl)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.leftImage.image = UIImage(data:data!)
            }
        }
        
        let rightObject = lifestyle.randomElement()
        rightImageName.text = rightObject?.lifestyletype
        let url2 = URL(string: rightObject!.imageUrl)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url2!)
            DispatchQueue.main.async {
                self.rightImage.image = UIImage(data:data!)
            }
        }
        
     
    }
    
    func showRandomMovie (){
        let leftObject = movie.randomElement()
        leftImageName.text = leftObject?.movieName
        let url = URL(string: leftObject!.imageUrl)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.leftImage.image = UIImage(data:data!)
            }
        }
        
        let rightObject = movie.randomElement()
        rightImageName.text = rightObject?.movieName
        let url2 = URL(string: rightObject!.imageUrl)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url2!)
            DispatchQueue.main.async {
                self.rightImage.image = UIImage(data:data!)
            }
        }
        
       
    }
    
    func downloadCityJson () {
        
        let url = "https://icebreakerappinc.herokuapp.com/cities"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let cityData = try JSONDecoder().decode([Cities].self, from: data)
                
                DispatchQueue.main.async {
                    self.WDYPViewController.reloadInputViews()
                    self.city = cityData
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    
    func downloadFoodJson () {
        
        let url = "https://icebreakerappinc.herokuapp.com/food"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let foodData = try JSONDecoder().decode([Food].self, from: data)
                
                DispatchQueue.main.async {
                    self.WDYPViewController.reloadInputViews()
                    self.food = foodData
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    
    func downloadMusicJson () {
        
        let url = "https://icebreakerappinc.herokuapp.com/music"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let musicData = try JSONDecoder().decode([Music].self, from: data)
                
                DispatchQueue.main.async {
                    self.WDYPViewController.reloadInputViews()
                    self.music = musicData
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    func downloadLifeStyleJson () {
        let url = "https://icebreakerappinc.herokuapp.com/lifestyle"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let lifestyleData = try JSONDecoder().decode([LifeStyle].self, from: data)
                
                DispatchQueue.main.async {
                    self.WDYPViewController.reloadInputViews()
                    self.lifestyle = lifestyleData
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    func downloadMoviesJson () {
        let url = "https://icebreakerappinc.herokuapp.com/movies"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let movieData = try JSONDecoder().decode([Movies].self, from: data)
                
                DispatchQueue.main.async {
                    self.WDYPViewController.reloadInputViews()
                    self.movie = movieData
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    func startAnimation (){
        
        view.addSubview(lotAnimateScreen)
        lotAnimateScreen.layer.cornerRadius = 50
        lotAnimateScreen.center = view.center
        lotAnimateScreen.animation = Animation.named("77-im-thirsty")
        lotAnimateScreen.loopMode = .loop
        lotAnimateScreen.play()
        
        lotAnimateScreen.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: -500, y: 0)
        
        UIView.animate(withDuration: 1, animations: {
            self.lotAnimateScreen.transform = CGAffineTransform.identity
            self.blurScreen.effect = self.effect
        })
        
        UIView.animate(withDuration: 3, animations: {
            self.blurScreen.effect = nil
        }) {(isComplete) in
            
            self.blurScreen.removeFromSuperview()
            self.lotAnimateScreen.removeFromSuperview()
        }
    }
    
    func viewsDesign () {
        randomBtn.layer.cornerRadius = 50
        pickerview.layer.cornerRadius = 34
        leftImage.layer.cornerRadius = 40
        leftImage.layer.shadowColor = UIColor.black.cgColor
        leftImage.layer.shadowOffset = CGSize (width: 2 , height: 3)
        leftImage.layer.shadowRadius = 4
        leftImage.layer.shadowOpacity = 0.5
        
        
        rightImage.layer.cornerRadius = 20
        rightImage.layer.shadowColor = UIColor.black.cgColor
        rightImage.layer.shadowOffset = CGSize (width: 2 , height: 3)
        rightImage.layer.shadowRadius = 4
        rightImage.layer.shadowOpacity = 0.5
    }
    
    func  blurEffect () {
        effect = blurScreen.effect
        
    }

    }


