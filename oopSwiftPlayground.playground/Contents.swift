class Music {
    let notes : [String]
    init(notes:[String]) {
        self.notes = notes
    }
    
    func prepared() -> String {
        return notes.joined(separator: " ")
    }
    
}


class Instrument {

    let brand : String
    init(brand : String) {
        self.brand = brand
    }
    func tune() -> String {
       fatalError("Implement this method for \(brand)")
    }
    
    func play(_ music : Music) -> String {
        return music.prepared()
    }
    
    func perform(_ music: Music){
        print(tune())
        print(play(music))
    }
    
}

class Piano:Instrument{
    let hasPedals : Bool
    static let whiteKeys = 52
    static let blackKeys = 36
    
    init(brand: String , hasPedals:Bool = false) {
        self.hasPedals = hasPedals
        super.init(brand: brand)
    }
    
    override func tune() -> String {
        return "Piano standard tuning for \(brand)"
    }
    
    override func play(_ music: Music) -> String {
        return play(music, usingPedals: hasPedals)
    }

    
    func play(_ music : Music , usingPedals:Bool) -> String {
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals{
            return "Play piano notes  \(preparedNotes) with pedals"
        }
        else{
            return "Play piano notes \(preparedNotes) without pedals "
        }
    
}



}

let piano = Piano(brand: "VERSACE", hasPedals : true)
piano.tune()
let music = Music(notes: ["a", "b" ,"g"])
piano.play(music)
piano.play(music, usingPedals: false)

Piano.whiteKeys
Piano.blackKeys



class Guitar :Instrument{
    let stringGauge : String
    init(brand: String, stringGauge: String = "Medium") {
        self.stringGauge = stringGauge
        super.init(brand: brand)
    }
    
    
}


class AcousticGuitar:Guitar{
    static let numberOfStrings = 6
    static let fratCount = 20
    override func tune() -> String {
        return "Tune \(brand) acoustic guitar with  E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play folk tune on fets \(preparedNotes)"
    }
    
}


let acousticGuitar = AcousticGuitar(brand: "CETESKINJEm" , stringGauge:"light")
acousticGuitar.tune()
acousticGuitar.play(music)


class Amplifier {
    private var _volume : Int
    private(set) var isOn : Bool
    
    init(){
        isOn = false
        _volume = 0
    }
    func plugIn() {
        isOn = true
    }
    func unplug() {
        isOn = false
    }
    var volume: Int {
    get {
        return isOn ? _volume : 0
    }
        set {
            _volume = min(max(newValue,0), 10)
        }
    }
}

class ElectricGuitar:Guitar{
    let amplifier : Amplifier
        init(brand: String, stringGauge:String = "light", amplifier: Amplifier ) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    override func tune() -> String {
        amplifier.plugIn()
        amplifier.volume = 5
        return "Tune \(brand) electric with E A D B G E ="
    }
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play solo \(preparedNotes) at volume \(amplifier.volume)"
    }
}

class BassGuitar:Guitar{
    let amplifier:Amplifier
    init(brand: String , stringGauge: String = "heavy" , amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        return "Tune \(brand) bass with E A D G"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play \(preparedNotes) at bass guitar at volume \(amplifier.volume)"
    }
    
}

let amplifier = Amplifier()

let electricGuitar = ElectricGuitar(brand: "Gibson", stringGauge: "medium", amplifier: amplifier)
electricGuitar.tune()


let bassGuitar = BassGuitar(brand: "Fender", stringGauge: "heavy", amplifier: amplifier)
bassGuitar.tune()




bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

bassGuitar.amplifier.unplug()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

bassGuitar.amplifier.plugIn()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume


class Band {
    let instruments: [Instrument]
    
    init(instruments: [Instrument]) {
        self.instruments = instruments
    }
    
    func perform(_ music: Music) {
        for instrument in instruments {
            instrument.perform(music)
        }
    }
}

let instruments = [piano, acousticGuitar, electricGuitar, bassGuitar]
let band = Band(instruments: instruments)
band.perform(music)

