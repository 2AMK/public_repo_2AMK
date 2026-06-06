[[rust]]
# Slices

Os slices são um tipo de referência a partir de uma coleção de elementos.

```rust
fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}
```


Para os tipos de `String`, a gente usa `&str` que é a forma mais idiomática, já que as funções não tomam posse dos seus argumentos a não ser que seja necessário.


## Slices das Strings

```Rust
    let s = String::from("hello world");

    let hello = &s[0..5];
    let world = &s[6..11];

```
- No exemplo acima, estamos criando 2 slices, referenciando à variável `s`
- Na variável `hello`, estamos usando a notação `&s` para referenciar a primeira palavra, enquanto a segunda variável, estamos referenciando a segunda palavra.

Na prática, quando o slice é criado, a variável contendo slice possui ponteiro apontado para um pedaço do valor original.
- Seria ponteiro para onde começa + tamanho trecho dessa variável


## Sintaxes
Sempre os slices têm essa sintaxe:
```Rust
&s[inicio..fim];
```
- O início sempre é inclusivo
- O fim é sempre exclusivo

Também será possível especificar para incluir o fim:
```Rust
&s[inicio..=fim];
```
- O sinal "=" sinaliza que deve incluir o índice do fim

Também é possível fazer atalhos, assim como no Python:
```Rust
&s[0..2] == &s[..2]
```
- Podemos tirar 0 do slice, e isso será aceito também

```Rust
&s[3..len] == &s[3..]
```
- Também podemos usar o `len` ou omitir no final, para poder incluir até o final do slice

```Rust
&s[0..len] == &s[..]
```
- Também podemos omitir ambos para incluir todos os elementos de um valor

Também é importante lembrar que precisamos ter cuidado em utilizar os valores de UTF-8 para os slices. Pois os caracteres de UTF-8 como "á, ç, ã" podem conter mais do que 1 byte e isso acaba quebrando o código também.
- Recomenda-se utilizar ASCII

## Assinatura
Recomenda-se usar essa assinatura de função:
```Rust
fn first_word(s: &str) -> &str
```
- Onde ambos lados devem usar `&str` que é um String Literal, mesmo que o próprio valor original seja um String
- Pois um string slice já é uma `str` literal e já é marcado como apenas read-only e imutável

O Rust já faz uma conversão automática desses slices, de String para str literal por causa do `deref coercion`.