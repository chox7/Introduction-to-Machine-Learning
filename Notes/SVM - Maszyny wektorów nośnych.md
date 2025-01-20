- [SVM - THE MATH YOU SHOULD KNOW](https://www.youtube.com/watch?v=05VABNfa1ds&ab_channel=CodeEmporium)



- Na zbiór uczący patrzymy jako na zbiór punktów w przestrzeni cech. Konstrukcja klasyfikatora polega na znalezieniu hiperpowierzchni możliwie dobrze separującej elementy oznaczone różnymi etykietkami. 
- Na potrzeby SVM przyjmujemy: 
$$ \begin{equation} 
h_{w,b}(x) = g(w^Tx + b) = \lbrace \begin{array} {rcl} 1 & dla & w^{T}x+b \ge 0 \\ -1 & dla & w^{T}x+b < 0 \\ \end{array}
\end{equation} $$
## Marginesy funkcjonalne i geometryczne
### Marginesy funkcjonalne

Dla przykładu ze zbioru uczącego $(x^{(j)},y^{(j)})$ definiujemy margines funkcjonalny jako: $$\begin{equation} 
\qquad
{\hat{\gamma}}\;\; ^{(j)} = y^{(j)}(w^{T}x^{(j)} + b)
\end{equation}$$Zauważmy, że:
* dla $y^{(j)}=1$ mamy duży margines funkcjonalny jeśli $w^{T}x^{(j)} +b$ jest dużą dodatnią liczbą.
* dla $y^{(j)}=-1$ mamy duży margines funkcjonalny jeśli $w^{T}x^{(j)} +b$ jest dużą ujemną liczbą.
* Ponadto jeśli klasyfikacja jest prawidłowa to margines funkcjonalny jest dodatni.

**Problem skalowania** $w$ i $b$ - margines funkcjonalny można sztucznie zwiększyć, mnożąc  $w$ i $b$ przez tę samą, dużą liczbę $k$, ponieważ:
$$\begin{equation}
\hat{\gamma}^{(j)} = y^{(j)} (k \cdot w^T x^{(j)} + k \cdot b) = k \cdot \hat{\gamma}^{(j)} 
\end{equation}$$ 
Aby to zneutralizować , normalizujemy $w$ i $b$: 
$$ \begin{equation} 
w\leftarrow \frac{w}{\|w\|}, \quad b \leftarrow \frac{b}{\|w\|}
\end{equation}$$

Margines funkcjonalny dla całego zbioru uczącego definiuje się jako najmniejszy margines funkcjonalny spośród wszystkich przykładów w zbiorze. Formalnie: $$\hat{\gamma} = \min_{j=1,\dots,m} \hat{\gamma}^{(j)} = \min_{j=1,\dots,m} \left( y^{(j)} (w^T x^{(j)} + b) \right)$$\begin{equation}

### Marginesy geometryczne

Margines geometryczny $\gamma^{(j)}$  dla pojedynczego punktu  $x^{(j)}$  to najmniejsza odległość od punktu do hiperpowierzchni rozdzielającej  $w^T x + b = 0$ . Aby to obliczyć, stosujemy następujące kroki:

Hiperpowierzchnia separująca jest zdefiniowana równaniem: 
$$\begin{equation}  
w^T x + b = 0
\end{equation}$$ 
Punkt  $x^{(j)}$  przesuwamy w kierunku wektora normalnego  $\frac{w}{\|w\|}$ , aż znajdzie się na hiperpowierzchni. Przesunięcie punktu opisuje się jako: 
$$\begin{equation}
x^{(j)} - \gamma^{(j)} \frac{w}{\|w\|}
\end{equation}$$
Jeśli przesunięty punkt leży na hiperpowierzchni, to spełnia równanie: 
$$\begin{equation}w^T \left( x^{(j)} - \gamma^{(j)} \frac{w}{\|w\|} \right) + b = 0
\end{equation}$$
Rozwijając równanie: 
$$\begin{equation}
w^T x^{(j)} - \gamma^{(j)} w^T \frac{w}{\|w\|} + b = 0
\end{equation}$$
$$\begin{equation}
w^T x^{(j)} + b = \gamma^{(j)} \|w\|
\end{equation}$$ 
$$\begin{equation}
\gamma^{(j)} = \frac{w^T x^{(j)} + b}{\|w\|}
\end{equation}$$
Dla uwzględnienia obu klas $( y^{(j)} = \pm 1 )$, możemy zapisać ogólną formułę: 
$$\begin{equation}
\gamma^{(j)} = y^{(j)} \frac{w^T x^{(j)} + b}{\|w\|}
\end{equation}$$
Margines geometryczny dla całego zbioru uczącego definiujemy jako najmniejszy margines geometryczny spośród wszystkich przykładów w zbiorze: $$\gamma = \min_{j=1,\dots,m} \gamma^{(j)}$$
### Związek marginesu geometrycznego z marginesem funkcjonalnym

Jeśli wektor  $w$  jest znormalizowany $( \|w\| = 1 )$, to margines funkcjonalny i margines geometryczny są równe, ponieważ:
$$\begin{equation}
\gamma^{(j)} = \frac{\hat{\gamma}^{(j)}}{\|w\|} = \hat{\gamma}^{(j)}
\end{equation}$$

## Klasyfikator SVM 
 
Podstawowa wersja SVM (Support Vector Machine) dla problemów liniowo separowalnych. Celem jest znalezienie hiperpowierzchni, która **maksymalizuje minimalny margines geometryczny**, czyli:  
$$\begin{equation}
\max_{w, b} \min_{j \in \{1, \dots, m\}} \frac{y^{(j)} \left(w^T x^{(j)} + b\right)}{\|w\|}
\end{equation}$$
Dążymy do tego, aby punkty były jak najdalej od hiperpowierzchni decyzyjnej, gwarantując, że klasy są dobrze separowane.

### Wersja 1: Maksymalizacja marginesu geometrycznego

Pierwotny problem optymalizacyjny można sformułować jako: 
$$\begin{equation}
\max_{w, b} \, \gamma
\quad \text{p.w.} \quad y^{(j)} \left( w^T x^{(j)} + b \right) \geq \gamma, \, j=1,\dots,m, \quad \|w\| = 1
\end{equation}$$
• Maksymalizujemy  $\gamma$ , minimalny margines geometryczny.
• Warunek  $\|w\| = 1$  zapewnia, że margines geometryczny jest równy funkcjonalnemu.
• Problem nie jest wypukły, ponieważ ograniczenie $\|w\| = 1$  tworzy sferę, a nie przestrzeń liniową.

### Wersja 2: Przeformułowanie problemu

Rozważając zależność między marginesami  $\gamma = \frac{\hat{\gamma}}{\|w\|}$ , możemy sformułować: 
$$\begin{equation}
\max_{w, b} \, \frac{\hat{\gamma}(w, b)}{\|w\|}
\quad \text{p.w.} \quad y^{(j)} \left( w^T x^{(j)} + b \right) \geq \hat{\gamma}, \, j=1,\dots,m
\end{equation}$$
- Problem staje się bardziej wygodny, ale funkcja celu  $\frac{\hat{\gamma}}{\|w\|}$  jest wciąż trudna do optymalizacji.
### Wersja 3: Skalowanie marginesu funkcjonalnego

Dzięki możliwości skalowania  $w$  i  $b$ , przyjmujemy  $\hat{\gamma} = 1$ . Po tej normalizacji problem sprowadza się do minimalizacji normy  $w$ , co jest równoważne maksymalizacji marginesu geometrycznego: 
$$\begin{equation}
\min_{w, b} \, \|w\|^2
\quad \text{p.w.} \quad y^{(j)} \left( w^T x^{(j)} + b \right) \geq 1, \, j=1,\dots,m
\end{equation}$$
- Funkcja celu  $\|w\|^2$  jest wypukła.
- Warunki  $y^{(j)} \left( w^T x^{(j)} + b \right) \geq 1$  są liniowe, co sprawia, że problem jest wypukły z więzami.


## Mnożniki Lagrange'a

Metoda mnożników Lagrange'a to uniwersalna technika rozwiązywania problemów optymalizacyjnych z więzami. Można ją przedstawić następująco:

- Problem optymalizacyjny: 
$$\begin{equation}
\min_{w} f(w) \quad \text{p.w.:} \quad h_i(w) = 0, \; i = 1, \ldots, l
\end{equation}$$
- Lagrangian: 
$$\begin{equation}
\mathcal{L}(w, \beta) = f(w) + \sum_{i=1}^l \beta_i h_i(w)
\end{equation}$$ 
gdzie $\beta_i$ to mnożniki Lagrange’a.

- Rozwiązywanie problemu:
	Znalezienie ekstremum polega na spełnieniu warunków:
$$\begin{equation}
\frac{\partial \mathcal{L}}{\partial w_i} = 0 \quad \text{i} \quad \frac{\partial \mathcal{L}}{\partial \beta_i} = 0
\end{equation}$$
### Więzy w postaci nierówności

- Metodę można rozszerzyć na problemy z więzami nierównościowymi:
$$\begin{equation}
\min_{w} f(w) \quad \text{p.w.:} \quad g_i(w) \leq 0, \; h_i(w) = 0
\end{equation}$$
- Uogólniony lagrangian przyjmuje postać:
$$\begin{equation}
\mathcal{L}(w, \alpha, \beta) = f(w) + \sum_{i=1}^k \alpha_i g_i(w) + \sum_{i=1}^l \beta_i h_i(w)
\end{equation}$$ 
gdzie $\alpha_i \geq 0$.


### Problem pierwotny i dualny

- **Definicja problemu pierwotnego**: $$ \theta _{p}(w) = \max _{\alpha ,\beta :\alpha _{i} \ge 0} \mathcal {L}(w,\alpha ,\beta )$$$$ p^{*} = \min _{w} \theta _{p}(w) = \min _{w} \max _{\alpha ,\beta : \alpha _{i }\ge 0 } \mathcal {L}(w,\alpha ,\beta )$$
- **Definicja problemu dualnego**: 
$$\begin{equation}
\theta_d(\alpha, \beta) = \min_{w} \mathcal{L}(w, \alpha, \beta)
\end{equation}$$ 
$$\begin{equation}
d^{*} = \max _{\alpha ,\beta : \alpha
_{i}\ge 0} \theta _{d}(\alpha, \beta) = \max _{\alpha ,\beta : \alpha _{i}\ge 0} \min _{w} \mathcal {L}(w,\alpha ,\beta )
\end{equation}$$
- **Relacja między problemem pierwotnym i dualnym**: 
$$\begin{equation}
d^* \leq p^* 
\end{equation}$$

### Warunki Karusha-Kuhna-Tuckera (KKT)

Równość $d^* = p^*$ zachodzi pod warunkami:

• $f(w)$ i $g_i(w)$ są wypukłe,
• $h_i(w)$ są afiniczne $(h_i(w) = a_i^T w + b_i)$,
• Istnieje w, dla którego $g_i(w) < 0$.


 Pod tymi warunkami istnieją $𝑤∗$, $𝛼∗$, $𝛽∗$, dla których $p^{*}=d^{*}=\mathcal {L} (w^{*},\alpha ^{*},\beta ^{*})$. Ponadto  $𝑤∗$, $𝛼∗$, $𝛽∗$ spełniają:

1. $\frac{\partial \mathcal{L}}{\partial w_i} = 0$,
2. $\frac{\partial \mathcal{L}}{\partial \beta_i} = 0$,
3. $\alpha_i^* g_i(w^*) = 0$,
4. $g_i(w) \leq 0, \; \alpha_i \geq 0$.

Prawdziwe jest też twierdzenie odwrotne. Jeśli jakieś parametry 𝑤∗,𝛼∗,𝛽∗ spełniają warunki KKT to są też rozwiązaniem problemu pierwotnego i dualnego.

## Klasyfikator SVM a Lagrange

Problem optymalizacyjny klasyfikatora SVM wyraziliśmy następująco: 
$$\begin{equation}
\min_{w, b} \frac{1}{2} \, \|w\|^2
\quad \text{p.w.} \quad y^{(j)} \left( w^T x^{(j)} + b \right) \geq 1, \, j=1,\dots,m
\end{equation}$$
Przekształcając do postaci pasującej do formalizmu uogólnionej metody Lagrange'a: 
$$\begin{equation}
\min_{w, b} \frac{1}{2} \, \|w\|^2
\quad \text{p.w.} \quad g_{j}(w,b) = 1 - y^{(j)}(w^{T}x^{(j)}+b) \le 0, \quad j= 1, \dots ,m
\end{equation}$$
Lagrangian dla tego problemu wygląda tak:
$$\begin{equation}
\mathcal {L}(w,b,\alpha ) = \frac{1}{2}||w||^{2} + \sum _{j=1}^{m} \alpha _{j}g_j(w,b)=
\end{equation}$$
$$\begin{equation}
= \frac{1}{2}||w||^{2} + \sum _{j=1}^{m} \alpha _{j}\left[1 - y^{(j)}(w^{T}x^{(j)}+b) \right]=
\end{equation}$$
$$\begin{equation}
=\frac{1}{2}||w||^{2} - \sum _{j=1}^{m} \alpha _{j}\left[ y^{(j)}(w^{T}x^{(j)}+b) -1\right]
\end{equation}$$
### Przejście do postaci dualnej
$$\begin{equation}
\mathcal{L}(w, b, \alpha) = \frac{1}{2} \|w\|^2 - \sum_{j=1}^{m} \alpha_j \left[ y^{(j)} \left(w^T x^{(j)} + b\right) - 1 \right]
\end{equation}$$
**Krok 1: Minimalizacja względem $w$ i $b$**
- Pochodna względem $w$: 
$$\begin{equation}
\nabla_w \mathcal{L}(w, b, \alpha) = w - \sum_{j=1}^{m} \alpha_j y^{(j)} x^{(j)} = 0 
\end{equation}$$ Stąd, po przekształceniu: 
$$\begin{equation}
w^* = \sum_{j=1}^{m} \alpha_j y^{(j)} x^{(j)} 
\end{equation}$$
- Pochodna względem $b$: 
$$\begin{equation}
\nabla_b \mathcal{L}(w, b, \alpha) = \sum_{j=1}^{m} \alpha_j y^{(j)} = 0 
\end{equation}$$
**Krok 2: Podstawienie $w^*$ do Lagrangiana**
- Norma $w^*$ jest równa: 
$$\begin{equation}
\|w^*\|^2 = \left\| \sum_{j=1}^{m} \alpha_j y^{(j)} x^{(j)} \right\|^2 = \sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle 
\end{equation}$$
- Po podstawieniu do funkcji Lagrangiana, uzyskujemy: 
$$\begin{equation}
\mathcal{L}(w^*, b, \alpha) = \frac{1}{2} \sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle - \sum_{j=1}^{m} \alpha_j \left[ y^{(j)} \left( \sum_{i=1}^{m} \alpha_i y^{(i)} \langle x^{(i)}, x^{(j)} \rangle + b \right) - 1 \right] = 
\end{equation}$$
$$\begin{equation}
= \frac{1}{2} \sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle - \sum_{j=1}^{m} \alpha_j y^{(j)} \left( \sum_{i=1}^{m} \alpha_i y^{(i)} \langle x^{(i)}, x^{(j)} \rangle + b \right) + \sum_{j=1}^{m} \alpha_j = 
\end{equation}$$ 
$$\begin{equation}
= \frac{1}{2} \sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle - \sum_{j=1}^{m} \alpha_j y^{(j)} \sum_{i=1}^{m} \alpha_i y^{(i)} \langle x^{(i)}, x^{(j)} \rangle - b\sum_{j=1}^{m} \alpha_j y^{(j)}  + \sum_{j=1}^{m} \alpha_j = 
\end{equation}$$ 
$$\begin{equation}
= \frac{1}{2} \sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle - \sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle - b\sum_{j=1}^{m} \alpha_j y^{(j)} + \sum_{j=1}^{m} \alpha_j =
\end{equation}$$ 
$$\begin{equation}
= -\frac{1}{2}\sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle - b\sum_{j=1}^{m} \alpha_j y^{(j)}  + \sum_{j=1}^{m} \alpha_j
\end{equation}$$
- Z warunku KTT wynika $\sum_{j=1}^{m} \alpha_j y^{(j)} = 0$, zatem: $$ \mathcal{L}(w^*, b, \alpha) = \sum_{j=1}^{m} \alpha_j -\frac{1}{2}\sum_{i,j=1}^{m} \alpha_i \alpha_j y^{(i)} y^{(j)} \langle x^{(i)}, x^{(j)} \rangle$$
**Krok 3: Dualny problem optymalizacyjny**
Funkcja $\mathcal{L}(w^*, b, \alpha)$ jest teraz funkcją tylko w zmiennych $\alpha_j$, a naszym celem jest jej zmaksymalizowanie, przy zachowaniu odpowiednich ograniczeń. Ostateczny dualny problem optymalizacyjny zapisujemy jako: $$\max_{\alpha} \left( \sum_{j=1}^{m} \alpha_j - \frac{1}{2} \sum_{i,j=1}^{m} y^{(i)} y^{(j)} \alpha_i \alpha_j \langle x^{(i)}, x^{(j)} \rangle \right)$$
Pod warunkiem:
- $\alpha_j \geq 0, \quad j = 1, \dots, m$
- $\sum_{j=1}^{m} \alpha_j y^{(j)} = 0$

Spełnione są warunki KKT, zatem rozwiązanie tego problemu dualnego jest też rozwiązaniem naszego problemu pierwotnego.


Po rozwiązaniu problemu dualnego SVM otrzymujemy optymalne wartości mnożników Lagrange’a $\alpha^*_j$. Wartość $\alpha^*_j > 0$ wskazuje, że odpowiadający mu punkt $(x^{(j)}, y^{(j)})$ jest wektorem nośnym. **(wektory nośne - przykłady położone najbliżej hiperpowierzchni decyzyjnej)**.

Zatem podstawiając $\alpha^*_j$:
$$\begin{equation}
w^* = \sum_{j=1}^{m} \alpha^*_j y^{(j)} x^{(j)}
\end{equation}$$ 
$$\begin{equation}
b^* = -\frac{1}{2} \left( \max_{j : y^{(j)} = -1} w^* \cdot x^{(j)} + \min_{j : y^{(j)} = 1} w^* \cdot x^{(j)} \right)
\end{equation}$$

# Pytania do wykładu
1. Algorytm SVM polega na ___ marginesów geometrycznych.
2. Czy margines geometryczny danego przykładu można zmienić przez mnożenie przez skalar?
3. Dodatnia wartość marginesu funkcjonalnego świadczy o ___ .
4. Margines geometryczny dla zbioru uczącego to: ___  z marginesów otrzymanych dla każdego z przykładów.
5. Co gwarantuje warunek: $$ y^{(j)}(w^{T}x^{(j)} + b) \geq 1,  j = 1,...,m$$ w trzeciej wersji problemu optymalizacyjnego SVM? 
6. Problem pierwotny dla uogólnionego Lagrangianu polega na najpierw  ___ względem ___ , a następnie na ___ względem ___ .
7. Czy parametry uogólnionego Lagrangianu spełniające warunki KKT są rozwiązaniem problemu pierwotnego?
8. Czym są wektory nośne?
9. Czy w technice SVM mapowanie wejścia do więcej wymiarowej przestrzeni wykonujemy w sposób jawny?
10. Co robi funkcja jądrowa? Jaką wartość zwraca dla wektorów, które są do siebie podobne? Czego ta funkcja jest miarą?
11. Czy warunek: "jeśli mamy jakieś mapowanie $\phi$ i związane z nim jądro $K$ to macierz jądra jest symetryczna i dodatnio określona" jest warunkiem wystarczającym aby $K$ była jądrem?
12. Czy metodę optymalizacji osiowej można zastosować wprost do problemu SVM?