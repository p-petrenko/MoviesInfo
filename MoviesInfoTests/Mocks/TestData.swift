//
//  TestData.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation

struct TestData {
    static let searchMoviesResultJSON = """
{
   "page":1,
   "total_results":4,
   "total_pages":1,
   "results":[
      {
         "vote_count":16067,
         "id":118340,
         "video":false,
         "vote_average":7.9,
         "title":"Guardians of the Galaxy",
         "popularity":54.687,
         "poster_path":"/y31QB9kn3XSudA15tV7UWQ9XLuW.jpg",
         "original_language":"en",
         "original_title":"Guardians of the Galaxy",
         "genre_ids":[
            28,
            878,
            12
         ],
         "backdrop_path":"/bHarw8xrmQeqf3t8HpuMY7zoK4x.jpg",
         "adult":false,
         "overview":"Light years from Earth, 26 years after being abducted, Peter Quill finds himself the prime target of a manhunt after discovering an orb wanted by Ronan the Accuser.",
         "release_date":"2014-07-30"
      },
      {
         "vote_count":2,
         "id":509080,
         "video":false,
         "vote_average":8.3,
         "title":"LEGO Marvel Super Heroes - Guardians of the Galaxy: The Thanos Threat",
         "popularity":0.752,
         "poster_path":"/e5h1RlnQzjgEAh4s96k50S8XkKa.jpg",
         "original_language":"en",
         "original_title":"LEGO Marvel Super Heroes - Guardians of the Galaxy: The Thanos Threat",
         "genre_ids":[
            16,
            10751,
            878
         ],
         "backdrop_path":"/hkllv8JmO3UuRNKSiIfks5plhgi.jpg",
         "adult":false,
         "overview":"Lego Marvel Super Heroes - Guardians of the Galaxy: The Thanos Threat is a computer-animated Lego film based on Marvel Comics and starring the Guardians of the Galaxy.",
         "release_date":"2017-12-09"
      }
   ]
}
"""

}
