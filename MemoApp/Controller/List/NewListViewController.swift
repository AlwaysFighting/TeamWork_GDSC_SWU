//
//  NewListViewController.swift
//  MemoApp
//
//  Created by nayeon  on 2022/11/17.
//

import UIKit

class NewListViewController: UIViewController {
    
    
    @IBAction func cancelNewNote(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
//    @IBAction func touchUpCancelNewNote (_sender : Any){
//        dismiss(animated: true, completion: nil)
//    }

    @IBOutlet weak var ListTextView: UITextView!
//    @IBOutlet weak var noteTextView: UITextView!
//
    @IBAction func saveNewNote(_ sender: Any) {
        guard let note = ListTextView.text, note.count > 0 else {
            return
    }
//    @IBAction func touchUpSaveNewNote (_ sender: Any) {
//        guard let note = ListTextView.text, note.count > 0 else {
//            return
//        }
        
//        let newNote = Note(content: note)
//        Note.dummyNoteList.append(newNote)
        DataManager.shared.addNewNote(note)
        
        
        NotificationCenter.default.post(name: NewListViewController.newNoteDidInsert, object: nil)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewListViewController {
    static let newNoteDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
}
