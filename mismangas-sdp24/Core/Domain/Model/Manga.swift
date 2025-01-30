//
//  Manga.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Representa un manga dentro de la aplicación.
struct Manga: Identifiable, Hashable, Sendable {
    
    /// Identificador único de la entidad dentro de la app.
    let entityId = UUID()
    
    /// Identificador del manga en la API.
    let id: Int
    
    /// Título del manga en su idioma original.
    let title: String
    
    /// Título del manga en inglés si está disponible.
    let titleEnglish: String?
    
    /// Título del manga en japonés si está disponible.
    let titleJapanese: String?
    
    /// Información de fondo sobre el manga.
    let background: String?
    
    /// URL de la imagen principal del manga.
    let mainPictute: URL?
    
    /// Número total de volúmenes publicados.
    let volumes: Int
    
    /// Número total de capítulos publicados.
    let chapters: Int
    
    /// Estado del manga (ej. finalizado, en publicación).
    let status: MangaStatus
    
    /// Fecha de inicio de publicación del manga.
    let startDate: Date?
    
    /// Fecha de finalización de la publicación del manga.
    let endDate: Date?
    
    /// Puntuación del manga basada en valoraciones de usuarios.
    let score: Double
    
    /// Sinopsis del manga.
    let synopsis: String?
    
    /// URL con más información sobre el manga.
    let url: URL?
    
    /// Autores del manga con sus respectivos roles.
    let authors: [Author]
    
    /// Categorías asociadas al manga, incluyendo géneros y demografías.
    let categories: [Category]
}
