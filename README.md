# VitaTrack 🏋️‍♀️

**Kilo & Sağlık Takip Uygulaması**

VitaTrack, kişisel sağlık hedeflerinize ulaşmanıza yardımcı olan kapsamlı bir mobil uygulamadır. Kilo takibi, beslenme kontrolü, su tüketimi ve daha fazlasını tek bir platformda sunar.

---
**Youtube linki:** https://youtu.be/J--hB7_tyao

**Ekranlar ve işlevleri**(amaçlar problemler ekranlar ve işlevlerden sonra geliyor)

**Ana Panel**
<img width="450" height="902" alt="download" src="https://github.com/user-attachments/assets/31a38dd2-cc31-45cc-9dbe-d0be661d6750" />
Uygulamanın ana sayfasıdır. Kullanıcının günlük hedeflerine (su, kalori, aktivite) ne kadar yaklaştığını, mevcut kilosunu ve hedef kilosuna olan uzaklığını dairesel grafiklerle ve özet kartlarla gösterir. Ayrıca günün makro besin (protein, yağ vb.) detaylarını da sunar.



**Giriş Ekranı**
<img width="441" height="901" alt="download" src="https://github.com/user-attachments/assets/df507589-6367-4d56-8e52-7d9d9dc2aa50" />
Kullanıcıların hesaplarına e-posta/şifre ile güvenli bir şekilde giriş yapmasını sağlayan karşılama ekranıdır. Ayrıca Google/Apple ile giriş, kayıt olma ve şifre sıfırlama seçeneklerini barındırır.



 **İlerleme Fotoğrafları Ekranı**
<img width="438" height="906" alt="download" src="https://github.com/user-attachments/assets/60272d2e-2621-41ce-8a31-2f7ed7830879" />
Kullanıcının fiziksel değişimini görsel olarak takip edebilmesi için tasarlanmıştır. Kullanıcılar buradan kamera veya galeri aracılığıyla öncesi/sonrası fotoğraflarını yükleyebilir ve vücut değişimlerini zaman çizelgesi üzerinde görebilirler


 **Kayıtlar / Günlük**
<img width="442" height="912" alt="download" src="https://github.com/user-attachments/assets/ec776e94-6bda-4c42-b5b1-7b010c1081f1" />
Kullanıcının gün içinde eklediği tüm verilerin (içilen su, yapılan egzersizler, yenen yemekler vb.) tarihsel ve kronolojik olarak listelendiği akış ekranıdır. Her bir aktivitenin saati ve detayları (örn. yakılan kalori) burada yer alır.



**Hızlı Ekleme Menüsü**
<img width="440" height="905" alt="download" src="https://github.com/user-attachments/assets/b337cde5-8c9c-4be9-879c-4055d0c48e6c" />
Ana sayfadaki "Artı" (+) butonuna tıklandığında açılan menüdür. Kullanıcının uygulamada en sık yaptığı 4 temel işlemi (Su Ekleme, Öğün Ekleme, Aktivite/Egzersiz Ekleme ve Vücut Fotoğrafı Ekleme) tek bir yerden hızlıca başlatmasını sağlar.



**Ayarlar Ekranı**
<img width="445" height="906" alt="download" src="https://github.com/user-attachments/assets/1559e502-db76-49e2-ac04-ccea64e8e811" />
Uygulamanın yapılandırma merkezidir. İki ana başlık içerir:
Profil ve Hedefler: Kullanıcının kişisel bilgilerini, hedef kilosunu ve vücut ölçülerini güncelleyebileceği alan.
Bildirimler: Su içme, yemek yeme veya spor yapma gibi hatırlatıcıların (bildirimlerin) saatlerinin ayarlandığı ve açılıp kapatılabildiği bölüm.



**Raporlar Ekranı**
<img width="437" height="907" alt="download" src="https://github.com/user-attachments/assets/9f845d73-18e2-4d43-81a6-74cef4898067" />
Kullanıcının haftalık veya aylık gelişimini grafikler üzerinden analiz ettiği sayfadır. Tüketilen kalori miktarı, günlük ortalamalar ve kilo değişim grafiği (çubuk grafik) burada görüntülenir.





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










