[[rust]]

É importante saber a diferença entre os `stacks` e `heaps` quando for escrever em Rust.

`Stacks` é como uma pilha de pratos em que baseia no princípio "Primeiro entra e primeiro sai", e sempre assume um tamanho fixo na memória.
- Adicionar o dado ao stack seria `pushing onto the stack` e remover seria `popping off the stack`

`Heaps` é como reservar um espaço na memória, assim como reserva as mesas no restaurante e nem sempre necessariamente está 100% cheio, assim como reservar para 8 pessoas na mesa com capacidade de 10 pessoas.
- Quando é criado, o programa cria um `pointer` (um apontador) que indica onde fica o `heap`

Sempre a manipulação envolvendo em `stacks` é muito mais rápido do que manipular num `heap` pois no `stack`, não há necessidade de seguir o `pointer`. Portanto, acessar um `heap` é mais lento pois envolve seguir o apontador.

# Regras de Ownership

Diferentemente de demais linguagem de programa, o Rust não tem próprio Garbage Collector. O Python o possui.
- Todos os valores em Rust tem dono;
- Só pode ter 1 dono ao mesmo tempo;
- Quando o dono sai do escopo, o valor é retirado.


Há diferença em comportamento entre os tipos de dados de tamanho conhecido (como i32, bool, float etc) e os de tamanho desconhecido como String.
- Os de tipo simples (i32, bool etc) são de tamanho fixo e portanto pode ser copiada usando `copy`
- E os que apresentam o tamanho variável depende do heap e nisso entra mais o ownership pois as cópias são mais caras para os heaps

Por exemplo, para os tipos mais simples ao fazer isso:
```rust
let x = 5;
let y = x;
```
- Isso significa que estamos copiando o valor e atribuindo ao y
- O X continua existindo

Mas para os tipos de tamanho variável como String:
```rust
let s1 = String::from("hello");
let s2 = s1;
```
- Isso significa que estamos só movendo o ponteiro + len e capacity do próprio heap
- O s1 deixa de existir, e o s2 passa ser o dono
- O heap continua existindo

Mas se quiser copiar, precisa fazer isso:
```rust
let s1 = String::from("hello");
let s2 = s1.clone();
```


No Rust, o escopo seria:
```rust
{
    let s = String::from("hello");
} // ← aqui o escopo acaba
```
- Todas as vezes que sai do escopo, uma variável como `s` deixa de existir e o Rust já convoca o método `drop( )` para tirar a variável e seu valor associado da memória, e assim liberar a memória

Caso uma variável seja reatribuída com novo valor como no exemplo:
```rust
let mut s = String::from("hello");
s = String::from("ahoy");
```
- O Rust já efetua o `drop(s)` para o valor antigo desta variável e agora assume novo valor.
- Na prática, o Rust cria uma nova instância de String para `ahoy` na memória, e o seu stack passa a apontar para a nova instância
- E a instância antiga de `hello` deixa de ser apontado e eventualmente deixa de existir.

No Python, caso o valor seja reatribuído como no exemplo abaixo:
```python
s = "exemplo"
s = "novo exemplo"
```
- Nesse caso, o valor antigo para a variável `s` ainda existe na memória até ser resolvido por garbage collector.
- Mas no caso do Rust, caso uma variável seja reatribuída com o novo valor, o valor antigo já é eliminada da memória com o `drop`

Ou seja, quando um valor perde o "ownership" ou dono, esse valor já é liberado da memória e não existe mais no Rust.

Vale lembrar que para os dados do tipo de Stack, o comportamento é um pouco diferente:
```Rust
    let x = 5;
    let y = x;

    println!("x = {x}, y = {y}");
```
- Nesse exemplo, para os dados mais simples, o comportamento por padrão é `clone`, diferentemente dos tipos que usam heaps como String e Vector.
- Os dados mais simples como os inteiros, float, booleanos e char possuem traço `copy` que permite esse tipo de comportamento

## Movendo o ownership e as funções 

O comportamento é semelhante caso passe as variáveis às funções, a depender do tipo de dados (se vai clonar ou vai passar valores), de modo semelhante à atribuição.

Para as variáveis com valores do tipo mais simples, ao passar à função, o Rust fará a cópia desta variável para a função. Mas para as variáveis do tipo que usa heap, o Rust passa o valor para a função e a variável deixa de ser dono deste valor. 

```rust
fn main() {
    let s1 = 1;
    let s2 = String::from("hello");

    function_example(s1);
    function_example2(s2);

    s1;
    s2; // inválido!
}



fn function_example(var: i32) -> i32{
    println!("{}",var);
    var
}

fn function_example2(var: String) -> String{
    println!("{}",var);
    var 
    
   }
```
- Nesse exemplo, para  `function_example`, como `s1` é do tipo mais simples, o comportamento padrão é copiar esse valor.
- Porém, para `function_example2`, como a variável `s2` é do tipo String, caso passe o valor para a função sem fazer o borrowing ou clone, `s2` deixa de existir e não pode ser usado depois.

Mas caso a função tiver return, isso também afeta a forma de como tratamos o ownership:
- Um return faz o valor passado à função possa voltar para a própria variável a qual passou:

```Rust
fn main() {
    let s2 = String::from("hello");
    
    let s2 = function_example2(s2);
}
fn function_example2(var: String) -> String{
    println!("{}",var);
    var
    
   }
```
- Nesse exemplo, `function_example2` tem um return, e quando a variável `s2` passa para a função, a variável perde dono e deixa de existir
- Quando a função tem return, é necessário atribuir a mesma variável ao `function_example2`, para que `s2`possa receber de volta.

## Borrowing e Reference

É possível passar os valores das variáveis às funções sem perder o seu ownership usando o borrow ou reference.

Uma referência é uma espécie de ponteiro apontando para o valor da variável, e a própria variável a qual passou não perde a propriedade deste valor.

```rust
fn main() {
    let s2 = String::from("hello");
    function_example_borrow(&s2);
    println!("{s2} existe");

}

fn function_example_borrow(s: &String){
    println!("{s}");
}
```
-  Observe que o uso `&` sinaliza o empréstimo, sem tomar a posse desse valor
- Isso significa que na prática, o Rust não efetua um `drop` desse valor, e isso faz com que esse novo valor seja uma referência ao original

Lembrando que as referências também são imutáveis por padrão, e não podemos ajustar os valores da própria referência.
- Ou seja, não podemos modificar algo que pegamos emprestado
- Também não precisamos devolver o valor para a variável original


Se a referência for mutável, a variável a qual emprestou deve ser mutável como no exemplo abaixo:
```rust
fn main() {
    let mut s2 = String::from("hello");
    function_example_borrow(&mut s2);
    println!("{s2} existe");

}

fn function_example_borrow(s: &mut String){
    s.push_str(", world");
    println!("{s}");
}
```

Porém uma referência mutável tem sua limitação. Não podemos colocar 2 referências mutáveis para uma variável ao mesmo tempo para evitar o "data race", como no exemplo abaixo:
```rust
fn main() {
    let mut s = String::from("hello");

    let r1 = &mut s;
    let r2 = &mut s;

    println!("{r1}, {r2}");
}
```
- Isso possibilita mutação, mas controlada e evita os bugs imprevisíveis e evita os diagnósticos mais difíceis.

Ou seja:
- Podemos ter várias referências imutáveis
- OU 1 referência mutável

Não podemos ter:
- 1 referência imutável e 1 referência mutável;
- 2 referências mutáveis.
- E assim por diante

## Referências soltas

No rust, nós não podemos referenciar a algo que não existe mais no escopo 
```rust
fn dangle() -> &String {
    let s = String::from("hello");
    &s
}
```
- No exemplo acima, quando nós tentamos referenciar `s` que deixou de ser dona deste valor `hello`, o Rust irá barrar 
- Isso ajuda a evitar os bugs imprevisíveis ou memórias inválidas


