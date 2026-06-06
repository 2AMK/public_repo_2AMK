[[rust]]

Os matchs são muito bem úteis em Rust e permite comparar um valor com uma série de padrões e executar o código com base na combinação dos padrões, economizando os `ifs`.
- Seria uma espécie de uma máquina que separa os ovos pelo tamanho, começando pelo tamanho pequeno e indo até o tamanho maior.
- E os matchs apresentam o comportamento de ser "exaustivos", procurando combinar com todos os possíveis valores que existam por aí.

A expressão de `match` permite incluir um padrão de expressão.
- Ela requer arms que são conjuntos de expressão.

Nesse caso, ao usar `ordering`, fará com que se a variável a ser comparada é maior, igual ou menor do que a outra variável. Isso requer usar o módulo de `cmp::Ordering`, e inserir as expressões de Less, Equal e Greater
```rust
    match guess.cmp(&secret_number.to_string()) {
        Ordering::Less => println!("Too small!"),
        Ordering::Equal => println!("You win!"),
        Ordering::Greater => println!("Too big!"),
    }
```

## Padrões extraídos de um variante de Enum
Também podemos extrair os valores de um variente de Enum em um `match` como no seguinte exemplo:
```Rust

enum Veiculo {
    Carro(TipoCarro),
    Moto,
    Caminhao(TipoCaminhao),
}

enum TipoCarro {
    Hatch,
    Sedan,
    SUV,
    Pickup,
}

enum TipoCaminhao {
    Cisterna,
    Reboque,
    Furgo,
}


fn veiculo_matcher(veiculo: Veiculo) -> String {
    match veiculo {
        Veiculo::Carro(tipo) => match tipo {
            TipoCarro::Hatch => String::from("Carro Hatch"),
            TipoCarro::Sedan => String::from("Carro Sedan"),
            TipoCarro::SUV => String::from("Carro SUV"),
            TipoCarro::Pickup => String::from("Carro Pickup"),
        },

        Veiculo::Moto => String::from("Moto"),

        Veiculo::Caminhao(tipo) => match tipo {
            TipoCaminhao::Cisterna => String::from("Caminhao Cisterna"),
            TipoCaminhao::Reboque => String::from("Caminhao Reboque"),
            TipoCaminhao::Furgo => String::from("Caminhao Furgo"),
        },
    }
}
```
- Isso representa a ideia de pegar o Enum de principais tipos de veículos (`Veiculo`), e também incluir os outros subtipos dos respectivos veículos como `TipoCarro` e `TipoCaminhao`
- No exemplo da função `veiculo_matcher`, estamos descompondo o principal tipo e seu subtipo
- Dessa forma, conseguimos fazer o modelagem de dados, e cada um representa um estado válido de um sistema
## Match e Result
E também o `match` pode ser usado para o tratamento de erro com arms diferentes.
- Podemos usar os arms `Ok()` e `Err()` para fazer com que o programa decida o que fazer com os erros no input.
```rust

        let guess: i32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };
```
- Nesse caso, caso a variável `guess` retornar com `Result` como "Ok", podemos prosseguir para as próximas linhas normalmente, retornando o valor do `num`
- Caso contrário, o `Result` irá retornar como `Err`, e podemos dizer o que fazer com o valor. Nesse exemplo, podemos dizer a ele que precisamos continuar, porém sem repassar o valor. 

Lembrando que o `Result<T>` também é um tipo de Enum.
## Match e Option

Os valores do tipo `Option <T>` precisam usar os padrões `match`para extrair os valores do option.

```Rust
fn main() {
    let x = Some(5);
    let y = soma_valor(x);
    println!("{:?}", y);
}


fn soma_valor(x: Option <u32>) -> Option<u32> {
    match x {
        None => None,
        Some(x) => Some(x + 1),
    }
}
```


## Placeholders

Caso tenha outros valores "sobrando" ou demais valores que não estejam lá, podemos também usar o placeholder `_`, em que não queremos listar todos os possíveis valores.

```Rust
fn main() {
    let egg1 = 1;
    let egg2 = 2;
    let egg3 = 3;
    let egg4 = 4;

    println!("Egg 1 is a {:?} egg", egg_matcher(egg1));
    println!("Egg 2 is a {:?} egg", egg_matcher(egg2));
    println!("Egg 3 is a {:?} egg", egg_matcher(egg3));
    println!("Egg 4 is a {:?} egg", egg_matcher(egg4));
}

#[derive(Debug)]
enum EggSize {
    Small,
    Medium,
    Large,
    Unknown
}

fn egg_matcher(egg_size: i32) -> EggSize {
    match egg_size {
        1 => EggSize::Small,
        2 => EggSize::Medium,
        3 => EggSize::Large,
        _ => EggSize::Unknown, // também podemos usar o ()
    }
}

```
- No exemplo do `egg_matcher`, foi usado o placeholder `_` para incluir os outros tamanhos de ovos que não saibam dentro do padrão previsto.
- Também podemos trocar para `( )` invés de `EggSize::Unknown` para sinalizar que nada vai acontecer.

# Fluxo mais conciso com if let e let ... else


Podemos usar `if let` no lugar de `match` para tornar o código menos verbosa e mais fácil de ler:
```rust

fn main() {
    let example = Some(5);
    match example {
        Some(5) => println!("Got 5"),
        _ => (),
    }
}

```
Para
```Rust
fn main() {
    let example = Some(5);
    if let some(5) = example {
        println!("Got five");
    }
}
```

É possível fazermos dessa forma que é menos verbosa, mas perdemos a capacidade de verificar todos os outros casos assim como no Match.

Assim:
- Se quisemos tratar apenas único caso, podemos usar o `if let`;
- Se quisemos tratar exaustivamente todos os casos, é melhor usar o `match`.

Também podemos usar o  `if let` com o `else`:
```Rust
fn main() {
    let example = Some(5);
    match example {
        Some(5) => println!("Got 5"),
        _ => println!("Got something else"),
    }
}
```
Para
```Rust
fn main() {
    let example = Some(5);
    if let Some(5) = example {
        println!("Got five");
    } else {
        println!("Got something else");
    }
}
```
- Nesse caso, é bem útil se você queira tratar uma situação, mas tratar de forma genérica para demais situações.


Também podemos usar o `let ... else`
```Rust
fn carregar_usuario(id: Option<u32>) {

    let id = if let Some(id) = id {
        id
    } else {
        return;
    };

    println!("Carregando {}", id);
}

fn carregar_usuario_2(id: Option<u32>){
    let Some(id) = id else {
        return;
    };

    println!("Carregando {}", id);
}

```

É muito útil se:
- Queremos manter o código mais limpo e menos verboso, além de falhar rapidamente
- Também é útil se queremos extrair os valores