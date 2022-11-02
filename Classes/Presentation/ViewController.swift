//
//  ViewController.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    private var timer: Timer?
    
    private let grid: Grid = .init(size: 50)
    private var isWorked: Bool = false
    
    private lazy var gridView: GridView = .init(grid: grid)
    
    private lazy var startStopButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Start/Stop", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .gray
        view.layer.cornerRadius = 6
        view.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var randomizeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Randomize", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .gray
        view.layer.cornerRadius = 6
        view.addTarget(self, action: #selector(randomizeButtonTapped), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gridView.frame = .init(x: 20,
                               y: view.safeAreaInsets.top + 5,
                               width: view.bounds.width - 40,
                               height: view.bounds.width - 40)
        
        let buttonInset = (view.bounds.width - (120 * 2)) / 3

        startStopButton.frame = .init(x: buttonInset,
                                      y: view.bounds.height / 2 + 50,
                                      width: 120,
                                      height: 40)
        
        randomizeButton.frame = .init(x: buttonInset + startStopButton.bounds.width + buttonInset,
                                      y: view.bounds.height / 2 + 50,
                                      width: 120,
                                      height: 40)
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(gridView)
        view.addSubview(startStopButton)
        view.addSubview(randomizeButton)
    }
    
    private func deleteTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func startStopButtonTapped() {
        if grid.cells.isEmpty {
            return
        }
        if !isWorked {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.250 , repeats: true) { [weak self] _ in
                self?.grid.updateCells()
                self?.gridView.setNeedsDisplay()
            }
        } else {
            deleteTimer()
        }
        isWorked.toggle()
    }
    
    @objc private func randomizeButtonTapped() {
        deleteTimer()
        grid.randomizeCells()
        gridView.setNeedsDisplay()
    }
}

