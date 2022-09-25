//
//  ViewController.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import UIKit

class PicOfTheDayViewController: UIViewController {
    
    /// Different view states
    private enum State {
        case loading
        case error
        case loaded(data: [ApodViewModel])
    }
    
    /// Collection view sections
    private enum Section: CaseIterable {
        case main
    }
    
    /// Collection view
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = dataSource
            collectionView.isHidden = true
        }
    }
    
    /// Ativity indicator
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    /// Message view
    @IBOutlet private var messageView: MessageView! {
        didSet {
            messageView.imageView.image = UIImage(named: "Error Illustration")
            messageView.label.text = MessageViewStrings.errorMessage.localized
            messageView.refreshButton.isHidden = false
            messageView.refreshButton.titleLabel?.text = MessageViewStrings.refreshButton.localized
            messageView.refreshButtonHandler = { [weak self] in
                guard let self = self else { return }
                self.state = .loading
                self.fetchPicture(date: Date())
            }
        }
    }
    
    /// Date picker view
    @IBOutlet weak var pickerView: PickerView!
    @IBOutlet weak var bottomPickerView: NSLayoutConstraint!

    
    /// API Client
    private lazy var client = CosmosClient()
    
    /// Data Source
    private lazy var dataSource = collectionViewDataSource()
    
    /// Pagination offset
    private var paginationOffset = 0
    
    /// Pagination page size
    private var pageSize = 1
    
    var startDate = ""
    
    var endDate = ""
    
    /// View state
    private var state: State = .loading {
        didSet {
            switch state {
            case .loading:
                activityIndicator.startAnimating()
                messageView.isHidden = true
                collectionView.isHidden = true
            case .error:
                activityIndicator.stopAnimating()
                messageView.isHidden = false
                collectionView.isHidden = true
            case .loaded(let data):
                activityIndicator.stopAnimating()
                messageView.isHidden = true
                collectionView.isHidden = false
                let animate = collectionView.numberOfItems(inSection: 0) != 0
                insert(data, animate: animate)
            }
        }
    }
    
    /// The identifier for the footer cell
    private static let footerCellIdentifier = "com.samuelyanez.CosmosCellFooter"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = PicOfTheDayViewStrings.title.localized
        fetchPicture(date: Date())
    }
            
    private func fetchPicture(date: Date, completion: (() -> Void)? = nil) {
        client.fetch(date: date) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.state = .error
            case .success(let apods):
                self.state = .loaded(data: [ApodViewModel(apod: apods)])
            }
            completion?()
        }
    }
    
}

// MARK: Collection Data Source

extension PicOfTheDayViewController {
    private func collectionViewDataSource() -> UICollectionViewDiffableDataSource<Section, ApodViewModel> {
        let dataSource =  UICollectionViewDiffableDataSource<Section, ApodViewModel>(collectionView: collectionView) { collectionView, indexPath, viewModel in
            let cell: DiscoverCell = DiscoverCell.dequeue(from: collectionView, for: indexPath)
            cell.viewModel = viewModel
            return cell
        }
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PicOfTheDayViewController.footerCellIdentifier, for: indexPath)
        }
        // Apply initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, ApodViewModel>()
        snapshot.appendSections(Section.allCases)
        dataSource.apply(snapshot, animatingDifferences: false)
        return dataSource
    }
    
    private func insert(_ identifiers: [ApodViewModel], animate: Bool = true) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(identifiers)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    private func configureDatePicker() {
        let minimumDate = self.getDate(01, 01, 1900)
        self.pickerView.setupPickerView(title: "Select Date", pickerType: .date, minimumdate: minimumDate, maximumdate: Date.yesterday, cancel: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.closePicker()
        }, done: {
            self.closePicker()
            let date = self.pickerView.tapPickerView.date
            self.fetchPicture(date: date)
        })
        self.openPicker()
    }
    
    func openPicker() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tabBarController?.tabBar.isHidden = true
            weakSelf.bottomPickerView.constant = 0.0
            weakSelf.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }

    func closePicker() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.bottomPickerView.constant = -255.0
            weakSelf.view.layoutIfNeeded()
        }, completion: { _ in
            self.tabBarController?.tabBar.isHidden = false
            self.view.layoutIfNeeded()
        })
    }
    
    private func getDate(_ day: Int, _ month: Int, _ year: Int) -> Date {
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day, .month, .year], from: Date())
        minDateComponent.day = day
        minDateComponent.month = month
        minDateComponent.year = year
        let minDate = calendar.date(from: minDateComponent)
        return minDate ?? Date()
    }
}

extension PicOfTheDayViewController {
    @IBAction func actionOnSelectDate(_ sender: UIBarButtonItem) {
        configureDatePicker()
    }
}

// MARK: UICollectionView Delegate

extension PicOfTheDayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = dataSource.itemIdentifier(for: indexPath), let detailViewController = storyboard?.instantiateViewController(identifier: DetailViewController.identifier, creator: { coder in
            DetailViewController(coder: coder, viewModel: viewModel)
        }) {
            show(detailViewController, sender: collectionView.cellForItem(at: indexPath))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("Unable to cast UICollectionViewLayout as UICollectionViewFlowLayout")
        }
        let itemHeight: CGFloat = 425.0
        let minimumItemWidth: CGFloat = 280.0
        let sectionInset = flowLayout.sectionInset
        let availableWidth = collectionView.bounds.size.width - sectionInset.left - sectionInset.right
        let maxNumberOfItemsPerRow = (availableWidth / minimumItemWidth).rounded(.down)
        let interItemspace = flowLayout.minimumInteritemSpacing * (maxNumberOfItemsPerRow - 1)
        let itemWidth = (availableWidth - interItemspace) / maxNumberOfItemsPerRow
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

// MARK: ScrollableViewController

extension PicOfTheDayViewController: ScrollableViewController {
    func scrollToTop() {
        self.collectionView.setContentOffset(CGPoint(x: 0, y: -120), animated: true)
    }
}
