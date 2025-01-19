Alternatywne procedury dopasowywania mogą zapewnić lepszą dokładność przewidywania oraz interpretowalność modelu:

- dokładność przewidywania
    - Jeśli liczba obserwacji (n) jest znacznie większa niż liczba zmiennych (p), estymaty najmniejszych kwadratów mają niską wariancję i dobrze działają na danych testowych.
    - Gdy n nie jest znacznie większe od p, istnieje ryzyko nadmiernego dopasowania, co pogarsza wyniki na danych testowych.
    - Jeśli p > n, brak unikalnych estymat prowadzi do zerowego błędu na danych treningowych, ale bardzo słabej wydajności na danych testowych z powodu wysokiej wariancji.
    
    Poprzez ograniczenie (constraining) lub zmniejszenie (shrinking) szacowanych współczynników, możemy często znacznie zredukować wariancję kosztem niewielkiego wzrostu obciążenia. Może to znacznie poprawić dokładność przewidywań dla nowych obserwacji.
    
- interpretowalność modelu
    - Niektóre lub wiele zmiennych używanych w modelu regresji wielorakiej w rzeczywistości nie jest związanych z odpowiedzią.
    - Uwzględnienie takich nieistotnych zmiennych prowadzi do niepotrzebnej złożoności modelu.
    
    Usuwając te zmienne, czyli ustawiając odpowiednie estymaty współczynników na zero, możemy uzyskać model, który jest łatwiejszy do interpretacji.
    

## Best Subset Selection - metoda siłowa: wyczerpujące przeszukiwanie

1. Niech  $M_0$ oznacza model zerowy, który nie zawiera żadnych predyktorów. Ten model po prostu przewiduje średnią próby dla każdej obserwacji.
2. Dla $k = 1, 2, \ldots, p$ :
    1. Dopasuj wszystkie $\binom{p}{k}$ modele z dokładnie $k$ predyktorami.
    2. Wybierz najlepszy spośród tych $\binom{p}{k}$ modeli i nazwij go $M_k$. Tutaj najlepszy jest zdefiniowany jako mający najmniejszy RSS lub równoważnie największy $R^2$.
3. Wybierz jeden najlepszy model spośród  $M_0, \ldots, M_p$  używając błędu predykcji na zbiorze walidacyjnym, $C_p$ (AIC), BIC lub skorygowanego $R^2$. Można również użyć metody walidacji krzyżowej.

Uwaga: Złożoność wykładnicza $(O(2^p))$.

## Forward Stepwise Selection - algorytm zachłanny: wyszukiwanie w przód

1. Niech  $M_0$ oznacza model zerowy, który nie zawiera żadnych predyktorów. Ten model po prostu przewiduje średnią próby dla każdej obserwacji.
2. Dla $k = 1, 2, \ldots, p -1$:
    1. Rozważ wszystkie modele $p-k$, które dodają jeden dodatkowy predyktor do modelu $M_k$.
    2. Wybierz najlepszy spośród tych $p-k$ modeli i nazwij go  $M_{k+1}$. Tutaj najlepszy jest zdefiniowany jako mający najmniejszy RSS lub równoważnie największy $R^2$.
3. Wybierz jeden najlepszy model spośród  $M_0, \ldots, M_p$  używając błędu predykcji na zbiorze walidacyjnym, $C_p$ (AIC), BIC lub skorygowanego $R^2$. Można również użyć metody walidacji krzyżowej.

Złożoność:   $1 + p(p+1)/2$

Algorytm ten może nie znaleźć najlepszego, optymalnego podzbioru, gdyż jest zależny od kolejności dokładania zmiennych. 

## Backward Stepwise Selection - algorytm zachłanny: wyszukiwanie wstecz

1. Niech $M_p$ oznacza pełen model, który zawiera wszystkie $p$ predyktory.
2. Dla $k = p, p-1, \ldots, 1$:
    1. Rozważ wszystkie modele $k$, które zawierają wszystkie oprócz jednego z predyktorów w $M_k$, łącznie $k-1$ predyktorów.
    2. Wybierz najlepszy spośród tych $k$ modeli i nazwij go $M_{k-1}$. Tutaj najlepszy jest zdefiniowany jako mający najmniejszy RSS lub równoważnie największy $R^2$.
3. Wybierz jeden najlepszy model spośród $M_0, \ldots, M_p$ używając błędu predykcji na zbiorze walidacyjnym,  $C_p$  (AIC), BIC lub skorygowanego $R^2$. Można również użyć metody walidacji krzyżowej.

Złożoność:   $1 + p(p+1)/2$

Algorytm również nie musi znaleźć najlepszego optymalnego modelu

Nie działa w przypadku, gdy p > n

## Wybór optymalnego modelu

Aby wybrać najlepszy model w odniesieniu do błędu testowego, musimy oszacować ten błąd testowy. Istnieją dwa popularne podejścia:

- Możemy pośrednio oszacować błąd testu, dokonując korekty błędu szkolenia, aby uwzględnić obciążenie spowodowane nadmiernym dopasowaniem.
- Możemy bezpośrednio oszacować błąd testu, stosując metodę zestawu walidacyjnego lub metodę walidacji krzyżowej.

### $C_p$, AIC, BIC oraz poprawione $R^2$

Błąd na zbiorze treningowym zmniejszy się, gdy w modelu zostanie uwzględnionych więcej zmiennych, ale błąd testu niekoniecznie. Dlatego, treningowe RSS oraz treningowy $R^2$ nie mogą być użyte w celu selekcji najlepszego modelu. 

Przypomnienie:

$$
RSS = \sum_{i=1}^n(y_i-\hat{y}_i)^2
$$

$$
R^2 = 1 - \frac{RSS}{TSS}
$$

dla $TSS  = \sum_{i=1}^n(y_i-\bar{y})^2$ mierzącego całkowitą wariancję

**$C_p$ Mallowa**

Dla dopasowanego modelu najmniejszych kwadratów zawierającego $d$ predyktorów oraz o estymowanej wariancji błędu $\epsilon$ związanego z odpowiedzią w modelu liniowym $\hat{\sigma}^2$:

$$
C_p = \frac{1}{n}(RSS+2d\hat{\sigma}^2)
$$

- im mniejsze $C_p$  tym lepiej
- polega na dopisaniu kary do RSS za liczbę wybranych predyktorów
- stosujemy tylko w przypadku regresji linowej

**Akaike information criterion (AIC)**

AIC jest zdefiniowane dla metod estymowanych metodą największej wiarygodności:

$$
AIC = 2d - 2log(\hat{L})
$$

gdzie: $d$ to liczba estymowanych parametrów modelu, $\hat{L}$ to maksymalna wartość funkcji wiarygodności.

- im mniejsze AIC tym lepiej
- większy log likelihood oznacza lepsze dopasowanie
- dodana kara za złożoność modelu

Dla regresji liniowej przy założeniu normalnego rozkładu $\epsilon$, AIC odpowiada $C_p$.

**Bayesian information criterion (BIC)**

Podobnie jak AIC, wprowadzone dla metod estymowanych metodą największej wiarygodności:

$$
BIC = log(n)d - 2log(\hat{L})
$$

- im mniejsze BIC tym lepiej
- silniejsza kara za liczbę wybranych predyktorów niż w przypadku AIC

**Poprawione $R^2$**

$$
adj. R^2 = 1-\frac{RSS/(n-d-1)}{TSS/(n-1)}
$$

- im większy $adj.R^2$ tym lepiej
- ze wzrostem liczby predyktorów $RSS/TSS$ maleje, ale rośnie $(n-1)/(n-d-1)$
- w przeciwieństwie do $C_p$, AIC i BIC, które mają solidne podstawy statystyczne, $adj. R^2$ jest heurystyczną poprawką