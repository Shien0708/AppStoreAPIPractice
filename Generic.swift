//
//  Generic.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/6.
//

import Foundation
import UIKit

class Prince<Pet, Personality> where Pet:PetIsQuiet, Personality:GoodLooking {
    var pet: Pet?
    var personality: Personality?
}

class Dog {
    func eat() {
        print("I can eat!")
    }
}

class Cat: PetIsQuiet {
    var name = "Kitty"
    func damage() {
        print("Can I destroy it?")
    }
    func sleep() {
        print("I sleep every day")
    }
    func sneak() {
         print("Nobody will notice me.")
    }
}

class Optimistism: GoodLooking {
    func beingTalkative() {
        print("Are you alone? Do you want to chat with me?")
    }
    func makeUP() {
        print("Comb hair everyday.")
    }
}

protocol GoodLooking {
    func makeUP()
}

protocol PetIsQuiet {
    func sleep()
    func sneak()
}

class PetViewController: UIViewController {
    let Chris = Prince<Cat, Optimistism>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Chris.pet = Cat()
        Chris.personality = Optimistism()
        if let pet = Chris.pet, let personality = Chris.personality {
            pet.sneak()
            personality.makeUP()
            eatFish(animal: pet)
        }
        run(pet: Dog.self)
        play(animal: Cat.self)
        play(animal: Dog.self)
    }
    
    func play<Animal>(animal: Animal.Type) {
        print("\(animal) likes to play")
    }
    
    func eatFish<Animal: PetIsQuiet>(animal: Animal){
        print("The \(animal) like to eat fish.")
        animal.sneak()
        animal.sleep()
    }
    
    func run<Dog>(pet: Dog) {
        print("\(pet) can run")
    }

}
