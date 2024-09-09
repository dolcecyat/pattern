//
//  PaternData.swift
//  taskwithUIView
//
//  Created by Анатолий Коробских on 09.09.2024.


import Foundation

struct PatternData{
    
    let patternData: [PatternsModel] = [
        PatternsModel(patternImage: "abstract-factory",patternName: "Абстрактная фабрика",patternDescription: "это порождающий паттерн проектирования, который позволяет создавать семейства связанных объектов, не привязываясь к конкретным классам создаваемых объектов.",category: .Порождающие, isFavorite: false, numberOfViews: 0),
        PatternsModel(patternImage: "adapter", patternName: "Адаптер", patternDescription: "это структурный паттерн проектирования, который позволяет объектам с несовместимыми интерфейсами работать вместе.", category: .Структурные, isFavorite: false, numberOfViews: 0),
        PatternsModel(patternImage: "bridge", patternName: "Мост", patternDescription: "это структурный паттерн проектирования, который разделяет один или несколько классов на две отдельные иерархии — абстракцию и реализацию, позволяя изменять их независимо друг от друга.", category: .Структурные, isFavorite: false, numberOfViews: 0),
        PatternsModel(patternImage: "builder", patternName: "Строитель", patternDescription: "это порождающий паттерн проектирования, который позволяет создавать сложные объекты пошагово. Строитель даёт возможность использовать один и тот же код строительства для получения разных представлений объектов.", category: .Порождающие, isFavorite: false, numberOfViews: 0)]
}
