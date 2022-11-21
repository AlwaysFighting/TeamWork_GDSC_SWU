import UIKit

class ChecklistCollectionDataManager {

    private var makeCollectionTextArray: [systemMaekCollectionViewData] = []

    func makeCollectionData(){
        makeCollectionTextArray = [
            systemMaekCollectionViewData(makeCollectionText: "등산 ⛰️"),
            systemMaekCollectionViewData(makeCollectionText: "운동"),
            systemMaekCollectionViewData(makeCollectionText: "요리 🍰"),
            systemMaekCollectionViewData(makeCollectionText: "책 읽기"),
            systemMaekCollectionViewData(makeCollectionText: "책 읽기"),
            systemMaekCollectionViewData(makeCollectionText: "책 읽기"),
            systemMaekCollectionViewData(makeCollectionText: "책 읽기"),
            systemMaekCollectionViewData(makeCollectionText: "책 읽기"),
            systemMaekCollectionViewData(makeCollectionText: "책 읽기"),
            systemMaekCollectionViewData(makeCollectionText: "+ 추가")
        ]
    }
    
    func getMakeCollectionData() -> [systemMaekCollectionViewData] {
        return makeCollectionTextArray
    }
    
}
