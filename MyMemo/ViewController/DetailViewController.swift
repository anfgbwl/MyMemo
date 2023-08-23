//
//  ComposeViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {
    // memoManager에 접근하는 변수 생성
    var myMemo = MemoManager.shared
    
    // prepare로 받아올 메모
    var prepareMemo: Memo?
    var prepareMemoIndex: Int?
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var targetDatePicker: UIDatePicker!
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var progressValueLabel: UILabel!
    @IBOutlet weak var memoManagement: UIBarButtonItem!
    
    @IBAction func progressSlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
        let progressValue = sender.value
        prepareMemo?.progress = Int(progressValue)
        progressValueLabel.text = String(Int(progressValue))
    }
    
    @IBAction func save(_ sender: Any) {
        let content = memoTextView.text ?? ""
        let isCompleted = true
        let targetDate = targetDatePicker.date
        let priority = priorityButton.titleLabel?.text ?? "없음"
        let category = categoryButton.titleLabel?.text ?? "일반"
        let progress = Int(progressSlider.value)
        if let prepareMemoIndex = prepareMemoIndex {
            myMemo.updateMemo(at: prepareMemoIndex, newContent: content, isCompleted: isCompleted, insertDate: Date(), targetDate: targetDate, priority: priority, category: category, progress: progress)
        }
        
        // 수정 완료 알람
        let checkAlert = UIAlertController(title: "수정되었습니다.", message: "", preferredStyle: .alert)
        self.present(checkAlert, animated: false)
        dismiss(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func memoManagement(_ sender: Any) {
        let memoManagementAlert = UIAlertController(title: "", message: "해당 메모를 삭제합니다.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "메모 삭제", style: .default) { [self] (_) in
            self.myMemo.deleteMemo(at: prepareMemoIndex!)
            self.navigationController?.popViewController(animated: true)
        }
        delete.setValue(UIColor.red, forKey: "titleTextColor")
        memoManagementAlert.addAction(cancel)
        memoManagementAlert.addAction(delete)
        self.present(memoManagementAlert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 여기에 setTitle 적용하면 디테일페이지 버튼에 디폴트 값이 안뜸, 그리고 디폴트 값 선택해도 버튼에 안뜸(저장은 잘됨, 다시 로드해도 잘 뜸) -> 일단 저장된 데이터는 불러와야하니까 얘로 설정
//        priorityButton.setTitle(prepareMemo?.priority ?? "없음", for: .normal)
//        categoryButton.setTitle(prepareMemo?.category ?? "일반", for: .normal)
        
        // 우와 해결!!!!! 빈값도 nil이 아니라 값으로 인지하고 있어서 조건문으로 설정
        // 근데 문제는 선택된 항목에 체크가 안되고 디폴트에 되어 있음
        if prepareMemo?.priority == "", prepareMemo?.category == "" {
            priorityButton.setTitle("없음", for: .normal)
            categoryButton.setTitle("일반", for: .normal)
        } else {
            priorityButton.setTitle(prepareMemo?.priority, for: .normal)
            priorityButton.titleLabel?.text = prepareMemo?.priority
            categoryButton.setTitle(prepareMemo?.category, for: .normal)
            categoryButton.titleLabel?.text = prepareMemo?.category
        }
        
        // nil 이 아닐때만 표시(실패)
//        if let priority = prepareMemo?.priority, let category = prepareMemo?.category {
//            priorityButton.setTitle(priority, for: .normal)
//            categoryButton.setTitle(category, for: .normal)
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        memoTextView.isScrollEnabled = false
        memoTextView.text = prepareMemo?.content
        targetDatePicker.date = prepareMemo?.targetDate ?? Date()
        
        // 버튼 상태변경(데이터 저장은 되나 불러올 때 기본값으로만 불러와지는 문제 발생)
        
        // 1. setTitle 설정 (실패) -> priority != priorityButton
//        priorityButton.setTitle(prepareMemo?.priority, for: .normal)
//        categoryButton.setTitle(prepareMemo?.category, for: .normal)
        
        // 2. 옵셔널 바인딩 시도 (실패) -> priority != priorityButton
        //        if let priority = prepareMemo?.priority {
        //            priorityButton.setTitle(priority, for: .normal)
        //        }
        //        if let category = prepareMemo?.category {
        //            categoryButton.setTitle(category, for: .normal)
        //        }
        
        // 3. titleLabel.text 설정 (실패) -> priority == priorityButton, 시뮬레이터에는 적용안됨(타이틀 설정이 안됐는데, 타이틀 텍스트는 적용됨; 무슨일?)
//        priorityButton.titleLabel?.text = prepareMemo?.priority
//        categoryButton.titleLabel?.text = prepareMemo?.category
        
        progressSlider.value = Float(prepareMemo?.progress ?? 0)
        progressValueLabel.text = String(Int(progressSlider.value))
        progressValueLabel.textColor = .link
        setProgressSlider()
        setPriorityButton()
        setCategoryButton()
    }
    
    
    func setPriorityButton() {
        let seletedPriority = {(action: UIAction) in
//             여기서 지정해줘야 하나?(실패)
//            self.priorityButton.setTitle(action.title, for: .normal)
        }
        priorityButton.menu = UIMenu(children: [
            UIAction(title: "없음", handler: seletedPriority),
            UIAction(title: "낮음", handler: seletedPriority),
            UIAction(title: "중간", handler: seletedPriority),
            UIAction(title: "높음", attributes: .destructive, handler: seletedPriority)])
        priorityButton.showsMenuAsPrimaryAction = true
        priorityButton.changesSelectionAsPrimaryAction = true
    }
    
    func setCategoryButton() {
        let normal = UIAction(title: "일반", handler: { _ in print("일반") })
        let pet = UIAction(title: "반려동물", handler: { _ in print("반려동물") })
        let home = UIAction(title: "집", handler: { _ in print("집") })
        let work = UIAction(title: "과제", handler: { _ in print("과제") })
        let exercise = UIAction(title: "운동", handler: { _ in print("운동") })
        self.categoryButton.menu = UIMenu(title: "", children: [normal, pet, home, work, exercise])
        self.categoryButton.showsMenuAsPrimaryAction = true
        self.categoryButton.changesSelectionAsPrimaryAction = true
    }
    
    func setProgressSlider() {
        progressSlider.setThumbImage(UIImage(named: "sliderThumb1"), for: .normal)
    }
}

extension DetailViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach{ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
