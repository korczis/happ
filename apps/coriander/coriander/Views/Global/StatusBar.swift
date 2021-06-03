//
//  StatusBar.swift
//  coriander
//
//  Created by Tomas Korcak on 22.05.2021.
//

import Foundation
import ReSwift
import SwiftUI

//extension UIBezierPath {
//    /// The Unwrap logo as a Bezier path.
//    static var logo: UIBezierPath {
////        let path = UIBezierPath()
////
////        path.move(to: CGPoint(x: 0.534, y: 0.5816))
////        path.addCurve(to: CGPoint(x: 0.1877, y: 0.088), controlPoint1: CGPoint(x: 0.534, y: 0.5816), controlPoint2: CGPoint(x: 0.2529, y: 0.4205))
////        path.addCurve(to: CGPoint(x: 0.9728, y: 0.8259), controlPoint1: CGPoint(x: 0.4922, y: 0.4949), controlPoint2: CGPoint(x: 1.0968, y: 0.4148))
////        path.addCurve(to: CGPoint(x: 0.0397, y: 0.5431), controlPoint1: CGPoint(x: 0.7118, y: 0.5248), controlPoint2: CGPoint(x: 0.3329, y: 0.7442))
////        path.addCurve(to: CGPoint(x: 0.6211, y: 0.0279), controlPoint1: CGPoint(x: 0.508, y: 1.1956), controlPoint2: CGPoint(x: 1.3042, y: 0.5345))
////        path.addCurve(to: CGPoint(x: 0.6904, y: 0.3615), controlPoint1: CGPoint(x: 0.7282, y: 0.2481), controlPoint2: CGPoint(x: 0.6904, y: 0.3615))
////
////        return path
//
//        return UIBezierPath(
//            ovalIn: CGRect()
//        )
//    }
//}
//
//struct ScaledBezier: Shape {
//    let bezierPath: UIBezierPath
//
//    func path(in rect: CGRect) -> Path {
//        let path = Path(bezierPath.cgPath)
//
//        // Figure out how much bigger we need to make our path in order for it to fill the available space without clipping.
//        let multiplier = min(rect.width, rect.height)
//
//        // Create an affine transform that uses the multiplier for both dimensions equally.
//        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)
//
//        // Apply that scale and send back the result.
//        return path.applying(transform)
//    }
//}


final class StatusBarButton<T: UIButton>: UIViewRepresentable {
    typealias ButtonCallback = (T) -> Void
    
    private var button: T
    internal var action: ButtonCallback?
    
    init(button: T, action: ButtonCallback?) {
        self.button = button
        self.action = action
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<StatusBarButton>) -> T {
        
        // button.setTitle(buttonText, for: .normal)
        button.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.buttonPressed(_:)),
            for: .touchUpInside
        )
        
        return button
    }
    
    func updateUIView(_ uiView: T, context: UIViewRepresentableContext<StatusBarButton>) {
        // uiView.setTitle(buttonText, for: .normal)
    }
}

extension StatusBarButton {
    final class Coordinator: NSObject {
        var parent: StatusBarButton
        
        init(_ parent: StatusBarButton) {
            self.parent = parent
        }
        
        @objc func buttonPressed(_ sender: AnyObject) {
            if let action = parent.action {
                action(parent.button)
            }
        }
    }
}

struct StatusBarView: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var state: ObservableState<AppState>
    
    var body: some View {
        VStack() {
            HStack {
                VStack {
                    let lastLocation = state.current.location.lastLocation
                    let lastCoordinate = lastLocation.coordinate
                    
                    Text(String(format: "Lat: %.4f", lastCoordinate.latitude))
                        .frame(alignment: .leading)
                    Text(String(format: "Lng: %.4f", lastCoordinate.longitude))
                        .frame(alignment: .leading)
                    Text(String(format: "Alt: %.2f", lastLocation.altitude))
                        .frame(alignment: .leading)
                }
                
                Spacer()
                
                let button = LocationRecordingButton(buttonSize: 40, isRecording: state.current.location.isRecording)
                
                StatusBarButton<LocationRecordingButton>(button: button, action: { sender in
                    // TODO: Duplicate of implementation in MapViewCoordinator
                    
                    let isRecording = state.current.location.isRecording;
                    
                    switch isRecording {
                    case true:
                        state.dispatch(LocationRecordingStopAction())
                        state.dispatch(JourneyActiveSetAction(journey: nil))
                        
                        if let journey = state.current.journey.active {
                            journey.finishedAt = Date()
                            
                            DispatchQueue.main.async {
                                do {
                                    try moc.save()
                                    print("Journey - finished")
                                    
                                } catch let error {
                                    print("Journey - unable to finish, reason: \(error)")
                                }
                            }
                        }
                        break
                        
                    case false:
                        let journey = Journey(context: moc)
                        journey.startedAt = Date()
                        journey.name = Journey.DefaultName
                        journey.desc = Journey.DefaultDesc
                        
                        state.current.user.current?.addToJourneys(journey)
                        
                        DispatchQueue.main.async {
                            do {
                                try moc.save()
                                print("Journey - started")
                                
                            } catch let error {
                                print("Journey - unable to start, reason: \(error)")
                            }
                        }
                        
                        state.dispatch(JourneyActiveSetAction(journey: journey))
                        state.dispatch(LocationRecordingStartAction())
                        break
                    }
                    
                    button.updateShape(isRecording: !isRecording)
                })
                .frame(
                    width: 40,
                    height: 40,
                    alignment: Alignment.trailing
                )
            }
            
            
        }
        .padding(.leading, 10)
        .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .frame(maxWidth: .infinity)
        .background(Color.gray)
    }
}

struct StatusBarView_Previews: PreviewProvider {
    static let previewStore = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    static var previews: some View {
        let state = ObservableState(store: previewStore)
        StatusBarView(state: state)
    }
}

