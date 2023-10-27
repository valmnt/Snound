//
//  SHManager.swift
//  Snound
//
//  Created by Valentin Mont on 26/10/2023.
//

import AVFAudio
import Foundation
import ShazamKit

class SHManager: NSObject {
    
    private var session: SHSession?
    private let audioEngine = AVAudioEngine()
    
    func startListening(delegate: SHSessionDelegate) throws {
        session = SHSession()
        
        session?.delegate = delegate
        
        let audioFormat = AVAudioFormat(
            standardFormatWithSampleRate:
                audioEngine.inputNode.outputFormat(forBus: 0).sampleRate,
            channels: 1)
        
        audioEngine.inputNode.installTap(
            onBus: 0,
            bufferSize: 2048,
            format: audioFormat
        ) { [weak session] buffer, audioTime in
            session?.matchStreamingBuffer(buffer, at: audioTime)
        }
        
        try AVAudioSession.sharedInstance().setCategory(.record)
        AVAudioSession.sharedInstance()
            .requestRecordPermission { [weak self] success in
                guard
                    success,
                    let self = self
                else { return }
                try? self.audioEngine.start()
            }
    }
    
    func stopListening() {
      audioEngine.stop()
      audioEngine.inputNode.removeTap(onBus: 0)
    }
}
