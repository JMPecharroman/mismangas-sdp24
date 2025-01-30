//
//  MangaDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Datos de un manga obtenido de la API.
///
/// Representa la estructura de datos de un manga, incluyendo títulos, autores, géneros,
/// demografías y otros atributos relevantes.
struct MangaDTO: Codable {
    
    /// Identificador único del manga.
    let id: Int
    
    /// Título principal del manga.
    let title: String
    
    /// Título en inglés, si está disponible.
    let titleEnglish: String?
    
    /// Título en japonés, si está disponible.
    let titleJapanese: String?
    
    /// Información de contexto sobre el manga.
    let background: String?
    
    /// URL de la imagen principal del manga.
    let mainPicture: String?
    
    /// Número total de volúmenes publicados.
    let volumes: Int?
    
    /// Número total de capítulos publicados.
    let chapters: Int?
    
    /// Estado del manga (finalizado, etc.).
    let status: String
    
    /// Puntuación promedio del manga.
    let score: Double
    
    /// URL de la página oficial del manga.
    let url: String
    
    /// Sinopsis del manga.
    let sypnosis: String?
    
    /// Fecha de inicio de publicación.
    let startDate: String?
    
    /// Fecha de finalización de publicación, si aplica.
    let endDate: String?
    
    /// Lista de autores del manga.
    let authors: [AuthorDTO]
    
    /// Demografía a la que está dirigido el manga.
    let demographics: [DemographicDTO]
    
    /// Géneros a los que pertenece el manga.
    let genres: [GenreDTO]
    
    /// Temáticas abordadas en el manga.
    let themes: [ThemeDTO]
}

