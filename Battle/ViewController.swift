import UIKit

class ViewController: UIViewController {
    let игрок = Игрок()
    let монстр = Монстр()
    var count = 4
    var directionAttack = directionAttacks.наМонстра
    
    
    @IBOutlet var ХП: UIButton!
    

    @IBOutlet var здоровьеИгрока: UILabel!
    @IBOutlet var здоровьеМонстра: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        здоровьеИгрока.text = String(игрок.здоровье)
        здоровьеМонстра.text = String(монстр.здоровье)
        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func changeAtack(_ sender: UIButton) {
        switch directionAttack {
        case .наИгрока:
            directionAttack = .наМонстра
            sender.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
        case .наМонстра:
            directionAttack = .наИгрока
            sender.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        }
    }
    
    
    
    @IBAction func востановитьЗдоровье(_ sender: UIButton) {
        
        if count != 1 {
            игрок.исцеление30()
            здоровьеИгрока.text = String(игрок.здоровье)
            count -= 1
            sender.setTitle("+ ХП(\(count))", for: .normal)
        } else {
            sender.isEnabled = false
            sender.setTitle("+ ХП(\(count))", for: .normal)
            
        }
        
    }
    
    
    
    @IBAction func atack(_ sender: UIButton) {
        switch directionAttack {
        case .наИгрока:
            монстр.ударить(кого: игрок)
        case .наМонстра:
            игрок.ударить(кого: монстр)
        }
        здоровьеИгрока.text = String(игрок.здоровье)
        здоровьеМонстра.text = String(монстр.здоровье)
        
        if игрок.здоровье <= 0 {
            showAlert(результат: "Вы проиграли")
        } else if монстр.здоровье <= 0 {
            showAlert(результат: "Вы выиграли")
        }
        
    }
    
    
}

extension ViewController {
    
    enum directionAttacks {
    case наИгрока
    case наМонстра
    }
    
    func showAlert(результат: String) {
        let alert = UIAlertController(title: результат, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Новая Игра", style: .default, handler: { _ in
            self.newGame()
        }))
        present(alert, animated: true)
    }
    
    func newGame() {
        игрок.здоровье = 100
        монстр.здоровье = 100
        здоровьеИгрока.text = String(игрок.здоровье)
        здоровьеМонстра.text = String(монстр.здоровье)
        count = 4
        ХП.isEnabled = true
        ХП.setTitle("+ ХП(\(count))", for: .normal)
    }
}
