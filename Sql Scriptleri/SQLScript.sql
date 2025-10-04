--A. VERİ TABANI TASARIMI
CREATE DATABASE EticaretDB;
GO

USE EticaretDB;
GO
--Tablolar
--KATEGORİ TABLOSU
CREATE TABLE Kategori (
	id INT IDENTITY (1,1) PRIMARY KEY,
	ad NVARCHAR(50) NOT NULL
);
GO 
--MÜŞTERİ TABLOSU 
CREATE TABLE Musteri (
	id INT IDENTITY (1,1) PRIMARY KEY,
	ad NVARCHAR(50) NOT NULL,
	soyad NVARCHAR(50) NOT NULL,
	email NVARCHAR(100) NOT NULL UNIQUE,
	sehir NVARCHAR(50),
	kayit_tarihi DATE DEFAULT GETDATE()
);
SELECT * FROM Musteri;
GO
GO
--SATICI TABLOSU
CREATE TABLE Satici (
	id INT IDENTITY(1,1) PRIMARY KEY,
	ad NVARCHAR(100) NOT NULL,
	adres NVARCHAR(200)
);
GO
--ÜRÜN TABLOSU
CREATE TABLE Urun (
	id INT IDENTITY(1,1) PRIMARY KEY,
	ad NVARCHAR(100) NOT NULL,
	fiyat DECIMAL(10,2) NOT NULL,
	stok INT DEFAULT 0,
	kategori_id INT,
	satici_id INT,
	FOREIGN KEY (kategori_id) REFERENCES Kategori(id),
	FOREIGN KEY (satici_id) REFERENCES Satici(id),
);
GO
--SİPARİŞ TABLOSU
CREATE TABLE Siparis (
	id INT IDENTITY(1,1) PRIMARY KEY,
	musteri_id INT,
	tarih DATE DEFAULT GETDATE(),
	toplam_tutar DECIMAL(10,2),
	odeme_turu NVARCHAR(50),
	FOREIGN KEY (musteri_id) REFERENCES Musteri(id)
);
SELECT * FROM Siparis;
GO
GO
--SİPARİŞ DETAY TABLOSU
CREATE TABLE Siparis_Detay (
	id INT IDENTITY(1,1) PRIMARY KEY,
	siparis_id INT,
	urun_id INT,
	adet INT DEFAULT 1,
	fiyat DECIMAL(10,2),
	FOREIGN KEY (siparis_id) REFERENCES Siparis(id),
	FOREIGN KEY (urun_id) REFERENCES Urun(id)
);
SELECT * FROM Siparis_Detay;
GO
GO
--B.VERİ EKLEME VE GÜNCELLEME
--KATEGORİ VERİLERİ
INSERT INTO Kategori (ad) VALUES ('Elektronik');
INSERT INTO Kategori (ad) VALUES ('Giyim');
INSERT INTO Kategori (ad) VALUES ('Ev & Yaşam');
INSERT INTO Kategori (ad) VALUES ('Kitap');
INSERT INTO Kategori (ad) VALUES ('Spor');
INSERT INTO Kategori (ad) VALUES ('Kozmetik');
INSERT INTO Kategori (ad) VALUES ('Oyuncak');

--MÜŞTERİ VERİLERİ
INSERT INTO Musteri (ad, soyad, email, sehir) VALUES
('Ahmet','Yılmaz','ahmetyilmaz@example.com','İstanbul'),
('Ayşe','Demir','aysedemir@example.com','Ankara'),
('Mehmet','Kara','mehmetkara@example.com','Izmir'),
('Elif','Şahin','elifsahin@example.com','Bursa'),
('Can','Aydın','canaydin@example.com','Antalya'),
('Deniz','Çelik','denizcelik@example.com','Mersin'),
('Selin','Koç','selinkoc@example.com','Samsun'),
('Aylin','Dursun','aylindursun@example.com','Kocaeli'),
('Elif', 'Kaya', 'elifkaya@example.com', 'İstanbul'),
('Mehmet', 'Demir', 'mehmetdemir@example.com', 'Ankara'),
('Zeynep', 'Çelik', 'zeynepcelik@example.com', 'Kocaeli'),
('Can', 'Arslan', 'canarslan@example.com', 'İzmir'),
('Ayşe', 'Öztürk', 'ayseozturk@example.com', 'Bursa'),
('Emre', 'Koç', 'emrekoc@example.com', 'Ankara'),
('Fatma', 'Şahin', 'fatmasahin@example.com', 'Kocaeli'),
('Murat', 'Erdoğan', 'muraterdogan@example.com', 'İstanbul'),
('Seda', 'Aydın', 'sedaaydin@example.com', 'İzmir');

SELECT * FROM Musteri;
GO

--SATICI VERİLERİ
INSERT INTO Satici (ad, adres) VALUES
('TeknoMarket','Istanbul, Kadıköy'),
('ModaShop','Ankara, Çankaya'),
('EvDekor','Izmir, Karşıyaka'),
('Kitapçı','Bursa, Nilüfer'),
('SporPlus','Antalya, Muratpaşa'),
('GiyimDünyası', 'İstanbul, Şişli'),
('ElektronikMerkez', 'Ankara, Kızılay'),
('MobilyaEvi', 'İzmir, Bornova'),
('HobiDükkanı', 'Bursa, Osmangazi'),
('KırtasiyeKale', 'Antalya, Kepez'),
('AyakkabıSarayı', 'İstanbul, Beşiktaş'),
('EvTekstili', 'Ankara, Yenimahalle'),
('MüzikDükkanı', 'İzmir, Alsancak'),
('OyunMerkezi', 'Bursa, Yıldırım'),
('BahçeMarket', 'Antalya, Konyaaltı');

--ÜRÜN VERİLERİ
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Laptop', 15000, 10, 1, 1),
('T-Shirt', 200, 50, 2, 2),
('Koltuk', 3000, 5, 3, 3),
('Roman Kitap', 80, 30, 4, 4),
('Basketbol Topu', 500, 20, 5, 5),
('Kulaklık', 800, 25, 1, 1),
('Sweatshirt', 350, 40, 2, 2),
('Telefon', 12000, 15, 1, 1),
('Pantolon', 250, 60, 2, 2),
('Masa', 2000, 8, 3, 3),
('Kırtasiye Seti', 150, 100, 4, 4),
('Tenis Raketi', 600, 12, 5, 5),
('Mouse', 300, 30, 1, 1),
('Ceket', 500, 35, 2, 2),
('Sandalye', 1500, 10, 3, 3),
('Çizgi Roman', 100, 20, 4, 4),
('Voleybol Topu', 400, 25, 5, 5),
('Peluş Ayı', 150, 40, 1, 6),
('Lego Seti', 500, 20, 2, 6),
('Oyuncak Araba', 80, 60, 3, 6),
('Bebek', 200, 30, 4, 6),
('Puzzle', 120, 50, 5, 6),
('Parfüm', 300, 25, 1, 7),
('Ruj', 90, 80, 2, 7),
('Yüz Kremi', 150, 35, 3, 7),
('Maskara', 120, 45, 4, 7),
('Oje', 50, 100, 5, 7);

--SİPARİŞ VE SİPARİŞ DETAYLARI
--SİPARİŞLER
INSERT INTO Siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES
(13, '2025-09-22', 15800, 'Kredi Kartı'),
(14, '2025-09-21', 550, 'Kapıda Ödeme'),
(15, '2025-09-20', 3050, 'Kredi Kartı'),
(16, '2025-10-03', 2000, 'Kapıda Ödeme'),
(17, '2025-10-03', 4500, 'Kredi Kartı'),
(18, '2025-10-04', 6200, 'Kapıda Ödeme'),
(19, '2025-10-04', 5000, 'Kapıda Ödeme'),
(20, '2025-10-03', 6500, 'Kredi Kartı'),
(21, '2025-10-05', 3200, 'Kapıda Ödeme');
GO

--SİPARİŞ DETAYLARI
INSERT INTO Siparis_Detay (siparis_id, urun_id, adet, fiyat) VALUES
(13, 1, 2, 500),  -- siparis_id = 13, urun_id = 1
(14, 2, 1, 300),  -- siparis_id = 14, urun_id = 2
(15, 1, 3, 150),  -- siparis_id = 15, urun_id = 1
(16, 3, 1, 2000), -- siparis_id = 16, urun_id = 3
(17, 2, 2, 2250), -- siparis_id = 17, urun_id = 2
(18, 1, 4, 6200), -- siparis_id = 18, urun_id = 1
(19, 3, 1, 5000), -- siparis_id = 19, urun_id = 3
(20, 2, 1, 6500), -- siparis_id = 20, urun_id = 2
(21, 1, 2, 3200); -- siparis_id = 21, urun_id = 1
(13, 28, 2, 500),  -- siparis_id = 13, urun_id = 1
(14, 29, 1, 300),  -- siparis_id = 14, urun_id = 2
(15, 30, 3, 150),  -- siparis_id = 15, urun_id = 1
(16, 31, 1, 2000), -- siparis_id = 16, urun_id = 3
(17, 32, 2, 2250), -- siparis_id = 17, urun_id = 2
(18, 33, 4, 6200), -- siparis_id = 18, urun_id = 1
(19, 34, 1, 5000), -- siparis_id = 19, urun_id = 3
(20, 35, 1, 6500), -- siparis_id = 20, urun_id = 2
(21, 36, 2, 3200); -- siparis_id = 21, urun_id = 1
GO
SELECT * FROM Siparis_Detay;
GO

--TEKRAR EDEN ÜRÜNLERİ BULUP SİLME
SELECT ad, COUNT(*) as tekrar_sayisi
FROM Urun
GROUP BY ad
HAVING COUNT(*) > 1;
GO
-- Siparis_Detay’daki tekrar eden ürünleri doğru id’ye yönlendir
WITH CTE AS (
    SELECT ad, MIN(id) AS keep_id
    FROM Urun
    GROUP BY ad
)
UPDATE sd
SET urun_id = cte.keep_id
FROM Siparis_Detay sd
JOIN Urun u ON sd.urun_id = u.id
JOIN CTE ON u.ad = cte.ad;
GO
-- Urun tablosunda tekrar edenleri sil
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY ad ORDER BY id) AS rn
    FROM Urun
)
DELETE FROM CTE
WHERE rn > 1;
GO

--stok güncelleme örneği
UPDATE Urun
SET stok = stok - 1
WHERE id = 1;
--birden fazla
UPDATE Urun
SET stok = stok - 2
WHERE id = 2; -- T-Shirt 2 adet satıldı
--stok mik. sıfırın altına düşürmemek için kontrol
UPDATE Urun
SET stok = CASE 
              WHEN stok >= 2 THEN stok - 2
              ELSE 0
           END
WHERE id = 1;

-- Tüm sipariş detaylarını temizle
TRUNCATE TABLE Siparis_Detay;


