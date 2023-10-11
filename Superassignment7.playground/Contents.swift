import UIKit

class SuperEnemy {
    let name: String
    let alias: String
    var hitPoints: Int
    let whyEvil: String
    
    init(name: String, alias: String, hitPoints: Int, whyEvil: String) {
        self.name = name
        self.alias = alias
        self.hitPoints = hitPoints
        self.whyEvil = whyEvil
    }
}

//Created class SuperEnemy with four properties: name, alias, hitPoints, and the reason they became evil (this will  gain importance later).

protocol Superhero: AnyObject {
    var name: String { get }
    var alias: String { get }
    var isEvil: Bool { get }
    var superPowers: [String: Int] { get }
    
    func attack(superEnemy: SuperEnemy) -> Int
    func performSuperPower(superEnemy: SuperEnemy) -> Int
}

// Created protocol Superhero which defines what properties and methods Superheroes must have.

extension Superhero {
    func currentInfo() {
        print("The \(name) has \(superPowers) left")
    }
}
// An extension to show us some info about how the superheroes are doing in terms of superpowers.

class PhysicsSuperhero: Superhero {
    let name: String
    let alias: String
    var isEvil: Bool
    var superPowers: [String: Int]
    
    init(name: String, alias: String, isEvil: Bool, superPowers: [String: Int]) {
        self.name = name
        self.alias = alias
        self.isEvil = isEvil
        self.superPowers = superPowers
    }
    
    func attack(superEnemy: SuperEnemy) -> Int {
        let damageReceived = Int.random(in: 20...40)
        superEnemy.hitPoints -= damageReceived
        return superEnemy.hitPoints
    }
    
    func performSuperPower(superEnemy: SuperEnemy) -> Int {
        if let (powerUsed, damageReceived) = superPowers.randomElement() {
            superPowers.removeValue(forKey: powerUsed)
            superEnemy.hitPoints -= damageReceived
        }
        return superEnemy.hitPoints
    }
}

// Created Class PhysicsSuperhero by adhering to Superhero protocol

let singularitySage = PhysicsSuperhero(name: "🧠Stephen Hawking", alias: "🧠Singularity Sage", isEvil: false, superPowers: [
    "🧠Black Hole Radiation": 6,
    "🧠Spaghettification": 19,
    "🧠Black Vapor": 3,
    "🧠Information Loss Attack": 5,
])

let relativityMan = PhysicsSuperhero(name: "⏳Albert Einstein", alias: "⏳Relativity Man", isEvil: false, superPowers: [
    "⏳Time and Space Continuum Attack": 8,
    "⏳Special Attack": 7,
    "⏳General Attack": 5,
    "⏳Denying Quantum Mechanics": 20,
    "⏳Cool Moustache Combo": 14
])

let photonMan = PhysicsSuperhero(name: "🌟Richard Feynman", alias: "🌟Photon Man", isEvil: false, superPowers: [
    "🌟Photon Laser Shoot": 5,
    "🌟Liquid Helium Tornado": 9,
    "🌟Charm and Negotiation": 10,
    "🌟Random Guitar Solo": 8
])

let quantumCat = PhysicsSuperhero(name: "🐱Erwin Schrödinger", alias: "🐱Quantum Cat", isEvil: false, superPowers: [
    "🐱Existential Crisis Attack": 15,
    "🐱Wave-like Particle Shoot": 7,
    "🐱Entanglement": 12,
    "🐱Superposition": 8
])

let nuclearBomb = PhysicsSuperhero(name: "💣Robert Oppenheimer", alias: "💣Nuclear Bomb", isEvil: false, superPowers: [
    "💣💣Double Atomic Attack": 10,
    "💣Nuclear Bomb Drop (and simultaneously being utterly surprised)": 2,
    "💣Proton Nuclei Scatter": 8
])

let astroMan = PhysicsSuperhero(name: "🌌🎤Neil deGrasse Tyson", alias: "🌌🎤AstroMan", isEvil: false, superPowers: [
    "🌌🎤Conversation Power Block Attack": 2,
    "🌌🎤Making a Documentary about the fight and Raising Awareness": 1,
    "🌌🎤Yelling Storm": 15
])

//Created some physics superhero instances.

class SuperheroSquad {
    var amazingSuperheroes: [Superhero]
    
    init(amazingSuperheroes: [Superhero]) {
        self.amazingSuperheroes = amazingSuperheroes
    }
    
    func getSquadInfo() {
        for superhero in amazingSuperheroes {
            print("\(superhero.name), also known as \(superhero.alias)")
        }
    }
}

//Created class SuperheroSquad which will be a way for us to put our Physics superheroes in teams and have them fight togehter!

//Now let's create a method for combat. There will be a total of 5 rounds, the team that wins more rounds is the final champion of the game.

func simulateShowdown(fighting team: SuperheroSquad, against enemy: SuperEnemy) {
    var roundCount = 1
    var superheroWins = 0
    var enemyWins = 0
    
    while !team.amazingSuperheroes.isEmpty && roundCount <= 5 {
        print("❗Round \(roundCount) has started ❗")
        
        for superhero in team.amazingSuperheroes {
            if enemy.hitPoints <= 0 {
                break
            }
            
            let useSuperpowerNow = (Int.random(in: 0...1) == 1) && !superhero.superPowers.isEmpty
            
            if useSuperpowerNow {
                if let (superpower, damage) = superhero.superPowers.randomElement() {
                    enemy.hitPoints = superhero.performSuperPower(superEnemy: enemy)
                    print("\(superhero.name) has used the Power of \(superpower) against \(enemy.alias) for -\(damage) damage")
                } else {
                    enemy.hitPoints = superhero.attack(superEnemy: enemy)
                    print("\(superhero.name) aka \(superhero.alias) has just used their good old regular attack on \(enemy.name)!")
                }
            }
        }
        
        if enemy.hitPoints <= 0 {
            print("💥\(enemy.name) aka \(enemy.alias) has been defeated in Round \(roundCount)!💥")
            superheroWins += 1
        } else {
            let enemyDamage = Int.random(in: 10...30)
            for superhero in team.amazingSuperheroes {
                superhero.attack(superEnemy: enemy)
            }
            print("💥\(enemy.name) counterattacks💥")
            enemyWins += 1
        }
        
        roundCount += 1
    }
    
    if superheroWins > enemyWins && superheroWins == 5 {
        print("🏆🏆🏆The Amazing Superheroes have destroyed \(enemy.name) with a super quantum strike of \(superheroWins) wins.🏆🏆🏆")
    } else if superheroWins > enemyWins {
        print("🏆🏆The Amazing Superheroes have won against \(enemy.name) with \(superheroWins) wins total. Modern physics wins after all!🏆🏆")
    } else {
        print("After all that, the enemy still stands!\n 🍎🏆🍎NOTHING CAN DEFY THE GREAT FORCE OF GRAVITY. \(enemy.name) has just canceled all of modern physics. No more weird quantum stuff!🍎🏆🍎")
    }
    
    let lastSuperhero = team.amazingSuperheroes.last
    
    if superheroWins > enemyWins || (superheroWins == 5 && enemy.hitPoints <= 0) {
        if let lastSuperhero = lastSuperhero {
            print("\n\(enemy.name) says: \(enemy.whyEvil)\n\(lastSuperhero.name) says: '💅Oh well, the apple was not the only thing that hit your head today, Sir Isaac!💅'")
        }
    }
}

//in case the superheroes win, we get a final dialogue.

let gravityGuardian = SuperEnemy(name: "🍎🍎Sir Isaac Newton", alias: "🍎🍎Gravity Guardian", hitPoints: 435, whyEvil: "🍎😞Nobody appreciates classic Newtonian physics anymore. I am also kinda mad at apples😞🍎")

//created an instance of superEnemy.

let superheroes: [Superhero] = [singularitySage, relativityMan, photonMan, quantumCat, nuclearBomb, astroMan]
let superheroSquad = SuperheroSquad(amazingSuperheroes: superheroes)

simulateShowdown(fighting: superheroSquad, against: gravityGuardian)

//called the method.
