[[rust]]

Um Struct é semelhante à tupla, já que pode conter vários valores de diferentes tipos.
- Mas o Struct se difere da Tupla pois no Struct, a gente pode nomear cada valor, de modo semelhante aos dicionários.
Há 3 tipos de structs: `Classic`, `tuples` e `unit`

# Classic
Para criar um struct, precisamos escrever a seguinte sintaxe como nesse exemplo:
```Rust
struct Tree{
        is_alive: bool,
        specie: String,
        variety: String,
        age: i32,
        height: f32,
        has_flowers: bool,
        has_fruits: bool,
        is_healthy: bool
}
```
- No exemplo acima, usamos as pares de `key: value`, assim como no Dicionário de Python.
- O Classic struct sempre permite utilizar qualquer tipo de dados e bem como a ordem não importa.

Podemos usar o Struct como um template para preencher os dados de um Struct como no exemplo abaixo:
```Rust
struct Tree{
	is_alive: bool,
	specie: String,
	variety: String,
	age: i32,
	height: f32,
	has_flowers: bool,
	has_fruits: bool,
	is_healthy: bool
}

let tree = Tree{
	is_alive: true,
	specie: String::from("Eucalyptus"),
	variety: String::from("Eucalyptus globulus"),
	age: 20,
	height: 10.0,
	has_flowers: true,
	has_fruits: true,
	is_healthy: true
};
```

Também podemos extrair os valores de um Struct, convocando o nome de um struct:
```Rust
let tree_species = tree.specie;
println!("A espécie da árvore é {tree_species}");
```

Também é possível tornar mutável o struct:
```Rust
let mut tree = Tree{
	is_alive: true,
	specie: String::from("Eucalyptus"),
	variety: String::from("Eucalyptus globulus"),
	age: 20,
	height: 10.0,
	has_flowers: true,
	has_fruits: true,
	is_healthy: true
};

tree.is_alive = false;
```
- Para isso, precisamos incluir o `mut` na struct a ser criada

Também é possível abreviar alguns desses campos, caso tiver as variáveis com mesmo nome (field init shorthand):
```Rust
fn create_tree(
	specie: String, 
	variety: String,    
	age: i32, 
	height: f32, 
	has_flowers: bool, 
	has_fruits: bool, 
	is_healthy: bool) 
{
let tree = Tree{
	is_alive: true,
	specie: specie,
	variety, // também podemos usar o shorthand
	age,
	height,
	has_flowers,
	has_fruits,
	is_healthy
	};
}
```
- No exemplo acima, nós não precisamos inicializar cada variável ao lado dos respectivos campos como no exemplo acima

Também podemos criar uma nova instância a partir da instância que já existe no Rust, como no seguinte exemplo:
```Rust
let tree = Tree{
	is_alive: true,
	specie: specie,
	variety, // também podemos usar o shorthand
	age,
	height,
	has_flowers,
	has_fruits,
	is_healthy
};

let tree2: Tree = Tree{
	is_alive: true,
	specie: String::from("Citrus"),
	variety: String::from("Citrus sinensis"),
	..tree
};
```
- Estamos usando a instância inicializada `tree` para gerar `tree2`
- Também usamos a sintaxe `..` no exemplo acima para sinalizar que vai usar os mesmos campos usadas para a primeira instância, mudando algumas coisas.

O Classic é uma estrutura semelhante ao dicionário, e sempre vem um par de chave e valores.

# Struct-Tuple
Também é possível definir um struct-tupla cuja principal diferença é que não possui nomes associados com seus campos, apenas o tipo de campos, como no exemplo abaixo:

```Rust

struct Coordinates(
	i32,
	i32
)

let coordinates = Coordinates(1, 2);    

```

```Rust

struct Name(String, String, String);
let name = Name(
String::from("João"), 
String::from("Pereira"),
String::from("Silva")
);   

```
Em ambos exemplos, podemos usar tuple-struct onde cada campo deve ser tipado, podendo ser do tipo I32 ou do tipo String.

É mais para a separação semântica e conceitual.

Também é importante frisar que no tipo de tuple-struct, vamos precisar extrair de maneira diferente:
```Rust
let sobrenome: String = name.3;
```
- Vamos acessar o Struct-Tuple através dos índices, diferentemente do struct clássico (através do nome do par de chave-valor).

# Struct-Unit

Esse struct na verdade não armazena os dados, somente os comportamentos através dos traits.

Também pode funcionar como "marker type" ou marcador para diferenciar os comportamentos.

# Lifetime

Em termo do owneship, os structs possuem o ownership dos dados, e portanto:
- Recomenda-se usar a String invés de `&str`, pois o `&str` referencia aos dados externos

## Depuração

Se tentarmos imprimir diretamente um struct, o Rust irá retornar um erro, com esse seguinte erro:
```Rust
error[E0277]: the trait bound `Rectangle: std::fmt::Display` is not satisfied
```

Isso significa que o struct não tem trait de ser "imprimível", porém para fins de depuração, a gente pode usar `#[derive(Debug)]` acima do struct.
- O Debug é um trait que nós podemos usar para depurar os outputs do Struct
```Rust
#[derive(Debug)]
struct Rectangule {
width: u32,
height: u32
}
```

Porém para podermos exibir o que há nesses valores de Struct, precisamos usar um operador bem específica `:?` no println.
```Rust
println!("{rect1:?}"); // Debug trait
```

```Rust
fn main() {

    let rect1 = Rectangule {
        width: 30,
        height: 50
    };

    println!("{rect1:?}"); // Debug trait

    let area = rectangule_area_calculator(rect1);

    println!("A area da rectangule é {area}");    
}

#[derive(Debug)]
struct Rectangule {
width: u32,
height: u32
}


fn rectangule_area_calculator(&rectangule: &Rectangule) -> u32 {
    rectangule.width * rectangule.height
}

```
- Também é importante lembrar que estamos usando o `&Rectangule`, pois não queremos tomar posse do próprio objeto e só queremos emprestar à função.

Assim, quando imprimirmos a parte de depuração, a gente consegue ver o seguinte resultado:
```
rect1 is Rectangle { length: 50, width: 30 }
```

## Métodos

O Struct é um pouco parecido com a programação orientado a objeto em Python, em que nós podemos implementar os métodos de uma classe.
- No Rust, a gente também pode criar métodos dentro de um struct usando o `impl` e `self`.

Para implementarmos um método dentro de um struct, a gente precisa seguir o seguinte sintaxe:
```Rust
fn main() {

    let rect1 = Rectangule {
        width: 30,
        height: 50
    };

    println!("{rect1:?}"); // Debug trait

    let area = rect1.area();
    println!("A area da rectangule é {area}");    
}

#[derive(Debug)]
struct Rectangule {
    width: u32,
    height: u32
}

impl Rectangule {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}
```
- Para usar o método de um struct, podemos seguir essa sintaxe: `rect1.area()`
- É importante usar a assinatura de `&self` (de modo semelhante no Python), pois estamos emprestando a instância de struct `Rectangule` sem tomar a posse. 

Também é possível implementar mais métodos para o mesmo struct:
```Rust

impl Rectangule {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn perimeter(&self) -> u32 {
        2 * self.width + 2 * self.height
    }
```
- Também podemos separar o bloco de `impl` em vários sem problema, e é útil dessa forma dependendo da situação

O uso dos métodos é mais vantajoso pois a gente consegue tornar o código mais organizado e legível.

Igualmente é possível incluir a outra instância do mesmo Struct como no exemplo abaixo:
```Rust
impl Rectangule {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn perimeter(&self) -> u32 {
        2 * self.width + 2 * self.height
    }


    fn can_hold_other(&self, other: &Rectangule) -> bool {
        self.width > other.width && self.height > other.height
    }
}
```
- Onde `other` pode ser uma referência de uma instância de Struct de Rectangule, em que não precisamos tomar posse da instância, só fazer uma leitura.

Podemos até mesmo implementar um método que não chama a si mesmo, e isso é conhecido como uma função associada, o que pode ser útil se quisermos montar um constructor que retorna uma nova instância de uma struct.
```Rust
impl Rectangule {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn perimeter(&self) -> u32 {
        2 * self.width + 2 * self.height
    }


    fn can_hold_other(&self, other: &Rectangule) -> bool {
        self.width > other.width && self.height > other.height
    }

    fn square(size: u32) -> Rectangule {
        Rectangule {height: size, width: size}
    }
}
```

Para convocá-lo, temos que escrever a seguinte sintaxe:
```Rust
let square = Rectangule::square(30);
    println!("{square:?}");
```
- Onde usamos a sintaxe de `::` com o nome da struct 