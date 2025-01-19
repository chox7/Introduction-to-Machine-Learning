Drzewa decyzyjne to algorytmy, które wykorzystuje się w klasyfikacji i regresji. Są popularne dzięki swojej prostocie, interpretowalności i wszechstronności.

Kluczowe cechy:
- Struktura drzewa: składa się z węzłów decyzyjnych (testowanie cech) i liści (wynik predykcji).
- Wszechstronność: obsługuje dane numeryczne i kategoryczne.
- Interpretowalność: wynik można łatwo wizualizować i zrozumieć.
- Typ algorytmu: działa w trybie wsadowym (batch) i wymaga minimalnego dostrajania parametrów.
- Podział przestrzeni cech: tworzy hiperpowierzchnie równoległe do osi cech.
![[Pasted image 20250119120430.png]]
## Ogólny proces tworzenia drzew

**Podział przestrzeni cech**:
- Dzielimy przestrzeń predyktorów na **$J$ rozłącznych obszarów** $R_1, R_2, \dots, R_J$​.
- Dla każdej obserwacji w obszarze $R_j$ przewidujemy wartość będącą średnią odpowiedzi dla obserwacji treningowych w $R_j$​.

**Minimalizacja błędu**:
- W klasyfikacji: minimalizujemy **nieczystość** (np. entropia, indeks Gini).
- W regresji: minimalizujemy **sumę kwadratów reszt (RSS)**: $$\sum_{j=1}^J\sum_{i \in R_j}(y_i - \hat{y}_{R_j})^2,$$ gdzie  $\hat{y}{R_j}$  to średnia wartość odpowiedzi w obszarze  $R_j$.

**Niestety, rozważenie każdego możliwego podziału przestrzeni cech na R_j jest niewykonalne obliczeniowo.**

### Algorytm Rekurencyjnego Podziału Binarnego: top-down, greedy approach

• **Top-down**: Drzewo rozwija się od korzenia, dzieląc przestrzeń cech w kolejnych krokach.
• **Greedy**: Na każdym etapie wybierany jest najlepszy podział z punktu widzenia bieżącego kroku.

**Podział:**
- Wybieramy cechę  $X_j$  i wartość progową  $s$ , które minimalizują RSS po podziale: $$ R_1(j, s) = {X | X_j < s}, \quad R_2(j, s) = {X | X_j \geq s}$$
- Minimalizujemy wyrażenie: $$\sum_{i:x_i \in R_1(j, s)}(y_i - \hat{y}_{R_1})^2 + \sum_{i:x_i \in R_2(j, s)}(y_i - \hat{y}_{R_2})^2$$
**Kryterium stopu:**
- Proces zatrzymuje się, gdy:
	- Obszar  $R_j$  ma mniej niż minimalną liczbę obserwacji (np. 5).
	- Dalsze podziały nie zmniejszają znacząco RSS.


## Przycinanie Drzewa

Proces rekurencyjnego binarnego dzielenia może prowadzić do stworzenia bardzo dużego drzewa, które świetnie dopasowuje się do danych treningowych, ale jest podatne na przeuczenie (overfitting). Przycinanie drzewa pozwala na zmniejszenie złożoności modelu, co może poprawić jego ogólną wydajność na zbiorze testowym.

### Post-prunning

**Post-prunning** polega na budowie pełnego drzewa decyzyjnego $T_0$, a następnie przycięcie go w celu uzyskania poddrzewa. W tym celu iteracyjnie przycinamy najsłabsze gałęzie (te, które są najmniej istotne). 

Dla ustalonego parametru $\alpha$ (parametr regularyzacji) wybieramy poddrzewo $T$ drzewa $T_0$ otrzymanego metodą rekurencyjnego binarnego dzielenia tak, aby zminimalizować koszt:$$ C_\alpha(T) = \sum_{m=1}^{|T|}\sum_{i: x_i \in R_m} (y_i - \hat{y}_{R_m})^2 + \alpha|T|$$ gdzie $|T|$ – liczba liści w drzewie $T$

**Algorytm:**
1. Zbuduj pełne drzewo $T_0$.
2. Iteracyjnie przycinaj najsłabsze gałęzie, które powodują najmniejszy wzrost członu $\sum_{m=1}^{|T|}\sum_{i: x_i \in R_m} (y_i - \hat{y}_{R_m})^2$.
3. Powtarzaj, aż uzyskasz korzeń drzewa. To generuje sekwencję poddrzew.
4. Wybierz optymalne poddrzewo $T_\alpha$, używając K-krotnej walidacji krzyżowej.

<aside> 🌟 Zaletą metody post-pruning jest dokładna kontrola złożoności drzewa i jej teoretyczne podstawy. Jednak proces iteracyjny może być czasochłonny. </aside>
### Rule post-prunning

Zamiast usuwać gałęzie drzewa, zamienia się je w warunki logiczne odpowiadające liściom. Te reguły mogą być następnie sortowane i redukowane, co poprawia interpretowalność modelu. Reguły o niskiej jakości są usuwane, a podobne reguły łączone w celu uproszczenia.

**Algorytm:**
1. Przekształć każde poddrzewo w reguły decyzyjne, gdzie każda ścieżka od korzenia do liścia reprezentuje jedną regułę.
2. Oceń jakość reguł, np. na podstawie wskaźników takich jak:
    - Współczynnik pokrycia (_coverage_): liczba obserwacji, które spełniają regułę.
    - Współczynnik dokładności (_accuracy_): stosunek poprawnych predykcji do wszystkich przypadków spełniających regułę.
3. Usuń reguły o niskiej jakości (np. o zbyt niskim pokryciu lub dokładności).
4. Jeśli kilka reguł prowadzi do tej samej decyzji, połącz je w jedną regułę (redukcja redundancji).

<aside> 🌟 Zaletą metody rule post-pruning jest łatwość interpretacji i możliwość efektywnego dopasowania do rzeczywistych danych. Jednak może być mniej skuteczna w optymalizacji złożoności drzewa w porównaniu do post-pruning. </aside>


## Algorytm konstrukcji drzewa regresyjnego

1. Użyj rekurencyjnego podziału binarnego do budowy dużego drzewa na danych treningowych, zatrzymując się tylko wtedy, gdy każdy węzeł terminalny zawiera mniej niż pewną minimalną liczbę obserwacji.
    
2. Zastosuj metodę przycinania najsłabszych gałęzi do dużego drzewa, aby uzyskać sekwencję najlepszych poddrzew, jako funkcję parametru $\alpha.$
    
3. Użyj K-krotnej walidacji krzyżowej do wyboru parametru $\alpha$. Podziel obserwacje treningowe na K foldów. Dla każdego $k = 1, \ldots, K$:
    
    1. Powtórz kroki 1 i 2 na wszystkich foldach poza k-tym foldem danych treningowych.
    2. Oceń średni błąd kwadratu predykcji na danych z k-tego foldu, jako funkcję parametru $\alpha$.
    
    Uśrednij wyniki dla każdej wartości $\alpha$ i wybierz $\alpha$, które minimalizuje średni błąd.
    
4. Zwróć poddrzewo z kroku 2, które odpowiada wybranej wartości $\alpha$.

## Boosting 

Boosting polega na wykorzystaniu wielu słabych klasyfikatorów, z których każdy kolejny jest trenowany w taki sposób, aby kłaść większy nacisk na próbki, które zostały błędnie sklasyfikowane przez poprzedni model.

Jest to ogólne podejście, można boostować różne metody. Szczególnym, popularnym, algorytmem dobierania wag modeli i modyfikowania wag przykładów jest Ada Boost. Algorytm wygląda następująco:

1.  Na początku każdy przykład w zbiorze treningowym ma przypisaną wagę  $w_i = \frac{1}{n}$ , gdzie  $n$  to liczba przykładów.
2. Powtarzaj dla kroków $m = 1, \dots, M$
	- **Dopasowanie modelu:** Trenujemy nowy model do danych, ale z uwzględnieniem wag przykładów. Każdy nowy model skupia się na błędach popełnionych przez poprzednie modele, co oznacza, że przykłady, które zostały źle sklasyfikowane, otrzymują wyższe wagi.
	
	- **Obliczenie wag:** Po dopasowaniu modelu  $h_m$ , obliczamy wagę tego modelu  $\alpha_m$ , która jest zależna od jego dokładności. Wzór na wagę to: $$\alpha_m = \log\left(\frac{1 - \text{err}_m}{\text{err}_m}\right)$$gdzie  $\text{err}_m$  to błąd modelu  $h_m$.
	
	- **Uaktualnianie wag przykładów:** Wagi przykładów są aktualizowane w taki sposób, że dla źle sklasyfikowanych przykładów  $w_i$  są zwiększane. Aktualizacja wag jest zależna od dokładności danego modelu: $$w_i := w_i \exp(\alpha_m 1\{y_i \neq h_m(x_i)\})$$gdzie  $\exp(\alpha_m)$  sprawia, że przykłady błędnie sklasyfikowane przez model otrzymują wyższe wagi.

3. **Ostateczna predykcja:**
	Modele te są następnie uśredniane z wagami i ostateczne wyjście z modelu całościowego ma postać: $$h(x) = \text{sign}\left(\sum_m \alpha_m h_m(x)\right)$$
## Bagging 

**Powtórzenie, Bootstrap:**  
Bootstrap to technika losowania próbek ze zbioru danych _ze zwracaniem_. Oznacza to, że każdy element zbioru może zostać wybrany więcej niż raz. Zbiory bootstrapowane mają ten sam rozmiar co zbiór oryginalny, ale mogą zawierać powtórzenia.

Bagging jest metodą, która wykorzystuje uśrednianie predykcji wielu modeli uczonych na różnych próbach bootstrapowych. Głównym celem jest zmniejszenie wariancji, szczególnie w przypadku modeli, które mają tendencję do nadmiernego dopasowania (overfitting), jak drzewa decyzyjne.

1. **Budowa modelu:**
    - Na początku losujemy $B$ próbek ze zbioru danych z użyciem bootstrapu (czyli z powtórzeniami).
    - Dla każdej próbki budujemy osobne drzewo decyzyjne (lub inny model), które będzie miało _małe obciążenie_ (bo jest uczone na części zbioru) i dużą _wariancję_ (ponieważ używa tylko części danych).
    
1. **Uśrednianie wyników:**
    - Po wytrenowaniu $B$ modeli na różnych próbach, wyniki są uśredniane (w przypadku regresji) lub agregowane za pomocą głosowania większościowego (w przypadku klasyfikacji).
    - Wzór dla ostatecznej predykcji w baggingu to:$$h(x) = \frac{1}{B} \sum_{b=1}^{B} h_b(x)$$gdzie $h_b(x)$ jest predykcją modelu $b$, wytrenowanego na bootstrapowanej próbce.
    
3. **Redukcja wariancji:**
    - Ponieważ każdy z modelów jest uczony na różnych próbkach, mają one różne błędy (wariancję), ale po uśrednieniu, wariancja całkowita modelu jest mniejsza, a dokładność poprawia się, szczególnie w przypadku drzew decyzyjnych, które mają tendencję do przeuczenia.
## Random Forests

- Pojedyncze drzewo decyzyjne jest podatne na szum w zbiorze uczącym, co może prowadzić do przeuczenia (overfitting).
- Mimo zastosowania technik takich jak przycinanie, pojedyncze drzewo może nadal być niewystarczające w modelowaniu bardziej złożonych zależności.

**Pomysł na Poprawę – Lasy Losowe:**
- Aby rozwiązać problem przeuczenia, stosuje się podejście, w którym budowane są **wielokrotnie różne drzewa**, różniące się między sobą, a ich wyniki są uśredniane.
- Pierwsza randomizacja polega na zastosowaniu **podzbiorów zbioru uczącego**:
    - Losujemy próbki z oryginalnego zbioru z **bootstrapem**, co daje różne zbiory treningowe dla każdego drzewa.
    - Próbki, które nie pojawiły się w danym bootstrapie, mogą zostać użyte do **walidacji krzyżowej** (CV), co pozwala na lepszą ocenę modelu.
- Druga randomizacja polega na zastosowaniu **podzbioru cech**:
    - Przy rozważaniu podziału w każdym węźle drzewa, zamiast wszystkich cech, wybieramy losowo $m$ cech spośród wszystkich $p$ dostępnych cech, gdzie $m≪p$. Często przyjmuje się, że $m = \sqrt{p}m$​.
    - Taka technika sprawia, że drzewa w lesie losowym różnią się od siebie, co redukuje ich **wzajemną korelację**, a tym samym zmniejsza ryzyko przeuczenia.
    - Dodatkowo, dzięki temu uwalniamy się od wpływu najsilniejszych predyktorów - mogą one nie wpaść do zbioru $m$ rozważanych


# Pytania do wykładu
1. Jaką postać ma podział przestrzeni cech?
2. Co poprawia duża liczba drzew w lesie losowym?
3. Czym się różnią metody post-prune od rule post-prune?