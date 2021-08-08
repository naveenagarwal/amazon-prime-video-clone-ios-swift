//
//  VideoDetail.swift
//  AmazonPrimeVideo
//
//  Created by Naveen on 03/08/21.
//

import Foundation

struct VideoDetail : Decodable, Identifiable {
    let id: Int
    let name: String
    let posterURL: String
    let videoGenericDetails: VideoGenericDetails
    let watchedPercentage: Int
    let runningTimeInMinutes: Int
    let description: String
    let releaseYear: Int
    let IMDBRating: Double
    let availableAudioLanguages: [String]
    let availableSubtitleLangauges: [String]
    let UARating: String
    let cast: [MovieCastMember]
    
    static let example = try! JSONDecoder().decode(VideoDetail.self, from: exampleData.data(using: .utf8)!)
}

struct MovieCastMember: Decodable {
    let name: String
    let photoURL: String
    let about: String
    let trivia: String
    
    static let example = MovieCastMember(name: "Asrani Patel", photoURL: "http://localhost:3000/assets/images/actors/1.jpeg", about: "As far as I know, it is not possible to change the height of the navigation bar. Maybe with UIKit you could do some explicit frame manipulation, but generally I would advise against that because it might mess with the layout of your views. What i generally have found to be useful is removing the dark shadow line under the navigation bar via appearance and putting content below the navigation bar that has, for example, the same color as the navigation bar, thus creating a seamless transition from your navigation bar to the view below it", trivia: "Has a daughter named Veronica.")
}

struct VideoGenericDetails :Decodable {
    let genre: [String]
    let director: [String]
    let starring: [String]
    let supportingActors: [String]
    let studio: String
    let contentAdvisory: [String]
    let customerReview: Double
}

struct MoreDetailsType: Decodable {
    let title: String
    let value: [String]
}

let exampleData = """
{
  "id": 1,
  "thumbnailURL": "http://localhost:3000/assets/images/thumbnail/0.jpg",
  "posterURL": "http://localhost:3000/assets/images/poster/1.jpeg",
  "watchedPercentage": 25,
  "type": "movie",
  "name": "Gangs of Ghosts",
  "bucketName": "watchInProgress",
  "description": "As far as I know, it is not possible to change the height of the navigation bar. Maybe with UIKit you could do some explicit frame manipulation, but generally I would advise against that because it might mess with the layout of your views. What i generally have found to be useful is removing the dark shadow line under the navigation bar via appearance and putting content below the navigation bar that has, for example, the same color as the navigation bar, thus creating a seamless transition from your navigation bar to the view below it",
  "releaseYear": 2014,
  "IMDBRating": 2.4,
  "UARating": "13+",
  "runningTimeInMinutes": 138,
  "availableAudioLanguages": [
    "English",
    "Hindi"
  ],
  "availableSubtitleLangauges": [
    "English",
    "Hindi"
  ],
  "videoGenericDetails": {
    "genre": [
      "Comedy",
      "Horror"
    ],
    "director": [
      "Staish Kahushik"
    ],
    "starring": [
      "Meera Chopra",
      "Sharman Joshi",
      "Jackie Shroff"
    ],
    "supportingActors": [
      "Chunky Pandey",
      "Paoli Dam",
      "Aniruddh Dave",
      "Sonal Tanna"
    ],
    "studio": "Venus Worldwide Entertainment",
    "contentAdvisory": [
      "violence",
      "foul language",
      "drug use"
    ],
    "customerReview": 2.8
  },
  "cast": [
    {
      "name": "Mahie Gill",
      "photoURL": "http://localhost:3000/assets/images/actors/0.jpeg",
      "about": "As far as I know, it is not possible to change the height of the navigation bar. Maybe with UIKit you could do some explicit frame manipulation, but generally I would advise against that because it might mess with the layout of your views. What i generally have found to be useful is removing the dark shadow line under the navigation bar via appearance and putting content below the navigation bar that has, for example, the same color as the navigation bar, thus creating a seamless transition from your navigation bar to the view below it",
      "trivia": "Has a daughter named Veronica."
    },
    {
      "name": "Asrani Patel",
      "photoURL": "http://localhost:3000/assets/images/actors/1.jpeg",
      "about": "As far as I know, it is not possible to change the height of the navigation bar. Maybe with UIKit you could do some explicit frame manipulation, but generally I would advise against that because it might mess with the layout of your views. What i generally have found to be useful is removing the dark shadow line under the navigation bar via appearance and putting content below the navigation bar that has, for example, the same color as the navigation bar, thus creating a seamless transition from your navigation bar to the view below it",
      "trivia": "Has a daughter named Veronica."
    },
    {
      "name": "Lankesh Bhardwaj",
      "photoURL": "http://localhost:3000/assets/images/actors/default.jpeg",
      "about": "As far as I know, it is not possible to change the height of the navigation bar. Maybe with UIKit you could do some explicit frame manipulation, but generally I would advise against that because it might mess with the layout of your views. What i generally have found to be useful is removing the dark shadow line under the navigation bar via appearance and putting content below the navigation bar that has, for example, the same color as the navigation bar, thus creating a seamless transition from your navigation bar to the view below it",
      "trivia": "Has a daughter named Veronica."
    },
    {
      "name": "Mira Chopra",
      "photoURL": "http://localhost:3000/assets/images/actors/2.jpeg",
      "about": "As far as I know, it is not possible to change the height of the navigation bar. Maybe with UIKit you could do some explicit frame manipulation, but generally I would advise against that because it might mess with the layout of your views. What i generally have found to be useful is removing the dark shadow line under the navigation bar via appearance and putting content below the navigation bar that has, for example, the same color as the navigation bar, thus creating a seamless transition from your navigation bar to the view below it",
      "trivia": "Has a daughter named Veronica."
    },
    {
      "name": "Pauli Dham",
      "photoURL": "http://localhost:3000/assets/images/actors/3.jpeg",
      "about": "As far as I know, it is not possible to change the height of the navigation bar. Maybe with UIKit you could do some explicit frame manipulation, but generally I would advise against that because it might mess with the layout of your views. What i generally have found to be useful is removing the dark shadow line under the navigation bar via appearance and putting content below the navigation bar that has, for example, the same color as the navigation bar, thus creating a seamless transition from your navigation bar to the view below it",
      "trivia": "Has a daughter named Veronica."
    }
  ]
}
"""
