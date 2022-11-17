import UIKit

// 설정화면에 들어갈 Cell의 정보
let settingName = [
    "다크모드 설정",
    "Face ID 및 암호",
    "폰트 스타일 설정",
    "폰트 크기 설정"
]

// Cell 의 Text 와 Image 설정하기
struct Setting {
    var settingText : String
    var settingImage : UIImage?
}
