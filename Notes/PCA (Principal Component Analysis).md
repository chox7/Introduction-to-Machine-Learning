**Analiza składowych głównych** to technika redukcji wymiarowości danych, stosowana głównie w uczeniu maszynowym bez nadzoru. PCA przekształca dane do nowej przestrzeni o mniejszej liczbie wymiarów, jednocześnie zachowując jak najwięcej informacji (wariancji) zawartych w oryginalnych danych.

**Główne założenia i cele PCA**

1. **Redukcja wymiarowości:**
	• PCA zmniejsza liczbę zmiennych (cech) w danych, co upraszcza modele, skraca czas obliczeń i zmniejsza problem kolinearności.

2. **Zachowanie wariancji:**
	• PCA wybiera nowe osie (składowe główne), wzdłuż których wariancja danych jest maksymalna. Każda kolejna składowa wyjaśnia możliwie największą część pozostałej wariancji.

3. **Ortogonalność składowych:**
	• Składowe główne są liniowo nieskorelowane, co eliminuje redundancję informacji między zmiennymi.

4. **Bez nadzoru:**
	• PCA działa niezależnie od etykiet danych i analizuje wyłącznie ich strukturę.


**Interpretacja kierunków składowych głównych**

- **Pierwsza składowa główna (PC1):** Kierunek, w którym wariancja danych jest największa.
- **Kolejne składowe główne (PC2, PC3, …):** Są prostopadłe do wcześniejszych składowych i maksymalizują pozostałą wariancję.
- **Współczynniki wektorów składowych (ang. loadings):** Informują, jak mocno oryginalne zmienne wpływają na daną składową główną.
- **Inna interpretacja PC1:** Wyznacza prostą w przestrzeni cech, która jest “najbliżej danych” (minimalizuje sumę kwadratów odległości punktów od tej prostej).
![[Untitled 1.png]]


  **Formalizacja PCA**

1. Niech  $X$  będzie macierzą o kolumnach $x_1, x_2, \dots, x_p$ , reprezentujących **standaryzowane** wartości predyktorów.

2. Jeśli składowe główne są wyznaczone przez wektory  $Z_1, Z_2, \dots, Z_M$ , to m-ta składowa główna spełnia: $$Z_m = X \phi \quad \text{gdzie} \quad \phi = \arg \max_{\phi} \text{Var}(X \phi),$$przy założeniach:
	- $||\phi||_2 = 1$  (norma wektora równa 1),
	- $Z_i^T Z_m = 0$ dla $i = 1, \dots, m-1$  (ortogonalność względem wcześniejszych składowych).

3. $Z_m$  jest liniową kombinacją oryginalnych predyktorów, nieskorelowaną z pozostałymi składowymi.

**Eksploracja danych za pomocą PCA**

1. **Wizualizacja:**
	- Projekcja danych na pierwsze dwie lub trzy składowe pozwala na łatwą wizualizację w przestrzeni 2D lub 3D.

2.  **Wykrywanie wzorców:**
	 - PCA pomaga identyfikować grupy podobnych punktów, wykrywać anomalie i badać relacje między zmiennymi.
	 
3. **Przygotowanie danych:**
	- PCA często poprzedza inne algorytmy maszynowego uczenia w celu redukcji wymiarowości i zmniejszenia szumu.

  

**Regresja Składowych Głównych (PCR)**

Regresja składowych głównych to technika łącząca PCA z regresją liniową, stosowana, gdy dane mają wiele zmiennych silnie skorelowanych.

**Kluczowe założenia:**

1. Relatywnie mała liczba składowych głównych może wystarczająco dobrze wyjaśniać zmienność w danych $X$, pozwalając na precyzyjne przewidywanie wartości $Y$.

2. Składowe główne są liniowymi kombinacjami wszystkich zmiennych objaśniających, co zmniejsza problem kolinearności.

  

**Ważne uwagi:**

• Dobór liczby składowych odbywa się przy użyciu walidacji krzyżowej.
• Predyktory muszą być standaryzowane przed zastosowaniem PCA.
• Ponieważ $Z_m$ są ortogonalne, PCR sprowadza się do regresji na linie proste.


**Podsumowanie**

PCA to potężne narzędzie umożliwiające redukcję wymiarowości danych przy jednoczesnym zachowaniu kluczowych informacji. Jego zastosowanie obejmuje zarówno eksplorację danych, jak i budowę bardziej efektywnych modeli w uczeniu maszynowym. Kombinacja PCA z innymi metodami, takimi jak regresja składowych głównych, umożliwia radzenie sobie z problemami kolinearności i przeuczenia w złożonych zestawach danych.


