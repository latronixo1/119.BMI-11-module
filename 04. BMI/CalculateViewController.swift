//
// ViewController.swift
// 1. Констрейнты на прим. BMI
//
// Created by MacBook on 08.01.2025.
//

import UIKit

class CalculateViewController: UIViewController {

    //============================================================
    //============================================================
    //MARK: - UI

    //фон
    private var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "calculate_background")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()

    //============================================================
    //главный вертикальный стек
    private var mainStackView = UIStackView ()

    //-------------------------------------------------------
    //стек view для ввода высоты (роста) пользователя
    private var heightStackView = UIStackView ()  //var - потому что его будем пересоздавать с помощью вспомогательного инициализатора

    //надпись "Введите ваш рост"
    private let heightTitleLabel = UILabel(alignment: .left)  //let - потому что UILabel - это у нас класс (создается по ссылке), а значит внутри ее можно менять, даже не смотря на то, что сам экземляр let. .left - потому что будет размещаться слева в горизонтальном стеке heightStackView
    //надпись, отображающая рост (высоту), установленный пользователем при помощи слайдера
    private let heightNumberLabel = UILabel(alignment: .right) //.right - потому что будет размещаться справа в горизонтальном стеке heightStackView
    private let heightSlider = UISlider(maxValue: 3)

    //-------------------------------------------------------
    //стек view для ввода веса пользователя
    private var weightStackView = UIStackView ()  //var - потому что его будем пересоздавать с помощью вспомогательного инициализатора
    //надпись "Введите ваш рост"
    private let weightTitleLabel = UILabel(alignment: .left)
    //надпись, отображающая вес, установленный пользователем при помощи слайдера
    private let weightNumberLabel = UILabel(alignment: .right)
    private let weightSlider = UISlider(maxValue: 200)

    //-------------------------------------------------------
    //надпись "Вычисление вашего ИМТ"
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 40, weight: .bold)
        element.textColor = .darkGray
        element.textAlignment = .left
        element.numberOfLines = 0

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    //-------------------------------------------------------
    //кнопка "Рассчитать"
    private let calculateButton = UIButton (isBackgroundWhite: false)

    //MARK: Private Properties
 
    //переменная - структура, которая будет содержать данные о весе, высоте и ИМТ
    private var calculatorBrain = CalculateBrain()

    //============================================================
    //============================================================
    //MARK: - Life Cycle

    //перед загрузкой фона
    override func viewDidLoad() {
    super.viewDidLoad()
        //создать все необходимые элементы
        setViews()
        //установить ограничения для всех необходимых элементов (привязать их к чему-либо)
        setupConstraints()
    }

    //функция созданиях всех необходимых элементов
    private func setViews() {
        //создаем стеки (сверху вниз) - путем переинциализации с помощью вспомогательного инициализатора
        //делаем это до добавления в иерархию (в противном случае создастся еще один стек,
        //будет использоваться еще одна (другая) ячейка памяти)

        //создаем стек для высоты (роста) пользователя
        heightStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillEqually,
            subViews: [heightTitleLabel, heightNumberLabel])

        //создаем стек для веса пользователя
        weightStackView = UIStackView(
            axis: .horizontal,
            distribution: .fillEqually,
            subViews: [weightTitleLabel, weightNumberLabel])

        //создаем главный вертикальный стек
        mainStackView = UIStackView(
            axis: .vertical,  //ось вертикальная
            distribution: .fillProportionally, //распределение - заполнить пропорционально
            //массив подвьюшек
            subViews: [
                titleLabel,
                heightStackView,
                heightSlider,
                weightStackView,
                weightSlider,
                calculateButton
            ]
        )
        //добавляем фоновый view
        view.addSubview(backgroundImageView)
        //добавляем главный вертикальный стековый view
        view.addSubview(mainStackView)

        //надпись "Вычисление вашего ИМТ"
        titleLabel.text = "Вычисление вашего индекса массы тела"

        //задаем изначальный текст для надписей
        heightTitleLabel.text = "Рост"
        heightNumberLabel.text = "1.5 м"

        weightTitleLabel.text = "Вес"
        weightNumberLabel.text = "100 кг"

        //создаем событие нажатия кнопки - запустим функцию calculateButtonTapped
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)

        //создаем событие изменения позции слайдеров - будем запускать функции heightSliderChanged и weightSliderChanged
        heightSlider.addTarget(self, action: #selector(heightSliderChanged), for: .valueChanged)
        weightSlider.addTarget(self, action: #selector(weightSliderChanged), for: .valueChanged)
    }

    //функция изменения позиции слайдера высоты
    @objc private func heightSliderChanged(_ sender: UISlider) {
        heightNumberLabel.text = String(format: "%.2f", sender.value) + " м"
    }
    //функция изменения позиции слайдера веса
    @objc private func weightSliderChanged(_ sender: UISlider) {
        weightNumberLabel.text = String(format: "%.0f", sender.value) + " кг "
    }

    //нажатие на кнопку "Рассчитать"
    @objc private func calculateButtonTapped() {
        //получаем рост и вес у слайдера
        let height = heightSlider.value
        let weight = weightSlider.value

        //передаем рост и вес структуру BMI при помощи функции calculateBMI, входящей в структуру calculatorBrain
        calculatorBrain.calculateBMI(height: height, weight: weight)

        //создаем переменную - следующее окно
        let resultVC = ResultViewController()

        //настраиваем следующее окно
        //modalTransitionStyle (перев. - Стиль модального перехода), показывает, в каком формате будет открываться наш экран.
        resultVC.modalTransitionStyle = .flipHorizontal //coverVertical (по умолчанию) - следующее окно всплывет снизу вверх. flipHorizontal - текущее окно перевернется по горизонтали словно игральная карта, а на обороте будет следующее окно.
        resultVC.modalPresentationStyle = .fullScreen  //popover (по умолчанию) - окно модально отображается в виде всплывающего окна, прикрепленного к определенному элементу интерфейса (в нашем случае к кнопке, таким образом основное окно будет "выглядывать" словно трусы из джинс). fullScreen - на весь экран.

        //задаем свойства структуры
        resultVC.bmiValue = calculatorBrain.getBMIValue()
        resultVC.advice = calculatorBrain.getAdvice()
        resultVC.color = calculatorBrain.getColor()


        //модально открываем следующее окно
        present(resultVC, animated: true, completion: nil)
    }
}


extension CalculateViewController {
    //функция установки ограничений для всех необходимых элементов (надо привязать их к чему-либо)
    private func setupConstraints() {
        NSLayoutConstraint.activate([

        //backgroundImageView - view для фона, его привязываем к корневому view
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        //mainStackView - главный вертикальный стек, его привязываем к корневому view за
        //маленьким исключением - слева и справа отступы по 20 точек
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

        //горизонтальный стек для выбора высоты (роста)
        heightStackView.heightAnchor.constraint(equalToConstant: 21),
        heightSlider.heightAnchor.constraint(equalToConstant: 60),

        //горизонтальный стек для выбора веса
        weightStackView.heightAnchor.constraint(equalToConstant: 21),
        weightSlider.heightAnchor.constraint(equalToConstant: 60),


        calculateButton.heightAnchor.constraint(equalToConstant: 51),
        ])
    }
}
