# VitaTrack 🏋️‍♀️

**Kilo & Sağlık Takip Uygulaması**

VitaTrack, kişisel sağlık hedeflerinize ulaşmanıza yardımcı olan kapsamlı bir mobil uygulamadır. Kilo takibi, beslenme kontrolü, su tüketimi ve daha fazlasını tek bir platformda sunar.

---
**Youtube linki:** https://youtu.be/J--hB7_tyao



## 🎯 Amaç ve Senaryo

### Bu uygulama kimin işine yarar?

VitaTrack, **sağlıklı yaşam hedeflerine ulaşmak isteyen herkes** için tasarlanmıştır:

1. **Kilo Vermek İsteyenler**
   - Günlük kalori alımını takip etmek isteyenler
   - Kilo değişimlerini grafik üzerinde görmek isteyenler
   - Beslenme alışkanlıklarını optimize etmek isteyenler

2. **Sporcular ve Fitness Meraklıları**
   - Makro besin değerlerini (protein, karbonhidrat, yağ) takip edenler
   - Kas kütlesi artışını veya yağ oranını izlemek isteyenler
   - Vücut ölçümlerini kaydetmek isteyenler

3. **Sağlıklı Yaşam Takipçileri**
   - Su tüketimini artırmak isteyenler
   - Aralıklı oruç (intermittent fasting) yapanlar
   - Günlük aktivite seviyesini kaydetmek isteyenler

4. **Kronik Hastalık Hastaları**
   - Doktor tavsiyesi ile kilo kontrolü gereken diyabet hastaları
   - Kalp sağlığı için beslenme takibi yapanlar
   - Düzenli rapor almak isteyenler

5. **Hamile ve Emziren Anneler**
   - Sağlıklı kilo alımını takip etmek isteyenler
   - Beslenme alışkanlıklarını optimize etmek isteyenler

---

## ❓ Hangi Problemleri Çözer?

### 1. **Kalori ve Beslenme Takibi Zorluğu**
**Problem:** Manuel kalori hesaplama zor ve hata yapılabilir.  
**Çözüm:** 
- OpenFoodFacts ve USDA API entegrasyonu ile barkod okutarak otomatik besin değeri alma
- Özel yemekler oluşturabilme

### 2. **Motivasyon Kaybı**
**Problem:** İlerlemeyi takip edememek motivasyonu düşürür.  
**Çözüm:**
- Grafiklerle kilo değişim trendleri
- Haftalık/aylık raporlar
- İlerleme fotoğrafları ile görsel karşılaştırma
- Analytics ile detaylı analiz

### 3. **Veri Kaybı Korkusu**
**Problem:** Uygulama silindi veya telefon değişti, tüm veriler gitti.  
**Çözüm:**
- Firebase Cloud Sync ile otomatik yedekleme
- Offline-first tasarım (internet olmadan çalışır)
- Demo mode ile internet olmadan kullanım

### 4. **Karmaşık Arayüz**
**Problem:** Çok fazla özellik, kullanımı zorlaştırır.  
**Çözüm:**
- Sade ve modern Material Design
- Quick actions ile hızlı erişim
- Shortcuts ile ana ekrandan direkt işlem
- Localization (Türkçe/İngilizce) desteği


---

## 📍 Nerede ve Nasıl Kullanılır?

### Kullanım Senaryoları

#### **Senaryo 1: Sabah Rutini**
```
07:00 → Uygulama açılır
07:05 → Su içildi, 250ml water log eklendi
07:30 → Kahvaltı yapıldı:
        - Barkod okut: Tam yağlı süt
        - Arama: "yumurta"
        - Manuel: Ekmek (100g)
08:00 → Tartıldı, kilo eklendi (75.2 kg)
```

#### **Senaryo 2: Öğle Yemeği**
```
12:30 → "Yemek Ekle" quick action
12:31 → "kek" arama → API 5 saniyede sonuç
12:32 → Porsiyon seçildi (120g)
12:33 → Makro değerler otomatik hesaplandı
        ✅ Kalori: 380 kcal
        ✅ Protein: 6g
        ✅ Karbonhidrat: 52g
```

#### **Senaryo 3: Akşam Değerlendirmesi**
```
21:00 → Dashboard kontrol
        - Günlük kalori: 1850/2000 kcal ✅
        - Su: 2.5/3 litre ⚠️
        - Protein: 95g ✅
21:05 → Reports → Haftalık grafik
        - 7 günde -0.8kg 📉
        - Ortalama kalori: 1920 kcal
21:10 → Fotoğraf eklendi (progress foto)
```



### Kullanım Yerleri

| Yer | Kullanım | Internet Gerekli mi? |
|-----|----------|---------------------|
| **Ev** | Sabah kilçsu log | Demo mode: ❌ |
| **Market** | Barkod okutma | internet: ✅ |
| **Restoran** | Yemek arama | API için: ✅ |
| **Spor Salonu** | Aktivite log | ❌ |
| **Seyahat** | Offline kullanım | Demo mode: ❌ |

---

## ✨ Özellikler

### 🍽️ Beslenme Takibi
- **Otomatik Besin Değerleri**: OpenFoodFacts & USDA API
- **Barkod Okuma**: Premium özellik
- **Öğün Kategorileri**: Kahvaltı, öğle, akşam, aperatifler
- **Makro Takibi**: Kalori, protein, karbonhidrat, yağ

### 💧 Su Takibi
- **Çeşitli İçecekler**: Su, çay, kahve, süt, meyve suyu vb.
- **Hidratasyon Katsayısı**: Her içeceğin farklı etki oranı
- **Hızlı Ekleme**: Preset miktarlar (250ml, 500ml, 1L)
- **Günlük Hedef**: Özelleştirilebilir su hedefi

### 📊 Kilo & Ölçüm Takibi
- **Günlük Tartı**: Kilo kayıtları
- **Vücut Ölçümleri**: Bel, göğüs, kalça, kol, bacak
- **Grafikler**: fl_chart ile görselleştirme
- **Trend Analizi**: Ortalamalar ve hedef çizgisi

### 📸 İlerleme Fotoğrafları
- **Karşılaştırma**: Tarih bazlı fotoğraf karşılaştırma
- **Cloud Storage**: Firebase Storage ile yedekleme

### 📈 Raporlar ve Analitikler
- **Haftalık/Aylık Raporlar**: Detaylı analizler
- **Firebase Analytics**: Kullanım istatistikleri


### ⚙️ Diğer Özellikler
- **Offline-First**: Internet olmadan çalışır
- **Firebase Sync**: Otomatik bulut yedekleme
- **Quick Actions**: Ana ekrandan hızlı işlemler










