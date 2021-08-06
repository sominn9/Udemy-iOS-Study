//
//  StoryBrain.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct StoryBrain {

    // storyNumber는 1에서 시작한다
    var storyNumber: Int = 1
    var storyHeight: Int = 1
    
    var endingIndex: Int = 0
    
    let stories = [
        Story(
            title: "내가 계획한 이번 여름휴가는?",
            choice1: "혼자 보내고 싶어",
            choice2: "같이 보내야 재밌지"
        ),
        Story(
            title: "휴가를 위한 나의 예산 규모는?",
            choice1: "플렉스 & 욜로",
            choice2: "가성비 & 절제미"
        ),
        Story(
            title: "뜨거운 여름에 밖/안?",
            choice1: "햇빛이 너무 뜨거워서 안에서 놀고 싶어",
            choice2: "여름이니까 당연히 밖에서 놀아야지"
        ),
    ]
    
    var endings = [
        Ending(title: "호캉스 욜로 라이프", subtitle: "나 홀로 호캉스로 안전하게 즐기자", content: "빌딩 숲 스위트룸에서 호캉스를 즐기며 룸서비스로 시킨 스테이크 칼질 쓱! 개츠비 감성으로 샴페인 따 먹는 여유", imageName: "호캉스엔딩"),
        Ending(title: "자연과 힐링 트립", subtitle: "일상 속의 소소함으로 힐링", content: "캠핑, 차박, 숲속의 집 or 한강에서치맥(노숙도 ok) 무주택자라 밖에서 노는 거 아님 주의!", imageName: "캠핑엔딩"),
        Ending(title: "왁자지껄 홈파티", subtitle: "여러명이서 재밌게 놀아보자~", content: "맛슐랭식당에 출장뷔페 예약하고 8명이 모여서 홈 파티 가자~! 음식 바닥날 때까지 집에 안 보내줌.", imageName: "홈파티엔딩"),
        Ending(title: "전국 맛집 투어", subtitle: "방방곡곡 누비며 스케일 크게 먹자", content: "수영장 딸린 해안가 호텔에서 조식 뷔페 먹고 지역 맛지도 격파하면서 후식이랑 카페 투어까지 도장 깨기!", imageName: "맛집투어엔딩")
    ]
    
    // 다음에 보여줄 스토리가 있으면 true, 없으면 false 반환
    mutating func nextStory(userChoice: String) -> Bool {
        let nextStoryNumber: Int
        
        if userChoice == "choice1" {
            nextStoryNumber = storyNumber * 2
        } else {
            nextStoryNumber = storyNumber * 2 + 1
        }
        
        if nextStoryNumber <= stories.count {
            storyNumber = nextStoryNumber
            storyHeight += 1
            return true
        } else {
            endingIndex = nextStoryNumber % Int((pow(2.0, Double(storyHeight))))
            return false
        }
    }
    
    // MARK: - Methods to show the story
    func getTitle() -> String {
        return stories[storyNumber - 1].title
    }
    
    func getChoices() -> [String] {
        return [stories[storyNumber - 1].choice1, stories[storyNumber - 1].choice2]
    }
    
    // MARK: - Methods to show the ending
    func getEndingTitle() -> String {
        return endings[endingIndex].title
    }
    
    func getEndingSubtitle() -> String {
        return endings[endingIndex].subtitle
    }
    
    func getEndingContent() -> String {
        return endings[endingIndex].content
    }
    
    func getEndingImageName() -> String {
        return endings[endingIndex].imageName
    }
}

var storyBrain = StoryBrain()
