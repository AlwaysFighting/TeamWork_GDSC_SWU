import UIKit

class ChecklistCollectionDataManager {

    private var makeCollectionTextArray: [systemMakeCollectionViewData] = []

    func makeCollectionData(){
        makeCollectionTextArray = [
            systemMakeCollectionViewData(makeCollectionText: "등산 ⛰️"),
            systemMakeCollectionViewData(makeCollectionText: "운동"),
            systemMakeCollectionViewData(makeCollectionText: "요리 🍰"),
            systemMakeCollectionViewData(makeCollectionText: "책 읽기"),
            systemMakeCollectionViewData(makeCollectionText: "책 읽기"),
            systemMakeCollectionViewData(makeCollectionText: "책 읽기"),
            systemMakeCollectionViewData(makeCollectionText: "책 읽기"),
            systemMakeCollectionViewData(makeCollectionText: "책 읽기"),
            systemMakeCollectionViewData(makeCollectionText: "책 읽기"),
            systemMakeCollectionViewData(makeCollectionText: "+ 추가")
        ]
    }
    
    func getMakeCollectionData() -> [systemMakeCollectionViewData] {
        return makeCollectionTextArray
    }
    
}
