//
//  Jokes.swift
//  practing
//
//  Created by shy attoun on 13/03/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit




struct Joke: Decodable{
    
    let id: Int
    let setup: String
    let punchline: String
   
}

class JokesController: UITableViewController{
    
    
    private var joke = [Joke]()
   
    
    @IBOutlet var JokeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        
        JokeTableView.delegate = self
        JokeTableView.dataSource = self
    }
    func downloadJson () {

        let url = "https:icebreakerappinc.herokuapp.com/jokes"

        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}

            do {
                let jokeArray = try JSONDecoder().decode([Joke].self, from: data)
                self.joke = jokeArray
                DispatchQueue.main.async {
                    self.JokeTableView.reloadData()
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.joke.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> JokesCell {
        let cell = self.JokeTableView.dequeueReusableCell(withIdentifier: "JokeCell" , for: indexPath) as! JokesCell
        
        cell.jokeTitleLabel?.text = joke[indexPath.row].setup
        cell.jokeTextLabel?.text = joke[indexPath.row].punchline
        
        return cell
    }
   
}

