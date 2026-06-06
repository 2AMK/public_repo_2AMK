[[Coleções]]
[[rust]]

O tipo `HashMap<K, V>` é o tipo de coleção menos utilizado do Rust e é parecido com o dicionário em outras linguagens de programação.

O hashmap tem um par de chaves e valores, assim como os dicionários, e também é armazenado em um heap assim como os outros tipos de coleção.
- As chaves podem de qualquer tipo;
- Os valores também podem ser de qualquer tipo;
- Porém as chaves e valores devem ser homogêneos, ou seja, as chaves devem ser do mesmo tipo escolhido como String, e os valores devem ser do mesmo tipo também como `i32`.

```Rust
use std::{collections::HashMap};
main(){
	// Inicializar um HashMap com HashMap::new()
	let mut recorde: HashMap<String, u32> = HashMap::new();
	
	recorde.insert(String::from("pescador 1"),  32);
	recorde.insert(String::from("pescador 2"), 70);
	
	println!("{:?}", recorde);
}
```
- No exemplo acima, foi necessário importar o módulo para HashMap usando `std::collections::HashMap`, pois o Rust por padrão não tem HashMap, e é necessário importar a biblioteca padrão do Rust
- Nós inicializamos um novo HashMap usando `HashMap::new()`
- Para inserir um par de chave e valor novo, usamos o método `.insert()`

# Acessar um valor do HashMap
Também podemos acessar os valores por meio de chaves no HashMap, e para isso, devemos usar o método `.get()`:
```Rust

use std::{collections::HashMap};

fn main() {

    let mut recorde: HashMap<String, u32> = HashMap::new();

    recorde.insert(String::from("pescador 1"),  32);
    recorde.insert(String::from("pescador 2"), 70);

    let pescador1 = String::from("pescador 1");
    let pescador2 = String::from("pescador 2");


    let peixes_pescador1 = recorde.get(&pescador1).copied().unwrap_or(0);
    let peixes_pescador2 = recorde.get(&pescador2).copied().unwrap_or(0);

    println!("{}: {}", pescador1, peixes_pescador1);
    println!("{}: {}", pescador2, peixes_pescador2);
}
}
```

- Lembrando que o método `.get()` sempre retorna um `Option<&V>`, o que indica que o valor para esta chave selecionada pode ter 2 possibilidades (None ou Some). Isso significa que precisamos tratar o valor:
- O valor retornado de uma chave do Hashmap sempre é uma referência como `&v`, pois nós não queremos tomar o ownership dos valores dentro do HashMap.
- No exemplo acima, usamos os métodos `copied` e `unwrap_or` justamente para tratar o valor da referência.
	- O método `copied` faz uma cópia barata dos valores, e nesse exemplo, estamos fazendo uma cópia do valor do tipo `u32`, e assim, nós não tomamos posse dos valores do HashMap
	- Mas como o get retorna em um `Option<&V>`, precisamos usar o `unwrap_or()` que é forma segura de tratar com a possibilidade de ausência de valor. Ou seja, caso o valor retornado seja ausente, podemos obrigá-lo a considerar 0.

Ou seja, as coleções geralmente retornam referências, e nunca retorna os valores em si mesmo. Isso significa que devemos ter certo cuidado no tratamento.
- Por exemplo, no HashMap, o método `get` sempre retorna um `Option<&V>`, e precisamos tratar os valores de forma segura.

Também podemos iterar cada par de chave-valor usando o loop `for`:
```Rust
fn main() {

    let mut recorde: HashMap<String, u32> = HashMap::new();

    recorde.insert(String::from("pescador 1"),  32);
    recorde.insert(String::from("pescador 2"), 70);

    for (key, value) in &recorde {
        println!("{}: {}", key, value);
    }
}
```

# Ownership do HashMap
[[ownership]]
Lembrando das regras de ownership onde os valores do tipo primitivo como `u32` tem comportamento de cópia, e que os tipos como String tem seu comportamento de `mover`, os comportamentos da inserção dos valores no HashMap também é aplicável.


Ou seja, as variáveis com valor do tipo primitivo como `u32` continua existindo após a inserção no HashMap, porém os do tipo de String e daqueles que usam heaps deixam de existir ao ser movido para HashMap
- Pois agora o HashMap é dono desses valores para os casos que usam heaps:
```Rust
fn main() {
    let chave = String::from("Joao");
    let valor: u32 = 30;

    let mut recorde: HashMap<String, u32> = HashMap::new();

    recorde.insert(chave, valor);

    // Agora a variável Chave não existe mais, pois ela foi movida para o HashMap.
    // E a variável Valor ainda existe, pois ela foi copiada para o HashMap.

    println!("{:?}", recorde);
}
```

# Atualizar o HashMap

Podemos usar o mesmo método `.insert()` para atualizar os valores das chaves já existentes.

```Rust
fn main() {
    let valor: u32 = 30;
    let novo_valor: u32 = 40;

    let mut recorde: HashMap<String, u32> = HashMap::new();

    recorde.insert(String::from("Joao"), valor);
    recorde.insert(String::from("Joao"), novo_valor);

    println!("{:?}", recorde);

}
```
- Lembrando que para atualizar os novos valores, a chave deve já ter existido antes. Senão, o comportamento padrão é criar um novo par de chave e valores.
- Ou seja, na prática, o valor original do `valor` foi sobrescrito por novo valor da variável `novo_valor`

Também podemos acrescentar uma chave e um valor caso a chave não exista através do método `entry`.
- Isso é bem útil se não queremos atualizar os valores das chaves já existentes, e apenas criar os novos pares de chave e valores caso não esteja no HashMap

```Rust
fn main() {
    let valor: u32 = 30;
    let novo_valor: u32 = 40;

    let mut recorde: HashMap<String, u32> = HashMap::new();

    recorde.insert(String::from("Joao"), valor);


    recorde.entry(String::from("Maria")).or_insert(novo_valor);
    recorde.entry(String::from("Joao")).or_insert(novo_valor);
    recorde.entry(String::from("Jose")).or_insert(novo_valor);


    println!("{:?}", recorde);

}
```
- No exemplo acima, como a chave `Joao` já existe, então o seu valor original não foi sobrescrito
- Porém para Maria e Jose, como não existia no HashMap criado, então eles receberam o novo valor do `novo_valor`.

## Atualizando um valor com base no valor antigo

Também podemos realizar algumas ações bem úteis com o HashMap. Podemos contar quantas vezes as palavras aparecem em um texto:
```Rust

fn main() {
    let texto: String = String::from("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua");

    let mut map = HashMap::new();
    for word in texto.split_whitespace() {
        let count = map.entry(word).or_insert(0);
        *count += 1;
    }
    
    println!("{:?}", map);
}
```

O resultado seria isso:
```
{"magna": 1, "dolore": 1, "aliqua": 1, "consectetur": 1, "ipsum": 1, "elit,": 1, "tempor": 1, "ut": 1, "sed": 1, "eiusmod": 1, "Lorem": 1, "amet,": 1, "labore": 1, "incididunt": 1, "do": 1, "sit": 1, "dolor": 1, "et": 1, "adipiscing": 1}
```
- O método `split_whitespace()` faz com que as palavras sejam separadas, usando os espaços como separadores;
- Também fazemos uma iteração sobre uma tupla que representam o conjunto de todas as palavras separadas
- E em cada iteração, usamos o `entry` e `or_insert` para verificar se essas chaves já existem, senão, terá que criar um par de chave e valor.
- É necessário também usar `*` para desreferenciar, pois o `count` é uma referência mutável, e precisamos acessar diretamente à referência, não a própria referência.
