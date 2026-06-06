[[rust]]
Por padrão, caso não seja especificado um tipo de variável numérico, Rust sempre coloca como padrão o tipo `i32` (número inteiro de 32-bit), porém também podemos especificar os outros tipos como:
- `u32` (tipo de "unsigned 32 bit");
- `i64` (número inteiro de 64 bits);


# Escalares

São 4 tipos principais de tipos de dados:
- inteiro
- booleano
- float
- caracteres (char)

## Inteiros
Os números inteiros podem ter tamanho variável, desde 8 bit até 128 bit.
- Esses bits representam até quais valores eles conseguem armazenar em única variável
- Por exemplo um 8bit indica que ele consegue armazenar de 0 a 255. Caso ultrapasse, vai ter integrer overflow e não vai computar por padrão (e é possível tratar esse erro)

Há 2 tipos de variáveis do tipo número inteiro: unsigned e signed.
- Os unsigned incluem apenas os números positivos, e nunca negativo. Denota com `u`
- Os signed incluem os números positivos bem como os negativos. Denota com `i`

Também podemos modificar a forma de como os números inteiros podem ser representados no Rust, como mostrar na forma de decimal, hex, octal e binário.

Importante destacar que o número de bit também influencia diretamente no tamanho de memória ocupado pela variável.
- Quanto maior, mais espaço que a variável do tipo inteiro precisa ocupar na memória.
## Float
- Há 2 tipos principais de float: `f32` e `f64`, que representa os bits que um número float pode representar.

Diferentemente do Python, o Rust não permite as operações matemáticas mesmo para os tipos diferentes de número (int + float).
- Também não pode fazer as operações matemáticas mesmo para tamanhos diferentes como i8 + i128 ou f32 + f64


## Char
O tipo `char` recebe 1 caractere de unicode (também permite letras, acentos, números, kanji, caracteres chineses/japoneses/coreanos)
- Não permite receber mais de 1 caractere

# Compostos
Os compostos permitem incluir vários valores em único tipo. E nesse grupo, há 2 tipos: array e tuple

## Tuple
As tuplas permitem armazenar vários tipos de dados em única tupla, porém tem quantidade de elemento (length) fixo.
- Após a definição de uma tupla, ela não pode ter quantidade de elementos alterados (não pode crescer ou reduzir elementos)

Para definir uma tupla, pode-se usar parênteses. É importante declarar o tipo de cada elemento que estão em uma tupla

```rust
	let tuple: (i64, f32) = (10, 0.232);
    let (x, y) = tuple;
    let tup1 = tuple.0;
    let tup2 = tuple.1;
```
- Também é possível desempacotar uma tupla em elementos individuais de duas formas diferentes como no exemplo acima.
- O Rust também permite extrair o valor de um elemento a partir do index de uma tupla.
## Array

Um array sempre é de tamanho fixo e todos os elementos em um array deve ser do mesmo tipo, diferentemente da tupla.
- Ou seja, também não pode mudar de tamanho (aumentar ou reduzir)

Para declarar um array e acessar um array:
```rust
let array: [i32; 4] = [1,2,3,4]; 
let array1: i32 = array[0];
```

Caso um array seja mutável (declarada com "mut"), os elementos podem ser alterados dentro do array, desde que sejam do mesmo tipo.
```rust
let mut array = [1, 2, 3];
array[0] = 5;
```

Da mesma forma no Python, no Rust, você não pode acessar um elemento fora do índice (como acessar o décimo elemento em um array que só tem 9 elementos), senão dá erro "out of bound".

Inclusive, é interessante apontar que no Rust, também é criar um array com vários elementos com mesmo valor:
```rust
let a = ['a'; 100];
```
- No exemplo acima, resultaria em um array com apenas 'a' 100 vezes.
## Vector
Diferentemente do Array, um vector pode mudar o tamanho de elemento (pode expandir ou reduzir o número de elementos)


## String
[[String]]
É muito importante diferenciar entre `string literal` e `String`.
- O `string literal` é `&str` e por padrão é imutável e de tamanho fixo. Esse tipo é armazenado no `stack`. 
	- Também não permite certo tipo de operação como `s.push_str` pois é não editável e atua apenas como read-only6
- Por outro lado `String` é mutável (se usar mut), e é armazenada em `heap` e pode crescer dinamicamente. 
	- Nesse caso, utiliza-se o apontador para String.


O String é armazenado em heap, diferentemente de todos os tipos descritos anteriormente (exceto o Vector). 
- Isso significa que ao criar uma variável em String, esse na verdade reserva um `heap` fixo no espaço da memória de computador e gera um `pointer`.
- Também permite armazenar um dado de tamanho desconhecido no tempo de compliação.

```rust
let s = String::from("hello");
```
- Na prática, também é criado um stack que aponta para o heap (onde fica armazenado `hello`), com algumas informações como tamanho e a capacidade.

Seria assim:
- s -> stack (pointer, len + cap) -> heap (h, e, l, l, o)

E caso String for mutável, isso permite com que o heap (onde contém os dados reais) cresça de maneira dinâmica (permite a alocação dinâmica e aumentar o buffer)
```rust
let mut s = String::from("hello");
s.push_str(", world!");
```