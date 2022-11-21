//
//  CheckListCoreDatabase+CoreDataProperties.swift
//  MemoApp
//
//  Created by 목정아 on 2022/11/19.
//
//

import Foundation
import CoreData


extension CheckListCoreDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckListCoreDatabase> {
        return NSFetchRequest<CheckListCoreDatabase>(entityName: "CheckListCoreDatabase")
    }

    @NSManaged public var checkListMemo: String?
    @NSManaged public var checkListColor: Int64
    @NSManaged public var isChecked: Bool
    @NSManaged public var whatSteps: Int64

}

extension CheckListCoreDatabase : Identifiable {

}
