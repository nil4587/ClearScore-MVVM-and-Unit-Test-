//
//  DashboardViewController.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/05.
//

import UIKit

class DashboardViewController: BaseViewController {

    @IBOutlet private weak var scoreBoardView: UIView!
    @IBOutlet private weak var scoreBoardTitleLabel: UILabel!
    
    private lazy var viewModel = DashboardViewModel(delegate: self)
        
    // MARK: - ================================
    // MARK: View Life-cycle
    // MARK: ================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        designUpdatedForSubviews()
        refershScore(nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let detailsViewController = segue.destination as? DashboardDetailsViewController
        detailsViewController?.createViewModel(with: viewModel.creditReportModel)
    }
    
    // MARK: - ================================
    // MARK: User-defined methods
    // MARK: ================================
    
    private func designUpdatedForSubviews() {
        scoreBoardView.addBorderAndShadow(offset: CGSize(width: 2.0, height: 2.0),
                                          borderColor: UIColor.lightGray,
                                          borderRadius: (scoreBoardView.width/2.0),
                                          shadowColor: UIColor.red,
                                          shadowRadius: 5.0,
                                          opacity: 0.5)
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(scoreBoardTapped(_:)))
        tapGuesture.cancelsTouchesInView = true
        tapGuesture.numberOfTapsRequired = 1
        scoreBoardView.addGestureRecognizer(tapGuesture)
    }
    
    private func refreshSubViews() {
        let font = UIFont.systemFont(ofSize: 50.0)
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.red
        shadow.shadowBlurRadius = 5
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.yellow, .shadow: shadow]
        let formattedScoreString = NSAttributedString(string: "\(viewModel.score)", attributes: attributes)
        let attributedSuffixString = NSAttributedString(string: String(format: "score_board_trailing_text".localised(), viewModel.totalScore))
        let mutableAttributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "score_board_leading_text".localised()))
        mutableAttributedText.append(formattedScoreString)
        mutableAttributedText.append(attributedSuffixString)
        scoreBoardTitleLabel.attributedText = mutableAttributedText
        self.navigationItem.rightBarButtonItem?.isEnabled = viewModel.isScoreAvailable
    }
    
    private func resetCreditScore() {
        viewModel.resetCreditScoreData()
        self.navigationItem.rightBarButtonItem?.isEnabled = viewModel.isScoreAvailable
        scoreBoardTitleLabel.attributedText = NSAttributedString(string: "Please wait....")
    }
    
    // MARK: - ================================
    // MARK: IBActions
    // MARK: ================================
    
    @IBAction private func scoreBoardTapped(_ sender: UITapGestureRecognizer) {
        guard viewModel.isScoreAvailable else { return }
        self.performSegue(withIdentifier: "DashboardDetailsViewSegue", sender: sender)
    }
    
    @IBAction private func refershScore(_ sender: UIBarButtonItem?) {
        resetCreditScore()
        viewModel.fetchCreditScoreData(using: URL(string: Constants.creditCheckURL))
    }
}

// MARK: - ================================
// MARK: DashboardViewModel Delegate Methods
// MARK: ================================

extension DashboardViewController: DashboardViewModelDelegate {
    func creditScoreSuccess() {
        DispatchQueue.main.async {[weak self] in
            self?.refreshSubViews()
        }
    }
    
    func creditScoreFailure(with errorMessage: String) {
        DispatchQueue.main.async {[weak self] in
            self?.displayAlert(message: errorMessage)
        }
    }
}
