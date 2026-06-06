[[rust]]

Para declarar uma função, você tem que escrever `fn` antes do nome de uma função e encapsular as instruções em uma linha.
- Por convenção comum, deve-se usar o snake-case para nomear uma função.
- Assim como Python, o Rust também recebe parâmetros e argumentos.

Diferentemente do Python, como o Rust é linguagem compliada, a declaração de função pode ocorrer em qualquer lugar, mesmo depois de a função ter sido convocada.
- No Python, vale lembrar que o comportamento padrão é sempre convocar a função depois de definição

----
Inclusive, é interessante pontuar que no Rust, o retorno na função pode ser **implícito**! Ou seja, você não precisa sempre declarar o return no final das funções!

O return implícito pode não necessariamente ser declarada explicitamente assim no exemplo abaixo:
```rust
fn exemplo_soma(a: i32, b:i32) -> i32 {
	let x = b; // exemplo de statement
	a + b //exemplo de expressão
}
```

O return explícito é útil quando se quer controlar o fluxo de execução de uma função, assim como no exemplo abaixo:
```rust
fn dividir(a: i32, b: i32) -> i32 {
    if b == 0 {
        return 10;
    }

    a / b
}
```

Pois no Rust, há diferenças entre statement e expression. O statement sempre retorna com ponto e vírgula, enquanto um expression não termina em ponto vírgula.
- Sempre um retorno implícito é um expression.
- Nunca pode colocar um statement sem terminar em return como no exemplo abaixo:

```rust
fn main() {
    let x = plus_one(5);

    println!("The value of x is: {x}");
}

fn plus_one(x: i32) -> i32 {
    x + 1;
}
```
