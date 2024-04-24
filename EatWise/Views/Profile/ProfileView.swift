//
//  ProfileView.swift
//  EatWise
//
//  Created by Thusal Athauda on 21/04/2024.
//

import SwiftUI
import Charts

struct ProfileView: View {
    @State private var showingAddWeightPopup = false
    @State private var inputWeight: String = ""
    @State private var inputDate = Date()
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Title()
                
                WeightGraph()
                //.frame(height: 250)
                
                Button(action: {
                    // This will show the popup when button is tapped
                    self.showingAddWeightPopup = true
                }) {
                    Text("Add Weight")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.primaryGreen)
                        .cornerRadius(10)
                }
                
                Section {
                    List {
                        NavigationLink(destination: AllergyView()) {
                            Text("Allergies")
                                .font(
                                    Font.custom("Nunito", size: 22)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.primaryGreen)
                        }
                        .padding(.top)
                        
                        NavigationLink(destination: DietView()) {
                            Text("Food Preference")
                                .font(
                                    Font.custom("Nunito", size: 22)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.primaryGreen)
                        }
                        .padding(.top)
                        
                        NavigationLink(destination: GoalView()) {
                            Text("Change Goal")
                                .font(
                                    Font.custom("Nunito", size: 22)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.primaryGreen)
                        }
                        .padding(.top)
                        
                        NavigationLink(destination: PersonalInfoView()) {
                            Text("Personal Information")
                                .font(
                                    Font.custom("Nunito", size: 22)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.primaryGreen)
                        }
                        .padding(.top)
                        
                        Button(action: {
                            userViewModel.signOut()
                        }, label: {
                            HStack{
                                Image(systemName: "arrow.left.circle.fill")
                                    .imageScale(.large)
                                    .foregroundStyle(Color.red)
                                
                                Text("Sign Out")
                                    .font(
                                        Font.custom("Nunito", size: 22)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color("TextColor"))
                                
                                Spacer()
                            }
                            .padding(.top)
                            
                        })
                    }
                    .padding([.top], 10)
                    .listStyle(.plain)
                    .foregroundStyle(.primaryGreen)
                }
            }
            .padding([.horizontal])
            .sheet(isPresented: $showingAddWeightPopup) {
                // This is the popup content
                AddWeightPopup(inputWeight: $inputWeight, inputDate: $inputDate, isAddingWeight: $showingAddWeightPopup)
            }
            
        }
        
    }
}

#Preview {
    ProfileView()
}

struct AddWeightPopup: View {
    @Binding var inputWeight: String
    @Binding var inputDate: Date
    @Binding var isAddingWeight: Bool
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Weight", text: $inputWeight)
                    .keyboardType(.decimalPad)
                
                DatePicker("Date", selection: $inputDate, in: ...Date(), displayedComponents: .date)
                
                Button("Save Weight") {
                    print(userViewModel.userModel?.weight ?? [])
                    // save the weight and date
                    if !inputWeight.isEmpty {
                        Task{
                            await userViewModel.updateUserWeight(newWeight: Weight(id: UUID().uuidString, weight: inputWeight, day: inputDate))
                        }
                        isAddingWeight = false
                    }
                }
            }
            .navigationBarTitle("Add Weight", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                // close the sheet
                isAddingWeight = false
            })
        }
        .accentColor(.primaryGreen)
    }
}
