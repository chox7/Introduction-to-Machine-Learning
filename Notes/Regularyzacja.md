Przypomnienie:

Metoda najmniejszych kwadratów = minimalizacja RSS

$$
RSS = \sum_{i=1}^n\left(y_i-\beta_0-\sum_{j=1}^p\beta_jx_{ij}\right)^2
$$

## Regresja grzbietowa (ridge regression)

$$
\sum_{i=1}^n\left(y_i-\beta_0-\sum_{j=1}^p\beta_jx_{ij}\right)^2 + \lambda\sum_{j=1}^p\beta_j^2 = RSS+\lambda\sum_{j=1}^p\beta_j^2
$$

- dodatkowa kara ściągająca
- $\lambda$ jest parametrem sterującym metody, kontroluje jak silnie parametry są ściągane do 0.
    - dla $\lambda=0$ zwykła metoda najmniejszych kwadratów
    - dla $\lambda \to \infty$ współczynniki $\beta_i$ kurczą się do 0 (**ale nigdy nie będą równe 0**)
- nie ściągamy wyrazu wolnego $\beta_0$ - jest to predykcja średniej

Standardowe oszacowania współczynników metodą najmniejszych kwadratów są równoważne pod względem skali, niezależnie od sposobu skalowania j-tego predyktora, $X_j\hat{\beta}_j$ pozostanie taki sam. W przeciwieństwie do tego, oszacowania współczynnika regresji grzbietowej mogą się zmieniać podczas mnożenia danego predyktora przez stałą (przy zmianie skali).

<aside>
🚨 Przed zastosowaniem regresji grzbietowej, standaryzuje się predyktory tak aby były w tej samej skali.

</aside>

### Regresja grzbietowa a metoda najmniejszych kwadratów

Przewaga regresji grzbietowej nad regresją najmniejszych kwadratów jest zakorzeniona w odchyleniu od wariancji. Wraz ze wzrostem $λ$ zmniejsza się elastyczność dopasowania regresji grzbietowej, co prowadzi do zmniejszenia wariancji, ale zwiększenia obciążenia. 

- Gdy liczba zmiennych p jest bliska liczbie obserwacji n to metoda najmniejszych kwadratów ma dużą wariancje
- Gdy $p>n$ to metoda najmniejszych kwadratów przestaje działać (brak jednoznaczności estymacji), podczas gdy regresja grzbietowa może efektywnie zmniejszyć wariancję kosztem niewielkiego wzrostu obciążenia i wybrać najlepszy model spośród wielu dających $RSS=0$
- Regresja grzbietowa najlepiej sprawdza się w sytuacjach, gdzie estymaty najmniejszych kwadratów mają wysoką wariancję.
- Regresja grzbietowa  może być użyto do wyboru modelu (pomijamy tu predyktory, dla których współczynnik $\beta_j$ jest mały) i ma znaczną przewagę obliczeniową nad selekcją najlepszych podzbiorów, która wymaga przeszukania  $2^p$ modeli.

## Lasso regression

$$
\sum_{i=1}^n\left(y_i-\beta_0-\sum_{j=1}^p\beta_jx_{ij}\right)^2 + \lambda\sum_{j=1}^p|\beta_j| = RSS+\lambda\sum_{j=1}^p|\beta_j|
$$

- dla dostatecznie dużych wartości $\lambda$ estymacje niektórych parametrów $\beta_j$ przyjmują wartości równe 0, jednocześnie zadając selekcję predyktorów

### Zjawisko selekcji predyktorów

Metoda lasso jest równoważna problemowi minimalizacji po wektorach $\beta$ wyrażenia:

$$
\sum_{i=1}^n\left(y_i-\beta_0 - \sum_{j=1}^p\beta_jx_{ij}\right)^2 \text{przy warunku } \sum_{j=1}^p|\beta_j|\le s
$$

Metoda grzbietowej regresji jest równoważna problemowi minimalizacji po wektorach  $\beta$ wyrażenia:

$$
\sum_{i=1}^n\left(y_i-\beta_0 - \sum_{j=1}^p\beta_jx_{ij}\right)^2 \text{przy warunku } \sum_{j=1}^p\beta_j^2\le s
$$

Dla każdego $\lambda \ge 0$ istnieje takie $s \ge 0$ spełniające powyższe warunki.

![[hierarchiczna.png]]

### Porównanie regresji grzbietowej z lasso

- Żadna z metod nie jest lepsza od drugiej we wszystkich sytuacjach.
- Lasso działa lepiej w sytuacjach, gdy zmienna objaśniana Y istotnie zależy tylko od małej liczby predyktorów.
- Regresja grzbietowa działa lepiej gdy Y zależy od dużej liczby predyktorów o współczynnikach w przybliżeniu podobnego rozmiaru.
- Liczba istotnych predyktorów nigdy nie jest znana z góry - trzeba stosować walidację krzyżową do wyboru modelu.
- W sytuacji gdy estymacje z metody najmniejszych kwadratów mają dużą wariancję to zarówno lasso, jaki regresja grzbietowa zmniejszają wariancję predykcji kosztem zwiększenia obciążenia.
- Metoda lasso, w odróżnieniu od regresji grzbietowej, pozwala dokonywać selekcji istotnych predyktorów.

# Metody redukcji wymiaru

Redukcja wymiaru polega na zastąpieniu oryginalnych predyktorów $X_1, X_2, \dots, X_p$ linowymi kombinacjami $Z_1, Z_2, \dots, Z_M$, gdzie $M \le p$ oraz dla $1 \le m\le M$:

$$
Z_m=\sum_{j=1}^p \phi_{jm}X_j
$$

gdzie $\phi_{1m},  \phi_{2m}, \dots,  \phi_{pm}$ są pewnymi stałymi (parametrami) metody.

Stosując metodę najmniejszych kwadratów, znajdujemy parametry $\theta_0, \theta_1, \dots, \theta_M$ modelu regresji liniowej:

$$
y_i = \theta_0  +\sum_{m=1}^M\theta_mz_{im} + \epsilon_i, \ \ \ \ \ \ \ \ \ \ i = 1, \dots, n
$$

- Wymiar został zredukowany z $p+1$ do $M+1$
- Przy odpowiednim doborze stałych $\phi_{jm}$ taka redukcja wymiaru często poprawia jakość predykcji