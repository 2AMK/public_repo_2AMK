[[rust]]

No Rust, temos as expressões condicionais, bem como laços (loops), assim como as outras lingaugens de programação.

# Ifs
A expressão de `if`, `else` e `else if` são utilizadas pelo Rust.
- Mas vale lembrar que a condição nessas expressões devem ser no formato booleano.
- Ou seja as expressões devem retornar true ou false.

E por padrão, os `if` no Rust, diferentemente do python, são expressões que retornam valores.
- O Python considera `if` como statement, e por padrão não retorna valor e precisa atrelar o valor à variável
- Mas no Rust, o `if` é uma expressão e pode retornar valores

```rust
fn main() {
    let result = temperatura(100);
    println!("Result: {}", result);
}

fn temperatura(temperatura: i32) -> String {
    let resultado = if temperatura > 30 {"Está quente!"} else {"Está frio!"};
    resultado.to_string()
}
```
- Nesse exemplo acima mostra que os dois lados da expressão deve ser do mesmo tipo, senão dá erro;
- E também o If é uma expressão, e atua como parte de um pipeline de transformação de dados.

# Loops

No rust, tem 3 tipos de loops: `loop`, `while` e `for`

## loop

Os `loop` do Rust é "equivalente" a Python `while True`, em que é um loop infinito, porém pode ser controlado manualmente usando o `break`. Veja o exemplo abaixo

```rust
fn contagem_dez(mut num: i64) -> () {
    loop{
        println!("{}", num);
        if num >= 10 {break};
        num += 1
    }
    println!("Fim!");
}
```
- Nessa função, o loop é quebrado caso o número chegar a 10

E também o `loop` também é uma expressão, diferentemente de outras linguagens!
```rust
fn loop_retorna_valor() {
    let mut num: i32 = 0;
    let result = loop {
        num += 1;
        if num == 10 {
            break num;
        }
    };
    println!("Result: {}", result);
    println!("Num: {}", num);
    // Result: 10
    // Num: 10
    for num in 0..10 {
        println!("Num: {}", num);
    }
}
```
- No exemplo acima, mostra que o loop pode retornar um valor, algo que não tem nas outras linguagens de programação como Python (no Python, não é possível atribuir diretamente o valor a um resultante de um loop)


## while

É bem semelhante ao Python, em que caso while retorne como verdadeiro, o programa quebra o laço.
```rust
fn while_contagem () {
    let mut num = 0;
    while num <= 100 {
        println!("Num: {}", num);
        num += 1
    }
}
```

## for

É possível iterar sobre os arrays (de modo semelhante no Python):
```rust
fn for_contagem() {
    let a = [0, 1, 2, 3, 4, 5];
    for element in a{
        println!("Element: {}", element);
    }
}
```

Assim como é possível usar o range (intervalo):
```rust

fn range_contagem_exclusivo() {
    for num in 0..10 {
        println!("Num: {}", num);
    }
}
fn range_contagem_inclusivo() {
    for num in 0..=10 {
        println!("Num: {}", num);
    }
}
```
- Veja a diferença entre os dois tipos de range inclusivo e range exclusivo!
- No range exclusivo, usamos a expressão `0..10`, e isso inclui desde 0 até 9, tirando o 10;
- No range inclusivo, usamos a expressão `0..=10` e isso também incluí 10 como o último elemento.

No rust, não usamos o índice, mas usamos o iterador `iter()` para evitar o outbound ou bugs relacionados ao índice.

