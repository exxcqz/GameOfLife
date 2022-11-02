//
//  ViewController.swift
//  GameOfLife
//
//  Created by Nikita Gavrikov on 02.11.2022.
//

import UIKit

final class ViewController: UIViewController {

    private weak var timer: Timer?
    private weak var workItem: DispatchWorkItem?

    private let grid: Grid = .init(size: 50)
    private var isWorked: Bool = false

    // MARK: - Subviews

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

    // MARK: - Lifecycle

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

    // MARK: - Actions
    
    @objc private func startStopButtonTapped() {
        if grid.cells.isEmpty {
            randomize()
        }
        if !isWorked {
            updateGridView()
        } else {
            deleteTimer()
        }
        isWorked.toggle()
    }

    @objc private func randomizeButtonTapped() {
        deleteTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.randomize()
        }
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(gridView)
        view.addSubview(startStopButton)
        view.addSubview(randomizeButton)
    }

    private func deleteTimer() {
        timer?.invalidate()
        timer = nil
        workItem?.cancel()
        workItem = nil
    }

    private func randomize() {
        isWorked = false
        grid.randomizeCells()
        gridView.setNeedsDisplay()
    }

    private func updateGridView() {
        let workItem = DispatchWorkItem { [weak self] in
            self?.grid.updateCells()
            DispatchQueue.main.async {
                self?.gridView.setNeedsDisplay()
            }
        }
        self.workItem = workItem
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.250 , repeats: true) { _ in
            DispatchQueue.global().async(execute: workItem)
        }
    }
}
