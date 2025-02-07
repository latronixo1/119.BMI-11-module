//
// ResultViewController.swift
// 1. Констрейнты на прим. BMI
//
// Created by MacBook on 19.01.2025.
//

import UIKit

class ResultViewController: UIViewController {

    //MARK: - UI

    //фон
    private var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "result_background")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    } ()

    //============================================================
    //главный вертикальный стек
    private var mainStackView = UIStackView ()

    //-------------------------------------------------------
    //надпись "Ваш индекс массы тела"
    private lazy var bmiLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 35, weight: .bold)
        element.textColor = .white
        element.textAlignment = .left
        element.numberOfLines = 0

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    //-------------------------------------------------------
    //надпись с результатом расчета
    private lazy var resultLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 80, weight: .bold)
        element.textColor = .white
        element.textAlignment = .left
        element.numberOfLines = 0

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    //-------------------------------------------------------
    //надпись с советом
    private lazy var adviceLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 20, weight: .light)
        element.textColor = .white
        element.textAlignment = .left
        element.numberOfLines = 2

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()


    //-------------------------------------------------------
    //кнопка "Рассчитать"
    private let recalculateButton = UIButton (isBackgroundWhite: true)

    //MARK: Public Properties

    //публичные свойства контроллера - для передачи в них значений из предыдущего окна
    var bmiValue: String?
    var advice: String?
    var color: UIColor?


    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()  //зададим и добавим ранее созданные элементы интерфейса к корневому view
        setupConstraints()  //определим ограничения для элементов интерфейса
    }

    // MARK: Set Views

    //функция созданиях всех необходимых элементов
    private func setViews() {

        resultLabel.text = bmiValue
        adviceLabel.text = advice
        view.backgroundColor = color
        
        //создаем главный вертикальный стек
        mainStackView = UIStackView(
            axis: .vertical,  //ось вертикальная
            distribution: .fillProportionally, //распределение - заполнить пропорционально
            //массив подвьюшек
            subViews: [
                bmiLabel,
                resultLabel,
                adviceLabel,
            ]
        )

        //добавляем к корневому view
        // фоновый view
        view.addSubview(backgroundImageView)
        // главный вертикальный стековый view
        view.addSubview(mainStackView)
        // кнопку Пересчитать
        view.addSubview(recalculateButton)

        //даем текст надписям
        bmiLabel.text = "Ваш результат"

        //создаем событие нажатия кнопки - запустим функцию calculateButtonTapped
        recalculateButton.addTarget(self, action: #selector(recalculateButtonTapped), for: .touchUpInside)
    }

    //функция нажатия на кнопку "пересчитать" - вернемся к предыдущему окну
    @objc private func recalculateButtonTapped () {
        dismiss(animated: true)
    }
}

//============================================================
//============================================================
//расширения

extension ResultViewController {
    //функция установки ограничений для всех необходимых элементов (надо привязать их к чему-либо)
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            //backgroundImageView - view для фона, его привязываем к корневому view
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            //mainStackView - главный вертикальный стек, его центруем
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),


            //кнопку "Пересчитать" делаем высотой 51, приклеиваем к нижней границе экрана, слева и справа отступает на 20
            recalculateButton.heightAnchor.constraint(equalToConstant: 51),
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            recalculateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recalculateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

