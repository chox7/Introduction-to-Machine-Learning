
# Ocena klasyfikatorów binarnych 

- klasyfikatory binarne to te, które przypisują danemu przykładowi jedną z dwóch możliwych klas (np. 0 i 1)
- np. regresja logistyczna
## Typy błędów 

![[Pasted image 20250117143034.png]]
W klasyfikacji binarnej, symbole te mają następujące znaczenia:

- **T (True)**: Oznacza, że model dokonał poprawnej predykcji.
- **F (False)**: Oznacza, że model dokonał błędnej predykcji.
- **P (Positive)**: Oznacza, że model przewidział przypadek jako należący do klasy pozytywnej.
- **N (Negative)**: Oznacza, że model przewidział przypadek jako należący do klasy negatywnej.

Łącząc te symbole, mamy cztery możliwości:

1. **TP (True Positive)**: Model poprawnie przewidział przypadek jako pozytywny.
2. **FP (False Positive)**: Model błędnie przewidział przypadek jako pozytywny (przypadek jest faktycznie negatywny).
3. **FN (False Negative)**: Model błędnie przewidział przypadek jako negatywny (przypadek jest faktycznie pozytywny).
4. **TN (True Negative)**: Model poprawnie przewidział przypadek jako negatywny.

### Czułość i specyficzność

- **Czułość** (ang. sensitivity): Prawdopodobieństwo, że klasyfikacja będzie poprawna pod warunkiem, że przypadek jest pozytywny (ang. True Positive Rate, recall).
  $$ TPR = \frac{TP}{P} = \frac{TP}{TP + FN} $$

  > Prawdopodobieństwo, że test wykonany dla osoby chorej wykaże, że jest ona chora.

- **Swoistość, specyficzność** (ang. specificity, SPC): Prawdopodobieństwo, że klasyfikacja będzie poprawna pod warunkiem, że przypadek jest negatywny (ang. True Negative Rate, TNR).
  $$ SPC = TNR = \frac{TN}{N} = \frac{TN}{FP + TN} = 1 - FPR $$

  > Prawdopodobieństwo, że dla osoby zdrowej test nie wykryje choroby.

### Fałszywe alarmy

- **Częstość fałszywych alarmów** (False Positive Rate):
  $$ FPR = \frac{FP}{N} = \frac{FP}{FP + TN} = 1 - SPC = 1 - TNR $$
  
  > Jak dużej frakcji osób zdrowych test wyjdzie pozytywnie?
  
- **Częstość fałszywych odkryć** (False Discovery Rate, FDR):
	$$ FDR = \frac{FP}{P'} = \frac{FP}{FP + TP} $$

  > Jak duża frakcja spośród pozytywnych wyników testu jest fałszywa?

### Własności predykcyjne: Precyzja

- **Precyzja pozytywna** (positive predictive value, PPV, precision). Odpowiada na pytanie:

  > Jeśli wynik testu jest pozytywny, jakie jest prawdopodobieństwo, że osoba badana jest chora?
$$ PPV = \frac{TP}{P'} = \frac{TP}{TP + FP} $$

- **Precyzja negatywna** (negative predictive value, NPV). Odpowiada na pytanie:

  > Jeśli wynik testu jest negatywny, jakie jest prawdopodobieństwo, że osoba badana jest zdrowa?  
$$ NPV = \frac{TN}{N'} = \frac{TN}{TN + FN} $$
### Dokładność (accuracy, ACC)
Prawdopodobieństwo prawidłowej klasyfikacji.

$$ ACC = \frac{TP + TN}{P + N} $$

### F1-score
Średnia harmoniczna z precyzji (PPV) i czułości (TPR). Miara ta daje ocenę balansu między czułością a precyzją i nie uwzględnia wyników prawdziwie negatywnych.

$$ F1 = 2 \cdot \frac{PPV \cdot TPR}{PPV + TPR} = \frac{2 \cdot TP}{2 \cdot TP + FP + FN} $$

### Fβ (uogólnienie F1-score)
Pozwala regulować za pomocą parametru β wagę, jaką przykładamy do PPV (precyzji).

$$ F_{\beta} = (1 + \beta^2) \cdot \frac{PPV \cdot TPR}{(\beta^2 \cdot PPV) + TPR} $$

### Współczynnik korelacji Matthews (Matthews correlation coefficient, MCC)
Uwzględnia wyniki zarówno prawdziwie, jak i fałszywie pozytywne oraz negatywne. Jest zrównoważoną miarą stosowaną nawet wtedy, gdy klasy mają różną liczebność. MCC to współczynnik korelacji pomiędzy obserwowanymi i przewidywanymi klasyfikacjami binarnymi; zwraca wartość od -1 do +1.

$$ MCC = \frac{TP \cdot TN - FP \cdot FN}{\sqrt{(TP + FP)(TP + FN)(TN + FP)(TN + FN)}} $$

- Współczynnik +1 odpowiada idealnej klasyfikacji.
- Współczynnik 0 oznacza, że klasyfikacja nie jest lepsza niż losowe przypisanie wyniku.
- Współczynnik -1 oznacza całkowitą niezgodę między klasyfikacją a stanem faktycznym.

### Krzywa ROC 
![[Pasted image 20250117144550.png]]
- każdy punkt na krzywej otrzymywany jest dla ustalonej wartości progu
- przydaje się do porównywania różnych klasyfikatorów oraz do wyboru progu
- AUC - pole powierzchni pod krzywą

AUC - interpretacja probabilistyczna:
> jest to prawdopodobieństwo tego, że klasyfikator przydzieli wyższą rangę dla losowo wybranego przypadku pozytywnego niż negatywnego (zakładając, że wynik pozytywny ma wyższą rangę niż negatywny)


- TODO: Walidacja Krzyżowa i generalizacja
# Pytania do wykładu
1. W klasyfikacji binarnej każdy przypadek należy do jednej z czterech możliwości: TP, FP, FN, TN. Co oznaczają symbole (T, F) oraz (P, N) w tym kontekście?
2. Prawdopodobieństwo, że klasyfikacja będzie poprawna, pod warunkiem, że przypadek jest negatywny to: __
3. Na pytanie: Jak dużej frakcji osób zdrowych test medyczny wyjdzie pozytywny?
	odpowiada: __
4. __ daje prawdopodobieństwo prawidłowej klasyfikacji.
5. Pole pod krzywą ROC wynosi 0.9. Hipoteza w klasyfikatorze jest zaprojektowana tak aby większe wartości oznaczały klasę 1 a mniejsze klasę 0. Jakie jest prawdopodobieństwo, że losowo wybrany element z klasy 0 będzie miał wyższą wartość hipotezy niż losowo wybrany element z klasy 1?
