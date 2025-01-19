## Analiza skupień: algorytm $k$ - średnich

Jednym z podstawowych algorytmów stosowanych w analizie skupień jest analiza $k$-średnich.

- **Dane**: Zbiór obserwacji  $\{x_1, \dots, x_n\}$ , gdzie każda obserwacja to wektor w przestrzeni wielowymiarowej. 
- **Cel**: Podział zbioru obserwacji na  $K$  **niepustych i rozłącznych klastrów**  $C_1, \dots, C_K$ , tak aby:
	- $C_1 \cup C_2 \cup \dots \cup C_K = \{x_1, \dots, x_n\}$,
	- $C_k \cap C_{k{\prime}} = \emptyset , dla  k \neq k{\prime}$ ,
	- **Minimalizować funkcję celu**: $$\sum_{k=1}^K \frac{1}{|C_k|} \sum_{i, i{\prime} \in C_k} \|x_i - x_{i{\prime}}\|^2,$$gdzie  $|C_k|$ to liczba elementów w klastrze  $C_k$.

### **Algorytm K-średnich:**

1. **Inicjalizacja**:
	- Losowo przypisz  $n$  obserwacji do  $K$  grup **lub** wybierz  $K$  punktów ze zbioru uczącego jako początkowe centroidy  $\mu_1, \dots, \mu_K$ .

2. **Iteracja** (powtarzaj do zbieżności): 
	- Przypisz każdą obserwację  $x_j$  do klastra  $c_j$, którego centroid  $\mu_i$  jest najbliższy: $$c_j = \arg\min_{i} \|x_j - \mu_i\|^2$$
	- Zaktualizuj położenia centrów każdego skupiska, tak aby były środkiem ciężkości punktów należących do danego skupiska: $$

\mu _{i} = \frac{\sum _{j=1}^{m} 1\lbrace c^{(j)}== i\rbrace x^{(j)}}{\sum _{j=1}^{m} 1\lbrace c^{(j)} == i\rbrace }

$$
3. **Warunek stopu**:
- Algorytm zatrzymuje się, gdy przypisania  $c_j$  przestaną się zmieniać lub po osiągnięciu maksymalnej liczby iteracji.

# Hierarchiczna klasteryzacja

- Algorytmy hierarchicznej klasteryzacji produkują dendrogramy
- Dendrogram jest drzewem, które reprezentuje wiele różnych klastrowań (w zależności od poziomu cięcia tego drzewa)
- Liście odpowiadają poszczególnym obserwacją
- Struktura dendrogramu opisuje strukturę podobieństwa pomiędzy obserwacjami
    - poziom podobieństwa pomiędzy dwoma obserwacjami reprezentowany jest wysokością najniższego wspólnego przodka tych obserwacji
    - im ta wysokość jest mniejsza tym obserwacje są do siebie bardziej podobne
    
- Wysokość cięcia charakteryzuje liczbę klastrów
![[hierarchiczna.png]]
## Algorytm hierarchicznego klastrowania

- bottom-up - zaczynamy od liści i tworzymy coraz większe klastry idąc w kierunku korzenia
- wejście: n obserwacji oraz miara odległości pomiędzy klastrami

1. Inicjujemy n klastrów, wszystkie jednoelementowe 
2. Dla $i = n, n-1, \dots, 2$ wykonuj:
    1. Mamy $i$ klastrów oraz obliczone odległości dla wszystkich $\binom{i}{2} = i(i-1)/2$ par klastrów. Wybierz dwa klastry, które są do siebie najbardziej podobne. Połącz je w niwy klaster, tworząc $i-1$ klastrów. Długość gałęzi w dendrogramie odpowiada odległości pomiędzy nimi. 
    2. Oblicz odległości pomiędzy nowym klastrem i wszystkimi pozostałymi klastrami
    

### **Różne sposoby obliczania odległości:**

- Pełne wiązanie: maksimum odległości pomiędzy elementami klastrów $\max\{d(x, x')|x \in C, x' \in C'\}$
- Pojedyncze wiązanie: minimum odległości pomiędzy elementami klastrów $\min\{d(x, x')|x \in C, x' \in C'\}$
- Wiązanie średnich: średnia odległości pomiędzy elementami klastrów
- Wiązanie centroidów:  odległości pomiędzy centroidami

# Ocena jakości klastrowania

- ***silhouette score:*** dobre klastrowanie to takie, gdzie ******elementy wewnątrz klastrów są bardziej podobne do siebie niż pomiędzy klastrami
    
    Niech $i \in C_I$ punkt danych w klastrze $C_I$, $d(i,j)$ odległość między punktami i oraz j
    
    - średnia odległość punktu i od innych punktów wewnątrz klastra:
        
        $$
        a(i) = \frac{1}{|C_I| - 1}\sum_{j\in C_I,i\ne j}d(i,j)
        $$
        
    - najmniejsza średnia odległość od punktów innych klastrów:
        
        $$
        b(i) = \min_{J\ne I}\frac{1}{|C_J|}\sum_{j \in C_J} d(i,j)
        $$
        
    - Silhouette score:
        
        $$
        s(i) = \frac{b(i) - a(i)}{\max\{a(i),b(i)\}}, \ \ \text{dla} \ \ |C_I|>1
        $$
        
- ***rand index:*** dobre klastrowanie to takie, które jest podobne do jakiegoś innego klastrowania
    
    Niech $C$ i $C'$ będą dwoma zestawami klasteryzacji dla zbioru danych. Punkty danych są oznaczone jako $i$ i $j.$
    
    Oznaczenia:
    
    - **TP (True Positive)**: liczba par punktów, które są w tym samym klastrze zarówno w $C$, jak i $C’.$
    - **TN (True Negative)**: liczba par punktów, które są w różnych klastrach zarówno w \(C\), jak i \(C'\).
    - **FP (False Positive)**: liczba par punktów, które są w tym samym klastrze w \(C\), ale w różnych klastrach w \(C'\).
    - **FN (False Negative)**: liczba par punktów, które są w różnych klastrach w \(C\), ale w tym samym klastrze w \(C'\).
    
    Rand Index jest zdefiniowany jako:
    
    $$
    
    RI = \frac{TP + TN}{TP + TN + FP + FN}
    
    $$