//
//  SpeechSynthesizer.swift
//  PODO
//
//  Created by Yun on 2023/03/13.
//

import Foundation
import AVFoundation

protocol SpeechSynthesizerDelegate: AnyObject {

    func speechSynthesizerDidStart(synthesizer: SpeechSynthesizer)
    func speechSynthesizerDidFinish(synthesizer: SpeechSynthesizer)
    func speechSynthesizerDidContinue(synthesizer: SpeechSynthesizer)
    func speechSynthesizerDidPause(synthesizer: SpeechSynthesizer)
    func speechSynthesizerDidCancel(synthesizer: SpeechSynthesizer)
}

class SpeechSynthesizer: NSObject {

    weak var delegate: SpeechSynthesizerDelegate?

    var isPaused: Bool {
        self.synthesizer.isPaused
    }

    var isSpeaking: Bool {
        self.synthesizer.isSpeaking
    }

    override init() {
        super.init()
        self.synthesizer.delegate = self
    }

    func start(script: String) {
        let utterance = self.makeSpeechUtterance(script: script)
        self.synthesizer.speak(utterance)
    }

    func stop() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }

    func pause() {
        self.synthesizer.pauseSpeaking(at: .word)
    }

    func resume() {
        self.synthesizer.continueSpeaking()
    }

    private func makeSpeechUtterance(script: String, language: String = "en") -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: script)

        // 체크
        // let voice = AVSpeechSynthesisVoice(identifier: "Alex") // Samantha
        let voice = AVSpeechSynthesisVoice(language: language)
        utterance.voice = voice
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.1
        utterance.preUtteranceDelay = 0.1
        utterance.volume = 1.0

        return utterance
    }

    private let synthesizer = AVSpeechSynthesizer()
}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart: AVSpeechUtterance) {
        self.delegate?.speechSynthesizerDidStart(synthesizer: self)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.delegate?.speechSynthesizerDidFinish(synthesizer: self)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        self.delegate?.speechSynthesizerDidContinue(synthesizer: self)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        self.delegate?.speechSynthesizerDidPause(synthesizer: self)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        self.delegate?.speechSynthesizerDidCancel(synthesizer: self)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
    }
}

