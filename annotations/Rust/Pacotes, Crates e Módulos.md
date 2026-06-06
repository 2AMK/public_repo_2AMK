No Rust, nós temos um sistema de módulo:
- Packages (parecido com pacotes do Python): permite também compartilhar os crates;
- Crates (é equivalente a biblioteca no Python): um conjunto de módulos que formam uma biblioteca
- Modules e Uses: permitem também controlar a organização, escopo e privacidade dos caminhos
- Paths: é uma forma de nomear um item.


# Pacotes

Um pacote pode conter várias crates, da mesma forma dos pacotes de Python que pode ser compartilhado nos repositórios.
- Cada pacote tem um `Cargo.toml` que define como compliar essas crates

# Crates

É equivalente às bibliotecas, e representa o menor unidade do código que o Compliador de Rust considera.

Temos 2 tipos principais de Crates: crate binário e crate de bibliotecas.
- As crates binários são programas que podem ser compliados para um executável, e sempre tem o `main`
- As crates de bibliotecas não possuem função `main` e não são compliados em executáveis. São aqueles que fornecem funcionalidades para os códigos como bibliotecas. Por exemplo, o crate `rand` é um módulo que podemos

As crates roots é o arquivo-fonte principal, ou seja "entrypoint" que o compliador começa a fazer compliação.
- Para As crates binários, o "entrypoint" é `src/main.rs`
- Para As crates de library, o "entrypoint" é `src/lib.rs`

# Módulos

Ou seja, no Rust, diferentemente do Python, precisamos ser explícito, e deixar claro onde tem módulo usando o `mod` e `pub` conjuntivamente.

A árvore de módulo é muito parecido com a árvore de diretório do sistema de arquivos. E é importante lembrar que há distinção entre organização e visibilidade, pois por padrão, os módulos precisam ter `pub` para ser visível ao compliador.
## Módulos maiores
- Podemos também declarar os módulos no próprio arquivo raiz da crate ao escrever `mod` ao lado do módulo como `mod module_example`
	- O compliador vai mapear onde fica o módulo `module_example` em alguns lugares

Por exemplo, no `main.rs`, devemos escrever assim:
```rust
// No src/main.rs
pub mod module_example

main(){}
```
## Sub módulos
- Para declarar os submódulos, podemos declarar o submódulo em qualquer lugar, menos a própria raiz da crate.

Devemos escrever assim dessa forma em qualquer lugar, exceto no próprio arquivo `main.rs` 
```rust
// No src/module_example
pub mod sub_module

etc(){}
```

## Privacidade
Por padrão, um módulo é privado em relação aos seus módulos pais, e para tornar um módulo público, precisa escrever `pub mod`, invés de `mod`.

Podemos também controlar a privacidade de cada módulo, e é bem útil nas seguintes situações:
```
crate
 └── front_of_house
     ├── hosting
     │   ├── add_to_waitlist
     │   └── seat_at_table
     └── serving
         ├── take_order
         ├── serve_order
         └── take_payment
```

```rust
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}

        fn seat_at_table() {}
    }

    mod serving {
        fn take_order() {}

        fn serve_order() {}

        fn take_payment() {}
    }
}
```
- Como o código principal não precisa saber a abstração das funções de `add_to_waitlist`, `seat_at_table`, `take_order`, `serve_order`, `take_payment`, podemos só pegar os interfaces desses módulos.
## Use
- A palavra-chave `use` permite usar o atalho, e escrever apenas o nome do módulo invés de escrever o caminho longo como `crate::planeta::continente::pais::Brasil`, usar apenas `Brasil`

Seria equivalente a escrever algo assim em Python (`import`):
```Python
from planeta.continente.pais import Brasil
```

