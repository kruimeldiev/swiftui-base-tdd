//
//  HomeViewModelTests.swift
//  ios_base_testingTests
//
//  Created by Casper on 22/05/2023.
//

@testable import ios_base_testing
import XCTest
import Factory

final class HomeViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Container.shared.setupMocks()
    }

    func test_addItemToList_WithValidName_DisplaysItem() async {
        // Given
        let sut = HomeViewModel()
        // When
        sut.newItemName = ItemModelStubs.ItemModel.stubToDoItem.title
        let amountOfItems = sut.items.count
        await sut.addNewItem()
        // Then
        XCTAssertEqual(sut.errorMessage, "")
        XCTAssertEqual(amountOfItems + 1, sut.items.count)
    }
    
    func test_addItemToList_WithInvalidName_ReturnsError() async {
        // Given
        let sut = HomeViewModel()
        // When
        let amountOfItems = sut.items.count
        await sut.addNewItem()
        // Then
        XCTAssertEqual(sut.errorMessage, ToDoListError.invalidTitle.description)
        XCTAssertEqual(amountOfItems, sut.items.count)
    }
    
    func test_checkOffItem_CheckOffListItem_ItemIsCheckedOff() async {
        // Given
        let sut = HomeViewModel()
        XCTAssertFalse(sut.items.first!.isCompleted)
        // When
        await sut.checkOffItem(sut.items.first!)
        // Then
        XCTAssertTrue(sut.items.first!.isCompleted)
    }
    
    func test_itemNameChanged_ChangesItemName_NewItemNameIsDisplayed() async {
        // Given
        let sut = HomeViewModel()
        // When
        sut.updateItemTitle = "Changed item title"
        XCTAssertEqual(sut.items[0].title, "Lorem ipsum")
        await sut.changeItem(sut.items[0])
        // Then
        XCTAssertEqual(sut.items[0].title, "Changed item title")
    }
    
    func test_addLabelToItem_AddsNewLabelToItem_NewLabelIsDisplayed() async {
        // Given
        let sut = HomeViewModel()
        XCTAssertEqual(sut.items[0].tag, "Monday")
        // When
        sut.updateItemTag = "Changed item tag"
        await sut.changeItem(sut.items[0])
        // Then
        XCTAssertEqual(sut.items[0].tag, "Changed item tag")
    }
    
    func test_removeLabelFromItem_RemovesLabelFromItem_RemovesLabel() async {
        // Given
        let sut = HomeViewModel()
        XCTAssertEqual(sut.items[2].tag, "Sunday")
        // When
        sut.updateItemTag = ""
        await sut.changeItem(sut.items[2])
        // Then
        XCTAssertNil(sut.items[2].tag)
    }
    
    func test_deleteItem_RemovesItemFromList_ItemIsRemoved() async {
        // Given
        let sut = HomeViewModel()
        XCTAssertEqual(sut.items.count, 5)
        // When
        await sut.deleteItem(sut.items[1].id)
        // Then
        XCTAssertEqual(sut.errorMessage, "")
        XCTAssertEqual(sut.items.count, 4)
    }
}
