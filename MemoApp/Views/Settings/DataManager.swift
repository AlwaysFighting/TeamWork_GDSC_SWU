import UIKit

// MARK: - settingDataArray


class SettingCellDataManger {
    private var settingDataArray: [Setting] = []

    func makeSettingData() {
        settingDataArray = [
            Setting(settingText: "다크모드 설정", settingImage: UIImage(systemName: "sun.max")),
            Setting(settingText: "Face ID 및 암호", settingImage: UIImage(systemName: "faceid")),
            Setting(settingText: "폰트 스타일 설정"),
            Setting(settingText: "폰트 크기 설정")
        ]
    }

    func getSettingData() -> [Setting] {
        return settingDataArray
    }
}

