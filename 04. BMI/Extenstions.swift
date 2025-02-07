//
// Extenstions.swift
// 1. Констрейнты на прим. BMI
//
// Created by MacBook on 19.01.2025.
//


import UIKit

//============================================================
//============================================================
//расширения не должны храниться в файле ViewController.swift

//расширение для стеков. У нас они будут вертикальные и горизонтальные
extension UIStackView {
    //вспомогательный инициализатор, принимающий параметры, которыми будут отличаться наши стеки
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, subViews: [UIView]) {
        //вызов собственного инициализатора обязателен (при использовании вспомогательного)
        self.init(arrangedSubviews: subViews)
        self.axis = axis
        self.distribution = distribution
        self.spacing = 0
        self.translatesAutoresizingMaskIntoConstraints = false //не забываем про TAMIC
    }
}

//расширение для надписей. У нас они будут различаться выравниванием (alignment)
extension UILabel {
    //вспомогательный инициализатор, принимающий параметры, которыми будут отличаться наши стеки
    convenience init(alignment: NSTextAlignment) {
        //вызов собственного инициализатора обязателен (при использовании вспомогательного)
        self.init()

        self.textAlignment = alignment
        self.font = .systemFont(ofSize: 17, weight: .light)
        self.textColor = .darkGray
        self.translatesAutoresizingMaskIntoConstraints = false  //не забываем про TAMIC
    }
}

//расширение для cлайдеров. У нас они будут различаться максимальным значением: 3 метра и 200 кг
extension UISlider {
  convenience init(maxValue: Float) {
    self.init()
   
    self.maximumValue = maxValue
    self.value = maxValue / 2  //при запуске приложение ползунок пусть будет установлен на середине
    self.thumbTintColor = UIColor(red: 0.45, green: 0.45, blue: 0.82, alpha: 0.5)  //цвет линии справа от ползунка
    self.minimumTrackTintColor = UIColor(red: 0.45, green: 0.45, blue: 0.82, alpha: 0.5)  //цвет линии слева от ползунка
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}


//расширение для кнопок. Будут различаться цветами. Одна - текст "рассчитать", белый текст и фиолетовый фон. Вторая - текст "пересчитать", белый текст и фиолетовый фон
extension UIButton {
  convenience init(isBackgroundWhite: Bool) {
    self.init(type: .system)  //собственный инициализатор такой же, как был бы без раширения
   
    let violet = UIColor(red: 0.45, green: 0.45, blue: 0.82, alpha: 1.00)  //фиолетовый
   
    //при помощи тернарной формы условного оператора инициализируем различающиеся параметры
    let textButton = isBackgroundWhite ? "пересчитать" : "рассчитать"
    self.tintColor = isBackgroundWhite ? violet : .white
    self.backgroundColor = isBackgroundWhite ? .white : violet
   
    self.layer.cornerRadius = 10 //сглаживаем углы
    self.titleLabel?.font = .systemFont(ofSize: 20)
    self.setTitle(textButton, for: .normal)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}

