[[rust]]
[[Coleções]]
## Vetores

Os vetores também permite armazenar vários elementos do mesmo tipo de maneira dinâmica.
`Vec<T>`

Para criarmos o novo vetor, podemos convocar a função `Vec::new`:
```Rust
let new_vector: Vec<i32> = Vec::new();
```
- É importante colocarmos o type annotation para o Vec para que o compliador identifique qual tipo de elementos será usado para o vetor.

Também podemos usar o macro `vec![]` como no exemplo abaixo:
```Rust
let vector_example_2: Vec<i32> = vec![1, 2, 3, 4];
```


Como o vector pode mudar de tamanho dinamicamente, podemos usar o método `push`
```Rust
fn main() {
    let mut vector_example: Vec<&str> = Vec::new();

    vector_example.push("pássaro");
    vector_example.push("pato");
    vector_example.push("gato");
    vector_example.push("cachorro");

    println!("{:?}", vector_example);

}

```
- É importante lembrar que para que o método `.push()` funcione, é necessário tornar o vector mutável com `mut`.

Podemos ler e extrair os elementos de um vector, e há duas formas de fazê-los
- Acessar o elemento usando a indexação:
```Rust
    let vector_example_2: Vec<i32> = vec![1, 2, 3, 4];

    let terceiro_elemento: &i32 = &vector_example_2[2];
    println!("terceiro elemento: {}", terceiro_elemento);
```
- Acessar o elemento usando o método de `.get()`
```Rust
    let vector_example_2: Vec<i32> = vec![1, 2, 3, 4];

    let terceiro_elemento1: &i32 = &vector_example_2[2];
    println!("terceiro elemento: {}", terceiro_elemento1);

    let terceiro_elemento2: Option<&i32> = vector_example_2.get(2);
    println!("terceiro elemento: {}", terceiro_elemento2.unwrap());

    let fora_indice: Option<&i32> = vector_example_2.get(4);
    match fora_indice {
        Some(elemento) => println!("terceiro elemento: {}", elemento),
        None => println!("terceiro elemento: None"),
    };
```

Para o segundo exemplo, veja que o método `.get()` na verdade resulta em `Option<T>` onde pode conter ou não conter valor.
- Isso pode resultar na forma diferente de tratar os dados, podendo usar o match ou `let..else` para extrair o valor desse elemento.

É importante lembrar que como os Vetores são os tipos de dados que usam `heaps` para armazenar os dados, é necessário referenciar o valor usando a notação de `&`.

### Ownership em Vector

Outra observação importante referente ao ownership, não podemos ter uma referência mutável e imutável ao mesmo tempo como no exemplo abaixo:
```Rust
    let mut codigo_quebra: Vec<i32> = vec![1, 2, 3, 4];

    let elemento_quebra: &i32 = &codigo_quebra[3];
    println!("quarto elemento: {}", elemento_quebra);

    codigo_quebra.push(5);
    println!("quarto elemento: {}", elemento_quebra);
```
- Veja que como `.push()` altera o vector, logo a variável `codigo_quebra` deveria ser mutável, mas nesse exemplo, temos também referência `elemento_quebra`. 

Isso porque o Vector funciona de maneira diferente, assim como os Strings e outros tipos de coleção. 
- Na prática, o Vector aponta para um bloco de memória com capacidade já cheia como no exemplo abaixo:
```
codigo_quebra
├── ptr ------> [1, 2, 3, 4]  
├── len = 4
└── capacity = 4
```
- Quando colocamos um `.push(5)`, isso significa que o Rust terá que pedir para criar um novo bloco de memória para incluir o elemento de 5, apagando o bloco de memória antiga 
- E isso significa que a referência imutável para `elemento_quebra` não existe mais, e pode gerar referência solta e inválida. 

Mas é possível evitar esse problema ao definir o escopo do borrow:
```Rust


    let mut codigo_nao_quebra: Vec<i32> = vec![1, 2, 3, 4];
    {
    let elemento_nao_quebra: &i32 = &codigo_nao_quebra[3];
    println!("quarto elemento: {}", elemento_nao_quebra);
    }

    codigo_nao_quebra.push(5);

    println!("quinto elemento: {}", codigo_nao_quebra[4]);
    
```
- Isso significa que a variável `elemento_nao_quebra` só existe no escopo interno, e deixa de existir mais depois que sai do escopo
- Dessa forma, o uso do `.push(5)` ainda é válido pois, na prática, temos apenas única referência mutável nesse momento.

### Iteração sobre Vetores

Podemos usar o laço de `for .. in` no Rust para iterar os valores:
```Rust
fn main() {
    let v = vec![1, 2, 3];

    for i in &v {
        println!("{}", i);
    }
}

```
- Lembrando que usamos `&v` pois queremos só emprestar o elemento e exibir os valores sem tomar o posse dela.

Também podemos modificar os valores dos elementos do Vetor, mas precisamos de tratamento bem específico:
```Rust
fn main() {
    let mut v = vec![1, 2, 3];

    for i in &mut v {
        *i += 10;
    }

    println!("{:?}", v);
}

```
- No exemplo acima, precisamos usar `*` para dereferenciar a variável `i`, e assim para garantir que só temos única referência mutável a ser considerada no tempo

## Usando Enum dentro do Vetor

É possível usar o enum dentro do vetor, diferentemente dos outros tipos de dados (o Vetor não aceita diferentes tipos de dados).
- Isso porque o Enum e suas variantes é visto como único tipo de dados com suas formas diferentes, como no exemplo abaixo:
```Rust
enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}

// Aqui é uma operação permitida
vec![
    SpreadsheetCell::Int(3),
    SpreadsheetCell::Text(String::from("blue")),
    SpreadsheetCell::Float(10.12),
]
```

Aqui o Vetor do Rust vê assim:
```
[
    SpreadsheetCell,
    SpreadsheetCell,
    SpreadsheetCell
]
```

Ou seja, o Enum pode funcionar como "embrulho" ou um "pacote", contendo os variantes que guardam os respectivos valores, invés de incorporar para dentro.
- Seria algo assim:
```
[tag][espaço interno]
```

Mas precisamos também depois acessar os valores usando `match`:
```Rust
for cell in row {
    match cell {
        SpreadsheetCell::Int(valor) => {
            println!("Inteiro: {}", valor);
        }

        SpreadsheetCell::Float(valor) => {
            println!("Float: {}", valor);
        }

        SpreadsheetCell::Text(valor) => {
            println!("Texto: {}", valor);
        }
    }
}
```

### Descarte de Vector

Quando o vetor sai do escopo, é importante lembrar que o vetor e seus elementos também são limpos internamente.