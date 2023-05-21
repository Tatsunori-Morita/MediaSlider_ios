# MediaSlider_ios  
## Hi!
This repository is image and movie slider app.  
![RocketSim_Recording_iPhone_14_Pro_Max_2023-05-22_07 58 54](https://github.com/Tatsunori-Morita/MediaSlider_ios/assets/56668897/e01307b9-8db8-4c18-945d-0a7a6ec56e4f)  
## How to  
```swift
class ExampleViewController: UIViewController {
    private let sliderView = MediaSliderViewController()

    private var media: [Medium] = [
        Medium(name: "image1", type: .image),
        Medium(name: "movie1.mp4", type: .movie),
        Medium(name: "movie2.mp4", type: .movie),
        Medium(name: "image2", type: .image),
        Medium(name: "image3", type: .image),
        Medium(name: "movie3.mp4", type: .movie),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    private func initialize() {
        view.backgroundColor = .white

        sliderView.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.width / 2)
        sliderView.view.center = view.center
        view.addSubview(sliderView.view)

        sliderView.configure(media: media)
        sliderView.readyToPlay = { [weak self] in
            guard let self = self else { return }
            self.sliderView.play()
        }
    }
}
```
