## Typy Uczenia 
- z nadzorem - trenowanie modelu na danych, gdzie każde wejście ma prawidłowe wyjście
- bez nadzoru
- semi-nadzorowany
- ze wzmocnieniem

## Podstawowe pojęcia i notacja
- $x$ -  wejście (dane wejściowe nazywane są również cechami)
- $X$ - przestrzeń wejść
- $y$ - wyjście 
- $Y$ - przestrzeń wyjść
- $(x, y)$ - przykład
- $(x^{(i)}, y^{(i)}), i = 1, ..., m$ - ciąg uczący
- $h: X -> Y$ - hipoteza, funkcja opisująca zależność między danymi wejściowymi a danymi wyjściowymi

# Regresja Liniowa
Prosta regresja liniowa z jedną zmienną objaśniającą:
$$
\begin{equation} Y = \beta_0 + \beta_1X + \epsilon \end{equation}
$$
Mamy $n$ obserwacji:
$$
(x^{(1)}, y^{(1)}), (x^{(2)}, y^{(2)}), ..., (x^{(n)}, y^{(n)})
$$
Nasz model zakłada, że:
$$
y_i = \beta_0 + \beta_1x_i + \epsilon_i
$$

## Funkcja kosztu (loss function)

Funkcja kosztu ocenia, jak dobrze model przewiduje wyniki w porównaniu do rzeczywistych wartości. Im niższa wartość funkcji kosztu, tym lepiej hipoteza opisuje dane. 

Dla regresji liniowej funkcja kosztu może być dana wzorem:
$$ J(\mathbf {\theta }) = \frac{1}{2} \sum _{i=1}^{m} \left( h_\theta (x^{(i)}) - y^{(i)} \right)^2 $$
Jej pochodna cząstkowa wynosi: 
$$\frac{\partial }{\partial \theta _j } J(\theta ) = \sum _{i=1}^{m} \left( h_\theta (x^{(i)}) - y^{(i)} \right) x_j^{(i)} $$

### Gradient funkcji kosztu 
- Gradient funkcji koszu to wektor pochodnych cząstkowych funkcji kosztu $J(\theta)$ względem jej parametrów.
- Jest obliczany w jednym punkcje przestrzeni parametrów. 
- Jest to wektor wskazujący kierunek najszybszego wzrostu wartości funkcji.

### Spadek gradientu (Gradient descent)
- [Gradient Descent, Step-by-Step](https://www.youtube.com/watch?v=sDv4f4s2SB8&ab_channel=StatQuestwithJoshStarmer)
- Poruszając się w kierunku przeciwnym do gradientu, zmniejszamy wartość funkcji.
- Gradient descent jest algorytmem iteracyjnym, który używa gradientu funkcji kosztu, aby aktualizować parametry $\theta$ w kierunku minimalizacji kosztu
- Algorytm:
	1. **Inicjalizacja**: Przyjmij wartość początkową parametrów $\theta$.
	2. **Iteracja**: Powtarzaj aż zbiegniesz: $$\theta _{j} := \theta _j - \alpha \frac{\partial }{\partial \theta _j } J(\theta ) = \theta _j - \alpha\sum _{i=1}^{m} \left( h_\theta (x^{(i)}) - y^{(i)} \right) x_j^{(i)}$$gdzie $\alpha$ to współczynnik szybkości uczenia (learning rate).
	
- Gradient obliczany jest na podstawie całego zbioru danych w każdej iteracji, przy ogromnej ilości danych takie obliczenia są bardzo kosztowne.

### Gradient stochastyczny (Stochastic Gradient Descent)
- [Stochastic Gradient Descent, Clearly Explained!!!](https://www.youtube.com/watch?v=vMh0zPT0tLI&ab_channel=StatQuestwithJoshStarmer)
- Wersja stochastyczna algorytmu polega na aktualizowaniu parametrów po każdej prezentacji pojedynczego przykładu. 
- Jest to bardziej efektywne obliczeniowo.
- Algorytm:
	1. Zainicjuj $\theta_j$
	2. Powtarzaj aż zbiegniesz:
		- Wybierz losowy przykład $i$
		- Dla każdego $j$:$$\theta _{j} := \theta _j - \alpha\left( h_\theta (x^{(i)}) - y^{(i)} \right) x_j^{(i)}$$
### Równania normalne
- Gradientowy algorytm minimalizacji przydaje się w uczeniu sieci neuronowych. 
- W przypadku regresji liniowej można jednak obliczyć optymalne parametry analitycznie, korzystając z rachunków macierzowych.

**Macierzowy zapis funkcji kosztu Tworzymy macierz wejść:** 
$$ 
X =\begin{bmatrix} (x^{(1)})^T \\ \vdots \\ (x^{(m)})^T \end{bmatrix} $$ 
Tworzymy wektor wartości wyjściowych: $$ y = \begin{bmatrix} y^{(1)} \\ \vdots \\ y^{(m)} \end{bmatrix} $$ Funkcja kosztu w zapisie macierzowym: $$ J(\theta) = \frac{1}{2} (X\theta - y)^T (X\theta - y) $$ **Gradient funkcji kosztu Gradient funkcji kosztu wynosi:**$$ \nabla_{\theta} J(\theta) = X^T (X\theta - y) $$ **Optymalizacja parametrów Aby zminimalizować $J(\theta)$, przyrównujemy gradient do zera:** $$ X^T (X\theta - y) = 0 $$ Ostatecznie: $$ \theta = (X^T X)^{-1} X^T y $$
## Funkcja wiarygodności (likelihood function)
- Określa prawdopodobieństwo zaobserwowania ciągu uczącego w zależności od przyjętego $\theta$.
- Matematycznie, funkcję wiarygodności możemy zapisać jako:
	$$ L(\theta| X, Y) = P(Y | X, \theta)$$
- dla próby składającej się z $n$ obserwacji:
	$$ L(\theta| X, Y) = \prod_{i=1}^{n} P(y^{(i)} | x^{(i)}, \theta) = \prod_{i=1}^{n} \frac{1}{\sqrt{2\pi \sigma^2}} \exp \left( -\frac{(y^{(i)} - \theta^T x^{(i)})^2}{2\sigma^2} \right)$$
### Metoda największej wiarygodności
- Metoda największej wiarygodności polega znalezieniu takich wartości parametru $\theta$, które maksymalizują funkcję wiarygodności.
- A w zasadzie, które maksymalizują jej logarytm:
$\qquad$$$\begin{matrix}

l(\theta ) &=& \log (L(\theta )) \\

&=& \log \prod _{i=1}^m \frac{1}{\sqrt{2 \pi} \sigma } \exp \left( - \frac{ \left(y^{(i)} - \theta ^Tx^{(i)} \right)^2}{2 \sigma ^2} \right)\\

&=& \sum _{i=1}^m \log \frac{1}{\sqrt{2 \pi} \sigma } \exp \left( - \frac{ \left(y^{(i)} - \theta ^Tx^{(i)} \right)^2}{2 \sigma ^2} \right) \\

&=& m \log \frac{1}{\sqrt{2 \pi }\sigma } - \frac{1}{\sigma ^2} \cdot \frac{1}{2} \sum _{i=1}^m \left( y^{(i)} - \theta ^Tx^{(i)} \right)^2

\end{matrix}$$
- Zauważmy, że aby zmaksymalizować funkcję wiarygodności musimy zminimalizować wyrażenie $\frac{1}{2} \sum _{i=1}^m \left( y^{(i)} - \theta ^Tx^{(i)} \right)^2$, czyli wprowadzoną w poprzednim rozdziale funkcję kosztu $J(\theta )$.
# Pytania do wykładu
1. Co to jest hipoteza w uczeniu maszynowym?
2. Na czym polega uczenie z nadzorem?
3. Co to jest funkcja kosztu?
4. Wymień 3 algorytmy optymalizacji parametrów regresji liniowej.
5. Co to jest funkcja wiarygodności?
6. Na czym polega metoda największej wiarygodności?
7. Jak jest zbudowany ciąg uczący dla regresji liniowej?