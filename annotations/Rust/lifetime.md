[[rust]]
[[lifetime]]

A gente só precisa incluir as anotações de lifetime em situações bem específicas. Mas o lifetime já é presente em todas as referência, e é escopo onde essa referência continua sendo válida e geralmente já é implícito e inferido.

A principal função do lifetime é evitar as referências soltas (dangling reference), de maneira que os seus ponteiros apontam para endereço inválido (que não existe mais ou saiu do escopo). O compliador irá tentar identificar onde as referências se tornaram invalidadas usando borrow checker.

Mas precisamos fazer anotação de lifetime em algumas situações onde ficarão ambíguas.

A sintaxe para lifetime é `&'a`, onde `a` é um tipo de genérico. 
- Vale lembrar que a anotação de lifetime `'a` também aplica a seu retorno. Ou seja, pegará do parâmetro com menor lifetime.
# Elisão de lifetime

Há 3 regras onde nós não precisamos escrever explicitamente o lifetime, sendo elas:
- Caso a própria função tiver um ou mais parâmetro sem retorno, cada parâmetro recebe próprio parâmetro de lifetime.
	- `fn exemplo<'a>(x: &'a i32)` -> o parâmetro `x` recebe o parâmetro `&'a`
	- `fn exemplo2<'a, 'b>(x: &'a i32, y: &'b i32)` -> o parâmetro `x` recebe o parâmetro de lifetime de `&'a` e o parâmetro `y` recebe o parâmetro de lifetime de `&'b`, e assim por diante
	- Nesse caso, não há ambiguidade pois como não há retorno ambíguo, podemos inferir implicitamente para cada parâmetro
- Caso a função tiver **ÚNICO** parâmetro e com retorno **ÚNICO**, esse lifetime também é aplicado a parâmetro de retorno.
	- `fn exemplo3<'a>(x: &'a i32) -> &'a i32` -> onde temos o mesmo lifetime tanto para o parâmetro de entrada quanto a saída
- Caso a própria função tiver vários parâmetros de entrada, mas um deles é `&self` ou `&mut self` (que refere a próprio método), logo o lifetime do `self` será atribuído a todos os parâmetros de saída.

Segue o exemplo da terceira regra:
```Rust
struct Parser {
    input: String,
}

impl Parser {
    // O compilador infere que o retorno vive tanto quanto &self
    fn primeiro_token(&self) -> &str {
        &self.input[..self.input.find(' ').unwrap_or(self.input.len())]
    }
}
```
- Isso mostra implicitamente que o lifetime de `'a` do `self` também viverá 

# Uso de lifetime `'static`

É possível 