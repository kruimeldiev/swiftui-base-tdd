//
//  HomeView.swift
//  ios_base_testing
//
//  Created by Casper on 22/05/2023.
//

import SwiftUI
import Factory

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    @State private var showingNewItemAlert = false
    @State private var showingItemNameChangeAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    HStack(spacing: 12) {
                        
                        ZStack {
                            Image(systemName: item.isCompleted ? "circle.fill" : "circle")
                                .foregroundColor(item.isCompleted ? .blue : .gray)
                                .onTapGesture {
                                    Task { await viewModel.checkOffItem(item) }
                                }
                                .imageScale(.large)
                            if item.isCompleted {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .imageScale(.small)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(item.title)")
                                .font(.headline)
                                .strikethrough(item.isCompleted)
                            if let tag = item.tag {
                                Text(tag)
                                    .font(.caption)
                                    .strikethrough(item.isCompleted)
                            }
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            showingItemNameChangeAlert.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.black)
                        }
                        .alert("Edit \(item.title)", isPresented: $showingItemNameChangeAlert) {
                            TextField("Item title", text: $viewModel.updateItemTitle)
                            TextField("Item tag", text: $viewModel.updateItemTag)
                            HStack {
                                Button("Ok") {
                                    Task { await viewModel.changeItem(item) }
                                }
                                Button("Delete") {
                                    Task { await viewModel.deleteItem(item.id) }
                                }
                            }
                        }
                    }
                    .buttonStyle(.borderless)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task { await viewModel.signOutUser() }
                    } label: {
                        Image(systemName: "person.fill.xmark")
                            .foregroundColor(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewItemAlert.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.green)
                    }
                    .alert("New item", isPresented: $showingNewItemAlert) {
                        TextField("Enter item title", text: $viewModel.newItemName)
                        Button("Ok") {
                            Task { await viewModel.addNewItem() }
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Container.shared.setupMocks()
        return HomeView(viewModel: .init())
    }
}
