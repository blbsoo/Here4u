import SwiftUI

struct LineGraph: Shape {
    var dataPoints: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        if dataPoints.count < 2 {
            return path
        }
        
        let maxValue = dataPoints.max() ?? 0
        let minValue = dataPoints.min() ?? 0
        let delta = maxValue - minValue
        
        let xInterval = rect.width / CGFloat(dataPoints.count - 1)
        
        var normalizedPoint = ((rect.height * (dataPoints[0] - minValue)) / delta)
        normalizedPoint = rect.height - normalizedPoint  // Flip the coordinate system
        path.move(to: CGPoint(x: 0, y: normalizedPoint))
        
        for i in 1..<dataPoints.count {
            let x = xInterval * CGFloat(i)
            normalizedPoint = ((rect.height * (dataPoints[i] - minValue)) / delta)
            normalizedPoint = rect.height - normalizedPoint  // Flip the coordinate system
            path.addLine(to: CGPoint(x: x, y: normalizedPoint))
        }
        
        return path
    }
}

struct EmotionalStateCard: View {
    var emotion: String
    var level: CGFloat
    var dataPoints: [CGFloat]
    var graphColor: Color
    
    var body: some View {
        VStack {
            Text("\(emotion)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("GentleGreen"))
                .padding(.bottom, 10)
            
            LineGraph(dataPoints: dataPoints)
                .stroke(graphColor, lineWidth: 2)
                .frame(height: 100)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                Text("Triggers")
                    .foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("GentleGreen"))
                    .frame(width: 280, height: 40)
                    .overlay(Text("Example: Stressful work").foregroundColor(.white))
            }
            .padding(.top, 10)
            
            VStack(alignment: .leading) {
                Text("Recommendations")
                    .foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("GentleGreen"))
                    .frame(width: 280, height: 40)
                    .overlay(Text("Example: Take short breaks").foregroundColor(.white))
            }
            .padding(.top, 10)
        }
        .frame(width: 300, height: 400)
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)  // This respects the cornerRadius
                .stroke(Color("GentleGreen"), lineWidth: 1)  // Your border color and width
        )
    }
}

struct MoodTrackingView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("PastelBlue"), Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Mood Tracking")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("GentleGreen"))
                
                ScrollView {
                    EmotionalStateCard(emotion: "Stress", level: 150, dataPoints: [100, 150, 200, 130, 170], graphColor: Color.red)
                    EmotionalStateCard(emotion: "Anxiety", level: 100, dataPoints: [100, 90, 120, 80, 95], graphColor: Color.yellow)
                    EmotionalStateCard(emotion: "Happiness", level: 200, dataPoints: [150, 170, 190, 180, 210], graphColor: Color.green)
                    EmotionalStateCard(emotion: "Excitement", level: 175, dataPoints: [160, 180, 190, 165, 175], graphColor: Color.blue)
                }
                .padding()
                .cornerRadius(25)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
