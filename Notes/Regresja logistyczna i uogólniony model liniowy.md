# Regresja logistyczna
- Stosowana do problemów klasyfikacyjnych, gdzie zmienna zależna jest dyskretna (np. 0 lub 1)
### Hipoteza:
- Hipoteza w regresji logistycznej jest oparta na funkcji logistycznej (sigmoidalnej):
$$h_\theta(x) = g(\theta^T x) = \frac{1}{1+ \exp(-\theta^T x)}$$
![[Pasted image 20250117134528.png]]

- Funkcja ta jest wybierana ze względu na jej naturalne właściwości i wygodną pochodną: 
$$ g'(s) = ... = g(s)(1-g(s)) $$
![[Pasted image 20250117134545.png]]
### Hiperpowierzchnia podejmowania decyzji
- Granica decyzyjna w regresji logistycznej jest określona przez równanie:$$ h_{\theta}(x) = \frac{1}{2} $$
	co odpowiada: $$\theta^Tx = 0$$
- Dla dwuwymiarowej przestrzeni cech mamy: $$\theta_0 + \theta_1x_1 + \theta_2x_2 = 0$$
- Przekształcając na równanie prostej: $$x_2 = -\frac{\theta_1}{\theta_2}x_1 -\frac{\theta_0}{\theta_2}$$![[Pasted image 20250117134609.png]]
## Estymacja parametrów
- Sigmoida ma zbiór wartości $(0, 1)$, zatem jej wartość możemy traktować jako prawdopodobieństwo przynależności do jednej z klas (np. klasa y = 1): $$ P(y = 1|x, \theta) = h_\theta(x)$$Wtedy:$$  P(y = 0|x, \theta) = 1 - h_\theta(x) $$
- Co możemy zapisać w zwartej formie: $$P(y|x;\theta) = \left(h_\theta(x)\right)^y \left(1-h_\theta(x)\right)^{1-y}$$
### Funkcja wiarygodności
- Zakładamy, że przykłady zbioru uczącego są od siebie niezależne
- Wtedy prawdopodobieństwo zaobserwowania całego zbioru uczącego możemy wyrazić jako: $$P(Y|X;\theta) = \prod_{j=1}^m P(y^{(j)}|x^{(j)};\theta)$$
- Funkcję tą nazywamy funkcją wiarygodności $L(\theta)$:$$L(\theta)= \prod_{j=1}^m P(y^{(j)}|x^{(j)};\theta) =

\prod_{j=1}^m \left(h_\theta(x^{(j)})\right)

^{y^{(j)}} \left(1-h_\theta(x^{(j)})\right)^{1-y^{(j)}}$$
- Aby uprościć obliczenia, posługujemy się funkcją log-wiarygodności (logarytm przekształca iloczyny w sumy): $$l(\theta) = \log L(\theta) = \sum_{j=1}^m y^{(j)} \log h_{\theta}(x^{(j)}) + (1 - y^{(j)}) \log (1 - h_{\theta}(x^{(j)}))$$
- Dobre parametry $\theta$ to te, dla których prawdopodobieństwo zaobserwowania ciągu uczącego jest największe. Aby je znaleźć należy zmaksymalizować funkcję wiarygodności. 
- $h_{\theta}(x) = g(\theta^Tx)$ i  $g'(s) = g(s)(1-g(s))$, zatem:
$$
\frac{\partial}{\partial \theta_i} l(\theta) = ... = \sum_{j=1}^m (y^{(j)}-h_\theta(x^{(j)}))x_i^{(j)}
$$
- Zatem aby zwiększać funkcję wiarygodności powinniśmy parametry zmieniać zgodnie z obliczoną pochodną: $$\theta_i^{(j+1)} :=\theta_i^{(j)} + \alpha \sum_{j=1}^m (y^{(j)} - h_\theta( x^{(j)}) )x_i^{(j)} $$czyli: $$\theta_i^{(j+1)} :=\theta_i^{(j)} - \alpha \sum_{j=1}^m (h_\theta( x^{(j)}) -y^{(j)} )x_i^{(j)} $$
- Dostaliśmy taką samą regułę zmiany parametrów jak przy gradientowej minimalizacji funkcji kosztu w [[Wstęp i regresja liniowa]].

# Rodzina rozkładów wykładniczych w uogólnione modele liniowe
- To be continued...
# Pytania do wykładu
1. Opisz przestrzeń wyjść w regresji logistycznej.
2. Podaj postać hipotezy w regresji logistycznej.
3. Z jakiego założenia korzystamy aby móc zapisać funkcję wiarygodności dla regresji w postaci: $L(\theta) = \prod_{i=1}^{n} P(y^{(i)} | x^{(i)}, \theta)$
4. Dlaczego zwykle posługujemy się funkcją log-wiarygodności?
5. Podaj słownie istotę zasady największej wiarygodności.
6. Jaką postać hipotezy postulujemy dla uogólnionych modeli liniowych?
7. Gdzie przejawia się liniowość uogólnionych modeli linowych?
8. Jak interpretujemy wartości zwracane przez funkcję softmax dla regresji wielorakiej?