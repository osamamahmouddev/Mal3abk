# ملعبك — App Store & Google Play Submission Pack
**v1.0 · 15 November 2026**

كل اللي محتاجه لتقديم **ملعبك (Malabak)** على App Store وGoogle Play. الحقول اللي لازم صاحب الحساب يكتبها معلّمة **[DEV FILL]**.

---

## 0. حاجات لازم تتحل قبل التقديم

1. **[DEV FILL]** Bundle ID لـ iOS، وPackage name لـ Android، وإيميل الدعم، والموقع، ورابط سياسة الخصوصية، واسم الشركة وعنوانها.
2. **لقطات الشاشة أندرويد وبالعربي بس.** الإطار المستخدم جهاز أندرويد (punch-hole)، ونسخة الـ EN من الصور فيها واجهة التطبيق بالعربي كمان. قبل النشر:
   - صوّر الشاشات من iPhone لـ App Store (Guideline 2.3.3: الصور لازم تمثّل التطبيق على نفس المنصة).
   - بدّل الأداة لـ English من شاشة البداية وصوّر نفس الشاشات لنسخة الـ EN.
   - بعد ما تبدّل ملفات الصور في `prep/`، كل التصميمات بتتولّد تاني بأمر واحد (`run_store.py` ثم `run_extra.py`).
3. **أرقام الأسعار في الصور معدّلة يدوياً.** سعر الساعة ٢٥٠ جنيه (بدل ٤٠٠)، والإجمالي ٢٥٠، والباقي ٢٠٠، والعربون ٥٠. التعديل متركّب فوق لقطة الشاشة. الأحسن تضبط بيانات الملعب التجريبي على ٢٥٠ وتصوّر تاني.
4. **بيانات شخصية اتشالت من الصور.** شاشة الدفع كانت بتعرض اسم ورقم محفظة حقيقيين. استبدلتهم في الصور بـ "أحمد محمود علي" ورقم `01000000000` (وهميين). الأحسن تصوّر من حساب تجريبي ببيانات مستلم وهمية بدل الاستبدال ده.
5. **اسم ملعب حقيقي.** شاشة الملاعب بتعرض "ملعب مجاوره 4، حلوان". خد موافقة صاحب الملعب أو استخدم ملعب تجريبي.
6. **ملاحظات على واجهة التطبيق (اتصلّحها قبل إعادة التصوير):**
   - شاشة دفع العربون فيها سطر فاضي بين رقم الحجز والميعاد (اسم الملعب مش بيظهر).
   - إحصائيات الفريق (فوز، تعادل، خسارة، أهداف) بتظهر نقطة صغيرة بدل الرقم "٠". غالباً مشكلة عرض الصفر العربي.
   - اسم اللاعب "Ahmed" إنجليزي جوه واجهة عربية. استخدم اسم تجريبي عربي.
7. **حساب تجريبي للمراجعين.** Apple وGoogle محتاجين حساب (رقم موبايل + طريقة دخول ما تحتاجش OTP حقيقي) فيه ملعب ومواعيد فاضية وفريق جاهز. اعمل حساب Review وسجّل فيه بيانات تجريبية.
8. **الدفع.** العربون بيتحوّل يدوياً (محفظة موبايل/إنستاباي) لخدمة فعلية (حجز ملعب)، فغالباً مش محتاج In-App Purchase. اتأكد من مراجعة Guideline 3.1.1 / 3.1.3(e) وصياغة وصف التطبيق بحيث ما يوحيش إن التطبيق بيستلم الفلوس.
9. **الصور مش بتدّعي حاجة التطبيق مش بيعملها.** الحجز مش مؤكد غير بعد ما الملعب يراجع التحويل، وده مكتوب في الوصف تحت. ما تضيفش "تأكيد فوري" أو "دفع أونلاين" في الصور أو الوصف.

---

## 1. بيانات التطبيق (مشتركة)

| الحقل | القيمة |
|---|---|
| Category (أساسي) | Sports |
| Category (ثانوي) | Lifestyle |
| السعر | مجاني |
| Age rating | Apple 4+ · Play Everyone |
| Support email | **[DEV FILL]** |
| Website | **[DEV FILL]** |
| Privacy policy | **[DEV FILL]** (لازم تذكر: رقم الموبايل، صور إيصال التحويل، الاسم) |
| iOS bundle ID | **[DEV FILL]** |
| iOS SKU | malabak-ios-001 |
| Android package | **[DEV FILL]** |

---

## 2. APP STORE CONNECT

### 2.1 العربي

**Name (≤30):**
```
ملعبك: احجز ملعب كورة
```

**Subtitle (≤30):**
```
احجز ملعبك وكوّن فريقك
```

**Promotional text (≤170):**
```
شوف المواعيد الفاضية، احجز ملعبك، وكوّن فريقك وتحدّى أي فريق في منطقتك. الحجز بيتأكد بعد ما الملعب يراجع تحويل العربون.
```

**Keywords (≤100):**
```
ملعب,كورة,حجز,ملاعب,خماسي,فريق,تحدي,كرة قدم,نجيل صناعي,حجز ملعب,تشكيل,ماتش
```

**Description:**
```
ملعبك بيخلّي حجز ملعب الكورة أسهل من مكالمات الواتساب والتليفونات.

احجز في ثواني
شوف المواعيد الفاضية والمحجوزة لكل ملعب واختار ميعادك ومدة الحجز.

ملاعب قريبة منك
صور الملعب وأسعاره ومواصفاته (عدد اللاعبين ونوع الأرضية) قبل ما تتصل بحد.

عربون واضح وإيصال
شوف العربون المطلوب والباقي اللي بيتدفع في الملعب. حوّل العربون بمحفظة موبايل أو إنستاباي، وارفع صورة الإيصال، وتابع حالة حجزك. الحجز بيتأكد بعد ما الملعب يراجع التحويل.

كوّن فريقك
اعمل فريقك وادعو صحابك بكود واحد، وشوف ترتيب فريقك في منطقتك.

تحدّى أي فريق
ابعت تحدّي لفريق تاني وحدد اليوم والميعاد ومدة الماتش.

رتّب تشكيلك
اختار ٥ ضد ٥ أو ٧ ضد ٧ أو ١١ ضد ١١ ورتّب اللاعبين على لوحة التشكيل.

متاح بالعربي والإنجليزي.

احجز. كوّن فريقك. العب.
```

### 2.2 English

**Name (≤30):**
```
Malabak: Book a Pitch
```

**Subtitle (≤30):**
```
Book pitches, build your team
```

**Promotional text (≤170):**
```
See free time slots, book your pitch, build your team and challenge teams near you. A booking is confirmed once the pitch reviews your deposit transfer.
```

**Keywords (≤100):**
```
football,pitch,booking,soccer,5-a-side,team,challenge,turf,court,lineup,match,egypt,cairo
```

**Description:**
```
Malabak makes booking a football pitch simpler than chasing WhatsApp messages and phone calls.

BOOK IN SECONDS
See free and taken slots for each pitch, then pick your time and duration.

PITCHES NEAR YOU
Photos, prices and details (players per team, surface) before you call anyone.

CLEAR DEPOSIT AND RECEIPT
See the deposit due now and the rest paid at the pitch. Transfer the deposit by mobile wallet or InstaPay, upload your receipt and track your booking. A booking is confirmed once the pitch reviews your transfer.

BUILD YOUR TEAM
Create a team, invite friends with one code and see your team's rank in your area.

CHALLENGE ANY TEAM
Send a challenge to another team and pick the day, time and match length.

SET YOUR LINEUP
Choose 5v5, 7v7 or 11v11 and arrange players on the lineup board.

Available in Arabic and English.

Book. Build your team. Play.
```

---

## 3. GOOGLE PLAY

### العربي
**Title (≤30):** `ملعبك: احجز ملعب كورة`

**Short description (≤80):**
```
احجز ملعب كورة، كوّن فريقك، وتحدّى فرق منطقتك
```

**Full description:** نفس نص App Store (2.1).

### English
**Title (≤30):** `Malabak: Book a Pitch`

**Short description (≤80):**
```
Book football pitches, build your team and challenge teams near you
```

**Full description:** same as App Store (2.2).

---

## 4. ملفات الصور

| المجلد | الحجم | المحتوى |
|---|---|---|
| `AppStore/AR` و `AppStore/EN` | 1284 × 2778 | 5 صور |
| `GooglePlay/AR` و `GooglePlay/EN` | 1080 × 2160 | 5 صور + `FeatureGraphic.png` (1024 × 500) |
| `Preview_AR.png` / `Preview_EN.png` | 3000 × 1072 | ملخص كل الصور في صورة واحدة |

ترتيب الصور: 1 الحجز (المواعيد) · 2 الملاعب · 3 العربون والإيصال · 4 الفريق (كود الدعوة) · 5 لوحة التشكيل.

لمسات الكورة: ملعب بكشافات، خطوط ملعب، نجيل مقصوص، مرمى بشبكة وكورة، وكورة بتتحرك في كل صورة.

كل صورة فيها نسخة SVG (النصوص محوّلة لخطوط مرسومة، فمش محتاج تنزّل الخط).

## 5. إعادة التوليد

```
cd source
python3 prep.py          # يجهّز الشاشات من لقطاتك (غيّر مسارات الملفات جوه)
python3 run_store.py     # كل صور AppStore وGooglePlay
python3 run_extra.py     # Feature Graphic وصور Preview
```
