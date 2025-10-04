--C.VERİ SORGULAMA VE RAPORLAMA
-- Toplam sipariş sayısı
SELECT COUNT(*) AS ToplamSiparis
FROM Siparis;

--En çok sipariş veren 5 müşteri
SELECT TOP 5 m.id, m.ad, m.soyad, COUNT(s.id) AS siparis_sayisi
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
GROUP BY m.id, m.ad, m.soyad
ORDER BY siparis_sayisi DESC;

-- En çok satılan ürünler
SELECT u.ad, SUM(sd.adet) AS ToplamAdet
FROM Siparis_Detay sd
JOIN Urun u ON sd.urun_id = u.id
GROUP BY u.ad
ORDER BY ToplamAdet DESC;

--En yüksek cirosu olan satıcılar
SELECT TOP 5 s.id, s.ad, SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Satici s
JOIN Urun u ON s.id = u.satici_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY s.id, s.ad
ORDER BY toplam_ciro DESC;

--AGGREGATE & GROUP BY
--Şehirlere göre müşteri sayısı
SELECT sehir, COUNT(*) AS musteri_sayisi
FROM Musteri
GROUP BY sehir;

--Kategori bazlı toplam satışlar
SELECT k.ad AS kategori, SUM(sd.adet * sd.fiyat) AS toplam_satis
FROM Kategori k
JOIN Urun u ON k.id = u.kategori_id
JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.ad;

--Aylara göre sipariş sayısı 
SELECT YEAR(tarih) AS yil, MONTH(tarih) AS ay, COUNT(*) AS siparis_sayisi
FROM Siparis
GROUP BY YEAR(tarih), MONTH(tarih)
ORDER BY yil, ay;

--JOİNLER
--siparişlerde müşteri+ürün+satıcı bilgisi
SELECT s.id AS siparis_id, m.ad AS musteri_ad, m.soyad AS musteri_soyad,
       u.ad AS urun_ad, sd.adet, sd.fiyat, sat.ad AS satici_ad
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Satici sat ON u.satici_id = sat.id;

--Hiç Satılmamış ürünler
SELECT u.id, u.ad
FROM Urun u
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.id IS NULL;

--Hiç Sipariş Vermemiş müşteriler
SELECT m.id, m.ad, m.soyad
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
WHERE s.id IS NULL;

--Her müşterinin toplam sipariş tutarı 5000’den büyük olanlar
SELECT m.ad, m.soyad, SUM(s.toplam_tutar) AS ToplamTutar
FROM Siparis s
JOIN Musteri m ON s.musteri_id = m.id
GROUP BY m.ad, m.soyad
HAVING SUM(s.toplam_tutar) > 5000;

--D ileri seviye 
--En az bir kez elektronik ürün satın alan müşteriler
SELECT DISTINCT m.id, m.ad, m.soyad
FROM Musteri m
JOIN Siparis s ON m.id = s.musteri_id
JOIN Siparis_Detay sd ON s.id = sd.siparis_id
JOIN Urun u ON sd.urun_id = u.id
JOIN Kategori k ON u.kategori_id = k.id
WHERE k.ad = 'Elektronik';


