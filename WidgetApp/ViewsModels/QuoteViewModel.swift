//
//  QuoteViewModel.swift
//  WidgetApp
//
//  Created by Esteban SEMELLIER on 22/11/2023.
//

import SwiftUI

class QuoteViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var quote = Quote(quote: "", author: "")
    @Published var day = ""
    
    var quotes: [Quote] = []
    
    // MARK: - Init
    init() {
        quotes = load("Source.json")
        quote = displayQuote()
        day = displayDay()
        setupDailyQuoteUpdate()
        
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(dateDidChange),
                    name: .NSCalendarDayChanged,
                    object: nil
                )
    }
    
    @objc func dateDidChange(notification: NSNotification) {
            DispatchQueue.main.async {
                self.day = self.displayDay()
                self.quote = self.displayQuote()
            }
        }
    
    // MARK: - Functions
    private func setupDailyQuoteUpdate() {
            // Configurez le timer pour se déclencher à minuit
            let calendar = Calendar.current
            let nextMidnight = calendar.nextDate(after: Date(), matching: DateComponents(hour: 0), matchingPolicy: .nextTime)!
            let timeInterval = nextMidnight.timeIntervalSinceNow

            // Lancer un timer qui se déclenche à minuit et qui se répète tous les jours
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
                self?.day = self?.displayDay() ?? ""
                self?.quote = self?.displayQuote() ?? Quote(quote: "Erreur", author: "")
            }
        }
    
    func load(_ filename: String) -> [Quote] {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Quote].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([Quote].self):\n\(error)")
        }
    }
    
    func displayDay() -> String {
        let f = DateFormatter()
        let day = f.weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1]
        
        return day
    }
    
    func displayQuote() -> Quote {
       let day = displayDay()
        
        var displayQuote: Quote {
            switch day {
                case "Monday":
                    return quotes[0]
                case "Tuesday":
                    return quotes[1]
                case "Wednesday":
                    return quotes[2]
                case "Thursday":
                    return quotes[3]
                case "Friday":
                    return quotes[4]
                case "Saturday":
                    return quotes[5]
                case "Sunday":
                    return quotes[6]
                default:
                    return Quote(quote: "Erreur", author: "")
            }
        }
        
        return displayQuote
    }
    
    func quoteTextColor() -> Color {
        var color: Color = .black

        if quote.quote == quotes[0].quote {
            color = .black
        } else if quote.quote == quotes[1].quote {
            color = .black
        } else if quote.quote == quotes[2].quote {
            color = .white
        } else if quote.quote == quotes[3].quote {
            color = .pink
        } else if quote.quote == quotes[4].quote {
            color = .green
        } else if quote.quote == quotes[5].quote {
            color = .mint
        } else if quote.quote == quotes[6].quote {
            color = .teal
        }

        return color
    }
    
    func quoteBackgroundColor() -> Color {
        var color: Color = .black
        
        if quote.quote == quotes[0].quote {
            color = .purple
        } else if quote.quote == quotes[1].quote {
            color = .brown
        } else if quote.quote == quotes[2].quote {
            color = .indigo
        } else if quote.quote == quotes[3].quote {
            color = .pink
        } else if quote.quote == quotes[4].quote {
            color = .green
        } else if quote.quote == quotes[5].quote {
            color = .mint
        } else if quote.quote == quotes[6].quote {
            color = .teal
        }
        return color
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
