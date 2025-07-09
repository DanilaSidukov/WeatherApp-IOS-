import UIKit
import SwiftUI

final class DayTimeCurveView: UIView {
    
    private var dayTimeCurve: DayTimeCurve!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.dayTimeCurve = DayTimeCurve(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: frame.width, height: 20)
            )
        )
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dayTimeCurve = DayTimeCurve(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: frame.width, height: 20)
            )
        )
        setupView()
        setupConstraints()
    }
    
    private let sunriseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sunriseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .supportText
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        label.text = stringRes("sunrise")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sunriseValue: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.text = "7:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sunsetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sunsetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .supportText
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        label.text = stringRes("sunset")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sunsetValue: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.text = "19:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        dayTimeCurve.translatesAutoresizingMaskIntoConstraints = false
        dayTimeCurve.backgroundColor = .clear
        sunriseStackView.addArrangedSubview(sunriseValue)
        sunriseStackView.addArrangedSubview(sunriseLabel)
        sunsetStackView.addArrangedSubview(sunsetValue)
        sunsetStackView.addArrangedSubview(sunsetLabel)
        addSubview(dayTimeCurve)
        addSubview(sunsetStackView)
        addSubview(sunriseStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayTimeCurve.widthAnchor.constraint(equalToConstant: self.frame.width),
            dayTimeCurve.heightAnchor.constraint(equalToConstant: 20),
            dayTimeCurve.topAnchor.constraint(equalTo: topAnchor),
            dayTimeCurve.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            dayTimeCurve.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            sunriseStackView.topAnchor.constraint(equalTo: dayTimeCurve.bottomAnchor, constant: 4),
            sunriseStackView.leftAnchor.constraint(equalTo: leftAnchor),
            
            sunsetStackView.topAnchor.constraint(equalTo: dayTimeCurve.bottomAnchor, constant: 4),
            sunsetStackView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    private func setupCurve() {
        
    }
}

private final class DayTimeCurve: UIView {
    final let strokeWidth: CGFloat = 2
    
    var fillPart: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height),
            controlPoint1: CGPoint(x: 0, y: 0),
            controlPoint2: CGPoint(x: rect.width, y: 0)
        )
        
        path.lineWidth = strokeWidth
        path.lineCapStyle = .round
        
        let fillX = rect.width * fillPart
        
        context.saveGState()
        context.clip(to: CGRect(x: 0, y: 0, width: fillX, height: rect.height))
        UIColor.progressForeground.setStroke()
        path.stroke()
        context.restoreGState()
        
        context.saveGState()
        context.clip(to: CGRect(x: fillX, y: 0, width: rect.width - fillX, height: rect.height))
        UIColor.progressBackground.setStroke()
        path.stroke()
        context.restoreGState()
    }
}

struct DayTimeCurveViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> DayTimeCurveView {
        let view = DayTimeCurveView()
        return view
    }
    
    func updateUIView(_ uiView: DayTimeCurveView, context: Context) {

    }
}

#Preview {
    return ZStack {
        Color.container
        DayTimeCurveViewPreview()
            .padding(20)
            .frame(width: 410, height: 70, alignment: .center)
    }
    .fixedSize()
}
