-- Datenbank erstellen
CREATE DATABASE Buchhandlungssystem;
GO

-- Zur Datenbank wechseln
USE Buchhandlungssystem;
GO

-- Tabelle "Autoren" erstellen
CREATE TABLE Autoren (
    AutorID INT PRIMARY KEY IDENTITY(1,1),
    Vorname NVARCHAR(50) NOT NULL,
    Nachname NVARCHAR(50) NOT NULL,
    Geburtsdatum DATE
);

-- Tabelle "Verlage" erstellen
CREATE TABLE Verlage (
    VerlagID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Adresse NVARCHAR(200)
);

-- Tabelle "Bücher" erstellen
CREATE TABLE Buecher (
    BuchID INT PRIMARY KEY IDENTITY(1,1),
    ISBN NVARCHAR(20) UNIQUE NOT NULL,
    Titel NVARCHAR(200) NOT NULL,
    Erscheinungsjahr INT,
    Preis DECIMAL(10, 2),
    VerlagID INT FOREIGN KEY REFERENCES Verlage(VerlagID)
);

-- Tabelle "BuchAutoren" (für n:m-Beziehung zwischen Büchern und Autoren)
CREATE TABLE BuchAutoren (
    BuchID INT FOREIGN KEY REFERENCES Buecher(BuchID),
    AutorID INT FOREIGN KEY REFERENCES Autoren(AutorID),
    PRIMARY KEY (BuchID, AutorID) -- Zusammengesetzter Primärschlüssel
);

-- Tabelle "Kunden" erstellen
CREATE TABLE Kunden (
    KundenID INT PRIMARY KEY IDENTITY(1,1),
    Vorname NVARCHAR(50) NOT NULL,
    Nachname NVARCHAR(50) NOT NULL,
    Adresse NVARCHAR(200),
    Email NVARCHAR(100) UNIQUE
);

-- Tabelle "Bestellungen" erstellen
CREATE TABLE Bestellungen (
    BestellID INT PRIMARY KEY IDENTITY(1,1),
    KundenID INT FOREIGN KEY REFERENCES Kunden(KundenID),
    Bestelldatum DATETIME DEFAULT GETDATE()
);

-- Tabelle "Bestellpositionen" erstellen
CREATE TABLE Bestellpositionen (
    BestellPositionID INT PRIMARY KEY IDENTITY(1,1),
    BestellID INT FOREIGN KEY REFERENCES Bestellungen(BestellID),
    BuchID INT FOREIGN KEY REFERENCES Buecher(BuchID),
    Anzahl INT NOT NULL,
    PreisProStueck DECIMAL(10, 2) -- Preis zum Zeitpunkt der Bestellung
);

-- Beispielhafte Datensätze einfügen (optional)
INSERT INTO Verlage (Name) VALUES ('Penguin Books'), ('O’Reilly');
INSERT INTO Autoren (Vorname, Nachname) VALUES ('Stephen', 'King'), ('J.R.R.', 'Tolkien');
INSERT INTO Buecher (ISBN, Titel, Erscheinungsjahr, Preis, VerlagID) VALUES ('978-3-16-148410-0', 'Der Herr der Ringe', 1954, 29.99, 1);