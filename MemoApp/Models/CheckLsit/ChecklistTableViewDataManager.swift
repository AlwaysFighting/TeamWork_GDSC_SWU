import UIKit

class ChecklistTableViewDataManager {
    
    private var makeTableOneViewTextArray: [systemMakeTableStepOneViewData] = []
    private var makeTableTwoViewTextArray: [systemMakeTableStepTwoViewData] = []
    private var makeTableThreeViewTextArray: [systemMakeTableStepThreeViewData] = []
    
    
    func makeTableData() {
        
        makeTableOneViewTextArray = [
            systemMakeTableStepOneViewData(stepOneList: "유산소 운동 1시간"),
            systemMakeTableStepOneViewData(stepOneList: "물 한 잔")
        ]
        
        makeTableTwoViewTextArray = [
            systemMakeTableStepTwoViewData(stepTwoList: "20000보 달성"),
            systemMakeTableStepTwoViewData(stepTwoList: "필라테스 한 달 이용"),
            systemMakeTableStepTwoViewData(stepTwoList: "헬스장 PT 한 달 빡세게"),
        ]
        
        makeTableThreeViewTextArray = [
            systemMakeTableStepThreeViewData(stepThreeList: "체지방률 XX 달성!"),
            systemMakeTableStepThreeViewData(stepThreeList: "단백질 위주 식단 완성"),
        ]

    }
    
    func getMakeTableOneData() -> [systemMakeTableStepOneViewData] {
        return makeTableOneViewTextArray
    }
    
    func getMakeTableTwoData() -> [systemMakeTableStepTwoViewData] {
        return makeTableTwoViewTextArray
    }
    
    func getMakeTableThreeData() -> [systemMakeTableStepThreeViewData] {
        return makeTableThreeViewTextArray
    }
    
}
