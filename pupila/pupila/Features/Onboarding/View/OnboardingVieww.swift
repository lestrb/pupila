//
//  OnboardingVieww.swift
//  pupila
//
//  Created by Vyvian Freitas on 30/09/26.
//

import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @State private var viewModel = OnboardingViewModel()
    
    private let topYellow = Color(red: 255/255, green: 195/255, blue: 50/255)
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [topYellow, .white]),
                startPoint: .top,
                endPoint: UnitPoint(x: 0.5, y: 0.85)
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                TabView(selection: $viewModel.currentPage) {
                    ForEach(viewModel.pages) { page in
                        pageContentView(for: page)
                            .tag(page.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                actionSection
                
                dotsIndicator
            }
        }
        .alert("Atenção", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
    private var headerView: some View {
        HStack(spacing: 2) {
            Text("Pupila")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(.black)
            
            Text("*")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.red)
                .baselineOffset(6)
        }
        .padding(.top, 16)
    }
    
    private func pageContentView(for page: OnboardingItem) -> some View {
        VStack(spacing: 0) {
            Spacer(minLength: 16)
            
            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 260)
                .padding(.horizontal, 32)
            
            Spacer().frame(height: 32)
            
            VStack(spacing: 12) {
                Text(page.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.black.opacity(0.65))
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.horizontal, 36)
            }
            
            Spacer(minLength: 24)
        }
    }
    
    private var actionSection: some View {
        ZStack {
            if viewModel.isLastPage {
                SignInWithAppleButton(
                    .signIn,
                    onRequest: viewModel.handleAppleSignInRequest,
                    onCompletion: viewModel.handleAppleSignInCompletion
                )
                .signInWithAppleButtonStyle(.black)
                .clipShape(Capsule())
                .disabled(viewModel.isLoading)
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
        }
        .frame(height: 52)
        .padding(.horizontal, 32)
        .padding(.bottom, 16)
        .animation(.easeInOut(duration: 0.25), value: viewModel.isLastPage)
    }
    
    private var dotsIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<viewModel.pages.count, id: \.self) { index in
                Circle()
                    .fill(viewModel.currentPage == index ? Color.black : Color.black.opacity(0.2))
                    .frame(width: 6, height: 6)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: viewModel.currentPage)
        .padding(.bottom, 32)
    }
}

#Preview {
    OnboardingView()
}
