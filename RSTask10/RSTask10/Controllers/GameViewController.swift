//
//  GameViewController.swift
//  RSTask10
//
//  Created by Ivan Budovich on 8/25/21.
//

import UIKit

final class GameViewController: UIViewController {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let headerLabel = UILabel()
    let diceButton = UIButton()
    let timerLabel = UILabel()
    let playButton = UIButton()
    let stackView = UIStackView()
    let backButton = UIButton()
    let leftButton = UIButton()
    let rightButton = UIButton()
    let diceView = DiceView(frame: .zero)
    let userIndicator = UserIndicator(frame: .zero)
    
    let buttons: [ShadowedButton] = [.init(), .init(), .init(), .init(), .init()]
    let oneButton: ShadowedButton = ShadowedButton()
    
    var viewModel: GameViewModel!
    
    
    var timer: Timer?
    var startTime: TimeInterval?
    var stopTime: TimeInterval?
    var isTimerActive: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()


        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.id)
        
        viewModel.onNewTurn = {[unowned self] index in
            if self.viewModel.currentPlayerIndex == 0 {
                leftButton.setImage(UIImage(named: "ToEnd"), for: .normal)
            }
            else {
                leftButton.setImage(UIImage(named: "Backward"), for: .normal)
            }
            if self.viewModel.currentPlayerIndex == self.viewModel.players.count - 1{
                rightButton.setImage(UIImage(named: "ToStart"), for: .normal)
            }
            else {
                rightButton.setImage(UIImage(named: "Forward"), for: .normal)
            }
            self.userIndicator.activeIndex = index
            self.resetTimer()
            self.startTimer()
           
        }
        self.userIndicator.characters = viewModel.players.map({ $0.name })
        userIndicator.activeIndex = viewModel.currentPlayerIndex

        
        leftButton.setImage(UIImage(named: "ToEnd"), for: .normal)
        
        if self.viewModel.currentPlayerIndex == self.viewModel.players.count - 1{
            rightButton.setImage(UIImage(named: "ToStart"), for: .normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userIndicator.focus(at: viewModel.currentPlayerIndex)
        scrollToCurrentIndex()
    }
    
    func configureUI(){
        view.addSubview(headerLabel)
        view.addSubview(collectionView)
        view.addSubview(diceButton)
        view.addSubview(timerLabel)
        view.addSubview(playButton)
        view.addSubview(oneButton)
        view.addSubview(backButton)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(stackView)
        
        view.addSubview(userIndicator)
        view.addSubview(diceView)
        
        view.backgroundColor = UIColor(named: "AppBackground")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(showResults))
        
        headerLabel.text = "Game"
        headerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 36.0)
        headerLabel.textColor =  UIColor.white
        
        buttons.forEach {
            stackView.addArrangedSubview($0)
            $0.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 25)
            $0.addTarget(self, action: #selector(addButtonTapped(sender:)), for: .touchUpInside)
        }
        
        buttons[0].setTitle("-10", for: .normal)
        buttons[1].setTitle("-5", for: .normal)
        buttons[2].setTitle("-1", for: .normal)
        buttons[3].setTitle("+5", for: .normal)
        buttons[4].setTitle("+10", for: .normal)
        
        oneButton.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40)
        oneButton.setTitle("+1", for: .normal)
        oneButton.addTarget(self, action: #selector(addButtonTapped(sender:)), for: .touchUpInside)
        
        diceButton.setImage(UIImage(named: "Four"), for: .normal)
        diceButton.addTarget(self, action: #selector(showDice), for: .touchUpInside)

        
        diceView.isHidden = true
        diceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideDice)))
        
        leftButton.setImage(UIImage(named: "Backward"), for: .normal)
        leftButton.addTarget(self, action: #selector(previousPlayer), for: .touchUpInside)
        
        rightButton.setImage(UIImage(named: "Forward"), for: .normal)
        rightButton.addTarget(self, action: #selector(nextPlayer), for: .touchUpInside)
        
        backButton.setImage(UIImage(named: "CurveBack"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        collectionView.backgroundColor = UIColor(named: "AppBackground")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        
        timerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        timerLabel.textColor = UIColor.white
        timerLabel.text = "00:00"
        startTimer()
        playButton.setImage(UIImage(named: "Pause"), for: .normal)
        playButton.addTarget(self, action: #selector(stopAndPlay), for: .touchUpInside)
        
    }
    
    func configureLayout(){
        let multiplier: CGFloat = (view.safeAreaLayoutGuide.layoutFrame.height / Constants.verticalHeight)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        diceButton.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        oneButton.translatesAutoresizingMaskIntoConstraints = false
        buttons.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        diceView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        userIndicator.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = (view.safeAreaLayoutGuide.layoutFrame.width - (Constants.stackViewButtonWidth * multiplier * 5) - 2 * Constants.horizontalOffset) / 4
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            
            stackView.heightAnchor.constraint(equalToConstant: Constants.stackViewButtonWidth * multiplier),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalOffset),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -Constants.stackViewBottomOffset * multiplier),
            
            diceButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.horizontalOffset),
            diceButton.heightAnchor.constraint(equalToConstant: Constants.diceButtonWidth),
            diceButton.widthAnchor.constraint(equalToConstant: Constants.diceButtonWidth),
            diceButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.horizontalOffset),
            headerLabel.heightAnchor.constraint(equalToConstant: Constants.headerLabelHeight),
            
            oneButton.widthAnchor.constraint(equalToConstant: Constants.oneButtonWidth * multiplier),
            oneButton.heightAnchor.constraint(equalToConstant: Constants.oneButtonWidth * multiplier),
            oneButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -Constants.oneButtonVerticalOffset),
            oneButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            diceView.topAnchor.constraint(equalTo: view.topAnchor),
            diceView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            diceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            diceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.backButtonOffset),
            backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonWidth),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonHeight),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.bottomOffset * multiplier),
            
            leftButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.arrowsOffset),
            leftButton.heightAnchor.constraint(equalToConstant: Constants.diceButtonWidth),
            leftButton.widthAnchor.constraint(equalToConstant: Constants.diceButtonWidth),
            leftButton.centerYAnchor.constraint(equalTo: oneButton.centerYAnchor),
            
            rightButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.arrowsOffset),
            rightButton.heightAnchor.constraint(equalToConstant: Constants.diceButtonWidth),
            rightButton.widthAnchor.constraint(equalToConstant: Constants.diceButtonWidth),
            rightButton.centerYAnchor.constraint(equalTo: oneButton.centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: Constants.collectionViewWidthToHeightMultiplier),
            collectionView.bottomAnchor.constraint(equalTo: oneButton.topAnchor, constant: -Constants.collectionViewBottomOffset * multiplier),
            
            timerLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -Constants.timerInterSpacing * multiplier),
            timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: timerLabel.centerYAnchor),
            playButton.leftAnchor.constraint(equalTo: timerLabel.rightAnchor, constant: Constants.horizontalOffset),
            
            userIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.userIndicatorOffset),
            userIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userIndicator.heightAnchor.constraint(equalToConstant: Constants.userIndicatorHeight),
            userIndicator.lastBaselineAnchor.constraint(equalTo: backButton.lastBaselineAnchor)
            
        ])
        let collectionViewLayout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 20

        
    }
    
    
    @objc func addButtonTapped(sender: UIButton){
        if sender === oneButton {
            viewModel.add(score: 1)
        }
        if sender === buttons[0]{
            viewModel.add(score: -10)
        }
        if sender === buttons[1]{
            viewModel.add(score: -5)
        }
        if sender === buttons[2]{
            viewModel.add(score: -1)
        }
        if sender === buttons[3]{
            viewModel.add(score: 5)
        }
        if sender === buttons[4]{
            viewModel.add(score: 10)
        }
        collectionView.reloadItems(at: [IndexPath(item: viewModel.currentPlayerIndex, section: 0)])
    }
    
    @objc func newGame(){
        viewModel.newGame()
    }
    
    @objc func showResults(){
        viewModel.showResults()
    }
    
    @objc func showDice(){
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        navigationController?.setNavigationBarHidden(true, animated: false)
        diceView.isHidden = false
    }
    
    @objc func hideDice(){
        diceView.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func stopAndPlay(){
        if isTimerActive {
            timerLabel.textColor = UIColor(named: "AppGrey")
            playButton.setImage(UIImage(named: "Play"), for: .normal)
            stopTimer()
        }
        else {
            timerLabel.textColor = .white
            playButton.setImage(UIImage(named: "Pause"), for: .normal)
            startTimer()
        }
    }
    
    @objc func nextPlayer(){
        if (viewModel.currentPlayerIndex == viewModel.players.count - 1){
            viewModel.currentPlayerIndex = 0
        }
        else {
            viewModel.currentPlayerIndex += 1
        }
        scrollToCurrentIndex()
    }
    
    @objc func previousPlayer(){
        if (viewModel.currentPlayerIndex == 0){
            viewModel.currentPlayerIndex = viewModel.players.count - 1
        }
        else {
            viewModel.currentPlayerIndex -= 1
        }

        scrollToCurrentIndex()
    }
    
    @objc func back(){
        viewModel.resetTurn()
        collectionView.reloadItems(at: [IndexPath(row: viewModel.currentPlayerIndex, section: 0)])
    }
    
    func startTimer(){
        let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)

        self.timer = timer
        
        if self.startTime != nil, let stopTime = self.stopTime {
            self.startTime! += (Date.timeIntervalSinceReferenceDate - stopTime)
        }
        else {
            self.startTime = Date.timeIntervalSinceReferenceDate
        }
        isTimerActive = true
    }
    
    func stopTimer(){

        stopTime = Date.timeIntervalSinceReferenceDate
        isTimerActive = false
        timer?.invalidate()
    }
    
    func resetTimer(){
        startTime = nil
        stopTime = nil
        timer?.invalidate()
        isTimerActive = false
    }
    
    @objc func updateTimerLabel(){
        guard let startTime = startTime else {return}
        let currentTime = Date.timeIntervalSinceReferenceDate
        let value: TimeInterval = currentTime - startTime
        let minutes: Int = Int(value / 60)
        let seconds: Int = Int(value - Double(minutes) * 60.0)
        
        let string = String(format: "%02d:%02d", minutes, seconds)
        timerLabel.text = string
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension GameViewController{
    enum Constants{
        static let headerLabelHeight: CGFloat = 42.0
        static let horizontalOffset: CGFloat = 20.0
        static let arrowsOffset: CGFloat = 45.0
        static let backButtonOffset: CGFloat = 40.0
        static let backButtonWidth: CGFloat = 15.0
        static let backButtonHeight: CGFloat = 20.0
        static let bottomOffset: CGFloat = 30.0
        static let diceButtonWidth: CGFloat = 30.0
        static let oneButtonWidth: CGFloat = 90.0
        static let oneButtonVerticalOffset: CGFloat = 22.0
        static let collectionViewBottomOffset: CGFloat = 28.0
        static let stackViewButtonWidth: CGFloat = 55.0
        static let collectionViewCellHeightToWidthAspectRatio: CGFloat = 300.0/255.0
        static let collectionViewCellWidthAspectRatio: CGFloat = 255.0/375.0
        static let collectionViewWidthToHeightMultiplier: CGFloat = collectionViewCellWidthAspectRatio * collectionViewCellHeightToWidthAspectRatio
        static let stackViewBottomOffset: CGFloat = 22.0
        static let verticalHeight: CGFloat = 768.0
        static let timerInterSpacing: CGFloat = 30.0
        static let userIndicatorOffset: CGFloat = 70.0
        static let userIndicatorHeight: CGFloat = 30.0
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.players.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.id, for: indexPath) as! CarouselCell
        cell.nameLabel.text = viewModel.players[indexPath.item].name
        cell.scoreLabel.text = "\(viewModel.players[indexPath.item].score)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * Constants.collectionViewCellWidthAspectRatio
        let height = collectionView.frame.width * Constants.collectionViewWidthToHeightMultiplier
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellWidth = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0)).width
        let sideInset = (view.frame.width - cellWidth) / 2
        return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0)).width + 20
        
        let newIndex = (velocity.x == 0) ? Int(floor((targetContentOffset.pointee.x - pageWidth / 2) / pageWidth) + 1.0 ) : (velocity.x > 0 ? viewModel.currentPlayerIndex + 1: viewModel.currentPlayerIndex - 1)
        
        if newIndex >= 0 && newIndex < viewModel.players.count {
            viewModel.currentPlayerIndex = newIndex
        }
        
        targetContentOffset.pointee = CGPoint(x: pageWidth * CGFloat(viewModel.currentPlayerIndex), y: targetContentOffset.pointee.y)
    }
    

    func scrollToCurrentIndex(){
        let pageWidth = collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0)).width + 20
        let offset = CGPoint(x: CGFloat(viewModel.currentPlayerIndex) * pageWidth, y: 0)
        collectionView.setContentOffset(offset, animated: true)
    }
    
}
