# MealLog

Offline-first yemek g�nl���. Open Food Facts ile arama yapar, g�nl�k ���n ve makro toplamlar�n� g�sterir.

## Run

```bash
flutter pub get
flutter run
```

## API (Open Food Facts)

Arama endpointi:

```
GET https://world.openfoodfacts.org/api/v2/search
```

Kullan�lan alanlar:
- `product_name`, `product_name_tr`, `generic_name`
- `brands`, `code`
- `nutriments.energy-kcal_100g`, `proteins_100g`, `carbohydrates_100g`, `fat_100g`
- `data_quality_tags`

## Offline Cache

- Hive kutular�:
  - `search_cache`: arama sonu�lar� (TTL: 24saat)
  - `food_entries`: g�nl�k giri�ler
  - `recent_items`, `favorite_items`: h�zl� eri�im
- A� hatas�nda cache varsa g�sterilir.
- Cache yoksa �rnek veri (`mock_food_data.dart`) ile sonu� g�sterilir.

## Optional API Adapters (Stub)

�leride farkl� veri kaynaklar� i�in adapter eklemek isterseniz:
- `FoodRemoteDataSource` yerine yeni bir datasource
- `FoodRepositoryImpl` i�inde se�im

�rnek adaylar: USDA FoodData Central, Edamam, Spoonacular.

## Tests

```bash
flutter test
```

## Self-check

- [ ] Today ekran� a��l�yor, tarih ve �zet g�r�n�yor
- [ ] Kahvalt�/��le/Ak�am/Ara ���n kartlar� toplamlar� g�steriyor
- [ ] Open Food Facts aramas�ndan sonu� geliyor (internet varsa)
- [ ] Porsiyon gram girince kcal/makro hesaplan�yor
- [ ] Ekleme sonras� g�nl�k toplamlar g�ncelleniyor
- [ ] Offline�da cache veya �rnek veri g�steriliyor
- [ ] flutter analyze temiz
- [ ] flutter test ge�iyor
