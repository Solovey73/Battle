/*
 Все сущности должны быть написаны и спроектированы в ООП стиле. Объекты обязательно должны реагировать на некорректные аргументы методов.
 В вашей программе обязательно должны получиться классы сущностей Игрок и Монстр. Наличие дополнительных классов по вашему желанию.

 Результатом должно стать приложение с реализацией классов и примером их использования.
 
Спроектируйте и реализуйте классы для одной видеоигры. Реализацию опубликуйте в открытом репозитории на github. В readme репозитория оставьте свое имя пользователя в Telegram для связи.
Условия:
 
 
 
 
 
1) В игре есть Существа. К ним относятся Игрок и Монстры.
2) У Существа есть параметры Атака и Защита. Это целые числа от 1 до 30.
 
3) У Существа есть Здоровье. Это натуральное число от 0 до N. Если Здоровье становится равным 0, то Существо умирает. Игрок может себя исцелить до 4-х раз на 30% от максимального Здоровья.
 
4) У Существа есть параметр Урон. Это диапазон натуральных чисел M - N. Например, 1-6.
 
5) Одно Существо может ударить другое по такому алгоритму:
  - Рассчитываем Модификатор атаки. Он равен разности Атаки атакующего и Защиты защищающегося плюс 1
  - Успех определяется броском K кубиков с цифрами от 1 до 6, где K - это Модификатор атаки. Всегда бросается хотя бы один кубик.
    - Удар считается успешным, если хотя бы на одном из кубиков выпадает 5 или 6
  - Если удар успешен, то берется произвольное значение из параметра Урон атакующего и вычитается из Здоровья защищающегося.
*/
class Существо {
    
    var атака: Int {
        return Int.random(in: 1...30)
    }
    var защита: Int {
        return Int.random(in: 1...30)
    }
    
    var здоровье: Int = 100 {
        willSet {
            guard newValue < 1 else {return}
            print("cущество умирает")
        }
    }
    var урон : Int  {
        return Int.random(in: 1...30)
    }
    
    func ударить(кого: Существо) {
        let модификаторАтаки = self.атака - (кого.защита + 1)
        var array = [Int]()
        for _ in 1...max(1, модификаторАтаки) {
            array.append(Int.random(in: 1...6))
        }
        let secses = array.contains(5) || array.contains(6)
        switch secses {
        case true : кого.здоровье -= self.урон
        case false: self.здоровье -= кого.урон
            print(self.здоровье)
            print(кого.здоровье)
        }
        
    
    }
    
}

class Игрок: Существо {
    let максимальноеЗдоровье = 100
    
    func исцеление30() {
        здоровье += Int(Double(максимальноеЗдоровье) * 0.3)
    }
}

class Монстр: Существо{
    
}

