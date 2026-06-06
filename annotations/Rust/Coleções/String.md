[[rust]]
[[Coleções]]

As operações envolvendo as strings (`String`) são parecidas com as de vetores, como o uso do método `push` e a criação de uma nova String.


O exemplo abaixo mostra como criamos a String e como fazemos o `push`
```Rust
    let mut string_example: String = String::new();

    string_example.push_str("Exemplo ");
    string_example.push_str("String");

    println!("{}", &string_example);
```
- Para a criação da string, usa-se `String::new();`, que é parecido com a criação de uma instância vazia de [[Vetores]].
- Também usamos o método `.push_str()` para acrescentar a cadeia de caracteres à nova instância de String.

Também podemos converter uma cadeia de caracteres em uma string usando o método `to_string()`
```Rust
    let frase: &str = "Quero aprender Rust";
    let string_example_2: String = frase.to_string();

    println!("{}", &string_example_2);
```
- No exemplo acima, usamos o valor da variável `frase` (na forma de &str) e convertemos em `String` com o método `to_string();`

Podemos também usar a `String::from()` para gerar um valor em `String`:
```Rust
let string_example_3: String = String::from("Exemplo String");
println!("{}", &string_example_3);
```

# Atualização de String
Também temos algumas formas de atualizar uma string:
- Usar o operador `+`;
- Macro `format!`
- Usar `push`/`push_str`

Usando o operador  `+`
```Rust

fn main() {
    let s1: String = String::from("Quero ");
    let s2: String = String::from("aprender ");
    let s3: String = String::from("Rust");

    let s = s1 + &s2 + &s3;

    println!("{s}");

    // Apenas s2 e s3 existem, e s1 não existe mais
    println!("{} {}", s2, s3);
}
```
- No exemplo acima, as variáveis `s2` e `s3` devem usar a referência `&` pois a função do próprio operador `+` tem essa sintaxe:
```Rust
fn add(self, s: &str) -> String {
```
- Isso significa que precisamos referenciar, e não tomamos posse do `s2` e `s3`.
- Logo o `s1` não existe mais nesse escopo após a adição.

Usando a operação de format
```Rust

fn main() {
    let s1: String = String::from("Quero ");
    let s2: String = String::from("aprender ");
    let s3: String = String::from("Rust");

    let s = format!("{s1}{s2}{s3}");
    println!("{}", s);

    // S1, S2 e S3 ainda existem nesse escopo
    println!("{} {} {}", s1, s2, s3);
}


```
- Também é forma mais legível, e também o macro `format!` não toma posse dos valores dessas variáveis.
# String e UTF-8
As Strings são do formato de `UTF-8`, ou seja aceita todos os diferentes caracteres como `à, ç, ã, ñ`  e assim por diante. Mas é importante lembrar que os caracteres não padrões precisam ser tratados de forma diferente no Rust, pois esses caracteres nem sempre tem exatamente único byte. 

Por isso, no Rust, não há suporte de indexação para o tipo de String e nem é sempre recomendável usar os [[slices]] da String especialmente para os caracteres que não sejam de ASCII, pois os caracteres não padrões podem ter mais de 1 bytes e pode quebrar o programa.

Para isso, a melhor prática é iterar sobre uma String, deixando explícito onde queremos pegar a String.
```Rust
    for c in frase.chars() {
        println!("{}", c);
    }

    for b in frase.bytes() {
        println!("{}", b);
    }
```

A melhor prática é tratar usando o `texto.chars()`, como nos exemplos abaixo:
```Rust
	// Pegar o primeiro
    let first = &frase.chars().next();

    // Pegar o ultimo
    let last = &frase.chars().last();

    println!("Primeiro caractere: {}", first.unwrap());
    println!("Ultimo caractere: {}", last.unwrap());

    // Pegar os 3 primeiros
    let tres_primeiros = frase.chars().take(3);

    println!("Os 3 primeiros caracteres: {}", tres_primeiros.collect::<String>());
    
```


Também tem algumas operações bem úteis para String como `.trim()` e `.replace()`:
```Rust
fn trim_me(input: &str) -> &str {
    // TODO: Remove whitespace from both ends of a string.
    input.trim()
}

fn compose_me(input: &str) -> String {
    // TODO: Add " world!" to the string! There are multiple ways to do this.
    format!("{} world!", input)
}

fn replace_me(input: &str) -> String {
    // TODO: Replace "cars" in the string with "balloons".
    input.replace("cars", "balloons")
}

```